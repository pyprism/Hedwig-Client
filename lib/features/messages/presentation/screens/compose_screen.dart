import 'dart:async';
import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hedwig_client/core/api/dio_client.dart';
import 'package:hedwig_client/core/api/error_interceptor.dart';
import 'package:hedwig_client/core/error/failure.dart';
import 'package:hedwig_client/features/contacts/data/repositories/contact_repository.dart';
import 'package:hedwig_client/features/mailboxes/presentation/controllers/mailbox_controller.dart';
import 'package:hedwig_client/features/messages/data/repositories/message_repository.dart';
import 'package:hedwig_client/features/messages/presentation/controllers/compose_controller.dart';
import 'package:hedwig_client/features/messages/presentation/utils/email_body_converter.dart';
import 'package:hedwig_client/features/threads/data/repositories/thread_repository.dart';
import 'package:hedwig_client/features/threads/presentation/controllers/thread_controller.dart';
import 'package:hedwig_client/shared/models/message.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _maxAttachments = 10;
const _maxAttachmentBytes = 10 * 1024 * 1024;
// Provider recipient cap (to+cc+bcc) and subject length, mirroring docs/api.md.
const _maxRecipients = 50;
const _maxSubjectChars = 998;

class _SendIntent extends Intent {
  const _SendIntent();
}

class _SenderIdentity {
  const _SenderIdentity({
    required this.id,
    required this.email,
    this.displayName,
    this.signatureText,
    this.signatureHtml,
  });

  final String id;
  final String email;
  final String? displayName;
  final String? signatureText;
  final String? signatureHtml;

  String get label => displayName == null || displayName!.isEmpty
      ? email
      : '$displayName <$email>';

  factory _SenderIdentity.fromJson(Map<String, dynamic> json) =>
      _SenderIdentity(
        id: json['id'] as String,
        email: json['email'] as String? ?? '',
        displayName: json['display_name'] as String?,
        signatureText: json['signature_text'] as String?,
        signatureHtml: json['signature_html'] as String?,
      );
}

class ComposeScreen extends ConsumerStatefulWidget {
  const ComposeScreen({
    super.key,
    this.replyToMessageId,
    this.mode,
    this.to,
    this.draftMessageId,
  });

  final String? replyToMessageId;
  final String? mode;
  final String? to;
  final String? draftMessageId;

  @override
  ConsumerState<ComposeScreen> createState() => _ComposeScreenState();
}

