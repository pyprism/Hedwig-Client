import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hedwig_client/core/api/dio_client.dart';
import 'package:hedwig_client/core/api/error_interceptor.dart';
import 'package:hedwig_client/core/error/failure.dart';
import 'package:hedwig_client/features/contacts/data/repositories/contact_repository.dart';
import 'package:hedwig_client/features/mailboxes/presentation/controllers/mailbox_controller.dart';
import 'package:hedwig_client/features/messages/data/repositories/message_repository.dart';
import 'package:hedwig_client/features/messages/presentation/controllers/compose_controller.dart';
import 'package:hedwig_client/shared/models/message.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _maxAttachments = 10;
const _maxAttachmentBytes = 10 * 1024 * 1024;

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
  const ComposeScreen({super.key, this.replyToMessageId, this.mode, this.to});

  final String? replyToMessageId;
  final String? mode;
  final String? to;

  @override
  ConsumerState<ComposeScreen> createState() => _ComposeScreenState();
}

class _ComposeScreenState extends ConsumerState<ComposeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _toCtrl = TextEditingController();
  final _ccCtrl = TextEditingController();
  final _bccCtrl = TextEditingController();
  final _subjectCtrl = TextEditingController();
  final _bodyCtrl = TextEditingController();

  final List<String> _toChips = [];
  final List<String> _ccChips = [];
  final List<String> _bccChips = [];
  final List<ComposeAttachmentRequest> _attachments = [];
  bool _showCc = false;
  bool _showBcc = false;
  bool _composeHtml = false;
  bool _draftLoaded = false;
  bool _signatureInserted = false;
  bool _prefillStarted = false;
  String? _selectedSenderIdentityId;
  String? _senderIdentityMailboxId;
  Future<List<_SenderIdentity>>? _senderIdentitiesFuture;
  String? _error;
  DateTime? _scheduledAt;

  @override
  void initState() {
    super.initState();
    _subjectCtrl.addListener(_saveDraft);
    _bodyCtrl.addListener(_saveDraft);
  }

  @override
  void dispose() {
    _toCtrl.dispose();
    _ccCtrl.dispose();
    _bccCtrl.dispose();
    _subjectCtrl.dispose();
    _bodyCtrl.dispose();
    super.dispose();
  }

  String get _draftKey => 'compose_draft_${widget.replyToMessageId ?? 'new'}';

  bool get _hasDraftContent =>
      _toChips.isNotEmpty ||
      _ccChips.isNotEmpty ||
      _bccChips.isNotEmpty ||
      _subjectCtrl.text.trim().isNotEmpty ||
      _bodyCtrl.text.trim().isNotEmpty ||
      _attachments.isNotEmpty;

  Future<void> _saveDraft() async {
    if (!_draftLoaded) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _draftKey,
      jsonEncode({
        'to': _toChips,
        'cc': _ccChips,
        'bcc': _bccChips,
        'subject': _subjectCtrl.text,
        'body': _bodyCtrl.text,
        'compose_html': _composeHtml,
      }),
    );
  }

  Future<void> _loadDraftAndPrefill() async {
    if (_prefillStarted) return;
    _prefillStarted = true;
    final prefs = await SharedPreferences.getInstance();
    final draft = prefs.getString(_draftKey);
    if (draft != null) {
      final data = jsonDecode(draft) as Map<String, dynamic>;
      setState(() {
        _toChips.addAll((data['to'] as List? ?? []).cast<String>());
        _ccChips.addAll((data['cc'] as List? ?? []).cast<String>());
        _bccChips.addAll((data['bcc'] as List? ?? []).cast<String>());
        _subjectCtrl.text = data['subject'] as String? ?? '';
        _bodyCtrl.text = data['body'] as String? ?? '';
        _composeHtml = data['compose_html'] as bool? ?? false;
        _showCc = _ccChips.isNotEmpty;
        _showBcc = _bccChips.isNotEmpty;
        _draftLoaded = true;
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
          _bodyCtrl.text =
              '\n\n---------- Forwarded message ----------\nFrom: ${original.fromName ?? original.fromAddress} <${original.fromAddress}>\nSubject: $subject\n\n${original.bodyText ?? original.snippet ?? ''}';
        } else {
          _subjectCtrl.text = subject.toLowerCase().startsWith('re:')
              ? subject
              : 'Re: $subject';
          _toChips.add(original.fromAddress);
          if (mode == 'replyAll') {
            _ccChips.addAll(original.ccAddresses.map((row) => row.email));
            _showCc = _ccChips.isNotEmpty;
          }
          _bodyCtrl.text =
              '\n\nOn ${DateFormat('MMM d, yyyy HH:mm').format((original.receivedAt ?? original.createdAt ?? DateTime.now()).toLocal())}, ${original.fromAddress} wrote:\n${original.bodyText ?? original.snippet ?? ''}';
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
    final discard = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Discard draft?'),
        content: const Text(
          'Your unsent message will be removed from this device.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Discard'),
          ),
        ],
      ),
    );
    if (discard != true) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_draftKey);
    if (mounted) context.pop();
  }

  void _addChip(TextEditingController ctrl, List<String> chips) {
    final val = ctrl.text.trim();
    if (val.isNotEmpty && val.contains('@')) {
      setState(() {
        chips.add(val);
        ctrl.clear();
      });
      _saveDraft();
    }
  }

  Future<List<_SenderIdentity>> _senderIdentitiesFor(String mailboxId) {
    if (_senderIdentityMailboxId != mailboxId) {
      _senderIdentityMailboxId = mailboxId;
      _selectedSenderIdentityId = null;
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

  Future<void> _showAddAttachmentDialog() async {
    if (_attachments.length >= _maxAttachments) {
      _showSnack('At most $_maxAttachments attachments are allowed.');
      return;
    }

    final filenameCtrl = TextEditingController();
    final contentTypeCtrl = TextEditingController(
      text: 'application/octet-stream',
    );
    final contentCtrl = TextEditingController();
    final contentIdCtrl = TextEditingController();
    var isInline = false;
    String? dialogError;

    await showDialog<void>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text('Add attachment'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: filenameCtrl,
                  decoration: const InputDecoration(labelText: 'Filename'),
                  autofocus: true,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: contentTypeCtrl,
                  decoration: const InputDecoration(labelText: 'Content type'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: contentCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Base64 content',
                  ),
                  minLines: 4,
                  maxLines: 8,
                ),
                const SizedBox(height: 12),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Inline image'),
                  subtitle: const Text('Adds a content ID for HTML cid: use'),
                  value: isInline,
                  onChanged: (value) => setDialogState(() {
                    isInline = value;
                    if (value && contentIdCtrl.text.trim().isEmpty) {
                      contentIdCtrl.text =
                          'inline-${DateTime.now().microsecondsSinceEpoch}@hedwig';
                    }
                  }),
                ),
                if (isInline)
                  TextField(
                    controller: contentIdCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Content ID',
                      helperText: 'Use as <img src="cid:content-id">',
                    ),
                  ),
                if (dialogError != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    dialogError!,
                    style: TextStyle(color: Theme.of(ctx).colorScheme.error),
                  ),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                final filename = filenameCtrl.text.trim();
                final contentType = contentTypeCtrl.text.trim().isEmpty
                    ? 'application/octet-stream'
                    : contentTypeCtrl.text.trim();
                final content = contentCtrl.text.replaceAll(RegExp(r'\s+'), '');

                if (filename.isEmpty) {
                  setDialogState(() => dialogError = 'Filename is required.');
                  return;
                }
                if (content.isEmpty) {
                  setDialogState(
                    () => dialogError = 'Base64 content is required.',
                  );
                  return;
                }

                late final int sizeBytes;
                try {
                  sizeBytes = base64Decode(content).length;
                } on FormatException {
                  setDialogState(
                    () => dialogError = 'Base64 content is invalid.',
                  );
                  return;
                }

                if (_attachmentBytes + sizeBytes > _maxAttachmentBytes) {
                  setDialogState(
                    () => dialogError = 'Total attachment size exceeds 10 MB.',
                  );
                  return;
                }

                setState(() {
                  _attachments.add(
                    ComposeAttachmentRequest(
                      filename: filename,
                      contentType: contentType,
                      content: content,
                      sizeBytes: sizeBytes,
                      contentId: isInline ? contentIdCtrl.text.trim() : null,
                    ),
                  );
                  if (isInline) {
                    _composeHtml = true;
                    _bodyCtrl.text +=
                        '\n<p><img src="cid:${contentIdCtrl.text.trim()}" alt="$filename"></p>';
                  }
                });
                Navigator.of(ctx).pop();
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );

    filenameCtrl.dispose();
    contentTypeCtrl.dispose();
    contentCtrl.dispose();
    contentIdCtrl.dispose();
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

  Future<void> _send() async {
    if (!_formKey.currentState!.validate()) return;
    if (_toChips.isEmpty) {
      setState(() => _error = 'Add at least one recipient.');
      return;
    }

    final mailboxId = ref.read(selectedMailboxProvider);
    if (mailboxId == null) {
      setState(() => _error = 'No mailbox selected.');
      return;
    }

    setState(() => _error = null);

    final req = SendMessageRequest(
      mailboxId: mailboxId,
      senderIdentityId: _selectedSenderIdentityId,
      to: _toChips.map((e) => EmailAddress(email: e)).toList(),
      cc: _ccChips.map((e) => EmailAddress(email: e)).toList(),
      bcc: _bccChips.map((e) => EmailAddress(email: e)).toList(),
      subject: _subjectCtrl.text.trim(),
      bodyText: _composeHtml
          ? _plainTextFromHtml(_bodyCtrl.text)
          : _bodyCtrl.text.trim(),
      bodyHtml: _composeHtml ? _bodyCtrl.text.trim() : null,
      replyToMessageId: widget.replyToMessageId,
      scheduledAt: _scheduledAt,
    );

    final composeController = ref.read(composeControllerProvider.notifier);
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

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(composeControllerProvider).isLoading;
    final mailboxId = ref.watch(selectedMailboxProvider);
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
              widget.replyToMessageId != null ? 'Reply' : 'New message',
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
                  onPressed: _showAddAttachmentDialog,
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
                  const SizedBox(height: 8),
                  ..._attachments.asMap().entries.map(
                    (entry) => ListTile(
                      dense: true,
                      leading: const Icon(Icons.attach_file, size: 18),
                      title: Text(
                        entry.value.filename,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        [
                          entry.value.contentType,
                          _formatBytes(entry.value.sizeBytes),
                          if (entry.value.contentId?.isNotEmpty == true)
                            'inline',
                        ].join(' · '),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.close, size: 18),
                        tooltip: 'Remove attachment',
                        onPressed: () =>
                            setState(() => _attachments.removeAt(entry.key)),
                      ),
                    ),
                  ),
                ],
                const Divider(),
                TextFormField(
                  controller: _subjectCtrl,
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
                  title: const Text('HTML body'),
                  value: _composeHtml,
                  onChanged: (value) {
                    setState(() => _composeHtml = value);
                    _saveDraft();
                  },
                ),
                TextFormField(
                  controller: _bodyCtrl,
                  decoration: InputDecoration(
                    hintText: _composeHtml
                        ? '<p>Message body</p>'
                        : 'Message body',
                    border: InputBorder.none,
                  ),
                  maxLines: null,
                  minLines: 12,
                  keyboardType: TextInputType.multiline,
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Body required' : null,
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

  void _insertSignature({String? text, String? html}) {
    if (_signatureInserted || _bodyCtrl.text.trim().isNotEmpty) return;
    final signature = (html != null && html.trim().isNotEmpty)
        ? html.trim()
        : text?.trim();
    if (signature == null || signature.isEmpty) return;
    setState(() {
      _composeHtml = html != null && html.trim().isNotEmpty;
      _bodyCtrl.text = _composeHtml ? '<br><br>$signature' : '\n\n$signature';
      _signatureInserted = true;
    });
  }

  String _plainTextFromHtml(String html) => html
      .replaceAll(RegExp(r'<[^>]+>'), ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
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
