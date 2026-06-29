// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $MailboxesTable extends Mailboxes
    with TableInfo<$MailboxesTable, MailboxRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MailboxesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _domainIdMeta = const VerificationMeta(
    'domainId',
  );
  @override
  late final GeneratedColumn<String> domainId = GeneratedColumn<String>(
    'domain_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localPartMeta = const VerificationMeta(
    'localPart',
  );
  @override
  late final GeneratedColumn<String> localPart = GeneratedColumn<String>(
    'local_part',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailAddressMeta = const VerificationMeta(
    'emailAddress',
  );
  @override
  late final GeneratedColumn<String> emailAddress = GeneratedColumn<String>(
    'email_address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sendEnabledMeta = const VerificationMeta(
    'sendEnabled',
  );
  @override
  late final GeneratedColumn<bool> sendEnabled = GeneratedColumn<bool>(
    'send_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("send_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _receiveEnabledMeta = const VerificationMeta(
    'receiveEnabled',
  );
  @override
  late final GeneratedColumn<bool> receiveEnabled = GeneratedColumn<bool>(
    'receive_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("receive_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _quotaBytesMeta = const VerificationMeta(
    'quotaBytes',
  );
  @override
  late final GeneratedColumn<int> quotaBytes = GeneratedColumn<int>(
    'quota_bytes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _usedBytesMeta = const VerificationMeta(
    'usedBytes',
  );
  @override
  late final GeneratedColumn<int> usedBytes = GeneratedColumn<int>(
    'used_bytes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _signatureHtmlMeta = const VerificationMeta(
    'signatureHtml',
  );
  @override
  late final GeneratedColumn<String> signatureHtml = GeneratedColumn<String>(
    'signature_html',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _signatureTextMeta = const VerificationMeta(
    'signatureText',
  );
  @override
  late final GeneratedColumn<String> signatureText = GeneratedColumn<String>(
    'signature_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    domainId,
    localPart,
    emailAddress,
    displayName,
    sendEnabled,
    receiveEnabled,
    isActive,
    quotaBytes,
    usedBytes,
    signatureHtml,
    signatureText,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mailboxes';
  @override
  VerificationContext validateIntegrity(
    Insertable<MailboxRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('domain_id')) {
      context.handle(
        _domainIdMeta,
        domainId.isAcceptableOrUnknown(data['domain_id']!, _domainIdMeta),
      );
    } else if (isInserting) {
      context.missing(_domainIdMeta);
    }
    if (data.containsKey('local_part')) {
      context.handle(
        _localPartMeta,
        localPart.isAcceptableOrUnknown(data['local_part']!, _localPartMeta),
      );
    } else if (isInserting) {
      context.missing(_localPartMeta);
    }
    if (data.containsKey('email_address')) {
      context.handle(
        _emailAddressMeta,
        emailAddress.isAcceptableOrUnknown(
          data['email_address']!,
          _emailAddressMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_emailAddressMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    }
    if (data.containsKey('send_enabled')) {
      context.handle(
        _sendEnabledMeta,
        sendEnabled.isAcceptableOrUnknown(
          data['send_enabled']!,
          _sendEnabledMeta,
        ),
      );
    }
    if (data.containsKey('receive_enabled')) {
      context.handle(
        _receiveEnabledMeta,
        receiveEnabled.isAcceptableOrUnknown(
          data['receive_enabled']!,
          _receiveEnabledMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('quota_bytes')) {
      context.handle(
        _quotaBytesMeta,
        quotaBytes.isAcceptableOrUnknown(data['quota_bytes']!, _quotaBytesMeta),
      );
    }
    if (data.containsKey('used_bytes')) {
      context.handle(
        _usedBytesMeta,
        usedBytes.isAcceptableOrUnknown(data['used_bytes']!, _usedBytesMeta),
      );
    }
    if (data.containsKey('signature_html')) {
      context.handle(
        _signatureHtmlMeta,
        signatureHtml.isAcceptableOrUnknown(
          data['signature_html']!,
          _signatureHtmlMeta,
        ),
      );
    }
    if (data.containsKey('signature_text')) {
      context.handle(
        _signatureTextMeta,
        signatureText.isAcceptableOrUnknown(
          data['signature_text']!,
          _signatureTextMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MailboxRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MailboxRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      domainId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}domain_id'],
      )!,
      localPart: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_part'],
      )!,
      emailAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email_address'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      ),
      sendEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}send_enabled'],
      )!,
      receiveEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}receive_enabled'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      quotaBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quota_bytes'],
      )!,
      usedBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}used_bytes'],
      )!,
      signatureHtml: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}signature_html'],
      ),
      signatureText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}signature_text'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $MailboxesTable createAlias(String alias) {
    return $MailboxesTable(attachedDatabase, alias);
  }
}