class _ComposeScreenState extends ConsumerState<ComposeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _toCtrl = TextEditingController();
  final _ccCtrl = TextEditingController();
  final _bccCtrl = TextEditingController();
  final _subjectCtrl = TextEditingController();
  final _htmlSourceCtrl = TextEditingController();
  final _bodyController = QuillController.basic();
  final _bodyFocusNode = FocusNode();
  final _bodyScrollController = ScrollController();

  final List<String> _toChips = [];
  final List<String> _ccChips = [];
  final List<String> _bccChips = [];
  final List<ComposeAttachmentRequest> _attachments = [];
  bool _showCc = false;
  bool _showBcc = false;
  bool _htmlSourceMode = false;
  bool _draftLoaded = false;
  bool _signatureInserted = false;
  bool _prefillStarted = false;
  String? _selectedSenderIdentityId;
  String? _senderIdentityMailboxId;
  Future<List<_SenderIdentity>>? _senderIdentitiesFuture;
  String? _error;
  DateTime? _scheduledAt;
  String? _composeMailboxId;
  String? _savedDraftMessageId;
  String? _draftReplyToMessageId;

  @override
  void initState() {
    super.initState();
    _savedDraftMessageId = widget.draftMessageId;
    _subjectCtrl.addListener(_saveDraft);
    _htmlSourceCtrl.addListener(_saveDraft);
    _bodyController.addListener(_saveDraft);
  }

  @override
  void dispose() {
    _toCtrl.dispose();
    _ccCtrl.dispose();
    _bccCtrl.dispose();
    _subjectCtrl.dispose();
    _htmlSourceCtrl.dispose();
    _bodyController.dispose();
    _bodyFocusNode.dispose();
    _bodyScrollController.dispose();
    super.dispose();
  }

  String get _draftKey {
    final savedId = _savedDraftMessageId ?? widget.draftMessageId;
    if (savedId != null) return 'compose_draft_saved_$savedId';
    return 'compose_draft_${widget.replyToMessageId ?? 'new'}';
  }

  bool get _hasDraftContent =>
      _toChips.isNotEmpty ||
      _ccChips.isNotEmpty ||
      _bccChips.isNotEmpty ||
      _subjectCtrl.text.trim().isNotEmpty ||
      _hasBodyContent ||
      _attachments.isNotEmpty;

  bool get _hasBodyContent =>
      _bodyPlainText.trim().isNotEmpty || _bodyHtml.trim().isNotEmpty;

  String get _bodyPlainText => _htmlSourceMode
      ? plainTextFromHtml(_htmlSourceCtrl.text)
      : emailPlainTextFromDocument(_bodyController.document);

  String get _bodyHtml => _htmlSourceMode
      ? _htmlSourceCtrl.text.trim()
      : emailHtmlFromDocument(_bodyController.document);

  String? get _effectiveMailboxId =>
      _composeMailboxId ??
      ref.read(selectedMailboxProvider) ??
      // Compose can be reached via a deep link or web refresh before any
      // mailbox has been selected (the /compose route carries no mailbox), so
      // fall back to the first available mailbox like the shell does.
      ref.read(mailboxListProvider).valueOrNull?.firstOrNull?.id;

  Future<void> _saveDraft() async {
    if (!_draftLoaded) return;
    final prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setString(
        _draftKey,
        jsonEncode({
          'to': _toChips,
          'cc': _ccChips,
          'bcc': _bccChips,
          'subject': _subjectCtrl.text,
          'body': _bodyHtml,
          'body_delta': _htmlSourceMode
              ? null
              : _bodyController.document.toDelta().toJson(),
          'compose_html': true,
          'html_source_mode': _htmlSourceMode,
          'sender_identity_id': _selectedSenderIdentityId,
          'reply_to_message_id':
              widget.replyToMessageId ?? _draftReplyToMessageId,
          'scheduled_at': _scheduledAt?.toIso8601String(),
          'attachments': _attachments.map((a) => a.toDraftJson()).toList(),
        }),
      );
    } catch (_) {
      // Browser localStorage can reject large base64 attachments. The explicit
      // mailbox draft save uses Drift/IndexedDB and remains the source of truth.
    }
  }

  Future<void> _loadDraftAndPrefill() async {
    if (_prefillStarted) return;
    _prefillStarted = true;
    if (widget.draftMessageId != null) {
      final loaded = await _loadSavedDraft(widget.draftMessageId!);
      if (loaded) return;
    }

    final prefs = await SharedPreferences.getInstance();
    final draft = prefs.getString(_draftKey);
    if (draft != null) {
      final data = jsonDecode(draft) as Map<String, dynamic>;
      setState(() {
        _applyDraftData(data);
      });
      return;
    }

    if (widget.replyToMessageId != null) {
      final original = await ref
          .read(messageRepositoryProvider)
          .remote
          .getById(widget.replyToMessageId!);
      if (!mounted) return;
      setState(() {
        final mode = widget.mode;
        final subject = original.subject;
        if (mode == 'forward') {
          _subjectCtrl.text = subject.toLowerCase().startsWith('fwd:')
              ? subject
              : 'Fwd: $subject';
          _setBodyFromText(
            '\n\n---------- Forwarded message ----------\nFrom: ${original.fromName ?? original.fromAddress} <${original.fromAddress}>\nSubject: $subject\n\n${original.bodyText ?? original.snippet ?? ''}',
          );
        } else {
          _subjectCtrl.text = subject.toLowerCase().startsWith('re:')
              ? subject
              : 'Re: $subject';
          _toChips.add(original.fromAddress);
          if (mode == 'replyAll') {
            _ccChips.addAll(original.ccAddresses.map((row) => row.email));
            _showCc = _ccChips.isNotEmpty;
          }
          _setBodyFromText(
            '\n\nOn ${DateFormat('MMM d, yyyy HH:mm').format((original.receivedAt ?? original.createdAt ?? DateTime.now()).toLocal())}, ${original.fromAddress} wrote:\n${original.bodyText ?? original.snippet ?? ''}',
          );
        }
        _draftLoaded = true;
      });
      return;
    }

    setState(() {
      final to = widget.to;
      if (to != null && to.trim().isNotEmpty && !_toChips.contains(to)) {
        _toChips.add(to.trim());
      }
      _draftLoaded = true;
    });
  }

  Future<void> _discard() async {
    if (!_hasDraftContent) {
      if (mounted) context.pop();
      return;
    }
    final action = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Discard draft?'),
        content: Text(
          _savedDraftMessageId == null
              ? 'Your unsent message will be removed from this device.'
              : 'Your unsent message will be removed from Drafts.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop('cancel'),
            child: const Text('Keep editing'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop('discard'),
            child: const Text('Discard'),
          ),
          FilledButton.icon(
            onPressed: () => Navigator.of(ctx).pop('save'),
            icon: const Icon(Icons.drafts_outlined),
            label: const Text('Save draft'),
          ),
        ],
      ),
    );
    if (action == 'save') {
      await _saveMailboxDraft(closeAfter: true);
      return;
    }
    if (action != 'discard') return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_draftKey);
    final savedDraftMessageId = _savedDraftMessageId;
    if (savedDraftMessageId != null) {
      await ref
          .read(composeControllerProvider.notifier)
          .deleteDraft(savedDraftMessageId);
    }
    if (mounted) context.pop();
  }

  void _addChip(TextEditingController ctrl, List<String> chips) {
    final val = ctrl.text.trim();
    if (val.isNotEmpty && val.contains('@')) {
      setState(() {
        chips.add(val);
        ctrl.clear();
      });
      unawaited(_saveDraft());
    }
  }

  Future<List<_SenderIdentity>> _senderIdentitiesFor(String mailboxId) {
    if (_senderIdentityMailboxId != mailboxId) {
      _senderIdentityMailboxId = mailboxId;
      _senderIdentitiesFuture = _loadSenderIdentities(mailboxId);
    }
    return _senderIdentitiesFuture!;
  }

  Future<List<_SenderIdentity>> _loadSenderIdentities(String mailboxId) async {
    final dio = ref.read(dioClientProvider);
    final res = await dio.get(
      'mail/sender-identities/',
      queryParameters: {
        'mailbox': mailboxId,
        'is_active': true,
        'page_size': 100,
      },
    );
    final results = (res.data['results'] as List? ?? [])
        .cast<Map<String, dynamic>>();
    return results.map(_SenderIdentity.fromJson).toList();
  }

  int get _attachmentBytes =>
      _attachments.fold(0, (total, item) => total + item.sizeBytes);

  Future<void> _pickAttachments() async {
    if (_attachments.length >= _maxAttachments) {
      _showSnack('At most $_maxAttachments attachments are allowed.');
      return;
    }

    final remainingSlots = _maxAttachments - _attachments.length;
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      withData: true,
      type: FileType.any,
      dialogTitle: 'Attach files',
    );
    if (result == null || result.files.isEmpty) return;

    var availableBytes = _maxAttachmentBytes - _attachmentBytes;
    final accepted = <ComposeAttachmentRequest>[];
    var skippedCount = 0;
    var skippedBytes = 0;
    var missingBytes = 0;

    for (final file in result.files.take(remainingSlots)) {
      final bytes = file.bytes;
      if (bytes == null) {
        missingBytes++;
        continue;
      }
      if (file.size > availableBytes) {
        skippedBytes++;
        continue;
      }

      accepted.add(
        ComposeAttachmentRequest(
          filename: file.name,
          contentType: _contentTypeFor(file.name),
          content: base64Encode(bytes),
          sizeBytes: file.size,
        ),
      );
      availableBytes -= file.size;
    }

    if (result.files.length > remainingSlots) {
      skippedCount = result.files.length - remainingSlots;
    }

    if (accepted.isNotEmpty) {
      setState(() => _attachments.addAll(accepted));
      await _saveDraft();
    }

    final notes = <String>[
      if (accepted.isNotEmpty)
        '${accepted.length} ${accepted.length == 1 ? 'file' : 'files'} attached.',
      if (skippedCount > 0)
        '$skippedCount skipped because only $remainingSlots attachment slots remained.',
      if (skippedBytes > 0)
        '$skippedBytes skipped because the total limit is 10 MB.',
      if (missingBytes > 0)
        '$missingBytes skipped because file bytes were unavailable.',
    ];
    if (notes.isNotEmpty) _showSnack(notes.join(' '));
  }

  void _removeAttachment(int index) {
    setState(() => _attachments.removeAt(index));
    unawaited(_saveDraft());
  }

  void _insertAttachmentInline(int index) {
    final attachment = _attachments[index];
    if (!_isImageContentType(attachment.contentType)) return;

    final contentId = attachment.contentId?.trim().isNotEmpty == true
        ? attachment.contentId!
        : 'inline-${DateTime.now().microsecondsSinceEpoch}@hedwig';

    setState(() {
      _attachments[index] = ComposeAttachmentRequest(
        filename: attachment.filename,
        contentType: attachment.contentType,
        content: attachment.content,
        sizeBytes: attachment.sizeBytes,
        contentId: contentId,
      );
      _appendHtmlFragment(
        '<p><img src="cid:$contentId" alt="${const HtmlEscape().convert(attachment.filename)}"></p>',
      );
    });
    unawaited(_saveDraft());
  }

  String _contentTypeFor(String filename) {
    final extension = filename.split('.').lastOrNull?.toLowerCase();
    return switch (extension) {
      'apng' => 'image/apng',
      'avif' => 'image/avif',
      'bmp' => 'image/bmp',
      'gif' => 'image/gif',
      'jpg' || 'jpeg' => 'image/jpeg',
      'png' => 'image/png',
      'svg' => 'image/svg+xml',
      'webp' => 'image/webp',
      'pdf' => 'application/pdf',
      'txt' => 'text/plain',
      'csv' => 'text/csv',
      'html' || 'htm' => 'text/html',
      'json' => 'application/json',
      'xml' => 'application/xml',
      'zip' => 'application/zip',
      'doc' => 'application/msword',
      'docx' =>
        'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      'xls' => 'application/vnd.ms-excel',
      'xlsx' =>
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
      'ppt' => 'application/vnd.ms-powerpoint',
      'pptx' =>
        'application/vnd.openxmlformats-officedocument.presentationml.presentation',
      'mp3' => 'audio/mpeg',
      'wav' => 'audio/wav',
      'mp4' => 'video/mp4',
      'mov' => 'video/quicktime',
      _ => 'application/octet-stream',
    };
  }

  bool _isImageContentType(String contentType) {
    return contentType.toLowerCase().startsWith('image/');
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _pickScheduledTime() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: _scheduledAt ?? now.add(const Duration(minutes: 5)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (date == null || !mounted) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
        _scheduledAt ?? now.add(const Duration(minutes: 5)),
      ),
    );
    if (time == null) return;

    setState(() {
      _scheduledAt = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  void _addPendingRecipientChips() {
    void add(TextEditingController controller, List<String> chips) {
      final value = controller.text.trim();
      if (value.isNotEmpty && value.contains('@') && !chips.contains(value)) {
        chips.add(value);
        controller.clear();
      }
    }

    add(_toCtrl, _toChips);
    add(_ccCtrl, _ccChips);
    add(_bccCtrl, _bccChips);
  }

  List<dynamic>? get _draftBodyDelta =>
      _htmlSourceMode ? null : _bodyController.document.toDelta().toJson();

  SendMessageRequest _composeRequest(String mailboxId) {
    return SendMessageRequest(
      mailboxId: mailboxId,
      senderIdentityId: _selectedSenderIdentityId,
      to: _toChips.map((e) => EmailAddress(email: e)).toList(),
      cc: _ccChips.map((e) => EmailAddress(email: e)).toList(),
      bcc: _bccChips.map((e) => EmailAddress(email: e)).toList(),
      subject: _subjectCtrl.text.trim(),
      bodyText: _bodyPlainText.trim(),
      bodyHtml: _bodyHtml,
      replyToMessageId: widget.replyToMessageId ?? _draftReplyToMessageId,
      scheduledAt: _scheduledAt,
    );
  }

  Future<void> _saveMailboxDraft({required bool closeAfter}) async {
    setState(() {
      _addPendingRecipientChips();
      _error = null;
    });

    if (!_hasDraftContent) {
      if (closeAfter && mounted) context.pop();
      return;
    }

    final mailboxId = _effectiveMailboxId;
    if (mailboxId == null) {
      setState(() => _error = 'No mailbox selected.');
      return;
    }

    try {
      final composeController = ref.read(composeControllerProvider.notifier);
      final result = await composeController.saveDraft(
        _composeRequest(mailboxId),
        draftId: _savedDraftMessageId,
        attachments: _attachments,
        bodyDelta: _draftBodyDelta,
        htmlSourceMode: _htmlSourceMode,
      );
      _savedDraftMessageId = result.id;
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_draftKey);
      ref.invalidate(threadListProvider);
      ref.invalidate(threadCountsProvider(mailboxId));
      if (!mounted) return;
      if (closeAfter) context.pop();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Draft saved.')));
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e is ApiException ? e.failure.userMessage : e.toString();
      });
    }
  }

  Future<void> _send() async {
    if (!_formKey.currentState!.validate()) return;
    setState(_addPendingRecipientChips);
    if (_toChips.isEmpty) {
      setState(() => _error = 'Add at least one recipient.');
      return;
    }

    final recipientCount = _toChips.length + _ccChips.length + _bccChips.length;
    if (recipientCount > _maxRecipients) {
      setState(
        () => _error =
            'Too many recipients ($recipientCount). Limit is $_maxRecipients.',
      );
      return;
    }

    final mailboxId = _effectiveMailboxId;
    if (mailboxId == null) {
      setState(() => _error = 'No mailbox selected.');
      return;
    }

    setState(() => _error = null);

    final req = _composeRequest(mailboxId);

    final composeController = ref.read(composeControllerProvider.notifier);

    // A draft loaded from another device carries reference-only attachments
    // (no local bytes), so it can't go through the normal send path — promote
    // it server-side via the send-draft endpoint, which uses the staged bytes.
    if (_attachments.any((a) => a.isReference)) {
      await _sendViaDraft(composeController, req, mailboxId);
      return;
    }

    await composeController.send(req, attachments: _attachments);

    final result = ref.read(composeControllerProvider);
    if (result.hasError && mounted) {
      final e = result.error;
      setState(() {
        _error = e is ApiException ? e.failure.userMessage : e.toString();
      });
    } else if (mounted) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_draftKey);
      final savedDraftMessageId = _savedDraftMessageId;
      if (savedDraftMessageId != null) {
        await composeController.deleteDraft(savedDraftMessageId);
        ref.invalidate(threadListProvider);
        ref.invalidate(threadCountsProvider(mailboxId));
      }
      if (!mounted) return;
      context.pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _scheduledAt != null
                ? 'Message scheduled for ${DateFormat('MMM d, HH:mm').format(_scheduledAt!)}.'
                : 'Message queued. Sending shortly.',
          ),
          action: _scheduledAt == null
              ? SnackBarAction(
                  label: 'Undo',
                  onPressed: () => composeController.undoLastSend(),
                )
              : null,
        ),
      );
    }
  }

  Future<void> _sendViaDraft(
    ComposeController composeController,
    SendMessageRequest req,
    String mailboxId,
  ) async {
    final localDraftId = _savedDraftMessageId;
    if (localDraftId == null) {
      setState(() => _error = 'Draft not saved yet. Try again.');
      return;
    }
    await composeController.sendDraft(
      localDraftId: localDraftId,
      req: req,
      attachments: _attachments,
    );
    final result = ref.read(composeControllerProvider);
    if (result.hasError && mounted) {
      final e = result.error;
      setState(() {
        _error = e is ApiException ? e.failure.userMessage : e.toString();
      });
      return;
    }
    if (!mounted) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_draftKey);
    ref.invalidate(threadListProvider);
    ref.invalidate(threadCountsProvider(mailboxId));
    if (!mounted) return;
    context.pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Message queued. Sending shortly.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(composeControllerProvider).isLoading;
    final selectedMailboxId = ref.watch(selectedMailboxProvider);
    final mailboxId = _composeMailboxId ?? selectedMailboxId;
    final mailboxes = ref.watch(mailboxListProvider).valueOrNull ?? [];
    final selectedMailbox = mailboxes
        .where((mailbox) => mailbox.id == mailboxId)
        .firstOrNull;

    if (!_draftLoaded) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _loadDraftAndPrefill(),
      );
    }

    return Shortcuts(
      shortcuts: {
        LogicalKeySet(LogicalKeyboardKey.meta, LogicalKeyboardKey.enter):
            const _SendIntent(),
        LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.enter):
            const _SendIntent(),
      },
      child: Actions(
        actions: {
          _SendIntent: CallbackAction<_SendIntent>(
            onInvoke: (_) {
              _send();
              return null;
            },
          ),
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.close),
              tooltip: 'Discard',
              onPressed: _discard,
            ),
            title: Text(
              widget.draftMessageId != null
                  ? 'Edit draft'
                  : widget.replyToMessageId != null
                  ? 'Reply'
                  : 'New message',
            ),
            actions: [
              if (isLoading)
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
              else ...[
                IconButton(
                  icon: const Icon(Icons.attach_file),
                  tooltip: 'Attach file',
                  onPressed: _pickAttachments,
                ),
                IconButton(
                  icon: const Icon(Icons.drafts_outlined),
                  tooltip: 'Save draft',
                  onPressed: () => _saveMailboxDraft(closeAfter: true),
                ),
                IconButton(
                  icon: Icon(
                    _scheduledAt != null
                        ? Icons.schedule
                        : Icons.schedule_outlined,
                  ),
                  tooltip: 'Schedule send',
                  onPressed: _pickScheduledTime,
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  tooltip: 'Send',
                  onPressed: _send,
                ),
              ],
            ],
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _ChipField(
                  label: 'To',
                  chips: _toChips,
                  controller: _toCtrl,
                  onAdd: () => _addChip(_toCtrl, _toChips),
                  onRemove: (i) => setState(() => _toChips.removeAt(i)),
                  contactSuggestions: (q) =>
                      ref.read(contactRepositoryProvider).searchEmails(q),
                ),
                if (!_showCc)
                  TextButton(
                    onPressed: () => setState(() => _showCc = true),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Add Cc'),
                    ),
                  )
                else
                  _ChipField(
                    label: 'Cc',
                    chips: _ccChips,
                    controller: _ccCtrl,
                    onAdd: () => _addChip(_ccCtrl, _ccChips),
                    onRemove: (i) => setState(() => _ccChips.removeAt(i)),
                    contactSuggestions: (q) =>
                        ref.read(contactRepositoryProvider).searchEmails(q),
                  ),
                if (!_showBcc)
                  TextButton(
                    onPressed: () => setState(() => _showBcc = true),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Add Bcc'),
                    ),
                  )
                else
                  _ChipField(
                    label: 'Bcc',
                    chips: _bccChips,
                    controller: _bccCtrl,
                    onAdd: () => _addChip(_bccCtrl, _bccChips),
                    onRemove: (i) => setState(() => _bccChips.removeAt(i)),
                    contactSuggestions: (q) =>
                        ref.read(contactRepositoryProvider).searchEmails(q),
                  ),
                if (_scheduledAt != null)
                  Chip(
                    avatar: const Icon(Icons.schedule, size: 18),
                    label: Text(
                      'Sends ${DateFormat('MMM d, HH:mm').format(_scheduledAt!)}',
                    ),
                    onDeleted: () => setState(() => _scheduledAt = null),
                  ),
                if (mailboxId != null)
                  FutureBuilder<List<_SenderIdentity>>(
                    future: _senderIdentitiesFor(mailboxId),
                    builder: (context, snapshot) {
                      final identities =
                          snapshot.data ?? const <_SenderIdentity>[];
                      if (snapshot.hasError || identities.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      final selected =
                          identities.any(
                            (identity) =>
                                identity.id == _selectedSenderIdentityId,
                          )
                          ? _selectedSenderIdentityId
                          : null;
                      return DropdownButtonFormField<String?>(
                        initialValue: selected,
                        decoration: const InputDecoration(labelText: 'From'),
                        items: [
                          const DropdownMenuItem<String?>(
                            value: null,
                            child: Text('Mailbox default'),
                          ),
                          ...identities.map(
                            (identity) => DropdownMenuItem<String?>(
                              value: identity.id,
                              child: Text(identity.label),
                            ),
                          ),
                        ],
                        onChanged: (value) => setState(() {
                          _selectedSenderIdentityId = value;
                          final identity = identities
                              .where((item) => item.id == value)
                              .firstOrNull;
                          _insertSignature(
                            text: identity?.signatureText,
                            html: identity?.signatureHtml,
                          );
                        }),
                      );
                    },
                  ),
                if (selectedMailbox != null && !_signatureInserted)
                  Builder(
                    builder: (context) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _insertSignature(
                          text: selectedMailbox.signatureText,
                          html: selectedMailbox.signatureHtml,
                        );
                      });
                      return const SizedBox.shrink();
                    },
                  ),
                if (_attachments.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  _AttachmentSummary(
                    attachmentCount: _attachments.length,
                    totalBytes: _attachmentBytes,
                    maxBytes: _maxAttachmentBytes,
                    formatBytes: _formatBytes,
                  ),
                  const SizedBox(height: 8),
                  ..._attachments.asMap().entries.map((entry) {
                    final attachment = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _AttachmentItem(
                        attachment: attachment,
                        formatBytes: _formatBytes,
                        canInsertInline: _isImageContentType(
                          attachment.contentType,
                        ),
                        onInsertInline: attachment.contentId?.isNotEmpty == true
                            ? null
                            : () => _insertAttachmentInline(entry.key),
                        onRemove: () => _removeAttachment(entry.key),
                      ),
                    );
                  }),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      onPressed: _attachments.length >= _maxAttachments
                          ? null
                          : _pickAttachments,
                      icon: const Icon(Icons.add),
                      label: const Text('Add more'),
                    ),
                  ),
                ],
                const Divider(),
                TextFormField(
                  controller: _subjectCtrl,
                  maxLength: _maxSubjectChars,
                  // Hide the per-field counter; the cap just fails fast.
                  buildCounter:
                      (
                        _, {
                        required currentLength,
                        required isFocused,
                        maxLength,
                      }) => null,
                  decoration: const InputDecoration(
                    labelText: 'Subject',
                    border: InputBorder.none,
                  ),
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Subject required'
                      : null,
                ),
                const Divider(),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('HTML source'),
                  value: _htmlSourceMode,
                  onChanged: _setHtmlSourceMode,
                ),
                if (_htmlSourceMode)
                  TextFormField(
                    controller: _htmlSourceCtrl,
                    decoration: const InputDecoration(
                      hintText: '<p>Message body</p>',
                      border: InputBorder.none,
                    ),
                    maxLines: null,
                    minLines: 12,
                    keyboardType: TextInputType.multiline,
                    validator: (_) => _hasBodyContent ? null : 'Body required',
                  )
                else
                  FormField<void>(
                    validator: (_) => _hasBodyContent ? null : 'Body required',
                    builder: (field) {
                      final errorText = field.errorText;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: errorText == null
                                    ? Theme.of(context).dividerColor
                                    : Theme.of(context).colorScheme.error,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                QuillSimpleToolbar(
                                  controller: _bodyController,
                                  config: QuillSimpleToolbarConfig(
                                    showAlignmentButtons: true,
                                    showBackgroundColorButton: false,
                                    showCodeBlock: false,
                                    showDirection: false,
                                    showFontFamily: false,
                                    showInlineCode: false,
                                    showLineHeightButton: false,
                                    showSearchButton: false,
                                    showSubscript: false,
                                    showSuperscript: false,
                                    buttonOptions:
                                        QuillSimpleToolbarButtonOptions(
                                          base: QuillToolbarBaseButtonOptions(
                                            afterButtonPressed: () {
                                              _bodyFocusNode.requestFocus();
                                            },
                                          ),
                                        ),
                                  ),
                                ),
                                const Divider(height: 1),
                                SizedBox(
                                  height: 320,
                                  child: QuillEditor(
                                    controller: _bodyController,
                                    focusNode: _bodyFocusNode,
                                    scrollController: _bodyScrollController,
                                    config: const QuillEditorConfig(
                                      placeholder: 'Message body',
                                      padding: EdgeInsets.all(12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (errorText != null) ...[
                            const SizedBox(height: 8),
                            Text(
                              errorText,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                          ],
                        ],
                      );
                    },
                  ),
                if (_error != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    _error!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    }
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  Future<bool> _loadSavedDraft(String draftId) async {
    final messageDao = ref.read(messageRepositoryProvider).db.messageDao;
    var row = await messageDao.getById(draftId);
    if (row == null) {
      // No local copy — this is a draft authored on another device, reached via
      // its server thread id. Fetch and cache it, then load that cached row.
      final cached = await ref
          .read(composeControllerProvider.notifier)
          .cacheRemoteDraft(draftId);
      if (!mounted) return true;
      if (cached) row = await messageDao.getById(draftId);
    }
    if (!mounted) return true;
    final draftRow = row;
    if (draftRow == null || draftRow.status != 'draft') {
      setState(() => _draftLoaded = true);
      return false;
    }

    Map<String, dynamic> metadata;
    try {
      metadata = jsonDecode(draftRow.metadataJson) as Map<String, dynamic>;
    } catch (_) {
      metadata = {};
    }

    setState(() {
      _savedDraftMessageId = draftRow.id;
      _composeMailboxId = draftRow.mailboxId;
      _applyDraftData({
        'to': _decodeDraftEmailList(draftRow.toAddressesJson),
        'cc': _decodeDraftEmailList(draftRow.ccAddressesJson),
        'bcc': _decodeDraftEmailList(draftRow.bccAddressesJson),
        'subject': draftRow.subject,
        'body': draftRow.bodyHtml ?? draftRow.bodyText ?? '',
        'body_delta': metadata['body_delta'],
        'compose_html': draftRow.bodyHtml != null,
        'html_source_mode': metadata['html_source_mode'] as bool? ?? false,
        'sender_identity_id': metadata['sender_identity_id'],
        'reply_to_message_id': metadata['reply_to_message_id'],
        'scheduled_at': draftRow.scheduledAt?.toIso8601String(),
        'attachments': metadata['compose_attachments'],
      });
    });
    return true;
  }

  List<String> _decodeDraftEmailList(String json) {
    try {
      return (jsonDecode(json) as List)
          .map((item) {
            if (item is String) return item;
            if (item is Map<String, dynamic>) {
              return item['email'] as String? ?? '';
            }
            return '';
          })
          .where((email) => email.isNotEmpty)
          .toList();
    } catch (_) {
      return [];
    }
  }

  void _applyDraftData(Map<String, dynamic> data) {
    _toChips
      ..clear()
      ..addAll((data['to'] as List? ?? []).cast<String>());
    _ccChips
      ..clear()
      ..addAll((data['cc'] as List? ?? []).cast<String>());
    _bccChips
      ..clear()
      ..addAll((data['bcc'] as List? ?? []).cast<String>());
    _attachments
      ..clear()
      ..addAll(
        (data['attachments'] as List? ?? [])
            .whereType<Map<String, dynamic>>()
            .map(ComposeAttachmentRequest.fromDraftJson),
      );
    _subjectCtrl.text = data['subject'] as String? ?? '';
    _selectedSenderIdentityId = data['sender_identity_id'] as String?;
    _draftReplyToMessageId = data['reply_to_message_id'] as String?;
    final scheduled = data['scheduled_at'] as String?;
    _scheduledAt = scheduled == null ? null : DateTime.tryParse(scheduled);
    _loadDraftBody(data);
    _showCc = _ccChips.isNotEmpty;
    _showBcc = _bccChips.isNotEmpty;
    _draftLoaded = true;
  }

  void _loadDraftBody(Map<String, dynamic> data) {
    final delta = data['body_delta'];
    final sourceMode = data['html_source_mode'] as bool? ?? false;
    final body = data['body'] as String? ?? '';
    final wasHtml = data['compose_html'] as bool? ?? true;

    _htmlSourceMode = sourceMode;
    if (sourceMode) {
      _htmlSourceCtrl.text = body;
      return;
    }

    if (delta is List) {
      _setBodyDocument(Document.fromJson(delta));
      return;
    }

    _setBodyDocument(emailDocumentFromBody(body: body, isHtml: wasHtml));
  }

  void _setBodyFromText(String text) {
    _htmlSourceMode = false;
    _setBodyDocument(emailDocumentFromBody(body: text, isHtml: false));
  }

  void _setBodyFromHtml(String html) {
    _htmlSourceMode = false;
    _setBodyDocument(emailDocumentFromBody(body: html, isHtml: true));
  }

  void _setBodyDocument(Document document) {
    final offset = document.length <= 0 ? 0 : document.length - 1;
    _bodyController.document = document;
    _bodyController.updateSelection(
      TextSelection.collapsed(offset: offset),
      ChangeSource.local,
    );
  }

  void _setHtmlSourceMode(bool value) {
    setState(() {
      if (value) {
        _htmlSourceCtrl.text = _bodyHtml;
      } else {
        _setBodyFromHtml(_htmlSourceCtrl.text);
      }
      _htmlSourceMode = value;
    });
    unawaited(_saveDraft());
  }

  void _appendHtmlFragment(String html) {
    if (!_htmlSourceMode) {
      _htmlSourceCtrl.text = _bodyHtml;
    }
    _htmlSourceCtrl.text = '${_htmlSourceCtrl.text.trimRight()}\n$html';
    _htmlSourceMode = true;
  }

  void _insertSignature({String? text, String? html}) {
    if (_signatureInserted || _hasBodyContent) return;
    final signature = (html != null && html.trim().isNotEmpty)
        ? html.trim()
        : text?.trim();
    if (signature == null || signature.isEmpty) return;
    setState(() {
      if (html != null && html.trim().isNotEmpty) {
        _setBodyFromHtml('<br><br>$signature');
      } else {
        _setBodyFromText('\n\n$signature');
      }
      _signatureInserted = true;
    });
  }
}

class _ChipField extends StatelessWidget {
  const _ChipField({
    required this.label,
    required this.chips,
    required this.controller,
    required this.onAdd,
    required this.onRemove,
    required this.contactSuggestions,
  });

  final String label;
  final List<String> chips;
  final TextEditingController controller;
  final VoidCallback onAdd;
  final void Function(int) onRemove;
  final Future<List<String>> Function(String) contactSuggestions;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Text('$label:', style: Theme.of(context).textTheme.labelLarge),
        ),
        ...chips.asMap().entries.map(
          (e) => Padding(
            padding: const EdgeInsets.only(right: 4),
            child: Chip(label: Text(e.value), onDeleted: () => onRemove(e.key)),
          ),
        ),
        SizedBox(
          width: 200,
          child: RawAutocomplete<String>(
            textEditingController: controller,
            focusNode: FocusNode(),
            optionsBuilder: (textValue) {
              if (textValue.text.length < 2) return [];
              return contactSuggestions(textValue.text);
            },
            onSelected: (v) {
              controller.text = v;
              onAdd();
            },
            fieldViewBuilder: (context, ctrl, focusNode, onSubmit) {
              return TextField(
                controller: ctrl,
                focusNode: focusNode,
                decoration: const InputDecoration(border: InputBorder.none),
                onSubmitted: (_) => onAdd(),
              );
            },
            optionsViewBuilder: (context, onSelected, options) {
              return Align(
                alignment: Alignment.topLeft,
                child: Material(
                  elevation: 4,
                  child: SizedBox(
                    width: 300,
                    child: ListView(
                      shrinkWrap: true,
                      children: options
                          .map(
                            (o) => ListTile(
                              title: Text(o),
                              onTap: () => onSelected(o),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _AttachmentSummary extends StatelessWidget {
  const _AttachmentSummary({
    required this.attachmentCount,
    required this.totalBytes,
    required this.maxBytes,
    required this.formatBytes,
  });

  final int attachmentCount;
  final int totalBytes;
  final int maxBytes;
  final String Function(int) formatBytes;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = totalBytes / maxBytes;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.attach_file,
              size: 18,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '$attachmentCount ${attachmentCount == 1 ? 'attachment' : 'attachments'}',
                style: theme.textTheme.labelLarge,
              ),
            ),
            Text(
              '${formatBytes(totalBytes)} / ${formatBytes(maxBytes)}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(value: progress.clamp(0, 1)),
        ),
      ],
    );
  }
}

class _AttachmentItem extends StatelessWidget {
  const _AttachmentItem({
    required this.attachment,
    required this.formatBytes,
    required this.canInsertInline,
    required this.onRemove,
    this.onInsertInline,
  });

  final ComposeAttachmentRequest attachment;
  final String Function(int) formatBytes;
  final bool canInsertInline;
  final VoidCallback? onInsertInline;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isInline = attachment.contentId?.isNotEmpty == true;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            _AttachmentIcon(contentType: attachment.contentType),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    attachment.filename,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    [
                      attachment.contentType,
                      formatBytes(attachment.sizeBytes),
                      if (isInline) 'inline',
                    ].join(' · '),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            if (canInsertInline)
              IconButton(
                icon: Icon(isInline ? Icons.image : Icons.add_photo_alternate),
                tooltip: isInline ? 'Inserted inline' : 'Insert inline',
                onPressed: onInsertInline,
              ),
            IconButton(
              icon: const Icon(Icons.close),
              tooltip: 'Remove attachment',
              onPressed: onRemove,
            ),
          ],
        ),
      ),
    );
  }
}

class _AttachmentIcon extends StatelessWidget {
  const _AttachmentIcon({required this.contentType});

  final String contentType;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final icon = _iconFor(contentType);

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: theme.colorScheme.onSurfaceVariant),
    );
  }

  IconData _iconFor(String contentType) {
    final normalized = contentType.toLowerCase();
    if (normalized.startsWith('image/')) return Icons.image;
    if (normalized.startsWith('audio/')) return Icons.audio_file;
    if (normalized.startsWith('video/')) return Icons.video_file;
    if (normalized == 'application/pdf') return Icons.picture_as_pdf;
    if (normalized.contains('spreadsheet') || normalized.contains('excel')) {
      return Icons.table_chart;
    }
    if (normalized.contains('presentation') ||
        normalized.contains('powerpoint')) {
      return Icons.slideshow;
    }
    if (normalized.contains('wordprocessing') ||
        normalized.contains('msword')) {
      return Icons.description;
    }
    if (normalized.startsWith('text/')) return Icons.subject;
    if (normalized.contains('zip')) return Icons.folder_zip;
    return Icons.insert_drive_file;
  }
}