class MailboxRow extends DataClass implements Insertable<MailboxRow> {
  final String id;
  final String domainId;
  final String localPart;
  final String emailAddress;
  final String? displayName;
  final bool sendEnabled;
  final bool receiveEnabled;
  final bool isActive;
  final int quotaBytes;
  final int usedBytes;
  final String? signatureHtml;
  final String? signatureText;
  final DateTime updatedAt;
  const MailboxRow({
    required this.id,
    required this.domainId,
    required this.localPart,
    required this.emailAddress,
    this.displayName,
    required this.sendEnabled,
    required this.receiveEnabled,
    required this.isActive,
    required this.quotaBytes,
    required this.usedBytes,
    this.signatureHtml,
    this.signatureText,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['domain_id'] = Variable<String>(domainId);
    map['local_part'] = Variable<String>(localPart);
    map['email_address'] = Variable<String>(emailAddress);
    if (!nullToAbsent || displayName != null) {
      map['display_name'] = Variable<String>(displayName);
    }
    map['send_enabled'] = Variable<bool>(sendEnabled);
    map['receive_enabled'] = Variable<bool>(receiveEnabled);
    map['is_active'] = Variable<bool>(isActive);
    map['quota_bytes'] = Variable<int>(quotaBytes);
    map['used_bytes'] = Variable<int>(usedBytes);
    if (!nullToAbsent || signatureHtml != null) {
      map['signature_html'] = Variable<String>(signatureHtml);
    }
    if (!nullToAbsent || signatureText != null) {
      map['signature_text'] = Variable<String>(signatureText);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MailboxesCompanion toCompanion(bool nullToAbsent) {
    return MailboxesCompanion(
      id: Value(id),
      domainId: Value(domainId),
      localPart: Value(localPart),
      emailAddress: Value(emailAddress),
      displayName: displayName == null && nullToAbsent
          ? const Value.absent()
          : Value(displayName),
      sendEnabled: Value(sendEnabled),
      receiveEnabled: Value(receiveEnabled),
      isActive: Value(isActive),
      quotaBytes: Value(quotaBytes),
      usedBytes: Value(usedBytes),
      signatureHtml: signatureHtml == null && nullToAbsent
          ? const Value.absent()
          : Value(signatureHtml),
      signatureText: signatureText == null && nullToAbsent
          ? const Value.absent()
          : Value(signatureText),
      updatedAt: Value(updatedAt),
    );
  }

  factory MailboxRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MailboxRow(
      id: serializer.fromJson<String>(json['id']),
      domainId: serializer.fromJson<String>(json['domainId']),
      localPart: serializer.fromJson<String>(json['localPart']),
      emailAddress: serializer.fromJson<String>(json['emailAddress']),
      displayName: serializer.fromJson<String?>(json['displayName']),
      sendEnabled: serializer.fromJson<bool>(json['sendEnabled']),
      receiveEnabled: serializer.fromJson<bool>(json['receiveEnabled']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      quotaBytes: serializer.fromJson<int>(json['quotaBytes']),
      usedBytes: serializer.fromJson<int>(json['usedBytes']),
      signatureHtml: serializer.fromJson<String?>(json['signatureHtml']),
      signatureText: serializer.fromJson<String?>(json['signatureText']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'domainId': serializer.toJson<String>(domainId),
      'localPart': serializer.toJson<String>(localPart),
      'emailAddress': serializer.toJson<String>(emailAddress),
      'displayName': serializer.toJson<String?>(displayName),
      'sendEnabled': serializer.toJson<bool>(sendEnabled),
      'receiveEnabled': serializer.toJson<bool>(receiveEnabled),
      'isActive': serializer.toJson<bool>(isActive),
      'quotaBytes': serializer.toJson<int>(quotaBytes),
      'usedBytes': serializer.toJson<int>(usedBytes),
      'signatureHtml': serializer.toJson<String?>(signatureHtml),
      'signatureText': serializer.toJson<String?>(signatureText),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MailboxRow copyWith({
    String? id,
    String? domainId,
    String? localPart,
    String? emailAddress,
    Value<String?> displayName = const Value.absent(),
    bool? sendEnabled,
    bool? receiveEnabled,
    bool? isActive,
    int? quotaBytes,
    int? usedBytes,
    Value<String?> signatureHtml = const Value.absent(),
    Value<String?> signatureText = const Value.absent(),
    DateTime? updatedAt,
  }) => MailboxRow(
    id: id ?? this.id,
    domainId: domainId ?? this.domainId,
    localPart: localPart ?? this.localPart,
    emailAddress: emailAddress ?? this.emailAddress,
    displayName: displayName.present ? displayName.value : this.displayName,
    sendEnabled: sendEnabled ?? this.sendEnabled,
    receiveEnabled: receiveEnabled ?? this.receiveEnabled,
    isActive: isActive ?? this.isActive,
    quotaBytes: quotaBytes ?? this.quotaBytes,
    usedBytes: usedBytes ?? this.usedBytes,
    signatureHtml: signatureHtml.present
        ? signatureHtml.value
        : this.signatureHtml,
    signatureText: signatureText.present
        ? signatureText.value
        : this.signatureText,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  MailboxRow copyWithCompanion(MailboxesCompanion data) {
    return MailboxRow(
      id: data.id.present ? data.id.value : this.id,
      domainId: data.domainId.present ? data.domainId.value : this.domainId,
      localPart: data.localPart.present ? data.localPart.value : this.localPart,
      emailAddress: data.emailAddress.present
          ? data.emailAddress.value
          : this.emailAddress,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      sendEnabled: data.sendEnabled.present
          ? data.sendEnabled.value
          : this.sendEnabled,
      receiveEnabled: data.receiveEnabled.present
          ? data.receiveEnabled.value
          : this.receiveEnabled,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      quotaBytes: data.quotaBytes.present
          ? data.quotaBytes.value
          : this.quotaBytes,
      usedBytes: data.usedBytes.present ? data.usedBytes.value : this.usedBytes,
      signatureHtml: data.signatureHtml.present
          ? data.signatureHtml.value
          : this.signatureHtml,
      signatureText: data.signatureText.present
          ? data.signatureText.value
          : this.signatureText,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MailboxRow(')
          ..write('id: $id, ')
          ..write('domainId: $domainId, ')
          ..write('localPart: $localPart, ')
          ..write('emailAddress: $emailAddress, ')
          ..write('displayName: $displayName, ')
          ..write('sendEnabled: $sendEnabled, ')
          ..write('receiveEnabled: $receiveEnabled, ')
          ..write('isActive: $isActive, ')
          ..write('quotaBytes: $quotaBytes, ')
          ..write('usedBytes: $usedBytes, ')
          ..write('signatureHtml: $signatureHtml, ')
          ..write('signatureText: $signatureText, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    domainId,
    localPart,
    emailAddress,
    displayName,
    sendEnabled,
    receiveEnabled,
    isActive,
    quotaBytes,
    usedBytes,
    signatureHtml,
    signatureText,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MailboxRow &&
          other.id == this.id &&
          other.domainId == this.domainId &&
          other.localPart == this.localPart &&
          other.emailAddress == this.emailAddress &&
          other.displayName == this.displayName &&
          other.sendEnabled == this.sendEnabled &&
          other.receiveEnabled == this.receiveEnabled &&
          other.isActive == this.isActive &&
          other.quotaBytes == this.quotaBytes &&
          other.usedBytes == this.usedBytes &&
          other.signatureHtml == this.signatureHtml &&
          other.signatureText == this.signatureText &&
          other.updatedAt == this.updatedAt);
}

class MailboxesCompanion extends UpdateCompanion<MailboxRow> {
  final Value<String> id;
  final Value<String> domainId;
  final Value<String> localPart;
  final Value<String> emailAddress;
  final Value<String?> displayName;
  final Value<bool> sendEnabled;
  final Value<bool> receiveEnabled;
  final Value<bool> isActive;
  final Value<int> quotaBytes;
  final Value<int> usedBytes;
  final Value<String?> signatureHtml;
  final Value<String?> signatureText;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const MailboxesCompanion({
    this.id = const Value.absent(),
    this.domainId = const Value.absent(),
    this.localPart = const Value.absent(),
    this.emailAddress = const Value.absent(),
    this.displayName = const Value.absent(),
    this.sendEnabled = const Value.absent(),
    this.receiveEnabled = const Value.absent(),
    this.isActive = const Value.absent(),
    this.quotaBytes = const Value.absent(),
    this.usedBytes = const Value.absent(),
    this.signatureHtml = const Value.absent(),
    this.signatureText = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MailboxesCompanion.insert({
    required String id,
    required String domainId,
    required String localPart,
    required String emailAddress,
    this.displayName = const Value.absent(),
    this.sendEnabled = const Value.absent(),
    this.receiveEnabled = const Value.absent(),
    this.isActive = const Value.absent(),
    this.quotaBytes = const Value.absent(),
    this.usedBytes = const Value.absent(),
    this.signatureHtml = const Value.absent(),
    this.signatureText = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       domainId = Value(domainId),
       localPart = Value(localPart),
       emailAddress = Value(emailAddress),
       updatedAt = Value(updatedAt);
  static Insertable<MailboxRow> custom({
    Expression<String>? id,
    Expression<String>? domainId,
    Expression<String>? localPart,
    Expression<String>? emailAddress,
    Expression<String>? displayName,
    Expression<bool>? sendEnabled,
    Expression<bool>? receiveEnabled,
    Expression<bool>? isActive,
    Expression<int>? quotaBytes,
    Expression<int>? usedBytes,
    Expression<String>? signatureHtml,
    Expression<String>? signatureText,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (domainId != null) 'domain_id': domainId,
      if (localPart != null) 'local_part': localPart,
      if (emailAddress != null) 'email_address': emailAddress,
      if (displayName != null) 'display_name': displayName,
      if (sendEnabled != null) 'send_enabled': sendEnabled,
      if (receiveEnabled != null) 'receive_enabled': receiveEnabled,
      if (isActive != null) 'is_active': isActive,
      if (quotaBytes != null) 'quota_bytes': quotaBytes,
      if (usedBytes != null) 'used_bytes': usedBytes,
      if (signatureHtml != null) 'signature_html': signatureHtml,
      if (signatureText != null) 'signature_text': signatureText,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MailboxesCompanion copyWith({
    Value<String>? id,
    Value<String>? domainId,
    Value<String>? localPart,
    Value<String>? emailAddress,
    Value<String?>? displayName,
    Value<bool>? sendEnabled,
    Value<bool>? receiveEnabled,
    Value<bool>? isActive,
    Value<int>? quotaBytes,
    Value<int>? usedBytes,
    Value<String?>? signatureHtml,
    Value<String?>? signatureText,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return MailboxesCompanion(
      id: id ?? this.id,
      domainId: domainId ?? this.domainId,
      localPart: localPart ?? this.localPart,
      emailAddress: emailAddress ?? this.emailAddress,
      displayName: displayName ?? this.displayName,
      sendEnabled: sendEnabled ?? this.sendEnabled,
      receiveEnabled: receiveEnabled ?? this.receiveEnabled,
      isActive: isActive ?? this.isActive,
      quotaBytes: quotaBytes ?? this.quotaBytes,
      usedBytes: usedBytes ?? this.usedBytes,
      signatureHtml: signatureHtml ?? this.signatureHtml,
      signatureText: signatureText ?? this.signatureText,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (domainId.present) {
      map['domain_id'] = Variable<String>(domainId.value);
    }
    if (localPart.present) {
      map['local_part'] = Variable<String>(localPart.value);
    }
    if (emailAddress.present) {
      map['email_address'] = Variable<String>(emailAddress.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (sendEnabled.present) {
      map['send_enabled'] = Variable<bool>(sendEnabled.value);
    }
    if (receiveEnabled.present) {
      map['receive_enabled'] = Variable<bool>(receiveEnabled.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (quotaBytes.present) {
      map['quota_bytes'] = Variable<int>(quotaBytes.value);
    }
    if (usedBytes.present) {
      map['used_bytes'] = Variable<int>(usedBytes.value);
    }
    if (signatureHtml.present) {
      map['signature_html'] = Variable<String>(signatureHtml.value);
    }
    if (signatureText.present) {
      map['signature_text'] = Variable<String>(signatureText.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MailboxesCompanion(')
          ..write('id: $id, ')
          ..write('domainId: $domainId, ')
          ..write('localPart: $localPart, ')
          ..write('emailAddress: $emailAddress, ')
          ..write('displayName: $displayName, ')
          ..write('sendEnabled: $sendEnabled, ')
          ..write('receiveEnabled: $receiveEnabled, ')
          ..write('isActive: $isActive, ')
          ..write('quotaBytes: $quotaBytes, ')
          ..write('usedBytes: $usedBytes, ')
          ..write('signatureHtml: $signatureHtml, ')
          ..write('signatureText: $signatureText, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ThreadsTable extends Threads with TableInfo<$ThreadsTable, ThreadRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ThreadsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mailboxIdMeta = const VerificationMeta(
    'mailboxId',
  );
  @override
  late final GeneratedColumn<String> mailboxId = GeneratedColumn<String>(
    'mailbox_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subjectMeta = const VerificationMeta(
    'subject',
  );
  @override
  late final GeneratedColumn<String> subject = GeneratedColumn<String>(
    'subject',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _messageCountMeta = const VerificationMeta(
    'messageCount',
  );
  @override
  late final GeneratedColumn<int> messageCount = GeneratedColumn<int>(
    'message_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _hasUnreadMeta = const VerificationMeta(
    'hasUnread',
  );
  @override
  late final GeneratedColumn<bool> hasUnread = GeneratedColumn<bool>(
    'has_unread',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_unread" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _unreadCountMeta = const VerificationMeta(
    'unreadCount',
  );
  @override
  late final GeneratedColumn<int> unreadCount = GeneratedColumn<int>(
    'unread_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _snippetMeta = const VerificationMeta(
    'snippet',
  );
  @override
  late final GeneratedColumn<String> snippet = GeneratedColumn<String>(
    'snippet',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _latestDirectionMeta = const VerificationMeta(
    'latestDirection',
  );
  @override
  late final GeneratedColumn<String> latestDirection = GeneratedColumn<String>(
    'latest_direction',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hasAttachmentsMeta = const VerificationMeta(
    'hasAttachments',
  );
  @override
  late final GeneratedColumn<bool> hasAttachments = GeneratedColumn<bool>(
    'has_attachments',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_attachments" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _attachmentFilenamesJsonMeta =
      const VerificationMeta('attachmentFilenamesJson');
  @override
  late final GeneratedColumn<String> attachmentFilenamesJson =
      GeneratedColumn<String>(
        'attachment_filenames_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      );
  static const VerificationMeta _labelsJsonMeta = const VerificationMeta(
    'labelsJson',
  );
  @override
  late final GeneratedColumn<String> labelsJson = GeneratedColumn<String>(
    'labels_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _searchHighlightMeta = const VerificationMeta(
    'searchHighlight',
  );
  @override
  late final GeneratedColumn<String> searchHighlight = GeneratedColumn<String>(
    'search_highlight',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastMessageAtMeta = const VerificationMeta(
    'lastMessageAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastMessageAt =
      GeneratedColumn<DateTime>(
        'last_message_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _participantsJsonMeta = const VerificationMeta(
    'participantsJson',
  );
  @override
  late final GeneratedColumn<String> participantsJson = GeneratedColumn<String>(
    'participants_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _folderMeta = const VerificationMeta('folder');
  @override
  late final GeneratedColumn<String> folder = GeneratedColumn<String>(
    'folder',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('inbox'),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    mailboxId,
    subject,
    messageCount,
    hasUnread,
    unreadCount,
    snippet,
    latestDirection,
    hasAttachments,
    attachmentFilenamesJson,
    labelsJson,
    searchHighlight,
    lastMessageAt,
    participantsJson,
    folder,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'threads';
  @override
  VerificationContext validateIntegrity(
    Insertable<ThreadRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('mailbox_id')) {
      context.handle(
        _mailboxIdMeta,
        mailboxId.isAcceptableOrUnknown(data['mailbox_id']!, _mailboxIdMeta),
      );
    } else if (isInserting) {
      context.missing(_mailboxIdMeta);
    }
    if (data.containsKey('subject')) {
      context.handle(
        _subjectMeta,
        subject.isAcceptableOrUnknown(data['subject']!, _subjectMeta),
      );
    } else if (isInserting) {
      context.missing(_subjectMeta);
    }
    if (data.containsKey('message_count')) {
      context.handle(
        _messageCountMeta,
        messageCount.isAcceptableOrUnknown(
          data['message_count']!,
          _messageCountMeta,
        ),
      );
    }
    if (data.containsKey('has_unread')) {
      context.handle(
        _hasUnreadMeta,
        hasUnread.isAcceptableOrUnknown(data['has_unread']!, _hasUnreadMeta),
      );
    }
    if (data.containsKey('unread_count')) {
      context.handle(
        _unreadCountMeta,
        unreadCount.isAcceptableOrUnknown(
          data['unread_count']!,
          _unreadCountMeta,
        ),
      );
    }
    if (data.containsKey('snippet')) {
      context.handle(
        _snippetMeta,
        snippet.isAcceptableOrUnknown(data['snippet']!, _snippetMeta),
      );
    }
    if (data.containsKey('latest_direction')) {
      context.handle(
        _latestDirectionMeta,
        latestDirection.isAcceptableOrUnknown(
          data['latest_direction']!,
          _latestDirectionMeta,
        ),
      );
    }
    if (data.containsKey('has_attachments')) {
      context.handle(
        _hasAttachmentsMeta,
        hasAttachments.isAcceptableOrUnknown(
          data['has_attachments']!,
          _hasAttachmentsMeta,
        ),
      );
    }
    if (data.containsKey('attachment_filenames_json')) {
      context.handle(
        _attachmentFilenamesJsonMeta,
        attachmentFilenamesJson.isAcceptableOrUnknown(
          data['attachment_filenames_json']!,
          _attachmentFilenamesJsonMeta,
        ),
      );
    }
    if (data.containsKey('labels_json')) {
      context.handle(
        _labelsJsonMeta,
        labelsJson.isAcceptableOrUnknown(data['labels_json']!, _labelsJsonMeta),
      );
    }
    if (data.containsKey('search_highlight')) {
      context.handle(
        _searchHighlightMeta,
        searchHighlight.isAcceptableOrUnknown(
          data['search_highlight']!,
          _searchHighlightMeta,
        ),
      );
    }
    if (data.containsKey('last_message_at')) {
      context.handle(
        _lastMessageAtMeta,
        lastMessageAt.isAcceptableOrUnknown(
          data['last_message_at']!,
          _lastMessageAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastMessageAtMeta);
    }
    if (data.containsKey('participants_json')) {
      context.handle(
        _participantsJsonMeta,
        participantsJson.isAcceptableOrUnknown(
          data['participants_json']!,
          _participantsJsonMeta,
        ),
      );
    }
    if (data.containsKey('folder')) {
      context.handle(
        _folderMeta,
        folder.isAcceptableOrUnknown(data['folder']!, _folderMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, folder};
  @override
  ThreadRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ThreadRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      mailboxId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mailbox_id'],
      )!,
      subject: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subject'],
      )!,
      messageCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}message_count'],
      )!,
      hasUnread: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_unread'],
      )!,
      unreadCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unread_count'],
      )!,
      snippet: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}snippet'],
      ),
      latestDirection: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}latest_direction'],
      ),
      hasAttachments: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_attachments'],
      )!,
      attachmentFilenamesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attachment_filenames_json'],
      )!,
      labelsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}labels_json'],
      )!,
      searchHighlight: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}search_highlight'],
      ),
      lastMessageAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_message_at'],
      )!,
      participantsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}participants_json'],
      )!,
      folder: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}folder'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ThreadsTable createAlias(String alias) {
    return $ThreadsTable(attachedDatabase, alias);
  }
}

class ThreadRow extends DataClass implements Insertable<ThreadRow> {
  final String id;
  final String mailboxId;
  final String subject;
  final int messageCount;
  final bool hasUnread;
  final int unreadCount;
  final String? snippet;
  final String? latestDirection;
  final bool hasAttachments;
  final String attachmentFilenamesJson;
  final String labelsJson;
  final String? searchHighlight;
  final DateTime lastMessageAt;
  final String participantsJson;
  final String folder;
  final DateTime updatedAt;
  const ThreadRow({
    required this.id,
    required this.mailboxId,
    required this.subject,
    required this.messageCount,
    required this.hasUnread,
    required this.unreadCount,
    this.snippet,
    this.latestDirection,
    required this.hasAttachments,
    required this.attachmentFilenamesJson,
    required this.labelsJson,
    this.searchHighlight,
    required this.lastMessageAt,
    required this.participantsJson,
    required this.folder,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['mailbox_id'] = Variable<String>(mailboxId);
    map['subject'] = Variable<String>(subject);
    map['message_count'] = Variable<int>(messageCount);
    map['has_unread'] = Variable<bool>(hasUnread);
    map['unread_count'] = Variable<int>(unreadCount);
    if (!nullToAbsent || snippet != null) {
      map['snippet'] = Variable<String>(snippet);
    }
    if (!nullToAbsent || latestDirection != null) {
      map['latest_direction'] = Variable<String>(latestDirection);
    }
    map['has_attachments'] = Variable<bool>(hasAttachments);
    map['attachment_filenames_json'] = Variable<String>(
      attachmentFilenamesJson,
    );
    map['labels_json'] = Variable<String>(labelsJson);
    if (!nullToAbsent || searchHighlight != null) {
      map['search_highlight'] = Variable<String>(searchHighlight);
    }
    map['last_message_at'] = Variable<DateTime>(lastMessageAt);
    map['participants_json'] = Variable<String>(participantsJson);
    map['folder'] = Variable<String>(folder);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ThreadsCompanion toCompanion(bool nullToAbsent) {
    return ThreadsCompanion(
      id: Value(id),
      mailboxId: Value(mailboxId),
      subject: Value(subject),
      messageCount: Value(messageCount),
      hasUnread: Value(hasUnread),
      unreadCount: Value(unreadCount),
      snippet: snippet == null && nullToAbsent
          ? const Value.absent()
          : Value(snippet),
      latestDirection: latestDirection == null && nullToAbsent
          ? const Value.absent()
          : Value(latestDirection),
      hasAttachments: Value(hasAttachments),
      attachmentFilenamesJson: Value(attachmentFilenamesJson),
      labelsJson: Value(labelsJson),
      searchHighlight: searchHighlight == null && nullToAbsent
          ? const Value.absent()
          : Value(searchHighlight),
      lastMessageAt: Value(lastMessageAt),
      participantsJson: Value(participantsJson),
      folder: Value(folder),
      updatedAt: Value(updatedAt),
    );
  }

  factory ThreadRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ThreadRow(
      id: serializer.fromJson<String>(json['id']),
      mailboxId: serializer.fromJson<String>(json['mailboxId']),
      subject: serializer.fromJson<String>(json['subject']),
      messageCount: serializer.fromJson<int>(json['messageCount']),
      hasUnread: serializer.fromJson<bool>(json['hasUnread']),
      unreadCount: serializer.fromJson<int>(json['unreadCount']),
      snippet: serializer.fromJson<String?>(json['snippet']),
      latestDirection: serializer.fromJson<String?>(json['latestDirection']),
      hasAttachments: serializer.fromJson<bool>(json['hasAttachments']),
      attachmentFilenamesJson: serializer.fromJson<String>(
        json['attachmentFilenamesJson'],
      ),
      labelsJson: serializer.fromJson<String>(json['labelsJson']),
      searchHighlight: serializer.fromJson<String?>(json['searchHighlight']),
      lastMessageAt: serializer.fromJson<DateTime>(json['lastMessageAt']),
      participantsJson: serializer.fromJson<String>(json['participantsJson']),
      folder: serializer.fromJson<String>(json['folder']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'mailboxId': serializer.toJson<String>(mailboxId),
      'subject': serializer.toJson<String>(subject),
      'messageCount': serializer.toJson<int>(messageCount),
      'hasUnread': serializer.toJson<bool>(hasUnread),
      'unreadCount': serializer.toJson<int>(unreadCount),
      'snippet': serializer.toJson<String?>(snippet),
      'latestDirection': serializer.toJson<String?>(latestDirection),
      'hasAttachments': serializer.toJson<bool>(hasAttachments),
      'attachmentFilenamesJson': serializer.toJson<String>(
        attachmentFilenamesJson,
      ),
      'labelsJson': serializer.toJson<String>(labelsJson),
      'searchHighlight': serializer.toJson<String?>(searchHighlight),
      'lastMessageAt': serializer.toJson<DateTime>(lastMessageAt),
      'participantsJson': serializer.toJson<String>(participantsJson),
      'folder': serializer.toJson<String>(folder),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ThreadRow copyWith({
    String? id,
    String? mailboxId,
    String? subject,
    int? messageCount,
    bool? hasUnread,
    int? unreadCount,
    Value<String?> snippet = const Value.absent(),
    Value<String?> latestDirection = const Value.absent(),
    bool? hasAttachments,
    String? attachmentFilenamesJson,
    String? labelsJson,
    Value<String?> searchHighlight = const Value.absent(),
    DateTime? lastMessageAt,
    String? participantsJson,
    String? folder,
    DateTime? updatedAt,
  }) => ThreadRow(
    id: id ?? this.id,
    mailboxId: mailboxId ?? this.mailboxId,
    subject: subject ?? this.subject,
    messageCount: messageCount ?? this.messageCount,
    hasUnread: hasUnread ?? this.hasUnread,
    unreadCount: unreadCount ?? this.unreadCount,
    snippet: snippet.present ? snippet.value : this.snippet,
    latestDirection: latestDirection.present
        ? latestDirection.value
        : this.latestDirection,
    hasAttachments: hasAttachments ?? this.hasAttachments,
    attachmentFilenamesJson:
        attachmentFilenamesJson ?? this.attachmentFilenamesJson,
    labelsJson: labelsJson ?? this.labelsJson,
    searchHighlight: searchHighlight.present
        ? searchHighlight.value
        : this.searchHighlight,
    lastMessageAt: lastMessageAt ?? this.lastMessageAt,
    participantsJson: participantsJson ?? this.participantsJson,
    folder: folder ?? this.folder,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ThreadRow copyWithCompanion(ThreadsCompanion data) {
    return ThreadRow(
      id: data.id.present ? data.id.value : this.id,
      mailboxId: data.mailboxId.present ? data.mailboxId.value : this.mailboxId,
      subject: data.subject.present ? data.subject.value : this.subject,
      messageCount: data.messageCount.present
          ? data.messageCount.value
          : this.messageCount,
      hasUnread: data.hasUnread.present ? data.hasUnread.value : this.hasUnread,
      unreadCount: data.unreadCount.present
          ? data.unreadCount.value
          : this.unreadCount,
      snippet: data.snippet.present ? data.snippet.value : this.snippet,
      latestDirection: data.latestDirection.present
          ? data.latestDirection.value
          : this.latestDirection,
      hasAttachments: data.hasAttachments.present
          ? data.hasAttachments.value
          : this.hasAttachments,
      attachmentFilenamesJson: data.attachmentFilenamesJson.present
          ? data.attachmentFilenamesJson.value
          : this.attachmentFilenamesJson,
      labelsJson: data.labelsJson.present
          ? data.labelsJson.value
          : this.labelsJson,
      searchHighlight: data.searchHighlight.present
          ? data.searchHighlight.value
          : this.searchHighlight,
      lastMessageAt: data.lastMessageAt.present
          ? data.lastMessageAt.value
          : this.lastMessageAt,
      participantsJson: data.participantsJson.present
          ? data.participantsJson.value
          : this.participantsJson,
      folder: data.folder.present ? data.folder.value : this.folder,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ThreadRow(')
          ..write('id: $id, ')
          ..write('mailboxId: $mailboxId, ')
          ..write('subject: $subject, ')
          ..write('messageCount: $messageCount, ')
          ..write('hasUnread: $hasUnread, ')
          ..write('unreadCount: $unreadCount, ')
          ..write('snippet: $snippet, ')
          ..write('latestDirection: $latestDirection, ')
          ..write('hasAttachments: $hasAttachments, ')
          ..write('attachmentFilenamesJson: $attachmentFilenamesJson, ')
          ..write('labelsJson: $labelsJson, ')
          ..write('searchHighlight: $searchHighlight, ')
          ..write('lastMessageAt: $lastMessageAt, ')
          ..write('participantsJson: $participantsJson, ')
          ..write('folder: $folder, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    mailboxId,
    subject,
    messageCount,
    hasUnread,
    unreadCount,
    snippet,
    latestDirection,
    hasAttachments,
    attachmentFilenamesJson,
    labelsJson,
    searchHighlight,
    lastMessageAt,
    participantsJson,
    folder,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ThreadRow &&
          other.id == this.id &&
          other.mailboxId == this.mailboxId &&
          other.subject == this.subject &&
          other.messageCount == this.messageCount &&
          other.hasUnread == this.hasUnread &&
          other.unreadCount == this.unreadCount &&
          other.snippet == this.snippet &&
          other.latestDirection == this.latestDirection &&
          other.hasAttachments == this.hasAttachments &&
          other.attachmentFilenamesJson == this.attachmentFilenamesJson &&
          other.labelsJson == this.labelsJson &&
          other.searchHighlight == this.searchHighlight &&
          other.lastMessageAt == this.lastMessageAt &&
          other.participantsJson == this.participantsJson &&
          other.folder == this.folder &&
          other.updatedAt == this.updatedAt);
}

class ThreadsCompanion extends UpdateCompanion<ThreadRow> {
  final Value<String> id;
  final Value<String> mailboxId;
  final Value<String> subject;
  final Value<int> messageCount;
  final Value<bool> hasUnread;
  final Value<int> unreadCount;
  final Value<String?> snippet;
  final Value<String?> latestDirection;
  final Value<bool> hasAttachments;
  final Value<String> attachmentFilenamesJson;
  final Value<String> labelsJson;
  final Value<String?> searchHighlight;
  final Value<DateTime> lastMessageAt;
  final Value<String> participantsJson;
  final Value<String> folder;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ThreadsCompanion({
    this.id = const Value.absent(),
    this.mailboxId = const Value.absent(),
    this.subject = const Value.absent(),
    this.messageCount = const Value.absent(),
    this.hasUnread = const Value.absent(),
    this.unreadCount = const Value.absent(),
    this.snippet = const Value.absent(),
    this.latestDirection = const Value.absent(),
    this.hasAttachments = const Value.absent(),
    this.attachmentFilenamesJson = const Value.absent(),
    this.labelsJson = const Value.absent(),
    this.searchHighlight = const Value.absent(),
    this.lastMessageAt = const Value.absent(),
    this.participantsJson = const Value.absent(),
    this.folder = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ThreadsCompanion.insert({
    required String id,
    required String mailboxId,
    required String subject,
    this.messageCount = const Value.absent(),
    this.hasUnread = const Value.absent(),
    this.unreadCount = const Value.absent(),
    this.snippet = const Value.absent(),
    this.latestDirection = const Value.absent(),
    this.hasAttachments = const Value.absent(),
    this.attachmentFilenamesJson = const Value.absent(),
    this.labelsJson = const Value.absent(),
    this.searchHighlight = const Value.absent(),
    required DateTime lastMessageAt,
    this.participantsJson = const Value.absent(),
    this.folder = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       mailboxId = Value(mailboxId),
       subject = Value(subject),
       lastMessageAt = Value(lastMessageAt),
       updatedAt = Value(updatedAt);
  static Insertable<ThreadRow> custom({
    Expression<String>? id,
    Expression<String>? mailboxId,
    Expression<String>? subject,
    Expression<int>? messageCount,
    Expression<bool>? hasUnread,
    Expression<int>? unreadCount,
    Expression<String>? snippet,
    Expression<String>? latestDirection,
    Expression<bool>? hasAttachments,
    Expression<String>? attachmentFilenamesJson,
    Expression<String>? labelsJson,
    Expression<String>? searchHighlight,
    Expression<DateTime>? lastMessageAt,
    Expression<String>? participantsJson,
    Expression<String>? folder,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mailboxId != null) 'mailbox_id': mailboxId,
      if (subject != null) 'subject': subject,
      if (messageCount != null) 'message_count': messageCount,
      if (hasUnread != null) 'has_unread': hasUnread,
      if (unreadCount != null) 'unread_count': unreadCount,
      if (snippet != null) 'snippet': snippet,
      if (latestDirection != null) 'latest_direction': latestDirection,
      if (hasAttachments != null) 'has_attachments': hasAttachments,
      if (attachmentFilenamesJson != null)
        'attachment_filenames_json': attachmentFilenamesJson,
      if (labelsJson != null) 'labels_json': labelsJson,
      if (searchHighlight != null) 'search_highlight': searchHighlight,
      if (lastMessageAt != null) 'last_message_at': lastMessageAt,
      if (participantsJson != null) 'participants_json': participantsJson,
      if (folder != null) 'folder': folder,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ThreadsCompanion copyWith({
    Value<String>? id,
    Value<String>? mailboxId,
    Value<String>? subject,
    Value<int>? messageCount,
    Value<bool>? hasUnread,
    Value<int>? unreadCount,
    Value<String?>? snippet,
    Value<String?>? latestDirection,
    Value<bool>? hasAttachments,
    Value<String>? attachmentFilenamesJson,
    Value<String>? labelsJson,
    Value<String?>? searchHighlight,
    Value<DateTime>? lastMessageAt,
    Value<String>? participantsJson,
    Value<String>? folder,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ThreadsCompanion(
      id: id ?? this.id,
      mailboxId: mailboxId ?? this.mailboxId,
      subject: subject ?? this.subject,
      messageCount: messageCount ?? this.messageCount,
      hasUnread: hasUnread ?? this.hasUnread,
      unreadCount: unreadCount ?? this.unreadCount,
      snippet: snippet ?? this.snippet,
      latestDirection: latestDirection ?? this.latestDirection,
      hasAttachments: hasAttachments ?? this.hasAttachments,
      attachmentFilenamesJson:
          attachmentFilenamesJson ?? this.attachmentFilenamesJson,
      labelsJson: labelsJson ?? this.labelsJson,
      searchHighlight: searchHighlight ?? this.searchHighlight,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      participantsJson: participantsJson ?? this.participantsJson,
      folder: folder ?? this.folder,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (mailboxId.present) {
      map['mailbox_id'] = Variable<String>(mailboxId.value);
    }
    if (subject.present) {
      map['subject'] = Variable<String>(subject.value);
    }
    if (messageCount.present) {
      map['message_count'] = Variable<int>(messageCount.value);
    }
    if (hasUnread.present) {
      map['has_unread'] = Variable<bool>(hasUnread.value);
    }
    if (unreadCount.present) {
      map['unread_count'] = Variable<int>(unreadCount.value);
    }
    if (snippet.present) {
      map['snippet'] = Variable<String>(snippet.value);
    }
    if (latestDirection.present) {
      map['latest_direction'] = Variable<String>(latestDirection.value);
    }
    if (hasAttachments.present) {
      map['has_attachments'] = Variable<bool>(hasAttachments.value);
    }
    if (attachmentFilenamesJson.present) {
      map['attachment_filenames_json'] = Variable<String>(
        attachmentFilenamesJson.value,
      );
    }
    if (labelsJson.present) {
      map['labels_json'] = Variable<String>(labelsJson.value);
    }
    if (searchHighlight.present) {
      map['search_highlight'] = Variable<String>(searchHighlight.value);
    }
    if (lastMessageAt.present) {
      map['last_message_at'] = Variable<DateTime>(lastMessageAt.value);
    }
    if (participantsJson.present) {
      map['participants_json'] = Variable<String>(participantsJson.value);
    }
    if (folder.present) {
      map['folder'] = Variable<String>(folder.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ThreadsCompanion(')
          ..write('id: $id, ')
          ..write('mailboxId: $mailboxId, ')
          ..write('subject: $subject, ')
          ..write('messageCount: $messageCount, ')
          ..write('hasUnread: $hasUnread, ')
          ..write('unreadCount: $unreadCount, ')
          ..write('snippet: $snippet, ')
          ..write('latestDirection: $latestDirection, ')
          ..write('hasAttachments: $hasAttachments, ')
          ..write('attachmentFilenamesJson: $attachmentFilenamesJson, ')
          ..write('labelsJson: $labelsJson, ')
          ..write('searchHighlight: $searchHighlight, ')
          ..write('lastMessageAt: $lastMessageAt, ')
          ..write('participantsJson: $participantsJson, ')
          ..write('folder: $folder, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MessagesTable extends Messages
    with TableInfo<$MessagesTable, MessageRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mailboxIdMeta = const VerificationMeta(
    'mailboxId',
  );
  @override
  late final GeneratedColumn<String> mailboxId = GeneratedColumn<String>(
    'mailbox_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _threadIdMeta = const VerificationMeta(
    'threadId',
  );
  @override
  late final GeneratedColumn<String> threadId = GeneratedColumn<String>(
    'thread_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _directionMeta = const VerificationMeta(
    'direction',
  );
  @override
  late final GeneratedColumn<String> direction = GeneratedColumn<String>(
    'direction',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _folderMeta = const VerificationMeta('folder');
  @override
  late final GeneratedColumn<String> folder = GeneratedColumn<String>(
    'folder',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('inbox'),
  );
  static const VerificationMeta _fromAddressMeta = const VerificationMeta(
    'fromAddress',
  );
  @override
  late final GeneratedColumn<String> fromAddress = GeneratedColumn<String>(
    'from_address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fromNameMeta = const VerificationMeta(
    'fromName',
  );
  @override
  late final GeneratedColumn<String> fromName = GeneratedColumn<String>(
    'from_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _envelopeSenderMeta = const VerificationMeta(
    'envelopeSender',
  );
  @override
  late final GeneratedColumn<String> envelopeSender = GeneratedColumn<String>(
    'envelope_sender',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _envelopeRecipientMeta = const VerificationMeta(
    'envelopeRecipient',
  );
  @override
  late final GeneratedColumn<String> envelopeRecipient =
      GeneratedColumn<String>(
        'envelope_recipient',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _toAddressesJsonMeta = const VerificationMeta(
    'toAddressesJson',
  );
  @override
  late final GeneratedColumn<String> toAddressesJson = GeneratedColumn<String>(
    'to_addresses_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _ccAddressesJsonMeta = const VerificationMeta(
    'ccAddressesJson',
  );
  @override
  late final GeneratedColumn<String> ccAddressesJson = GeneratedColumn<String>(
    'cc_addresses_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _bccAddressesJsonMeta = const VerificationMeta(
    'bccAddressesJson',
  );
  @override
  late final GeneratedColumn<String> bccAddressesJson = GeneratedColumn<String>(
    'bcc_addresses_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _replyToMeta = const VerificationMeta(
    'replyTo',
  );
  @override
  late final GeneratedColumn<String> replyTo = GeneratedColumn<String>(
    'reply_to',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _subjectMeta = const VerificationMeta(
    'subject',
  );
  @override
  late final GeneratedColumn<String> subject = GeneratedColumn<String>(
    'subject',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _snippetMeta = const VerificationMeta(
    'snippet',
  );
  @override
  late final GeneratedColumn<String> snippet = GeneratedColumn<String>(
    'snippet',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bodyTextMeta = const VerificationMeta(
    'bodyText',
  );
  @override
  late final GeneratedColumn<String> bodyText = GeneratedColumn<String>(
    'body_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bodyHtmlMeta = const VerificationMeta(
    'bodyHtml',
  );
  @override
  late final GeneratedColumn<String> bodyHtml = GeneratedColumn<String>(
    'body_html',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rawMimeUrlMeta = const VerificationMeta(
    'rawMimeUrl',
  );
  @override
  late final GeneratedColumn<String> rawMimeUrl = GeneratedColumn<String>(
    'raw_mime_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isReadMeta = const VerificationMeta('isRead');
  @override
  late final GeneratedColumn<bool> isRead = GeneratedColumn<bool>(
    'is_read',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_read" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isStarredMeta = const VerificationMeta(
    'isStarred',
  );
  @override
  late final GeneratedColumn<bool> isStarred = GeneratedColumn<bool>(
    'is_starred',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_starred" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _hasAttachmentsMeta = const VerificationMeta(
    'hasAttachments',
  );
  @override
  late final GeneratedColumn<bool> hasAttachments = GeneratedColumn<bool>(
    'has_attachments',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_attachments" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _attachmentsJsonMeta = const VerificationMeta(
    'attachmentsJson',
  );
  @override
  late final GeneratedColumn<String> attachmentsJson = GeneratedColumn<String>(
    'attachments_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _rawHeadersJsonMeta = const VerificationMeta(
    'rawHeadersJson',
  );
  @override
  late final GeneratedColumn<String> rawHeadersJson = GeneratedColumn<String>(
    'raw_headers_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _metadataJsonMeta = const VerificationMeta(
    'metadataJson',
  );
  @override
  late final GeneratedColumn<String> metadataJson = GeneratedColumn<String>(
    'metadata_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _receivedAtMeta = const VerificationMeta(
    'receivedAt',
  );
  @override
  late final GeneratedColumn<DateTime> receivedAt = GeneratedColumn<DateTime>(
    'received_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sentAtMeta = const VerificationMeta('sentAt');
  @override
  late final GeneratedColumn<DateTime> sentAt = GeneratedColumn<DateTime>(
    'sent_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _scheduledAtMeta = const VerificationMeta(
    'scheduledAt',
  );
  @override
  late final GeneratedColumn<DateTime> scheduledAt = GeneratedColumn<DateTime>(
    'scheduled_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    mailboxId,
    threadId,
    direction,
    status,
    folder,
    fromAddress,
    fromName,
    envelopeSender,
    envelopeRecipient,
    toAddressesJson,
    ccAddressesJson,
    bccAddressesJson,
    replyTo,
    subject,
    snippet,
    bodyText,
    bodyHtml,
    rawMimeUrl,
    isRead,
    isStarred,
    hasAttachments,
    attachmentsJson,
    rawHeadersJson,
    metadataJson,
    receivedAt,
    sentAt,
    scheduledAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'messages';
  @override
  VerificationContext validateIntegrity(
    Insertable<MessageRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('mailbox_id')) {
      context.handle(
        _mailboxIdMeta,
        mailboxId.isAcceptableOrUnknown(data['mailbox_id']!, _mailboxIdMeta),
      );
    } else if (isInserting) {
      context.missing(_mailboxIdMeta);
    }
    if (data.containsKey('thread_id')) {
      context.handle(
        _threadIdMeta,
        threadId.isAcceptableOrUnknown(data['thread_id']!, _threadIdMeta),
      );
    }
    if (data.containsKey('direction')) {
      context.handle(
        _directionMeta,
        direction.isAcceptableOrUnknown(data['direction']!, _directionMeta),
      );
    } else if (isInserting) {
      context.missing(_directionMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('folder')) {
      context.handle(
        _folderMeta,
        folder.isAcceptableOrUnknown(data['folder']!, _folderMeta),
      );
    }
    if (data.containsKey('from_address')) {
      context.handle(
        _fromAddressMeta,
        fromAddress.isAcceptableOrUnknown(
          data['from_address']!,
          _fromAddressMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fromAddressMeta);
    }
    if (data.containsKey('from_name')) {
      context.handle(
        _fromNameMeta,
        fromName.isAcceptableOrUnknown(data['from_name']!, _fromNameMeta),
      );
    }
    if (data.containsKey('envelope_sender')) {
      context.handle(
        _envelopeSenderMeta,
        envelopeSender.isAcceptableOrUnknown(
          data['envelope_sender']!,
          _envelopeSenderMeta,
        ),
      );
    }
    if (data.containsKey('envelope_recipient')) {
      context.handle(
        _envelopeRecipientMeta,
        envelopeRecipient.isAcceptableOrUnknown(
          data['envelope_recipient']!,
          _envelopeRecipientMeta,
        ),
      );
    }
    if (data.containsKey('to_addresses_json')) {
      context.handle(
        _toAddressesJsonMeta,
        toAddressesJson.isAcceptableOrUnknown(
          data['to_addresses_json']!,
          _toAddressesJsonMeta,
        ),
      );
    }
    if (data.containsKey('cc_addresses_json')) {
      context.handle(
        _ccAddressesJsonMeta,
        ccAddressesJson.isAcceptableOrUnknown(
          data['cc_addresses_json']!,
          _ccAddressesJsonMeta,
        ),
      );
    }
    if (data.containsKey('bcc_addresses_json')) {
      context.handle(
        _bccAddressesJsonMeta,
        bccAddressesJson.isAcceptableOrUnknown(
          data['bcc_addresses_json']!,
          _bccAddressesJsonMeta,
        ),
      );
    }
    if (data.containsKey('reply_to')) {
      context.handle(
        _replyToMeta,
        replyTo.isAcceptableOrUnknown(data['reply_to']!, _replyToMeta),
      );
    }
    if (data.containsKey('subject')) {
      context.handle(
        _subjectMeta,
        subject.isAcceptableOrUnknown(data['subject']!, _subjectMeta),
      );
    } else if (isInserting) {
      context.missing(_subjectMeta);
    }
    if (data.containsKey('snippet')) {
      context.handle(
        _snippetMeta,
        snippet.isAcceptableOrUnknown(data['snippet']!, _snippetMeta),
      );
    }
    if (data.containsKey('body_text')) {
      context.handle(
        _bodyTextMeta,
        bodyText.isAcceptableOrUnknown(data['body_text']!, _bodyTextMeta),
      );
    }
    if (data.containsKey('body_html')) {
      context.handle(
        _bodyHtmlMeta,
        bodyHtml.isAcceptableOrUnknown(data['body_html']!, _bodyHtmlMeta),
      );
    }
    if (data.containsKey('raw_mime_url')) {
      context.handle(
        _rawMimeUrlMeta,
        rawMimeUrl.isAcceptableOrUnknown(
          data['raw_mime_url']!,
          _rawMimeUrlMeta,
        ),
      );
    }
    if (data.containsKey('is_read')) {
      context.handle(
        _isReadMeta,
        isRead.isAcceptableOrUnknown(data['is_read']!, _isReadMeta),
      );
    }
    if (data.containsKey('is_starred')) {
      context.handle(
        _isStarredMeta,
        isStarred.isAcceptableOrUnknown(data['is_starred']!, _isStarredMeta),
      );
    }
    if (data.containsKey('has_attachments')) {
      context.handle(
        _hasAttachmentsMeta,
        hasAttachments.isAcceptableOrUnknown(
          data['has_attachments']!,
          _hasAttachmentsMeta,
        ),
      );
    }
    if (data.containsKey('attachments_json')) {
      context.handle(
        _attachmentsJsonMeta,
        attachmentsJson.isAcceptableOrUnknown(
          data['attachments_json']!,
          _attachmentsJsonMeta,
        ),
      );
    }
    if (data.containsKey('raw_headers_json')) {
      context.handle(
        _rawHeadersJsonMeta,
        rawHeadersJson.isAcceptableOrUnknown(
          data['raw_headers_json']!,
          _rawHeadersJsonMeta,
        ),
      );
    }
    if (data.containsKey('metadata_json')) {
      context.handle(
        _metadataJsonMeta,
        metadataJson.isAcceptableOrUnknown(
          data['metadata_json']!,
          _metadataJsonMeta,
        ),
      );
    }
    if (data.containsKey('received_at')) {
      context.handle(
        _receivedAtMeta,
        receivedAt.isAcceptableOrUnknown(data['received_at']!, _receivedAtMeta),
      );
    }
    if (data.containsKey('sent_at')) {
      context.handle(
        _sentAtMeta,
        sentAt.isAcceptableOrUnknown(data['sent_at']!, _sentAtMeta),
      );
    }
    if (data.containsKey('scheduled_at')) {
      context.handle(
        _scheduledAtMeta,
        scheduledAt.isAcceptableOrUnknown(
          data['scheduled_at']!,
          _scheduledAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MessageRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MessageRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      mailboxId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mailbox_id'],
      )!,
      threadId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}thread_id'],
      ),
      direction: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}direction'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      folder: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}folder'],
      )!,
      fromAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}from_address'],
      )!,
      fromName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}from_name'],
      ),
      envelopeSender: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}envelope_sender'],
      ),
      envelopeRecipient: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}envelope_recipient'],
      ),
      toAddressesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}to_addresses_json'],
      )!,
      ccAddressesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cc_addresses_json'],
      )!,
      bccAddressesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bcc_addresses_json'],
      )!,
      replyTo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reply_to'],
      ),
      subject: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subject'],
      )!,
      snippet: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}snippet'],
      ),
      bodyText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body_text'],
      ),
      bodyHtml: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body_html'],
      ),
      rawMimeUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}raw_mime_url'],
      ),
      isRead: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_read'],
      )!,
      isStarred: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_starred'],
      )!,
      hasAttachments: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_attachments'],
      )!,
      attachmentsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attachments_json'],
      )!,
      rawHeadersJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}raw_headers_json'],
      )!,
      metadataJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata_json'],
      )!,
      receivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}received_at'],
      ),
      sentAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}sent_at'],
      ),
      scheduledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scheduled_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $MessagesTable createAlias(String alias) {
    return $MessagesTable(attachedDatabase, alias);
  }
}

class MessageRow extends DataClass implements Insertable<MessageRow> {
  final String id;
  final String mailboxId;
  final String? threadId;
  final String direction;
  final String status;
  final String folder;
  final String fromAddress;
  final String? fromName;
  final String? envelopeSender;
  final String? envelopeRecipient;
  final String toAddressesJson;
  final String ccAddressesJson;
  final String bccAddressesJson;
  final String? replyTo;
  final String subject;
  final String? snippet;
  final String? bodyText;
  final String? bodyHtml;
  final String? rawMimeUrl;
  final bool isRead;
  final bool isStarred;
  final bool hasAttachments;
  final String attachmentsJson;
  final String rawHeadersJson;
  final String metadataJson;
  final DateTime? receivedAt;
  final DateTime? sentAt;
  final DateTime? scheduledAt;
  final DateTime createdAt;
  const MessageRow({
    required this.id,
    required this.mailboxId,
    this.threadId,
    required this.direction,
    required this.status,
    required this.folder,
    required this.fromAddress,
    this.fromName,
    this.envelopeSender,
    this.envelopeRecipient,
    required this.toAddressesJson,
    required this.ccAddressesJson,
    required this.bccAddressesJson,
    this.replyTo,
    required this.subject,
    this.snippet,
    this.bodyText,
    this.bodyHtml,
    this.rawMimeUrl,
    required this.isRead,
    required this.isStarred,
    required this.hasAttachments,
    required this.attachmentsJson,
    required this.rawHeadersJson,
    required this.metadataJson,
    this.receivedAt,
    this.sentAt,
    this.scheduledAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['mailbox_id'] = Variable<String>(mailboxId);
    if (!nullToAbsent || threadId != null) {
      map['thread_id'] = Variable<String>(threadId);
    }
    map['direction'] = Variable<String>(direction);
    map['status'] = Variable<String>(status);
    map['folder'] = Variable<String>(folder);
    map['from_address'] = Variable<String>(fromAddress);
    if (!nullToAbsent || fromName != null) {
      map['from_name'] = Variable<String>(fromName);
    }
    if (!nullToAbsent || envelopeSender != null) {
      map['envelope_sender'] = Variable<String>(envelopeSender);
    }
    if (!nullToAbsent || envelopeRecipient != null) {
      map['envelope_recipient'] = Variable<String>(envelopeRecipient);
    }
    map['to_addresses_json'] = Variable<String>(toAddressesJson);
    map['cc_addresses_json'] = Variable<String>(ccAddressesJson);
    map['bcc_addresses_json'] = Variable<String>(bccAddressesJson);
    if (!nullToAbsent || replyTo != null) {
      map['reply_to'] = Variable<String>(replyTo);
    }
    map['subject'] = Variable<String>(subject);
    if (!nullToAbsent || snippet != null) {
      map['snippet'] = Variable<String>(snippet);
    }
    if (!nullToAbsent || bodyText != null) {
      map['body_text'] = Variable<String>(bodyText);
    }
    if (!nullToAbsent || bodyHtml != null) {
      map['body_html'] = Variable<String>(bodyHtml);
    }
    if (!nullToAbsent || rawMimeUrl != null) {
      map['raw_mime_url'] = Variable<String>(rawMimeUrl);
    }
    map['is_read'] = Variable<bool>(isRead);
    map['is_starred'] = Variable<bool>(isStarred);
    map['has_attachments'] = Variable<bool>(hasAttachments);
    map['attachments_json'] = Variable<String>(attachmentsJson);
    map['raw_headers_json'] = Variable<String>(rawHeadersJson);
    map['metadata_json'] = Variable<String>(metadataJson);
    if (!nullToAbsent || receivedAt != null) {
      map['received_at'] = Variable<DateTime>(receivedAt);
    }
    if (!nullToAbsent || sentAt != null) {
      map['sent_at'] = Variable<DateTime>(sentAt);
    }
    if (!nullToAbsent || scheduledAt != null) {
      map['scheduled_at'] = Variable<DateTime>(scheduledAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MessagesCompanion toCompanion(bool nullToAbsent) {
    return MessagesCompanion(
      id: Value(id),
      mailboxId: Value(mailboxId),
      threadId: threadId == null && nullToAbsent
          ? const Value.absent()
          : Value(threadId),
      direction: Value(direction),
      status: Value(status),
      folder: Value(folder),
      fromAddress: Value(fromAddress),
      fromName: fromName == null && nullToAbsent
          ? const Value.absent()
          : Value(fromName),
      envelopeSender: envelopeSender == null && nullToAbsent
          ? const Value.absent()
          : Value(envelopeSender),
      envelopeRecipient: envelopeRecipient == null && nullToAbsent
          ? const Value.absent()
          : Value(envelopeRecipient),
      toAddressesJson: Value(toAddressesJson),
      ccAddressesJson: Value(ccAddressesJson),
      bccAddressesJson: Value(bccAddressesJson),
      replyTo: replyTo == null && nullToAbsent
          ? const Value.absent()
          : Value(replyTo),
      subject: Value(subject),
      snippet: snippet == null && nullToAbsent
          ? const Value.absent()
          : Value(snippet),
      bodyText: bodyText == null && nullToAbsent
          ? const Value.absent()
          : Value(bodyText),
      bodyHtml: bodyHtml == null && nullToAbsent
          ? const Value.absent()
          : Value(bodyHtml),
      rawMimeUrl: rawMimeUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(rawMimeUrl),
      isRead: Value(isRead),
      isStarred: Value(isStarred),
      hasAttachments: Value(hasAttachments),
      attachmentsJson: Value(attachmentsJson),
      rawHeadersJson: Value(rawHeadersJson),
      metadataJson: Value(metadataJson),
      receivedAt: receivedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(receivedAt),
      sentAt: sentAt == null && nullToAbsent
          ? const Value.absent()
          : Value(sentAt),
      scheduledAt: scheduledAt == null && nullToAbsent
          ? const Value.absent()
          : Value(scheduledAt),
      createdAt: Value(createdAt),
    );
  }

  factory MessageRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MessageRow(
      id: serializer.fromJson<String>(json['id']),
      mailboxId: serializer.fromJson<String>(json['mailboxId']),
      threadId: serializer.fromJson<String?>(json['threadId']),
      direction: serializer.fromJson<String>(json['direction']),
      status: serializer.fromJson<String>(json['status']),
      folder: serializer.fromJson<String>(json['folder']),
      fromAddress: serializer.fromJson<String>(json['fromAddress']),
      fromName: serializer.fromJson<String?>(json['fromName']),
      envelopeSender: serializer.fromJson<String?>(json['envelopeSender']),
      envelopeRecipient: serializer.fromJson<String?>(
        json['envelopeRecipient'],
      ),
      toAddressesJson: serializer.fromJson<String>(json['toAddressesJson']),
      ccAddressesJson: serializer.fromJson<String>(json['ccAddressesJson']),
      bccAddressesJson: serializer.fromJson<String>(json['bccAddressesJson']),
      replyTo: serializer.fromJson<String?>(json['replyTo']),
      subject: serializer.fromJson<String>(json['subject']),
      snippet: serializer.fromJson<String?>(json['snippet']),
      bodyText: serializer.fromJson<String?>(json['bodyText']),
      bodyHtml: serializer.fromJson<String?>(json['bodyHtml']),
      rawMimeUrl: serializer.fromJson<String?>(json['rawMimeUrl']),
      isRead: serializer.fromJson<bool>(json['isRead']),
      isStarred: serializer.fromJson<bool>(json['isStarred']),
      hasAttachments: serializer.fromJson<bool>(json['hasAttachments']),
      attachmentsJson: serializer.fromJson<String>(json['attachmentsJson']),
      rawHeadersJson: serializer.fromJson<String>(json['rawHeadersJson']),
      metadataJson: serializer.fromJson<String>(json['metadataJson']),
      receivedAt: serializer.fromJson<DateTime?>(json['receivedAt']),
      sentAt: serializer.fromJson<DateTime?>(json['sentAt']),
      scheduledAt: serializer.fromJson<DateTime?>(json['scheduledAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'mailboxId': serializer.toJson<String>(mailboxId),
      'threadId': serializer.toJson<String?>(threadId),
      'direction': serializer.toJson<String>(direction),
      'status': serializer.toJson<String>(status),
      'folder': serializer.toJson<String>(folder),
      'fromAddress': serializer.toJson<String>(fromAddress),
      'fromName': serializer.toJson<String?>(fromName),
      'envelopeSender': serializer.toJson<String?>(envelopeSender),
      'envelopeRecipient': serializer.toJson<String?>(envelopeRecipient),
      'toAddressesJson': serializer.toJson<String>(toAddressesJson),
      'ccAddressesJson': serializer.toJson<String>(ccAddressesJson),
      'bccAddressesJson': serializer.toJson<String>(bccAddressesJson),
      'replyTo': serializer.toJson<String?>(replyTo),
      'subject': serializer.toJson<String>(subject),
      'snippet': serializer.toJson<String?>(snippet),
      'bodyText': serializer.toJson<String?>(bodyText),
      'bodyHtml': serializer.toJson<String?>(bodyHtml),
      'rawMimeUrl': serializer.toJson<String?>(rawMimeUrl),
      'isRead': serializer.toJson<bool>(isRead),
      'isStarred': serializer.toJson<bool>(isStarred),
      'hasAttachments': serializer.toJson<bool>(hasAttachments),
      'attachmentsJson': serializer.toJson<String>(attachmentsJson),
      'rawHeadersJson': serializer.toJson<String>(rawHeadersJson),
      'metadataJson': serializer.toJson<String>(metadataJson),
      'receivedAt': serializer.toJson<DateTime?>(receivedAt),
      'sentAt': serializer.toJson<DateTime?>(sentAt),
      'scheduledAt': serializer.toJson<DateTime?>(scheduledAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MessageRow copyWith({
    String? id,
    String? mailboxId,
    Value<String?> threadId = const Value.absent(),
    String? direction,
    String? status,
    String? folder,
    String? fromAddress,
    Value<String?> fromName = const Value.absent(),
    Value<String?> envelopeSender = const Value.absent(),
    Value<String?> envelopeRecipient = const Value.absent(),
    String? toAddressesJson,
    String? ccAddressesJson,
    String? bccAddressesJson,
    Value<String?> replyTo = const Value.absent(),
    String? subject,
    Value<String?> snippet = const Value.absent(),
    Value<String?> bodyText = const Value.absent(),
    Value<String?> bodyHtml = const Value.absent(),
    Value<String?> rawMimeUrl = const Value.absent(),
    bool? isRead,
    bool? isStarred,
    bool? hasAttachments,
    String? attachmentsJson,
    String? rawHeadersJson,
    String? metadataJson,
    Value<DateTime?> receivedAt = const Value.absent(),
    Value<DateTime?> sentAt = const Value.absent(),
    Value<DateTime?> scheduledAt = const Value.absent(),
    DateTime? createdAt,
  }) => MessageRow(
    id: id ?? this.id,
    mailboxId: mailboxId ?? this.mailboxId,
    threadId: threadId.present ? threadId.value : this.threadId,
    direction: direction ?? this.direction,
    status: status ?? this.status,
    folder: folder ?? this.folder,
    fromAddress: fromAddress ?? this.fromAddress,
    fromName: fromName.present ? fromName.value : this.fromName,
    envelopeSender: envelopeSender.present
        ? envelopeSender.value
        : this.envelopeSender,
    envelopeRecipient: envelopeRecipient.present
        ? envelopeRecipient.value
        : this.envelopeRecipient,
    toAddressesJson: toAddressesJson ?? this.toAddressesJson,
    ccAddressesJson: ccAddressesJson ?? this.ccAddressesJson,
    bccAddressesJson: bccAddressesJson ?? this.bccAddressesJson,
    replyTo: replyTo.present ? replyTo.value : this.replyTo,
    subject: subject ?? this.subject,
    snippet: snippet.present ? snippet.value : this.snippet,
    bodyText: bodyText.present ? bodyText.value : this.bodyText,
    bodyHtml: bodyHtml.present ? bodyHtml.value : this.bodyHtml,
    rawMimeUrl: rawMimeUrl.present ? rawMimeUrl.value : this.rawMimeUrl,
    isRead: isRead ?? this.isRead,
    isStarred: isStarred ?? this.isStarred,
    hasAttachments: hasAttachments ?? this.hasAttachments,
    attachmentsJson: attachmentsJson ?? this.attachmentsJson,
    rawHeadersJson: rawHeadersJson ?? this.rawHeadersJson,
    metadataJson: metadataJson ?? this.metadataJson,
    receivedAt: receivedAt.present ? receivedAt.value : this.receivedAt,
    sentAt: sentAt.present ? sentAt.value : this.sentAt,
    scheduledAt: scheduledAt.present ? scheduledAt.value : this.scheduledAt,
    createdAt: createdAt ?? this.createdAt,
  );
  MessageRow copyWithCompanion(MessagesCompanion data) {
    return MessageRow(
      id: data.id.present ? data.id.value : this.id,
      mailboxId: data.mailboxId.present ? data.mailboxId.value : this.mailboxId,
      threadId: data.threadId.present ? data.threadId.value : this.threadId,
      direction: data.direction.present ? data.direction.value : this.direction,
      status: data.status.present ? data.status.value : this.status,
      folder: data.folder.present ? data.folder.value : this.folder,
      fromAddress: data.fromAddress.present
          ? data.fromAddress.value
          : this.fromAddress,
      fromName: data.fromName.present ? data.fromName.value : this.fromName,
      envelopeSender: data.envelopeSender.present
          ? data.envelopeSender.value
          : this.envelopeSender,
      envelopeRecipient: data.envelopeRecipient.present
          ? data.envelopeRecipient.value
          : this.envelopeRecipient,
      toAddressesJson: data.toAddressesJson.present
          ? data.toAddressesJson.value
          : this.toAddressesJson,
      ccAddressesJson: data.ccAddressesJson.present
          ? data.ccAddressesJson.value
          : this.ccAddressesJson,
      bccAddressesJson: data.bccAddressesJson.present
          ? data.bccAddressesJson.value
          : this.bccAddressesJson,
      replyTo: data.replyTo.present ? data.replyTo.value : this.replyTo,
      subject: data.subject.present ? data.subject.value : this.subject,
      snippet: data.snippet.present ? data.snippet.value : this.snippet,
      bodyText: data.bodyText.present ? data.bodyText.value : this.bodyText,
      bodyHtml: data.bodyHtml.present ? data.bodyHtml.value : this.bodyHtml,
      rawMimeUrl: data.rawMimeUrl.present
          ? data.rawMimeUrl.value
          : this.rawMimeUrl,
      isRead: data.isRead.present ? data.isRead.value : this.isRead,
      isStarred: data.isStarred.present ? data.isStarred.value : this.isStarred,
      hasAttachments: data.hasAttachments.present
          ? data.hasAttachments.value
          : this.hasAttachments,
      attachmentsJson: data.attachmentsJson.present
          ? data.attachmentsJson.value
          : this.attachmentsJson,
      rawHeadersJson: data.rawHeadersJson.present
          ? data.rawHeadersJson.value
          : this.rawHeadersJson,
      metadataJson: data.metadataJson.present
          ? data.metadataJson.value
          : this.metadataJson,
      receivedAt: data.receivedAt.present
          ? data.receivedAt.value
          : this.receivedAt,
      sentAt: data.sentAt.present ? data.sentAt.value : this.sentAt,
      scheduledAt: data.scheduledAt.present
          ? data.scheduledAt.value
          : this.scheduledAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MessageRow(')
          ..write('id: $id, ')
          ..write('mailboxId: $mailboxId, ')
          ..write('threadId: $threadId, ')
          ..write('direction: $direction, ')
          ..write('status: $status, ')
          ..write('folder: $folder, ')
          ..write('fromAddress: $fromAddress, ')
          ..write('fromName: $fromName, ')
          ..write('envelopeSender: $envelopeSender, ')
          ..write('envelopeRecipient: $envelopeRecipient, ')
          ..write('toAddressesJson: $toAddressesJson, ')
          ..write('ccAddressesJson: $ccAddressesJson, ')
          ..write('bccAddressesJson: $bccAddressesJson, ')
          ..write('replyTo: $replyTo, ')
          ..write('subject: $subject, ')
          ..write('snippet: $snippet, ')
          ..write('bodyText: $bodyText, ')
          ..write('bodyHtml: $bodyHtml, ')
          ..write('rawMimeUrl: $rawMimeUrl, ')
          ..write('isRead: $isRead, ')
          ..write('isStarred: $isStarred, ')
          ..write('hasAttachments: $hasAttachments, ')
          ..write('attachmentsJson: $attachmentsJson, ')
          ..write('rawHeadersJson: $rawHeadersJson, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('receivedAt: $receivedAt, ')
          ..write('sentAt: $sentAt, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    mailboxId,
    threadId,
    direction,
    status,
    folder,
    fromAddress,
    fromName,
    envelopeSender,
    envelopeRecipient,
    toAddressesJson,
    ccAddressesJson,
    bccAddressesJson,
    replyTo,
    subject,
    snippet,
    bodyText,
    bodyHtml,
    rawMimeUrl,
    isRead,
    isStarred,
    hasAttachments,
    attachmentsJson,
    rawHeadersJson,
    metadataJson,
    receivedAt,
    sentAt,
    scheduledAt,
    createdAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MessageRow &&
          other.id == this.id &&
          other.mailboxId == this.mailboxId &&
          other.threadId == this.threadId &&
          other.direction == this.direction &&
          other.status == this.status &&
          other.folder == this.folder &&
          other.fromAddress == this.fromAddress &&
          other.fromName == this.fromName &&
          other.envelopeSender == this.envelopeSender &&
          other.envelopeRecipient == this.envelopeRecipient &&
          other.toAddressesJson == this.toAddressesJson &&
          other.ccAddressesJson == this.ccAddressesJson &&
          other.bccAddressesJson == this.bccAddressesJson &&
          other.replyTo == this.replyTo &&
          other.subject == this.subject &&
          other.snippet == this.snippet &&
          other.bodyText == this.bodyText &&
          other.bodyHtml == this.bodyHtml &&
          other.rawMimeUrl == this.rawMimeUrl &&
          other.isRead == this.isRead &&
          other.isStarred == this.isStarred &&
          other.hasAttachments == this.hasAttachments &&
          other.attachmentsJson == this.attachmentsJson &&
          other.rawHeadersJson == this.rawHeadersJson &&
          other.metadataJson == this.metadataJson &&
          other.receivedAt == this.receivedAt &&
          other.sentAt == this.sentAt &&
          other.scheduledAt == this.scheduledAt &&
          other.createdAt == this.createdAt);
}

class MessagesCompanion extends UpdateCompanion<MessageRow> {
  final Value<String> id;
  final Value<String> mailboxId;
  final Value<String?> threadId;
  final Value<String> direction;
  final Value<String> status;
  final Value<String> folder;
  final Value<String> fromAddress;
  final Value<String?> fromName;
  final Value<String?> envelopeSender;
  final Value<String?> envelopeRecipient;
  final Value<String> toAddressesJson;
  final Value<String> ccAddressesJson;
  final Value<String> bccAddressesJson;
  final Value<String?> replyTo;
  final Value<String> subject;
  final Value<String?> snippet;
  final Value<String?> bodyText;
  final Value<String?> bodyHtml;
  final Value<String?> rawMimeUrl;
  final Value<bool> isRead;
  final Value<bool> isStarred;
  final Value<bool> hasAttachments;
  final Value<String> attachmentsJson;
  final Value<String> rawHeadersJson;
  final Value<String> metadataJson;
  final Value<DateTime?> receivedAt;
  final Value<DateTime?> sentAt;
  final Value<DateTime?> scheduledAt;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const MessagesCompanion({
    this.id = const Value.absent(),
    this.mailboxId = const Value.absent(),
    this.threadId = const Value.absent(),
    this.direction = const Value.absent(),
    this.status = const Value.absent(),
    this.folder = const Value.absent(),
    this.fromAddress = const Value.absent(),
    this.fromName = const Value.absent(),
    this.envelopeSender = const Value.absent(),
    this.envelopeRecipient = const Value.absent(),
    this.toAddressesJson = const Value.absent(),
    this.ccAddressesJson = const Value.absent(),
    this.bccAddressesJson = const Value.absent(),
    this.replyTo = const Value.absent(),
    this.subject = const Value.absent(),
    this.snippet = const Value.absent(),
    this.bodyText = const Value.absent(),
    this.bodyHtml = const Value.absent(),
    this.rawMimeUrl = const Value.absent(),
    this.isRead = const Value.absent(),
    this.isStarred = const Value.absent(),
    this.hasAttachments = const Value.absent(),
    this.attachmentsJson = const Value.absent(),
    this.rawHeadersJson = const Value.absent(),
    this.metadataJson = const Value.absent(),
    this.receivedAt = const Value.absent(),
    this.sentAt = const Value.absent(),
    this.scheduledAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MessagesCompanion.insert({
    required String id,
    required String mailboxId,
    this.threadId = const Value.absent(),
    required String direction,
    required String status,
    this.folder = const Value.absent(),
    required String fromAddress,
    this.fromName = const Value.absent(),
    this.envelopeSender = const Value.absent(),
    this.envelopeRecipient = const Value.absent(),
    this.toAddressesJson = const Value.absent(),
    this.ccAddressesJson = const Value.absent(),
    this.bccAddressesJson = const Value.absent(),
    this.replyTo = const Value.absent(),
    required String subject,
    this.snippet = const Value.absent(),
    this.bodyText = const Value.absent(),
    this.bodyHtml = const Value.absent(),
    this.rawMimeUrl = const Value.absent(),
    this.isRead = const Value.absent(),
    this.isStarred = const Value.absent(),
    this.hasAttachments = const Value.absent(),
    this.attachmentsJson = const Value.absent(),
    this.rawHeadersJson = const Value.absent(),
    this.metadataJson = const Value.absent(),
    this.receivedAt = const Value.absent(),
    this.sentAt = const Value.absent(),
    this.scheduledAt = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       mailboxId = Value(mailboxId),
       direction = Value(direction),
       status = Value(status),
       fromAddress = Value(fromAddress),
       subject = Value(subject),
       createdAt = Value(createdAt);
  static Insertable<MessageRow> custom({
    Expression<String>? id,
    Expression<String>? mailboxId,
    Expression<String>? threadId,
    Expression<String>? direction,
    Expression<String>? status,
    Expression<String>? folder,
    Expression<String>? fromAddress,
    Expression<String>? fromName,
    Expression<String>? envelopeSender,
    Expression<String>? envelopeRecipient,
    Expression<String>? toAddressesJson,
    Expression<String>? ccAddressesJson,
    Expression<String>? bccAddressesJson,
    Expression<String>? replyTo,
    Expression<String>? subject,
    Expression<String>? snippet,
    Expression<String>? bodyText,
    Expression<String>? bodyHtml,
    Expression<String>? rawMimeUrl,
    Expression<bool>? isRead,
    Expression<bool>? isStarred,
    Expression<bool>? hasAttachments,
    Expression<String>? attachmentsJson,
    Expression<String>? rawHeadersJson,
    Expression<String>? metadataJson,
    Expression<DateTime>? receivedAt,
    Expression<DateTime>? sentAt,
    Expression<DateTime>? scheduledAt,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mailboxId != null) 'mailbox_id': mailboxId,
      if (threadId != null) 'thread_id': threadId,
      if (direction != null) 'direction': direction,
      if (status != null) 'status': status,
      if (folder != null) 'folder': folder,
      if (fromAddress != null) 'from_address': fromAddress,
      if (fromName != null) 'from_name': fromName,
      if (envelopeSender != null) 'envelope_sender': envelopeSender,
      if (envelopeRecipient != null) 'envelope_recipient': envelopeRecipient,
      if (toAddressesJson != null) 'to_addresses_json': toAddressesJson,
      if (ccAddressesJson != null) 'cc_addresses_json': ccAddressesJson,
      if (bccAddressesJson != null) 'bcc_addresses_json': bccAddressesJson,
      if (replyTo != null) 'reply_to': replyTo,
      if (subject != null) 'subject': subject,
      if (snippet != null) 'snippet': snippet,
      if (bodyText != null) 'body_text': bodyText,
      if (bodyHtml != null) 'body_html': bodyHtml,
      if (rawMimeUrl != null) 'raw_mime_url': rawMimeUrl,
      if (isRead != null) 'is_read': isRead,
      if (isStarred != null) 'is_starred': isStarred,
      if (hasAttachments != null) 'has_attachments': hasAttachments,
      if (attachmentsJson != null) 'attachments_json': attachmentsJson,
      if (rawHeadersJson != null) 'raw_headers_json': rawHeadersJson,
      if (metadataJson != null) 'metadata_json': metadataJson,
      if (receivedAt != null) 'received_at': receivedAt,
      if (sentAt != null) 'sent_at': sentAt,
      if (scheduledAt != null) 'scheduled_at': scheduledAt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MessagesCompanion copyWith({
    Value<String>? id,
    Value<String>? mailboxId,
    Value<String?>? threadId,
    Value<String>? direction,
    Value<String>? status,
    Value<String>? folder,
    Value<String>? fromAddress,
    Value<String?>? fromName,
    Value<String?>? envelopeSender,
    Value<String?>? envelopeRecipient,
    Value<String>? toAddressesJson,
    Value<String>? ccAddressesJson,
    Value<String>? bccAddressesJson,
    Value<String?>? replyTo,
    Value<String>? subject,
    Value<String?>? snippet,
    Value<String?>? bodyText,
    Value<String?>? bodyHtml,
    Value<String?>? rawMimeUrl,
    Value<bool>? isRead,
    Value<bool>? isStarred,
    Value<bool>? hasAttachments,
    Value<String>? attachmentsJson,
    Value<String>? rawHeadersJson,
    Value<String>? metadataJson,
    Value<DateTime?>? receivedAt,
    Value<DateTime?>? sentAt,
    Value<DateTime?>? scheduledAt,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return MessagesCompanion(
      id: id ?? this.id,
      mailboxId: mailboxId ?? this.mailboxId,
      threadId: threadId ?? this.threadId,
      direction: direction ?? this.direction,
      status: status ?? this.status,
      folder: folder ?? this.folder,
      fromAddress: fromAddress ?? this.fromAddress,
      fromName: fromName ?? this.fromName,
      envelopeSender: envelopeSender ?? this.envelopeSender,
      envelopeRecipient: envelopeRecipient ?? this.envelopeRecipient,
      toAddressesJson: toAddressesJson ?? this.toAddressesJson,
      ccAddressesJson: ccAddressesJson ?? this.ccAddressesJson,
      bccAddressesJson: bccAddressesJson ?? this.bccAddressesJson,
      replyTo: replyTo ?? this.replyTo,
      subject: subject ?? this.subject,
      snippet: snippet ?? this.snippet,
      bodyText: bodyText ?? this.bodyText,
      bodyHtml: bodyHtml ?? this.bodyHtml,
      rawMimeUrl: rawMimeUrl ?? this.rawMimeUrl,
      isRead: isRead ?? this.isRead,
      isStarred: isStarred ?? this.isStarred,
      hasAttachments: hasAttachments ?? this.hasAttachments,
      attachmentsJson: attachmentsJson ?? this.attachmentsJson,
      rawHeadersJson: rawHeadersJson ?? this.rawHeadersJson,
      metadataJson: metadataJson ?? this.metadataJson,
      receivedAt: receivedAt ?? this.receivedAt,
      sentAt: sentAt ?? this.sentAt,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (mailboxId.present) {
      map['mailbox_id'] = Variable<String>(mailboxId.value);
    }
    if (threadId.present) {
      map['thread_id'] = Variable<String>(threadId.value);
    }
    if (direction.present) {
      map['direction'] = Variable<String>(direction.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (folder.present) {
      map['folder'] = Variable<String>(folder.value);
    }
    if (fromAddress.present) {
      map['from_address'] = Variable<String>(fromAddress.value);
    }
    if (fromName.present) {
      map['from_name'] = Variable<String>(fromName.value);
    }
    if (envelopeSender.present) {
      map['envelope_sender'] = Variable<String>(envelopeSender.value);
    }
    if (envelopeRecipient.present) {
      map['envelope_recipient'] = Variable<String>(envelopeRecipient.value);
    }
    if (toAddressesJson.present) {
      map['to_addresses_json'] = Variable<String>(toAddressesJson.value);
    }
    if (ccAddressesJson.present) {
      map['cc_addresses_json'] = Variable<String>(ccAddressesJson.value);
    }
    if (bccAddressesJson.present) {
      map['bcc_addresses_json'] = Variable<String>(bccAddressesJson.value);
    }
    if (replyTo.present) {
      map['reply_to'] = Variable<String>(replyTo.value);
    }
    if (subject.present) {
      map['subject'] = Variable<String>(subject.value);
    }
    if (snippet.present) {
      map['snippet'] = Variable<String>(snippet.value);
    }
    if (bodyText.present) {
      map['body_text'] = Variable<String>(bodyText.value);
    }
    if (bodyHtml.present) {
      map['body_html'] = Variable<String>(bodyHtml.value);
    }
    if (rawMimeUrl.present) {
      map['raw_mime_url'] = Variable<String>(rawMimeUrl.value);
    }
    if (isRead.present) {
      map['is_read'] = Variable<bool>(isRead.value);
    }
    if (isStarred.present) {
      map['is_starred'] = Variable<bool>(isStarred.value);
    }
    if (hasAttachments.present) {
      map['has_attachments'] = Variable<bool>(hasAttachments.value);
    }
    if (attachmentsJson.present) {
      map['attachments_json'] = Variable<String>(attachmentsJson.value);
    }
    if (rawHeadersJson.present) {
      map['raw_headers_json'] = Variable<String>(rawHeadersJson.value);
    }
    if (metadataJson.present) {
      map['metadata_json'] = Variable<String>(metadataJson.value);
    }
    if (receivedAt.present) {
      map['received_at'] = Variable<DateTime>(receivedAt.value);
    }
    if (sentAt.present) {
      map['sent_at'] = Variable<DateTime>(sentAt.value);
    }
    if (scheduledAt.present) {
      map['scheduled_at'] = Variable<DateTime>(scheduledAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessagesCompanion(')
          ..write('id: $id, ')
          ..write('mailboxId: $mailboxId, ')
          ..write('threadId: $threadId, ')
          ..write('direction: $direction, ')
          ..write('status: $status, ')
          ..write('folder: $folder, ')
          ..write('fromAddress: $fromAddress, ')
          ..write('fromName: $fromName, ')
          ..write('envelopeSender: $envelopeSender, ')
          ..write('envelopeRecipient: $envelopeRecipient, ')
          ..write('toAddressesJson: $toAddressesJson, ')
          ..write('ccAddressesJson: $ccAddressesJson, ')
          ..write('bccAddressesJson: $bccAddressesJson, ')
          ..write('replyTo: $replyTo, ')
          ..write('subject: $subject, ')
          ..write('snippet: $snippet, ')
          ..write('bodyText: $bodyText, ')
          ..write('bodyHtml: $bodyHtml, ')
          ..write('rawMimeUrl: $rawMimeUrl, ')
          ..write('isRead: $isRead, ')
          ..write('isStarred: $isStarred, ')
          ..write('hasAttachments: $hasAttachments, ')
          ..write('attachmentsJson: $attachmentsJson, ')
          ..write('rawHeadersJson: $rawHeadersJson, ')
          ..write('metadataJson: $metadataJson, ')
          ..write('receivedAt: $receivedAt, ')
          ..write('sentAt: $sentAt, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ContactsTable extends Contacts
    with TableInfo<$ContactsTable, ContactRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContactsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mailboxIdMeta = const VerificationMeta(
    'mailboxId',
  );
  @override
  late final GeneratedColumn<String> mailboxId = GeneratedColumn<String>(
    'mailbox_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _timesContactedMeta = const VerificationMeta(
    'timesContacted',
  );
  @override
  late final GeneratedColumn<int> timesContacted = GeneratedColumn<int>(
    'times_contacted',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastContactedAtMeta = const VerificationMeta(
    'lastContactedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastContactedAt =
      GeneratedColumn<DateTime>(
        'last_contacted_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    mailboxId,
    email,
    name,
    isFavorite,
    timesContacted,
    lastContactedAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contacts';
  @override
  VerificationContext validateIntegrity(
    Insertable<ContactRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('mailbox_id')) {
      context.handle(
        _mailboxIdMeta,
        mailboxId.isAcceptableOrUnknown(data['mailbox_id']!, _mailboxIdMeta),
      );
    } else if (isInserting) {
      context.missing(_mailboxIdMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('times_contacted')) {
      context.handle(
        _timesContactedMeta,
        timesContacted.isAcceptableOrUnknown(
          data['times_contacted']!,
          _timesContactedMeta,
        ),
      );
    }
    if (data.containsKey('last_contacted_at')) {
      context.handle(
        _lastContactedAtMeta,
        lastContactedAt.isAcceptableOrUnknown(
          data['last_contacted_at']!,
          _lastContactedAtMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ContactRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContactRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      mailboxId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mailbox_id'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      timesContacted: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}times_contacted'],
      )!,
      lastContactedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_contacted_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ContactsTable createAlias(String alias) {
    return $ContactsTable(attachedDatabase, alias);
  }
}

class ContactRow extends DataClass implements Insertable<ContactRow> {
  final String id;
  final String mailboxId;
  final String email;
  final String? name;
  final bool isFavorite;
  final int timesContacted;
  final DateTime? lastContactedAt;
  final DateTime updatedAt;
  const ContactRow({
    required this.id,
    required this.mailboxId,
    required this.email,
    this.name,
    required this.isFavorite,
    required this.timesContacted,
    this.lastContactedAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['mailbox_id'] = Variable<String>(mailboxId);
    map['email'] = Variable<String>(email);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['times_contacted'] = Variable<int>(timesContacted);
    if (!nullToAbsent || lastContactedAt != null) {
      map['last_contacted_at'] = Variable<DateTime>(lastContactedAt);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ContactsCompanion toCompanion(bool nullToAbsent) {
    return ContactsCompanion(
      id: Value(id),
      mailboxId: Value(mailboxId),
      email: Value(email),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      isFavorite: Value(isFavorite),
      timesContacted: Value(timesContacted),
      lastContactedAt: lastContactedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastContactedAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ContactRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContactRow(
      id: serializer.fromJson<String>(json['id']),
      mailboxId: serializer.fromJson<String>(json['mailboxId']),
      email: serializer.fromJson<String>(json['email']),
      name: serializer.fromJson<String?>(json['name']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      timesContacted: serializer.fromJson<int>(json['timesContacted']),
      lastContactedAt: serializer.fromJson<DateTime?>(json['lastContactedAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'mailboxId': serializer.toJson<String>(mailboxId),
      'email': serializer.toJson<String>(email),
      'name': serializer.toJson<String?>(name),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'timesContacted': serializer.toJson<int>(timesContacted),
      'lastContactedAt': serializer.toJson<DateTime?>(lastContactedAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ContactRow copyWith({
    String? id,
    String? mailboxId,
    String? email,
    Value<String?> name = const Value.absent(),
    bool? isFavorite,
    int? timesContacted,
    Value<DateTime?> lastContactedAt = const Value.absent(),
    DateTime? updatedAt,
  }) => ContactRow(
    id: id ?? this.id,
    mailboxId: mailboxId ?? this.mailboxId,
    email: email ?? this.email,
    name: name.present ? name.value : this.name,
    isFavorite: isFavorite ?? this.isFavorite,
    timesContacted: timesContacted ?? this.timesContacted,
    lastContactedAt: lastContactedAt.present
        ? lastContactedAt.value
        : this.lastContactedAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ContactRow copyWithCompanion(ContactsCompanion data) {
    return ContactRow(
      id: data.id.present ? data.id.value : this.id,
      mailboxId: data.mailboxId.present ? data.mailboxId.value : this.mailboxId,
      email: data.email.present ? data.email.value : this.email,
      name: data.name.present ? data.name.value : this.name,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      timesContacted: data.timesContacted.present
          ? data.timesContacted.value
          : this.timesContacted,
      lastContactedAt: data.lastContactedAt.present
          ? data.lastContactedAt.value
          : this.lastContactedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ContactRow(')
          ..write('id: $id, ')
          ..write('mailboxId: $mailboxId, ')
          ..write('email: $email, ')
          ..write('name: $name, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('timesContacted: $timesContacted, ')
          ..write('lastContactedAt: $lastContactedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    mailboxId,
    email,
    name,
    isFavorite,
    timesContacted,
    lastContactedAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContactRow &&
          other.id == this.id &&
          other.mailboxId == this.mailboxId &&
          other.email == this.email &&
          other.name == this.name &&
          other.isFavorite == this.isFavorite &&
          other.timesContacted == this.timesContacted &&
          other.lastContactedAt == this.lastContactedAt &&
          other.updatedAt == this.updatedAt);
}

class ContactsCompanion extends UpdateCompanion<ContactRow> {
  final Value<String> id;
  final Value<String> mailboxId;
  final Value<String> email;
  final Value<String?> name;
  final Value<bool> isFavorite;
  final Value<int> timesContacted;
  final Value<DateTime?> lastContactedAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ContactsCompanion({
    this.id = const Value.absent(),
    this.mailboxId = const Value.absent(),
    this.email = const Value.absent(),
    this.name = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.timesContacted = const Value.absent(),
    this.lastContactedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ContactsCompanion.insert({
    required String id,
    required String mailboxId,
    required String email,
    this.name = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.timesContacted = const Value.absent(),
    this.lastContactedAt = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       mailboxId = Value(mailboxId),
       email = Value(email),
       updatedAt = Value(updatedAt);
  static Insertable<ContactRow> custom({
    Expression<String>? id,
    Expression<String>? mailboxId,
    Expression<String>? email,
    Expression<String>? name,
    Expression<bool>? isFavorite,
    Expression<int>? timesContacted,
    Expression<DateTime>? lastContactedAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mailboxId != null) 'mailbox_id': mailboxId,
      if (email != null) 'email': email,
      if (name != null) 'name': name,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (timesContacted != null) 'times_contacted': timesContacted,
      if (lastContactedAt != null) 'last_contacted_at': lastContactedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ContactsCompanion copyWith({
    Value<String>? id,
    Value<String>? mailboxId,
    Value<String>? email,
    Value<String?>? name,
    Value<bool>? isFavorite,
    Value<int>? timesContacted,
    Value<DateTime?>? lastContactedAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ContactsCompanion(
      id: id ?? this.id,
      mailboxId: mailboxId ?? this.mailboxId,
      email: email ?? this.email,
      name: name ?? this.name,
      isFavorite: isFavorite ?? this.isFavorite,
      timesContacted: timesContacted ?? this.timesContacted,
      lastContactedAt: lastContactedAt ?? this.lastContactedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (mailboxId.present) {
      map['mailbox_id'] = Variable<String>(mailboxId.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (timesContacted.present) {
      map['times_contacted'] = Variable<int>(timesContacted.value);
    }
    if (lastContactedAt.present) {
      map['last_contacted_at'] = Variable<DateTime>(lastContactedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContactsCompanion(')
          ..write('id: $id, ')
          ..write('mailboxId: $mailboxId, ')
          ..write('email: $email, ')
          ..write('name: $name, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('timesContacted: $timesContacted, ')
          ..write('lastContactedAt: $lastContactedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LabelsTable extends Labels with TableInfo<$LabelsTable, LabelRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LabelsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mailboxIdMeta = const VerificationMeta(
    'mailboxId',
  );
  @override
  late final GeneratedColumn<String> mailboxId = GeneratedColumn<String>(
    'mailbox_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, mailboxId, name, color, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'labels';
  @override
  VerificationContext validateIntegrity(
    Insertable<LabelRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('mailbox_id')) {
      context.handle(
        _mailboxIdMeta,
        mailboxId.isAcceptableOrUnknown(data['mailbox_id']!, _mailboxIdMeta),
      );
    } else if (isInserting) {
      context.missing(_mailboxIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LabelRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LabelRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      mailboxId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mailbox_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $LabelsTable createAlias(String alias) {
    return $LabelsTable(attachedDatabase, alias);
  }
}

class LabelRow extends DataClass implements Insertable<LabelRow> {
  final String id;
  final String mailboxId;
  final String name;
  final String? color;
  final DateTime createdAt;
  const LabelRow({
    required this.id,
    required this.mailboxId,
    required this.name,
    this.color,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['mailbox_id'] = Variable<String>(mailboxId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  LabelsCompanion toCompanion(bool nullToAbsent) {
    return LabelsCompanion(
      id: Value(id),
      mailboxId: Value(mailboxId),
      name: Value(name),
      color: color == null && nullToAbsent
          ? const Value.absent()
          : Value(color),
      createdAt: Value(createdAt),
    );
  }

  factory LabelRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LabelRow(
      id: serializer.fromJson<String>(json['id']),
      mailboxId: serializer.fromJson<String>(json['mailboxId']),
      name: serializer.fromJson<String>(json['name']),
      color: serializer.fromJson<String?>(json['color']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'mailboxId': serializer.toJson<String>(mailboxId),
      'name': serializer.toJson<String>(name),
      'color': serializer.toJson<String?>(color),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LabelRow copyWith({
    String? id,
    String? mailboxId,
    String? name,
    Value<String?> color = const Value.absent(),
    DateTime? createdAt,
  }) => LabelRow(
    id: id ?? this.id,
    mailboxId: mailboxId ?? this.mailboxId,
    name: name ?? this.name,
    color: color.present ? color.value : this.color,
    createdAt: createdAt ?? this.createdAt,
  );
  LabelRow copyWithCompanion(LabelsCompanion data) {
    return LabelRow(
      id: data.id.present ? data.id.value : this.id,
      mailboxId: data.mailboxId.present ? data.mailboxId.value : this.mailboxId,
      name: data.name.present ? data.name.value : this.name,
      color: data.color.present ? data.color.value : this.color,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LabelRow(')
          ..write('id: $id, ')
          ..write('mailboxId: $mailboxId, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, mailboxId, name, color, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LabelRow &&
          other.id == this.id &&
          other.mailboxId == this.mailboxId &&
          other.name == this.name &&
          other.color == this.color &&
          other.createdAt == this.createdAt);
}

class LabelsCompanion extends UpdateCompanion<LabelRow> {
  final Value<String> id;
  final Value<String> mailboxId;
  final Value<String> name;
  final Value<String?> color;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const LabelsCompanion({
    this.id = const Value.absent(),
    this.mailboxId = const Value.absent(),
    this.name = const Value.absent(),
    this.color = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LabelsCompanion.insert({
    required String id,
    required String mailboxId,
    required String name,
    this.color = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       mailboxId = Value(mailboxId),
       name = Value(name),
       createdAt = Value(createdAt);
  static Insertable<LabelRow> custom({
    Expression<String>? id,
    Expression<String>? mailboxId,
    Expression<String>? name,
    Expression<String>? color,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mailboxId != null) 'mailbox_id': mailboxId,
      if (name != null) 'name': name,
      if (color != null) 'color': color,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LabelsCompanion copyWith({
    Value<String>? id,
    Value<String>? mailboxId,
    Value<String>? name,
    Value<String?>? color,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return LabelsCompanion(
      id: id ?? this.id,
      mailboxId: mailboxId ?? this.mailboxId,
      name: name ?? this.name,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (mailboxId.present) {
      map['mailbox_id'] = Variable<String>(mailboxId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LabelsCompanion(')
          ..write('id: $id, ')
          ..write('mailboxId: $mailboxId, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MessageLabelCacheTable extends MessageLabelCache
    with TableInfo<$MessageLabelCacheTable, MessageLabelCacheRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessageLabelCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _messageIdMeta = const VerificationMeta(
    'messageId',
  );
  @override
  late final GeneratedColumn<String> messageId = GeneratedColumn<String>(
    'message_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelIdMeta = const VerificationMeta(
    'labelId',
  );
  @override
  late final GeneratedColumn<String> labelId = GeneratedColumn<String>(
    'label_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [messageId, labelId, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'message_label_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<MessageLabelCacheRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('message_id')) {
      context.handle(
        _messageIdMeta,
        messageId.isAcceptableOrUnknown(data['message_id']!, _messageIdMeta),
      );
    } else if (isInserting) {
      context.missing(_messageIdMeta);
    }
    if (data.containsKey('label_id')) {
      context.handle(
        _labelIdMeta,
        labelId.isAcceptableOrUnknown(data['label_id']!, _labelIdMeta),
      );
    } else if (isInserting) {
      context.missing(_labelIdMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {messageId, labelId};
  @override
  MessageLabelCacheRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MessageLabelCacheRow(
      messageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message_id'],
      )!,
      labelId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label_id'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $MessageLabelCacheTable createAlias(String alias) {
    return $MessageLabelCacheTable(attachedDatabase, alias);
  }
}

class MessageLabelCacheRow extends DataClass
    implements Insertable<MessageLabelCacheRow> {
  final String messageId;
  final String labelId;
  final DateTime updatedAt;
  const MessageLabelCacheRow({
    required this.messageId,
    required this.labelId,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['message_id'] = Variable<String>(messageId);
    map['label_id'] = Variable<String>(labelId);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MessageLabelCacheCompanion toCompanion(bool nullToAbsent) {
    return MessageLabelCacheCompanion(
      messageId: Value(messageId),
      labelId: Value(labelId),
      updatedAt: Value(updatedAt),
    );
  }

  factory MessageLabelCacheRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MessageLabelCacheRow(
      messageId: serializer.fromJson<String>(json['messageId']),
      labelId: serializer.fromJson<String>(json['labelId']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'messageId': serializer.toJson<String>(messageId),
      'labelId': serializer.toJson<String>(labelId),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MessageLabelCacheRow copyWith({
    String? messageId,
    String? labelId,
    DateTime? updatedAt,
  }) => MessageLabelCacheRow(
    messageId: messageId ?? this.messageId,
    labelId: labelId ?? this.labelId,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  MessageLabelCacheRow copyWithCompanion(MessageLabelCacheCompanion data) {
    return MessageLabelCacheRow(
      messageId: data.messageId.present ? data.messageId.value : this.messageId,
      labelId: data.labelId.present ? data.labelId.value : this.labelId,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MessageLabelCacheRow(')
          ..write('messageId: $messageId, ')
          ..write('labelId: $labelId, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(messageId, labelId, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MessageLabelCacheRow &&
          other.messageId == this.messageId &&
          other.labelId == this.labelId &&
          other.updatedAt == this.updatedAt);
}

class MessageLabelCacheCompanion extends UpdateCompanion<MessageLabelCacheRow> {
  final Value<String> messageId;
  final Value<String> labelId;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const MessageLabelCacheCompanion({
    this.messageId = const Value.absent(),
    this.labelId = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MessageLabelCacheCompanion.insert({
    required String messageId,
    required String labelId,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : messageId = Value(messageId),
       labelId = Value(labelId),
       updatedAt = Value(updatedAt);
  static Insertable<MessageLabelCacheRow> custom({
    Expression<String>? messageId,
    Expression<String>? labelId,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (messageId != null) 'message_id': messageId,
      if (labelId != null) 'label_id': labelId,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MessageLabelCacheCompanion copyWith({
    Value<String>? messageId,
    Value<String>? labelId,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return MessageLabelCacheCompanion(
      messageId: messageId ?? this.messageId,
      labelId: labelId ?? this.labelId,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (messageId.present) {
      map['message_id'] = Variable<String>(messageId.value);
    }
    if (labelId.present) {
      map['label_id'] = Variable<String>(labelId.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessageLabelCacheCompanion(')
          ..write('messageId: $messageId, ')
          ..write('labelId: $labelId, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MessageUserStatesTable extends MessageUserStates
    with TableInfo<$MessageUserStatesTable, MessageUserStateRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessageUserStatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _messageIdMeta = const VerificationMeta(
    'messageId',
  );
  @override
  late final GeneratedColumn<String> messageId = GeneratedColumn<String>(
    'message_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _folderMeta = const VerificationMeta('folder');
  @override
  late final GeneratedColumn<String> folder = GeneratedColumn<String>(
    'folder',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('inbox'),
  );
  static const VerificationMeta _isReadMeta = const VerificationMeta('isRead');
  @override
  late final GeneratedColumn<bool> isRead = GeneratedColumn<bool>(
    'is_read',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_read" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isStarredMeta = const VerificationMeta(
    'isStarred',
  );
  @override
  late final GeneratedColumn<bool> isStarred = GeneratedColumn<bool>(
    'is_starred',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_starred" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isImportantMeta = const VerificationMeta(
    'isImportant',
  );
  @override
  late final GeneratedColumn<bool> isImportant = GeneratedColumn<bool>(
    'is_important',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_important" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _snoozedUntilMeta = const VerificationMeta(
    'snoozedUntil',
  );
  @override
  late final GeneratedColumn<DateTime> snoozedUntil = GeneratedColumn<DateTime>(
    'snoozed_until',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _archivedAtMeta = const VerificationMeta(
    'archivedAt',
  );
  @override
  late final GeneratedColumn<DateTime> archivedAt = GeneratedColumn<DateTime>(
    'archived_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    messageId,
    folder,
    isRead,
    isStarred,
    isImportant,
    snoozedUntil,
    archivedAt,
    deletedAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'message_user_states';
  @override
  VerificationContext validateIntegrity(
    Insertable<MessageUserStateRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('message_id')) {
      context.handle(
        _messageIdMeta,
        messageId.isAcceptableOrUnknown(data['message_id']!, _messageIdMeta),
      );
    } else if (isInserting) {
      context.missing(_messageIdMeta);
    }
    if (data.containsKey('folder')) {
      context.handle(
        _folderMeta,
        folder.isAcceptableOrUnknown(data['folder']!, _folderMeta),
      );
    }
    if (data.containsKey('is_read')) {
      context.handle(
        _isReadMeta,
        isRead.isAcceptableOrUnknown(data['is_read']!, _isReadMeta),
      );
    }
    if (data.containsKey('is_starred')) {
      context.handle(
        _isStarredMeta,
        isStarred.isAcceptableOrUnknown(data['is_starred']!, _isStarredMeta),
      );
    }
    if (data.containsKey('is_important')) {
      context.handle(
        _isImportantMeta,
        isImportant.isAcceptableOrUnknown(
          data['is_important']!,
          _isImportantMeta,
        ),
      );
    }
    if (data.containsKey('snoozed_until')) {
      context.handle(
        _snoozedUntilMeta,
        snoozedUntil.isAcceptableOrUnknown(
          data['snoozed_until']!,
          _snoozedUntilMeta,
        ),
      );
    }
    if (data.containsKey('archived_at')) {
      context.handle(
        _archivedAtMeta,
        archivedAt.isAcceptableOrUnknown(data['archived_at']!, _archivedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {messageId};
  @override
  MessageUserStateRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MessageUserStateRow(
      messageId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message_id'],
      )!,
      folder: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}folder'],
      )!,
      isRead: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_read'],
      )!,
      isStarred: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_starred'],
      )!,
      isImportant: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_important'],
      )!,
      snoozedUntil: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}snoozed_until'],
      ),
      archivedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}archived_at'],
      ),
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $MessageUserStatesTable createAlias(String alias) {
    return $MessageUserStatesTable(attachedDatabase, alias);
  }
}

class MessageUserStateRow extends DataClass
    implements Insertable<MessageUserStateRow> {
  final String messageId;
  final String folder;
  final bool isRead;
  final bool isStarred;
  final bool isImportant;
  final DateTime? snoozedUntil;
  final DateTime? archivedAt;
  final DateTime? deletedAt;
  final DateTime updatedAt;
  const MessageUserStateRow({
    required this.messageId,
    required this.folder,
    required this.isRead,
    required this.isStarred,
    required this.isImportant,
    this.snoozedUntil,
    this.archivedAt,
    this.deletedAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['message_id'] = Variable<String>(messageId);
    map['folder'] = Variable<String>(folder);
    map['is_read'] = Variable<bool>(isRead);
    map['is_starred'] = Variable<bool>(isStarred);
    map['is_important'] = Variable<bool>(isImportant);
    if (!nullToAbsent || snoozedUntil != null) {
      map['snoozed_until'] = Variable<DateTime>(snoozedUntil);
    }
    if (!nullToAbsent || archivedAt != null) {
      map['archived_at'] = Variable<DateTime>(archivedAt);
    }
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MessageUserStatesCompanion toCompanion(bool nullToAbsent) {
    return MessageUserStatesCompanion(
      messageId: Value(messageId),
      folder: Value(folder),
      isRead: Value(isRead),
      isStarred: Value(isStarred),
      isImportant: Value(isImportant),
      snoozedUntil: snoozedUntil == null && nullToAbsent
          ? const Value.absent()
          : Value(snoozedUntil),
      archivedAt: archivedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(archivedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory MessageUserStateRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MessageUserStateRow(
      messageId: serializer.fromJson<String>(json['messageId']),
      folder: serializer.fromJson<String>(json['folder']),
      isRead: serializer.fromJson<bool>(json['isRead']),
      isStarred: serializer.fromJson<bool>(json['isStarred']),
      isImportant: serializer.fromJson<bool>(json['isImportant']),
      snoozedUntil: serializer.fromJson<DateTime?>(json['snoozedUntil']),
      archivedAt: serializer.fromJson<DateTime?>(json['archivedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'messageId': serializer.toJson<String>(messageId),
      'folder': serializer.toJson<String>(folder),
      'isRead': serializer.toJson<bool>(isRead),
      'isStarred': serializer.toJson<bool>(isStarred),
      'isImportant': serializer.toJson<bool>(isImportant),
      'snoozedUntil': serializer.toJson<DateTime?>(snoozedUntil),
      'archivedAt': serializer.toJson<DateTime?>(archivedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MessageUserStateRow copyWith({
    String? messageId,
    String? folder,
    bool? isRead,
    bool? isStarred,
    bool? isImportant,
    Value<DateTime?> snoozedUntil = const Value.absent(),
    Value<DateTime?> archivedAt = const Value.absent(),
    Value<DateTime?> deletedAt = const Value.absent(),
    DateTime? updatedAt,
  }) => MessageUserStateRow(
    messageId: messageId ?? this.messageId,
    folder: folder ?? this.folder,
    isRead: isRead ?? this.isRead,
    isStarred: isStarred ?? this.isStarred,
    isImportant: isImportant ?? this.isImportant,
    snoozedUntil: snoozedUntil.present ? snoozedUntil.value : this.snoozedUntil,
    archivedAt: archivedAt.present ? archivedAt.value : this.archivedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  MessageUserStateRow copyWithCompanion(MessageUserStatesCompanion data) {
    return MessageUserStateRow(
      messageId: data.messageId.present ? data.messageId.value : this.messageId,
      folder: data.folder.present ? data.folder.value : this.folder,
      isRead: data.isRead.present ? data.isRead.value : this.isRead,
      isStarred: data.isStarred.present ? data.isStarred.value : this.isStarred,
      isImportant: data.isImportant.present
          ? data.isImportant.value
          : this.isImportant,
      snoozedUntil: data.snoozedUntil.present
          ? data.snoozedUntil.value
          : this.snoozedUntil,
      archivedAt: data.archivedAt.present
          ? data.archivedAt.value
          : this.archivedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MessageUserStateRow(')
          ..write('messageId: $messageId, ')
          ..write('folder: $folder, ')
          ..write('isRead: $isRead, ')
          ..write('isStarred: $isStarred, ')
          ..write('isImportant: $isImportant, ')
          ..write('snoozedUntil: $snoozedUntil, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    messageId,
    folder,
    isRead,
    isStarred,
    isImportant,
    snoozedUntil,
    archivedAt,
    deletedAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MessageUserStateRow &&
          other.messageId == this.messageId &&
          other.folder == this.folder &&
          other.isRead == this.isRead &&
          other.isStarred == this.isStarred &&
          other.isImportant == this.isImportant &&
          other.snoozedUntil == this.snoozedUntil &&
          other.archivedAt == this.archivedAt &&
          other.deletedAt == this.deletedAt &&
          other.updatedAt == this.updatedAt);
}

class MessageUserStatesCompanion extends UpdateCompanion<MessageUserStateRow> {
  final Value<String> messageId;
  final Value<String> folder;
  final Value<bool> isRead;
  final Value<bool> isStarred;
  final Value<bool> isImportant;
  final Value<DateTime?> snoozedUntil;
  final Value<DateTime?> archivedAt;
  final Value<DateTime?> deletedAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const MessageUserStatesCompanion({
    this.messageId = const Value.absent(),
    this.folder = const Value.absent(),
    this.isRead = const Value.absent(),
    this.isStarred = const Value.absent(),
    this.isImportant = const Value.absent(),
    this.snoozedUntil = const Value.absent(),
    this.archivedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MessageUserStatesCompanion.insert({
    required String messageId,
    this.folder = const Value.absent(),
    this.isRead = const Value.absent(),
    this.isStarred = const Value.absent(),
    this.isImportant = const Value.absent(),
    this.snoozedUntil = const Value.absent(),
    this.archivedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : messageId = Value(messageId),
       updatedAt = Value(updatedAt);
  static Insertable<MessageUserStateRow> custom({
    Expression<String>? messageId,
    Expression<String>? folder,
    Expression<bool>? isRead,
    Expression<bool>? isStarred,
    Expression<bool>? isImportant,
    Expression<DateTime>? snoozedUntil,
    Expression<DateTime>? archivedAt,
    Expression<DateTime>? deletedAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (messageId != null) 'message_id': messageId,
      if (folder != null) 'folder': folder,
      if (isRead != null) 'is_read': isRead,
      if (isStarred != null) 'is_starred': isStarred,
      if (isImportant != null) 'is_important': isImportant,
      if (snoozedUntil != null) 'snoozed_until': snoozedUntil,
      if (archivedAt != null) 'archived_at': archivedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MessageUserStatesCompanion copyWith({
    Value<String>? messageId,
    Value<String>? folder,
    Value<bool>? isRead,
    Value<bool>? isStarred,
    Value<bool>? isImportant,
    Value<DateTime?>? snoozedUntil,
    Value<DateTime?>? archivedAt,
    Value<DateTime?>? deletedAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return MessageUserStatesCompanion(
      messageId: messageId ?? this.messageId,
      folder: folder ?? this.folder,
      isRead: isRead ?? this.isRead,
      isStarred: isStarred ?? this.isStarred,
      isImportant: isImportant ?? this.isImportant,
      snoozedUntil: snoozedUntil ?? this.snoozedUntil,
      archivedAt: archivedAt ?? this.archivedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (messageId.present) {
      map['message_id'] = Variable<String>(messageId.value);
    }
    if (folder.present) {
      map['folder'] = Variable<String>(folder.value);
    }
    if (isRead.present) {
      map['is_read'] = Variable<bool>(isRead.value);
    }
    if (isStarred.present) {
      map['is_starred'] = Variable<bool>(isStarred.value);
    }
    if (isImportant.present) {
      map['is_important'] = Variable<bool>(isImportant.value);
    }
    if (snoozedUntil.present) {
      map['snoozed_until'] = Variable<DateTime>(snoozedUntil.value);
    }
    if (archivedAt.present) {
      map['archived_at'] = Variable<DateTime>(archivedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessageUserStatesCompanion(')
          ..write('messageId: $messageId, ')
          ..write('folder: $folder, ')
          ..write('isRead: $isRead, ')
          ..write('isStarred: $isStarred, ')
          ..write('isImportant: $isImportant, ')
          ..write('snoozedUntil: $snoozedUntil, ')
          ..write('archivedAt: $archivedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncMetaTable extends SyncMeta
    with TableInfo<$SyncMetaTable, SyncMetaRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncMetaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_meta';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncMetaRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  SyncMetaRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncMetaRow(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $SyncMetaTable createAlias(String alias) {
    return $SyncMetaTable(attachedDatabase, alias);
  }
}

class SyncMetaRow extends DataClass implements Insertable<SyncMetaRow> {
  final String key;
  final String value;
  final DateTime updatedAt;
  const SyncMetaRow({
    required this.key,
    required this.value,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SyncMetaCompanion toCompanion(bool nullToAbsent) {
    return SyncMetaCompanion(
      key: Value(key),
      value: Value(value),
      updatedAt: Value(updatedAt),
    );
  }

  factory SyncMetaRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncMetaRow(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SyncMetaRow copyWith({String? key, String? value, DateTime? updatedAt}) =>
      SyncMetaRow(
        key: key ?? this.key,
        value: value ?? this.value,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  SyncMetaRow copyWithCompanion(SyncMetaCompanion data) {
    return SyncMetaRow(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetaRow(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncMetaRow &&
          other.key == this.key &&
          other.value == this.value &&
          other.updatedAt == this.updatedAt);
}

class SyncMetaCompanion extends UpdateCompanion<SyncMetaRow> {
  final Value<String> key;
  final Value<String> value;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const SyncMetaCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncMetaCompanion.insert({
    required String key,
    required String value,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value),
       updatedAt = Value(updatedAt);
  static Insertable<SyncMetaRow> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncMetaCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return SyncMetaCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetaCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OutboxEntriesTable extends OutboxEntries
    with TableInfo<$OutboxEntriesTable, OutboxEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OutboxEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _operationMeta = const VerificationMeta(
    'operation',
  );
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
    'operation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _retryCountMeta = const VerificationMeta(
    'retryCount',
  );
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
    'retry_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    operation,
    payloadJson,
    status,
    retryCount,
    lastError,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'outbox_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<OutboxEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('operation')) {
      context.handle(
        _operationMeta,
        operation.isAcceptableOrUnknown(data['operation']!, _operationMeta),
      );
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('retry_count')) {
      context.handle(
        _retryCountMeta,
        retryCount.isAcceptableOrUnknown(data['retry_count']!, _retryCountMeta),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OutboxEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OutboxEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      operation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      retryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retry_count'],
      )!,
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $OutboxEntriesTable createAlias(String alias) {
    return $OutboxEntriesTable(attachedDatabase, alias);
  }
}

class OutboxEntry extends DataClass implements Insertable<OutboxEntry> {
  final int id;
  final String operation;
  final String payloadJson;
  final String status;
  final int retryCount;
  final String? lastError;
  final DateTime createdAt;
  final DateTime updatedAt;
  const OutboxEntry({
    required this.id,
    required this.operation,
    required this.payloadJson,
    required this.status,
    required this.retryCount,
    this.lastError,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['operation'] = Variable<String>(operation);
    map['payload_json'] = Variable<String>(payloadJson);
    map['status'] = Variable<String>(status);
    map['retry_count'] = Variable<int>(retryCount);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  OutboxEntriesCompanion toCompanion(bool nullToAbsent) {
    return OutboxEntriesCompanion(
      id: Value(id),
      operation: Value(operation),
      payloadJson: Value(payloadJson),
      status: Value(status),
      retryCount: Value(retryCount),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory OutboxEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OutboxEntry(
      id: serializer.fromJson<int>(json['id']),
      operation: serializer.fromJson<String>(json['operation']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      status: serializer.fromJson<String>(json['status']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      lastError: serializer.fromJson<String?>(json['lastError']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'operation': serializer.toJson<String>(operation),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'status': serializer.toJson<String>(status),
      'retryCount': serializer.toJson<int>(retryCount),
      'lastError': serializer.toJson<String?>(lastError),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  OutboxEntry copyWith({
    int? id,
    String? operation,
    String? payloadJson,
    String? status,
    int? retryCount,
    Value<String?> lastError = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => OutboxEntry(
    id: id ?? this.id,
    operation: operation ?? this.operation,
    payloadJson: payloadJson ?? this.payloadJson,
    status: status ?? this.status,
    retryCount: retryCount ?? this.retryCount,
    lastError: lastError.present ? lastError.value : this.lastError,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  OutboxEntry copyWithCompanion(OutboxEntriesCompanion data) {
    return OutboxEntry(
      id: data.id.present ? data.id.value : this.id,
      operation: data.operation.present ? data.operation.value : this.operation,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      status: data.status.present ? data.status.value : this.status,
      retryCount: data.retryCount.present
          ? data.retryCount.value
          : this.retryCount,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OutboxEntry(')
          ..write('id: $id, ')
          ..write('operation: $operation, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('status: $status, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastError: $lastError, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    operation,
    payloadJson,
    status,
    retryCount,
    lastError,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OutboxEntry &&
          other.id == this.id &&
          other.operation == this.operation &&
          other.payloadJson == this.payloadJson &&
          other.status == this.status &&
          other.retryCount == this.retryCount &&
          other.lastError == this.lastError &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class OutboxEntriesCompanion extends UpdateCompanion<OutboxEntry> {
  final Value<int> id;
  final Value<String> operation;
  final Value<String> payloadJson;
  final Value<String> status;
  final Value<int> retryCount;
  final Value<String?> lastError;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const OutboxEntriesCompanion({
    this.id = const Value.absent(),
    this.operation = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.status = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.lastError = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  OutboxEntriesCompanion.insert({
    this.id = const Value.absent(),
    required String operation,
    required String payloadJson,
    this.status = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.lastError = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : operation = Value(operation),
       payloadJson = Value(payloadJson),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<OutboxEntry> custom({
    Expression<int>? id,
    Expression<String>? operation,
    Expression<String>? payloadJson,
    Expression<String>? status,
    Expression<int>? retryCount,
    Expression<String>? lastError,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (operation != null) 'operation': operation,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (status != null) 'status': status,
      if (retryCount != null) 'retry_count': retryCount,
      if (lastError != null) 'last_error': lastError,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  OutboxEntriesCompanion copyWith({
    Value<int>? id,
    Value<String>? operation,
    Value<String>? payloadJson,
    Value<String>? status,
    Value<int>? retryCount,
    Value<String?>? lastError,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return OutboxEntriesCompanion(
      id: id ?? this.id,
      operation: operation ?? this.operation,
      payloadJson: payloadJson ?? this.payloadJson,
      status: status ?? this.status,
      retryCount: retryCount ?? this.retryCount,
      lastError: lastError ?? this.lastError,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OutboxEntriesCompanion(')
          ..write('id: $id, ')
          ..write('operation: $operation, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('status: $status, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastError: $lastError, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MailboxesTable mailboxes = $MailboxesTable(this);
  late final $ThreadsTable threads = $ThreadsTable(this);
  late final $MessagesTable messages = $MessagesTable(this);
  late final $ContactsTable contacts = $ContactsTable(this);
  late final $LabelsTable labels = $LabelsTable(this);
  late final $MessageLabelCacheTable messageLabelCache =
      $MessageLabelCacheTable(this);
  late final $MessageUserStatesTable messageUserStates =
      $MessageUserStatesTable(this);
  late final $SyncMetaTable syncMeta = $SyncMetaTable(this);
  late final $OutboxEntriesTable outboxEntries = $OutboxEntriesTable(this);
  late final MailboxDao mailboxDao = MailboxDao(this as AppDatabase);
  late final ThreadDao threadDao = ThreadDao(this as AppDatabase);
  late final MessageDao messageDao = MessageDao(this as AppDatabase);
  late final ContactDao contactDao = ContactDao(this as AppDatabase);
  late final LabelDao labelDao = LabelDao(this as AppDatabase);
  late final OutboxDao outboxDao = OutboxDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    mailboxes,
    threads,
    messages,
    contacts,
    labels,
    messageLabelCache,
    messageUserStates,
    syncMeta,
    outboxEntries,
  ];
}

typedef $$MailboxesTableCreateCompanionBuilder =
    MailboxesCompanion Function({
      required String id,
      required String domainId,
      required String localPart,
      required String emailAddress,
      Value<String?> displayName,
      Value<bool> sendEnabled,
      Value<bool> receiveEnabled,
      Value<bool> isActive,
      Value<int> quotaBytes,
      Value<int> usedBytes,
      Value<String?> signatureHtml,
      Value<String?> signatureText,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$MailboxesTableUpdateCompanionBuilder =
    MailboxesCompanion Function({
      Value<String> id,
      Value<String> domainId,
      Value<String> localPart,
      Value<String> emailAddress,
      Value<String?> displayName,
      Value<bool> sendEnabled,
      Value<bool> receiveEnabled,
      Value<bool> isActive,
      Value<int> quotaBytes,
      Value<int> usedBytes,
      Value<String?> signatureHtml,
      Value<String?> signatureText,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$MailboxesTableFilterComposer
    extends Composer<_$AppDatabase, $MailboxesTable> {
  $$MailboxesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get domainId => $composableBuilder(
    column: $table.domainId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localPart => $composableBuilder(
    column: $table.localPart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get emailAddress => $composableBuilder(
    column: $table.emailAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get sendEnabled => $composableBuilder(
    column: $table.sendEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get receiveEnabled => $composableBuilder(
    column: $table.receiveEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quotaBytes => $composableBuilder(
    column: $table.quotaBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get usedBytes => $composableBuilder(
    column: $table.usedBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get signatureHtml => $composableBuilder(
    column: $table.signatureHtml,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get signatureText => $composableBuilder(
    column: $table.signatureText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MailboxesTableOrderingComposer
    extends Composer<_$AppDatabase, $MailboxesTable> {
  $$MailboxesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get domainId => $composableBuilder(
    column: $table.domainId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localPart => $composableBuilder(
    column: $table.localPart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get emailAddress => $composableBuilder(
    column: $table.emailAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get sendEnabled => $composableBuilder(
    column: $table.sendEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get receiveEnabled => $composableBuilder(
    column: $table.receiveEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quotaBytes => $composableBuilder(
    column: $table.quotaBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get usedBytes => $composableBuilder(
    column: $table.usedBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get signatureHtml => $composableBuilder(
    column: $table.signatureHtml,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get signatureText => $composableBuilder(
    column: $table.signatureText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MailboxesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MailboxesTable> {
  $$MailboxesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get domainId =>
      $composableBuilder(column: $table.domainId, builder: (column) => column);

  GeneratedColumn<String> get localPart =>
      $composableBuilder(column: $table.localPart, builder: (column) => column);

  GeneratedColumn<String> get emailAddress => $composableBuilder(
    column: $table.emailAddress,
    builder: (column) => column,
  );

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get sendEnabled => $composableBuilder(
    column: $table.sendEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get receiveEnabled => $composableBuilder(
    column: $table.receiveEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get quotaBytes => $composableBuilder(
    column: $table.quotaBytes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get usedBytes =>
      $composableBuilder(column: $table.usedBytes, builder: (column) => column);

  GeneratedColumn<String> get signatureHtml => $composableBuilder(
    column: $table.signatureHtml,
    builder: (column) => column,
  );

  GeneratedColumn<String> get signatureText => $composableBuilder(
    column: $table.signatureText,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$MailboxesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MailboxesTable,
          MailboxRow,
          $$MailboxesTableFilterComposer,
          $$MailboxesTableOrderingComposer,
          $$MailboxesTableAnnotationComposer,
          $$MailboxesTableCreateCompanionBuilder,
          $$MailboxesTableUpdateCompanionBuilder,
          (
            MailboxRow,
            BaseReferences<_$AppDatabase, $MailboxesTable, MailboxRow>,
          ),
          MailboxRow,
          PrefetchHooks Function()
        > {
  $$MailboxesTableTableManager(_$AppDatabase db, $MailboxesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MailboxesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MailboxesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MailboxesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> domainId = const Value.absent(),
                Value<String> localPart = const Value.absent(),
                Value<String> emailAddress = const Value.absent(),
                Value<String?> displayName = const Value.absent(),
                Value<bool> sendEnabled = const Value.absent(),
                Value<bool> receiveEnabled = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> quotaBytes = const Value.absent(),
                Value<int> usedBytes = const Value.absent(),
                Value<String?> signatureHtml = const Value.absent(),
                Value<String?> signatureText = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MailboxesCompanion(
                id: id,
                domainId: domainId,
                localPart: localPart,
                emailAddress: emailAddress,
                displayName: displayName,
                sendEnabled: sendEnabled,
                receiveEnabled: receiveEnabled,
                isActive: isActive,
                quotaBytes: quotaBytes,
                usedBytes: usedBytes,
                signatureHtml: signatureHtml,
                signatureText: signatureText,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String domainId,
                required String localPart,
                required String emailAddress,
                Value<String?> displayName = const Value.absent(),
                Value<bool> sendEnabled = const Value.absent(),
                Value<bool> receiveEnabled = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> quotaBytes = const Value.absent(),
                Value<int> usedBytes = const Value.absent(),
                Value<String?> signatureHtml = const Value.absent(),
                Value<String?> signatureText = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => MailboxesCompanion.insert(
                id: id,
                domainId: domainId,
                localPart: localPart,
                emailAddress: emailAddress,
                displayName: displayName,
                sendEnabled: sendEnabled,
                receiveEnabled: receiveEnabled,
                isActive: isActive,
                quotaBytes: quotaBytes,
                usedBytes: usedBytes,
                signatureHtml: signatureHtml,
                signatureText: signatureText,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MailboxesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MailboxesTable,
      MailboxRow,
      $$MailboxesTableFilterComposer,
      $$MailboxesTableOrderingComposer,
      $$MailboxesTableAnnotationComposer,
      $$MailboxesTableCreateCompanionBuilder,
      $$MailboxesTableUpdateCompanionBuilder,
      (MailboxRow, BaseReferences<_$AppDatabase, $MailboxesTable, MailboxRow>),
      MailboxRow,
      PrefetchHooks Function()
    >;
typedef $$ThreadsTableCreateCompanionBuilder =
    ThreadsCompanion Function({
      required String id,
      required String mailboxId,
      required String subject,
      Value<int> messageCount,
      Value<bool> hasUnread,
      Value<int> unreadCount,
      Value<String?> snippet,
      Value<String?> latestDirection,
      Value<bool> hasAttachments,
      Value<String> attachmentFilenamesJson,
      Value<String> labelsJson,
      Value<String?> searchHighlight,
      required DateTime lastMessageAt,
      Value<String> participantsJson,
      Value<String> folder,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ThreadsTableUpdateCompanionBuilder =
    ThreadsCompanion Function({
      Value<String> id,
      Value<String> mailboxId,
      Value<String> subject,
      Value<int> messageCount,
      Value<bool> hasUnread,
      Value<int> unreadCount,
      Value<String?> snippet,
      Value<String?> latestDirection,
      Value<bool> hasAttachments,
      Value<String> attachmentFilenamesJson,
      Value<String> labelsJson,
      Value<String?> searchHighlight,
      Value<DateTime> lastMessageAt,
      Value<String> participantsJson,
      Value<String> folder,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$ThreadsTableFilterComposer
    extends Composer<_$AppDatabase, $ThreadsTable> {
  $$ThreadsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mailboxId => $composableBuilder(
    column: $table.mailboxId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subject => $composableBuilder(
    column: $table.subject,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get messageCount => $composableBuilder(
    column: $table.messageCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasUnread => $composableBuilder(
    column: $table.hasUnread,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get snippet => $composableBuilder(
    column: $table.snippet,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get latestDirection => $composableBuilder(
    column: $table.latestDirection,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasAttachments => $composableBuilder(
    column: $table.hasAttachments,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get attachmentFilenamesJson => $composableBuilder(
    column: $table.attachmentFilenamesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get labelsJson => $composableBuilder(
    column: $table.labelsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get searchHighlight => $composableBuilder(
    column: $table.searchHighlight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastMessageAt => $composableBuilder(
    column: $table.lastMessageAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get participantsJson => $composableBuilder(
    column: $table.participantsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get folder => $composableBuilder(
    column: $table.folder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ThreadsTableOrderingComposer
    extends Composer<_$AppDatabase, $ThreadsTable> {
  $$ThreadsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mailboxId => $composableBuilder(
    column: $table.mailboxId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subject => $composableBuilder(
    column: $table.subject,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get messageCount => $composableBuilder(
    column: $table.messageCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasUnread => $composableBuilder(
    column: $table.hasUnread,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get snippet => $composableBuilder(
    column: $table.snippet,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get latestDirection => $composableBuilder(
    column: $table.latestDirection,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasAttachments => $composableBuilder(
    column: $table.hasAttachments,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get attachmentFilenamesJson => $composableBuilder(
    column: $table.attachmentFilenamesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get labelsJson => $composableBuilder(
    column: $table.labelsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get searchHighlight => $composableBuilder(
    column: $table.searchHighlight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastMessageAt => $composableBuilder(
    column: $table.lastMessageAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get participantsJson => $composableBuilder(
    column: $table.participantsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get folder => $composableBuilder(
    column: $table.folder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ThreadsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ThreadsTable> {
  $$ThreadsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get mailboxId =>
      $composableBuilder(column: $table.mailboxId, builder: (column) => column);

  GeneratedColumn<String> get subject =>
      $composableBuilder(column: $table.subject, builder: (column) => column);

  GeneratedColumn<int> get messageCount => $composableBuilder(
    column: $table.messageCount,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get hasUnread =>
      $composableBuilder(column: $table.hasUnread, builder: (column) => column);

  GeneratedColumn<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get snippet =>
      $composableBuilder(column: $table.snippet, builder: (column) => column);

  GeneratedColumn<String> get latestDirection => $composableBuilder(
    column: $table.latestDirection,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get hasAttachments => $composableBuilder(
    column: $table.hasAttachments,
    builder: (column) => column,
  );

  GeneratedColumn<String> get attachmentFilenamesJson => $composableBuilder(
    column: $table.attachmentFilenamesJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get labelsJson => $composableBuilder(
    column: $table.labelsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get searchHighlight => $composableBuilder(
    column: $table.searchHighlight,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastMessageAt => $composableBuilder(
    column: $table.lastMessageAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get participantsJson => $composableBuilder(
    column: $table.participantsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get folder =>
      $composableBuilder(column: $table.folder, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ThreadsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ThreadsTable,
          ThreadRow,
          $$ThreadsTableFilterComposer,
          $$ThreadsTableOrderingComposer,
          $$ThreadsTableAnnotationComposer,
          $$ThreadsTableCreateCompanionBuilder,
          $$ThreadsTableUpdateCompanionBuilder,
          (ThreadRow, BaseReferences<_$AppDatabase, $ThreadsTable, ThreadRow>),
          ThreadRow,
          PrefetchHooks Function()
        > {
  $$ThreadsTableTableManager(_$AppDatabase db, $ThreadsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ThreadsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ThreadsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ThreadsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> mailboxId = const Value.absent(),
                Value<String> subject = const Value.absent(),
                Value<int> messageCount = const Value.absent(),
                Value<bool> hasUnread = const Value.absent(),
                Value<int> unreadCount = const Value.absent(),
                Value<String?> snippet = const Value.absent(),
                Value<String?> latestDirection = const Value.absent(),
                Value<bool> hasAttachments = const Value.absent(),
                Value<String> attachmentFilenamesJson = const Value.absent(),
                Value<String> labelsJson = const Value.absent(),
                Value<String?> searchHighlight = const Value.absent(),
                Value<DateTime> lastMessageAt = const Value.absent(),
                Value<String> participantsJson = const Value.absent(),
                Value<String> folder = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ThreadsCompanion(
                id: id,
                mailboxId: mailboxId,
                subject: subject,
                messageCount: messageCount,
                hasUnread: hasUnread,
                unreadCount: unreadCount,
                snippet: snippet,
                latestDirection: latestDirection,
                hasAttachments: hasAttachments,
                attachmentFilenamesJson: attachmentFilenamesJson,
                labelsJson: labelsJson,
                searchHighlight: searchHighlight,
                lastMessageAt: lastMessageAt,
                participantsJson: participantsJson,
                folder: folder,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String mailboxId,
                required String subject,
                Value<int> messageCount = const Value.absent(),
                Value<bool> hasUnread = const Value.absent(),
                Value<int> unreadCount = const Value.absent(),
                Value<String?> snippet = const Value.absent(),
                Value<String?> latestDirection = const Value.absent(),
                Value<bool> hasAttachments = const Value.absent(),
                Value<String> attachmentFilenamesJson = const Value.absent(),
                Value<String> labelsJson = const Value.absent(),
                Value<String?> searchHighlight = const Value.absent(),
                required DateTime lastMessageAt,
                Value<String> participantsJson = const Value.absent(),
                Value<String> folder = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ThreadsCompanion.insert(
                id: id,
                mailboxId: mailboxId,
                subject: subject,
                messageCount: messageCount,
                hasUnread: hasUnread,
                unreadCount: unreadCount,
                snippet: snippet,
                latestDirection: latestDirection,
                hasAttachments: hasAttachments,
                attachmentFilenamesJson: attachmentFilenamesJson,
                labelsJson: labelsJson,
                searchHighlight: searchHighlight,
                lastMessageAt: lastMessageAt,
                participantsJson: participantsJson,
                folder: folder,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ThreadsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ThreadsTable,
      ThreadRow,
      $$ThreadsTableFilterComposer,
      $$ThreadsTableOrderingComposer,
      $$ThreadsTableAnnotationComposer,
      $$ThreadsTableCreateCompanionBuilder,
      $$ThreadsTableUpdateCompanionBuilder,
      (ThreadRow, BaseReferences<_$AppDatabase, $ThreadsTable, ThreadRow>),
      ThreadRow,
      PrefetchHooks Function()
    >;
typedef $$MessagesTableCreateCompanionBuilder =
    MessagesCompanion Function({
      required String id,
      required String mailboxId,
      Value<String?> threadId,
      required String direction,
      required String status,
      Value<String> folder,
      required String fromAddress,
      Value<String?> fromName,
      Value<String?> envelopeSender,
      Value<String?> envelopeRecipient,
      Value<String> toAddressesJson,
      Value<String> ccAddressesJson,
      Value<String> bccAddressesJson,
      Value<String?> replyTo,
      required String subject,
      Value<String?> snippet,
      Value<String?> bodyText,
      Value<String?> bodyHtml,
      Value<String?> rawMimeUrl,
      Value<bool> isRead,
      Value<bool> isStarred,
      Value<bool> hasAttachments,
      Value<String> attachmentsJson,
      Value<String> rawHeadersJson,
      Value<String> metadataJson,
      Value<DateTime?> receivedAt,
      Value<DateTime?> sentAt,
      Value<DateTime?> scheduledAt,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$MessagesTableUpdateCompanionBuilder =
    MessagesCompanion Function({
      Value<String> id,
      Value<String> mailboxId,
      Value<String?> threadId,
      Value<String> direction,
      Value<String> status,
      Value<String> folder,
      Value<String> fromAddress,
      Value<String?> fromName,
      Value<String?> envelopeSender,
      Value<String?> envelopeRecipient,
      Value<String> toAddressesJson,
      Value<String> ccAddressesJson,
      Value<String> bccAddressesJson,
      Value<String?> replyTo,
      Value<String> subject,
      Value<String?> snippet,
      Value<String?> bodyText,
      Value<String?> bodyHtml,
      Value<String?> rawMimeUrl,
      Value<bool> isRead,
      Value<bool> isStarred,
      Value<bool> hasAttachments,
      Value<String> attachmentsJson,
      Value<String> rawHeadersJson,
      Value<String> metadataJson,
      Value<DateTime?> receivedAt,
      Value<DateTime?> sentAt,
      Value<DateTime?> scheduledAt,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$MessagesTableFilterComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mailboxId => $composableBuilder(
    column: $table.mailboxId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get threadId => $composableBuilder(
    column: $table.threadId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get direction => $composableBuilder(
    column: $table.direction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get folder => $composableBuilder(
    column: $table.folder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fromAddress => $composableBuilder(
    column: $table.fromAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fromName => $composableBuilder(
    column: $table.fromName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get envelopeSender => $composableBuilder(
    column: $table.envelopeSender,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get envelopeRecipient => $composableBuilder(
    column: $table.envelopeRecipient,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get toAddressesJson => $composableBuilder(
    column: $table.toAddressesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ccAddressesJson => $composableBuilder(
    column: $table.ccAddressesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bccAddressesJson => $composableBuilder(
    column: $table.bccAddressesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get replyTo => $composableBuilder(
    column: $table.replyTo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subject => $composableBuilder(
    column: $table.subject,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get snippet => $composableBuilder(
    column: $table.snippet,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bodyText => $composableBuilder(
    column: $table.bodyText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bodyHtml => $composableBuilder(
    column: $table.bodyHtml,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rawMimeUrl => $composableBuilder(
    column: $table.rawMimeUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isStarred => $composableBuilder(
    column: $table.isStarred,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasAttachments => $composableBuilder(
    column: $table.hasAttachments,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get attachmentsJson => $composableBuilder(
    column: $table.attachmentsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rawHeadersJson => $composableBuilder(
    column: $table.rawHeadersJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get sentAt => $composableBuilder(
    column: $table.sentAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MessagesTableOrderingComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mailboxId => $composableBuilder(
    column: $table.mailboxId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get threadId => $composableBuilder(
    column: $table.threadId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get direction => $composableBuilder(
    column: $table.direction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get folder => $composableBuilder(
    column: $table.folder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fromAddress => $composableBuilder(
    column: $table.fromAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fromName => $composableBuilder(
    column: $table.fromName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get envelopeSender => $composableBuilder(
    column: $table.envelopeSender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get envelopeRecipient => $composableBuilder(
    column: $table.envelopeRecipient,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get toAddressesJson => $composableBuilder(
    column: $table.toAddressesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ccAddressesJson => $composableBuilder(
    column: $table.ccAddressesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bccAddressesJson => $composableBuilder(
    column: $table.bccAddressesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get replyTo => $composableBuilder(
    column: $table.replyTo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subject => $composableBuilder(
    column: $table.subject,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get snippet => $composableBuilder(
    column: $table.snippet,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bodyText => $composableBuilder(
    column: $table.bodyText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bodyHtml => $composableBuilder(
    column: $table.bodyHtml,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rawMimeUrl => $composableBuilder(
    column: $table.rawMimeUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isStarred => $composableBuilder(
    column: $table.isStarred,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasAttachments => $composableBuilder(
    column: $table.hasAttachments,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get attachmentsJson => $composableBuilder(
    column: $table.attachmentsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rawHeadersJson => $composableBuilder(
    column: $table.rawHeadersJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get sentAt => $composableBuilder(
    column: $table.sentAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MessagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MessagesTable> {
  $$MessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get mailboxId =>
      $composableBuilder(column: $table.mailboxId, builder: (column) => column);

  GeneratedColumn<String> get threadId =>
      $composableBuilder(column: $table.threadId, builder: (column) => column);

  GeneratedColumn<String> get direction =>
      $composableBuilder(column: $table.direction, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get folder =>
      $composableBuilder(column: $table.folder, builder: (column) => column);

  GeneratedColumn<String> get fromAddress => $composableBuilder(
    column: $table.fromAddress,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fromName =>
      $composableBuilder(column: $table.fromName, builder: (column) => column);

  GeneratedColumn<String> get envelopeSender => $composableBuilder(
    column: $table.envelopeSender,
    builder: (column) => column,
  );

  GeneratedColumn<String> get envelopeRecipient => $composableBuilder(
    column: $table.envelopeRecipient,
    builder: (column) => column,
  );

  GeneratedColumn<String> get toAddressesJson => $composableBuilder(
    column: $table.toAddressesJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ccAddressesJson => $composableBuilder(
    column: $table.ccAddressesJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bccAddressesJson => $composableBuilder(
    column: $table.bccAddressesJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get replyTo =>
      $composableBuilder(column: $table.replyTo, builder: (column) => column);

  GeneratedColumn<String> get subject =>
      $composableBuilder(column: $table.subject, builder: (column) => column);

  GeneratedColumn<String> get snippet =>
      $composableBuilder(column: $table.snippet, builder: (column) => column);

  GeneratedColumn<String> get bodyText =>
      $composableBuilder(column: $table.bodyText, builder: (column) => column);

  GeneratedColumn<String> get bodyHtml =>
      $composableBuilder(column: $table.bodyHtml, builder: (column) => column);

  GeneratedColumn<String> get rawMimeUrl => $composableBuilder(
    column: $table.rawMimeUrl,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isRead =>
      $composableBuilder(column: $table.isRead, builder: (column) => column);

  GeneratedColumn<bool> get isStarred =>
      $composableBuilder(column: $table.isStarred, builder: (column) => column);

  GeneratedColumn<bool> get hasAttachments => $composableBuilder(
    column: $table.hasAttachments,
    builder: (column) => column,
  );

  GeneratedColumn<String> get attachmentsJson => $composableBuilder(
    column: $table.attachmentsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get rawHeadersJson => $composableBuilder(
    column: $table.rawHeadersJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get metadataJson => $composableBuilder(
    column: $table.metadataJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get receivedAt => $composableBuilder(
    column: $table.receivedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get sentAt =>
      $composableBuilder(column: $table.sentAt, builder: (column) => column);

  GeneratedColumn<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$MessagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MessagesTable,
          MessageRow,
          $$MessagesTableFilterComposer,
          $$MessagesTableOrderingComposer,
          $$MessagesTableAnnotationComposer,
          $$MessagesTableCreateCompanionBuilder,
          $$MessagesTableUpdateCompanionBuilder,
          (
            MessageRow,
            BaseReferences<_$AppDatabase, $MessagesTable, MessageRow>,
          ),
          MessageRow,
          PrefetchHooks Function()
        > {
  $$MessagesTableTableManager(_$AppDatabase db, $MessagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> mailboxId = const Value.absent(),
                Value<String?> threadId = const Value.absent(),
                Value<String> direction = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> folder = const Value.absent(),
                Value<String> fromAddress = const Value.absent(),
                Value<String?> fromName = const Value.absent(),
                Value<String?> envelopeSender = const Value.absent(),
                Value<String?> envelopeRecipient = const Value.absent(),
                Value<String> toAddressesJson = const Value.absent(),
                Value<String> ccAddressesJson = const Value.absent(),
                Value<String> bccAddressesJson = const Value.absent(),
                Value<String?> replyTo = const Value.absent(),
                Value<String> subject = const Value.absent(),
                Value<String?> snippet = const Value.absent(),
                Value<String?> bodyText = const Value.absent(),
                Value<String?> bodyHtml = const Value.absent(),
                Value<String?> rawMimeUrl = const Value.absent(),
                Value<bool> isRead = const Value.absent(),
                Value<bool> isStarred = const Value.absent(),
                Value<bool> hasAttachments = const Value.absent(),
                Value<String> attachmentsJson = const Value.absent(),
                Value<String> rawHeadersJson = const Value.absent(),
                Value<String> metadataJson = const Value.absent(),
                Value<DateTime?> receivedAt = const Value.absent(),
                Value<DateTime?> sentAt = const Value.absent(),
                Value<DateTime?> scheduledAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MessagesCompanion(
                id: id,
                mailboxId: mailboxId,
                threadId: threadId,
                direction: direction,
                status: status,
                folder: folder,
                fromAddress: fromAddress,
                fromName: fromName,
                envelopeSender: envelopeSender,
                envelopeRecipient: envelopeRecipient,
                toAddressesJson: toAddressesJson,
                ccAddressesJson: ccAddressesJson,
                bccAddressesJson: bccAddressesJson,
                replyTo: replyTo,
                subject: subject,
                snippet: snippet,
                bodyText: bodyText,
                bodyHtml: bodyHtml,
                rawMimeUrl: rawMimeUrl,
                isRead: isRead,
                isStarred: isStarred,
                hasAttachments: hasAttachments,
                attachmentsJson: attachmentsJson,
                rawHeadersJson: rawHeadersJson,
                metadataJson: metadataJson,
                receivedAt: receivedAt,
                sentAt: sentAt,
                scheduledAt: scheduledAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String mailboxId,
                Value<String?> threadId = const Value.absent(),
                required String direction,
                required String status,
                Value<String> folder = const Value.absent(),
                required String fromAddress,
                Value<String?> fromName = const Value.absent(),
                Value<String?> envelopeSender = const Value.absent(),
                Value<String?> envelopeRecipient = const Value.absent(),
                Value<String> toAddressesJson = const Value.absent(),
                Value<String> ccAddressesJson = const Value.absent(),
                Value<String> bccAddressesJson = const Value.absent(),
                Value<String?> replyTo = const Value.absent(),
                required String subject,
                Value<String?> snippet = const Value.absent(),
                Value<String?> bodyText = const Value.absent(),
                Value<String?> bodyHtml = const Value.absent(),
                Value<String?> rawMimeUrl = const Value.absent(),
                Value<bool> isRead = const Value.absent(),
                Value<bool> isStarred = const Value.absent(),
                Value<bool> hasAttachments = const Value.absent(),
                Value<String> attachmentsJson = const Value.absent(),
                Value<String> rawHeadersJson = const Value.absent(),
                Value<String> metadataJson = const Value.absent(),
                Value<DateTime?> receivedAt = const Value.absent(),
                Value<DateTime?> sentAt = const Value.absent(),
                Value<DateTime?> scheduledAt = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => MessagesCompanion.insert(
                id: id,
                mailboxId: mailboxId,
                threadId: threadId,
                direction: direction,
                status: status,
                folder: folder,
                fromAddress: fromAddress,
                fromName: fromName,
                envelopeSender: envelopeSender,
                envelopeRecipient: envelopeRecipient,
                toAddressesJson: toAddressesJson,
                ccAddressesJson: ccAddressesJson,
                bccAddressesJson: bccAddressesJson,
                replyTo: replyTo,
                subject: subject,
                snippet: snippet,
                bodyText: bodyText,
                bodyHtml: bodyHtml,
                rawMimeUrl: rawMimeUrl,
                isRead: isRead,
                isStarred: isStarred,
                hasAttachments: hasAttachments,
                attachmentsJson: attachmentsJson,
                rawHeadersJson: rawHeadersJson,
                metadataJson: metadataJson,
                receivedAt: receivedAt,
                sentAt: sentAt,
                scheduledAt: scheduledAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MessagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MessagesTable,
      MessageRow,
      $$MessagesTableFilterComposer,
      $$MessagesTableOrderingComposer,
      $$MessagesTableAnnotationComposer,
      $$MessagesTableCreateCompanionBuilder,
      $$MessagesTableUpdateCompanionBuilder,
      (MessageRow, BaseReferences<_$AppDatabase, $MessagesTable, MessageRow>),
      MessageRow,
      PrefetchHooks Function()
    >;
typedef $$ContactsTableCreateCompanionBuilder =
    ContactsCompanion Function({
      required String id,
      required String mailboxId,
      required String email,
      Value<String?> name,
      Value<bool> isFavorite,
      Value<int> timesContacted,
      Value<DateTime?> lastContactedAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ContactsTableUpdateCompanionBuilder =
    ContactsCompanion Function({
      Value<String> id,
      Value<String> mailboxId,
      Value<String> email,
      Value<String?> name,
      Value<bool> isFavorite,
      Value<int> timesContacted,
      Value<DateTime?> lastContactedAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$ContactsTableFilterComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mailboxId => $composableBuilder(
    column: $table.mailboxId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timesContacted => $composableBuilder(
    column: $table.timesContacted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastContactedAt => $composableBuilder(
    column: $table.lastContactedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ContactsTableOrderingComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mailboxId => $composableBuilder(
    column: $table.mailboxId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timesContacted => $composableBuilder(
    column: $table.timesContacted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastContactedAt => $composableBuilder(
    column: $table.lastContactedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ContactsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get mailboxId =>
      $composableBuilder(column: $table.mailboxId, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<int> get timesContacted => $composableBuilder(
    column: $table.timesContacted,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastContactedAt => $composableBuilder(
    column: $table.lastContactedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ContactsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ContactsTable,
          ContactRow,
          $$ContactsTableFilterComposer,
          $$ContactsTableOrderingComposer,
          $$ContactsTableAnnotationComposer,
          $$ContactsTableCreateCompanionBuilder,
          $$ContactsTableUpdateCompanionBuilder,
          (
            ContactRow,
            BaseReferences<_$AppDatabase, $ContactsTable, ContactRow>,
          ),
          ContactRow,
          PrefetchHooks Function()
        > {
  $$ContactsTableTableManager(_$AppDatabase db, $ContactsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContactsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContactsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContactsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> mailboxId = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<int> timesContacted = const Value.absent(),
                Value<DateTime?> lastContactedAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ContactsCompanion(
                id: id,
                mailboxId: mailboxId,
                email: email,
                name: name,
                isFavorite: isFavorite,
                timesContacted: timesContacted,
                lastContactedAt: lastContactedAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String mailboxId,
                required String email,
                Value<String?> name = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<int> timesContacted = const Value.absent(),
                Value<DateTime?> lastContactedAt = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ContactsCompanion.insert(
                id: id,
                mailboxId: mailboxId,
                email: email,
                name: name,
                isFavorite: isFavorite,
                timesContacted: timesContacted,
                lastContactedAt: lastContactedAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ContactsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ContactsTable,
      ContactRow,
      $$ContactsTableFilterComposer,
      $$ContactsTableOrderingComposer,
      $$ContactsTableAnnotationComposer,
      $$ContactsTableCreateCompanionBuilder,
      $$ContactsTableUpdateCompanionBuilder,
      (ContactRow, BaseReferences<_$AppDatabase, $ContactsTable, ContactRow>),
      ContactRow,
      PrefetchHooks Function()
    >;
typedef $$LabelsTableCreateCompanionBuilder =
    LabelsCompanion Function({
      required String id,
      required String mailboxId,
      required String name,
      Value<String?> color,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$LabelsTableUpdateCompanionBuilder =
    LabelsCompanion Function({
      Value<String> id,
      Value<String> mailboxId,
      Value<String> name,
      Value<String?> color,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$LabelsTableFilterComposer
    extends Composer<_$AppDatabase, $LabelsTable> {
  $$LabelsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mailboxId => $composableBuilder(
    column: $table.mailboxId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LabelsTableOrderingComposer
    extends Composer<_$AppDatabase, $LabelsTable> {
  $$LabelsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mailboxId => $composableBuilder(
    column: $table.mailboxId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LabelsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LabelsTable> {
  $$LabelsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get mailboxId =>
      $composableBuilder(column: $table.mailboxId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$LabelsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LabelsTable,
          LabelRow,
          $$LabelsTableFilterComposer,
          $$LabelsTableOrderingComposer,
          $$LabelsTableAnnotationComposer,
          $$LabelsTableCreateCompanionBuilder,
          $$LabelsTableUpdateCompanionBuilder,
          (LabelRow, BaseReferences<_$AppDatabase, $LabelsTable, LabelRow>),
          LabelRow,
          PrefetchHooks Function()
        > {
  $$LabelsTableTableManager(_$AppDatabase db, $LabelsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LabelsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LabelsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LabelsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> mailboxId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> color = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LabelsCompanion(
                id: id,
                mailboxId: mailboxId,
                name: name,
                color: color,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String mailboxId,
                required String name,
                Value<String?> color = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => LabelsCompanion.insert(
                id: id,
                mailboxId: mailboxId,
                name: name,
                color: color,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LabelsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LabelsTable,
      LabelRow,
      $$LabelsTableFilterComposer,
      $$LabelsTableOrderingComposer,
      $$LabelsTableAnnotationComposer,
      $$LabelsTableCreateCompanionBuilder,
      $$LabelsTableUpdateCompanionBuilder,
      (LabelRow, BaseReferences<_$AppDatabase, $LabelsTable, LabelRow>),
      LabelRow,
      PrefetchHooks Function()
    >;
typedef $$MessageLabelCacheTableCreateCompanionBuilder =
    MessageLabelCacheCompanion Function({
      required String messageId,
      required String labelId,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$MessageLabelCacheTableUpdateCompanionBuilder =
    MessageLabelCacheCompanion Function({
      Value<String> messageId,
      Value<String> labelId,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$MessageLabelCacheTableFilterComposer
    extends Composer<_$AppDatabase, $MessageLabelCacheTable> {
  $$MessageLabelCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get messageId => $composableBuilder(
    column: $table.messageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get labelId => $composableBuilder(
    column: $table.labelId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MessageLabelCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $MessageLabelCacheTable> {
  $$MessageLabelCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get messageId => $composableBuilder(
    column: $table.messageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get labelId => $composableBuilder(
    column: $table.labelId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MessageLabelCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $MessageLabelCacheTable> {
  $$MessageLabelCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get messageId =>
      $composableBuilder(column: $table.messageId, builder: (column) => column);

  GeneratedColumn<String> get labelId =>
      $composableBuilder(column: $table.labelId, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$MessageLabelCacheTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MessageLabelCacheTable,
          MessageLabelCacheRow,
          $$MessageLabelCacheTableFilterComposer,
          $$MessageLabelCacheTableOrderingComposer,
          $$MessageLabelCacheTableAnnotationComposer,
          $$MessageLabelCacheTableCreateCompanionBuilder,
          $$MessageLabelCacheTableUpdateCompanionBuilder,
          (
            MessageLabelCacheRow,
            BaseReferences<
              _$AppDatabase,
              $MessageLabelCacheTable,
              MessageLabelCacheRow
            >,
          ),
          MessageLabelCacheRow,
          PrefetchHooks Function()
        > {
  $$MessageLabelCacheTableTableManager(
    _$AppDatabase db,
    $MessageLabelCacheTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MessageLabelCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MessageLabelCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MessageLabelCacheTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> messageId = const Value.absent(),
                Value<String> labelId = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MessageLabelCacheCompanion(
                messageId: messageId,
                labelId: labelId,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String messageId,
                required String labelId,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => MessageLabelCacheCompanion.insert(
                messageId: messageId,
                labelId: labelId,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MessageLabelCacheTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MessageLabelCacheTable,
      MessageLabelCacheRow,
      $$MessageLabelCacheTableFilterComposer,
      $$MessageLabelCacheTableOrderingComposer,
      $$MessageLabelCacheTableAnnotationComposer,
      $$MessageLabelCacheTableCreateCompanionBuilder,
      $$MessageLabelCacheTableUpdateCompanionBuilder,
      (
        MessageLabelCacheRow,
        BaseReferences<
          _$AppDatabase,
          $MessageLabelCacheTable,
          MessageLabelCacheRow
        >,
      ),
      MessageLabelCacheRow,
      PrefetchHooks Function()
    >;
typedef $$MessageUserStatesTableCreateCompanionBuilder =
    MessageUserStatesCompanion Function({
      required String messageId,
      Value<String> folder,
      Value<bool> isRead,
      Value<bool> isStarred,
      Value<bool> isImportant,
      Value<DateTime?> snoozedUntil,
      Value<DateTime?> archivedAt,
      Value<DateTime?> deletedAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$MessageUserStatesTableUpdateCompanionBuilder =
    MessageUserStatesCompanion Function({
      Value<String> messageId,
      Value<String> folder,
      Value<bool> isRead,
      Value<bool> isStarred,
      Value<bool> isImportant,
      Value<DateTime?> snoozedUntil,
      Value<DateTime?> archivedAt,
      Value<DateTime?> deletedAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$MessageUserStatesTableFilterComposer
    extends Composer<_$AppDatabase, $MessageUserStatesTable> {
  $$MessageUserStatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get messageId => $composableBuilder(
    column: $table.messageId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get folder => $composableBuilder(
    column: $table.folder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isStarred => $composableBuilder(
    column: $table.isStarred,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isImportant => $composableBuilder(
    column: $table.isImportant,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get snoozedUntil => $composableBuilder(
    column: $table.snoozedUntil,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MessageUserStatesTableOrderingComposer
    extends Composer<_$AppDatabase, $MessageUserStatesTable> {
  $$MessageUserStatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get messageId => $composableBuilder(
    column: $table.messageId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get folder => $composableBuilder(
    column: $table.folder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isStarred => $composableBuilder(
    column: $table.isStarred,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isImportant => $composableBuilder(
    column: $table.isImportant,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get snoozedUntil => $composableBuilder(
    column: $table.snoozedUntil,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MessageUserStatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MessageUserStatesTable> {
  $$MessageUserStatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get messageId =>
      $composableBuilder(column: $table.messageId, builder: (column) => column);

  GeneratedColumn<String> get folder =>
      $composableBuilder(column: $table.folder, builder: (column) => column);

  GeneratedColumn<bool> get isRead =>
      $composableBuilder(column: $table.isRead, builder: (column) => column);

  GeneratedColumn<bool> get isStarred =>
      $composableBuilder(column: $table.isStarred, builder: (column) => column);

  GeneratedColumn<bool> get isImportant => $composableBuilder(
    column: $table.isImportant,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get snoozedUntil => $composableBuilder(
    column: $table.snoozedUntil,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get archivedAt => $composableBuilder(
    column: $table.archivedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$MessageUserStatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MessageUserStatesTable,
          MessageUserStateRow,
          $$MessageUserStatesTableFilterComposer,
          $$MessageUserStatesTableOrderingComposer,
          $$MessageUserStatesTableAnnotationComposer,
          $$MessageUserStatesTableCreateCompanionBuilder,
          $$MessageUserStatesTableUpdateCompanionBuilder,
          (
            MessageUserStateRow,
            BaseReferences<
              _$AppDatabase,
              $MessageUserStatesTable,
              MessageUserStateRow
            >,
          ),
          MessageUserStateRow,
          PrefetchHooks Function()
        > {
  $$MessageUserStatesTableTableManager(
    _$AppDatabase db,
    $MessageUserStatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MessageUserStatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MessageUserStatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MessageUserStatesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> messageId = const Value.absent(),
                Value<String> folder = const Value.absent(),
                Value<bool> isRead = const Value.absent(),
                Value<bool> isStarred = const Value.absent(),
                Value<bool> isImportant = const Value.absent(),
                Value<DateTime?> snoozedUntil = const Value.absent(),
                Value<DateTime?> archivedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MessageUserStatesCompanion(
                messageId: messageId,
                folder: folder,
                isRead: isRead,
                isStarred: isStarred,
                isImportant: isImportant,
                snoozedUntil: snoozedUntil,
                archivedAt: archivedAt,
                deletedAt: deletedAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String messageId,
                Value<String> folder = const Value.absent(),
                Value<bool> isRead = const Value.absent(),
                Value<bool> isStarred = const Value.absent(),
                Value<bool> isImportant = const Value.absent(),
                Value<DateTime?> snoozedUntil = const Value.absent(),
                Value<DateTime?> archivedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => MessageUserStatesCompanion.insert(
                messageId: messageId,
                folder: folder,
                isRead: isRead,
                isStarred: isStarred,
                isImportant: isImportant,
                snoozedUntil: snoozedUntil,
                archivedAt: archivedAt,
                deletedAt: deletedAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MessageUserStatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MessageUserStatesTable,
      MessageUserStateRow,
      $$MessageUserStatesTableFilterComposer,
      $$MessageUserStatesTableOrderingComposer,
      $$MessageUserStatesTableAnnotationComposer,
      $$MessageUserStatesTableCreateCompanionBuilder,
      $$MessageUserStatesTableUpdateCompanionBuilder,
      (
        MessageUserStateRow,
        BaseReferences<
          _$AppDatabase,
          $MessageUserStatesTable,
          MessageUserStateRow
        >,
      ),
      MessageUserStateRow,
      PrefetchHooks Function()
    >;
typedef $$SyncMetaTableCreateCompanionBuilder =
    SyncMetaCompanion Function({
      required String key,
      required String value,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$SyncMetaTableUpdateCompanionBuilder =
    SyncMetaCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$SyncMetaTableFilterComposer
    extends Composer<_$AppDatabase, $SyncMetaTable> {
  $$SyncMetaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncMetaTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncMetaTable> {
  $$SyncMetaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncMetaTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncMetaTable> {
  $$SyncMetaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SyncMetaTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncMetaTable,
          SyncMetaRow,
          $$SyncMetaTableFilterComposer,
          $$SyncMetaTableOrderingComposer,
          $$SyncMetaTableAnnotationComposer,
          $$SyncMetaTableCreateCompanionBuilder,
          $$SyncMetaTableUpdateCompanionBuilder,
          (
            SyncMetaRow,
            BaseReferences<_$AppDatabase, $SyncMetaTable, SyncMetaRow>,
          ),
          SyncMetaRow,
          PrefetchHooks Function()
        > {
  $$SyncMetaTableTableManager(_$AppDatabase db, $SyncMetaTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncMetaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncMetaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncMetaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncMetaCompanion(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => SyncMetaCompanion.insert(
                key: key,
                value: value,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncMetaTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncMetaTable,
      SyncMetaRow,
      $$SyncMetaTableFilterComposer,
      $$SyncMetaTableOrderingComposer,
      $$SyncMetaTableAnnotationComposer,
      $$SyncMetaTableCreateCompanionBuilder,
      $$SyncMetaTableUpdateCompanionBuilder,
      (SyncMetaRow, BaseReferences<_$AppDatabase, $SyncMetaTable, SyncMetaRow>),
      SyncMetaRow,
      PrefetchHooks Function()
    >;
typedef $$OutboxEntriesTableCreateCompanionBuilder =
    OutboxEntriesCompanion Function({
      Value<int> id,
      required String operation,
      required String payloadJson,
      Value<String> status,
      Value<int> retryCount,
      Value<String?> lastError,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$OutboxEntriesTableUpdateCompanionBuilder =
    OutboxEntriesCompanion Function({
      Value<int> id,
      Value<String> operation,
      Value<String> payloadJson,
      Value<String> status,
      Value<int> retryCount,
      Value<String?> lastError,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$OutboxEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $OutboxEntriesTable> {
  $$OutboxEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OutboxEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $OutboxEntriesTable> {
  $$OutboxEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OutboxEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $OutboxEntriesTable> {
  $$OutboxEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$OutboxEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OutboxEntriesTable,
          OutboxEntry,
          $$OutboxEntriesTableFilterComposer,
          $$OutboxEntriesTableOrderingComposer,
          $$OutboxEntriesTableAnnotationComposer,
          $$OutboxEntriesTableCreateCompanionBuilder,
          $$OutboxEntriesTableUpdateCompanionBuilder,
          (
            OutboxEntry,
            BaseReferences<_$AppDatabase, $OutboxEntriesTable, OutboxEntry>,
          ),
          OutboxEntry,
          PrefetchHooks Function()
        > {
  $$OutboxEntriesTableTableManager(_$AppDatabase db, $OutboxEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OutboxEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OutboxEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OutboxEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> operation = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => OutboxEntriesCompanion(
                id: id,
                operation: operation,
                payloadJson: payloadJson,
                status: status,
                retryCount: retryCount,
                lastError: lastError,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String operation,
                required String payloadJson,
                Value<String> status = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => OutboxEntriesCompanion.insert(
                id: id,
                operation: operation,
                payloadJson: payloadJson,
                status: status,
                retryCount: retryCount,
                lastError: lastError,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OutboxEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OutboxEntriesTable,
      OutboxEntry,
      $$OutboxEntriesTableFilterComposer,
      $$OutboxEntriesTableOrderingComposer,
      $$OutboxEntriesTableAnnotationComposer,
      $$OutboxEntriesTableCreateCompanionBuilder,
      $$OutboxEntriesTableUpdateCompanionBuilder,
      (
        OutboxEntry,
        BaseReferences<_$AppDatabase, $OutboxEntriesTable, OutboxEntry>,
      ),
      OutboxEntry,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MailboxesTableTableManager get mailboxes =>
      $$MailboxesTableTableManager(_db, _db.mailboxes);
  $$ThreadsTableTableManager get threads =>
      $$ThreadsTableTableManager(_db, _db.threads);
  $$MessagesTableTableManager get messages =>
      $$MessagesTableTableManager(_db, _db.messages);
  $$ContactsTableTableManager get contacts =>
      $$ContactsTableTableManager(_db, _db.contacts);
  $$LabelsTableTableManager get labels =>
      $$LabelsTableTableManager(_db, _db.labels);
  $$MessageLabelCacheTableTableManager get messageLabelCache =>
      $$MessageLabelCacheTableTableManager(_db, _db.messageLabelCache);
  $$MessageUserStatesTableTableManager get messageUserStates =>
      $$MessageUserStatesTableTableManager(_db, _db.messageUserStates);
  $$SyncMetaTableTableManager get syncMeta =>
      $$SyncMetaTableTableManager(_db, _db.syncMeta);
  $$OutboxEntriesTableTableManager get outboxEntries =>
      $$OutboxEntriesTableTableManager(_db, _db.outboxEntries);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appDatabase)
final appDatabaseProvider = AppDatabaseProvider._();

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'59cce38d45eeaba199eddd097d8e149d66f9f3e1';
