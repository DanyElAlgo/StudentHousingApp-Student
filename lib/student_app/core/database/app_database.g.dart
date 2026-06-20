// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CachedConversationsTable extends CachedConversations
    with TableInfo<$CachedConversationsTable, CachedConversation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedConversationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _chatIdMeta = const VerificationMeta('chatId');
  @override
  late final GeneratedColumn<int> chatId = GeneratedColumn<int>(
    'chat_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _otherParticipantIdMeta =
      const VerificationMeta('otherParticipantId');
  @override
  late final GeneratedColumn<String> otherParticipantId =
      GeneratedColumn<String>(
        'other_participant_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _otherParticipantNameMeta =
      const VerificationMeta('otherParticipantName');
  @override
  late final GeneratedColumn<String> otherParticipantName =
      GeneratedColumn<String>(
        'other_participant_name',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _lastMessageMeta = const VerificationMeta(
    'lastMessage',
  );
  @override
  late final GeneratedColumn<String> lastMessage = GeneratedColumn<String>(
    'last_message',
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
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
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
    chatId,
    otherParticipantId,
    otherParticipantName,
    lastMessage,
    lastMessageAt,
    unreadCount,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_conversations';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedConversation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('chat_id')) {
      context.handle(
        _chatIdMeta,
        chatId.isAcceptableOrUnknown(data['chat_id']!, _chatIdMeta),
      );
    }
    if (data.containsKey('other_participant_id')) {
      context.handle(
        _otherParticipantIdMeta,
        otherParticipantId.isAcceptableOrUnknown(
          data['other_participant_id']!,
          _otherParticipantIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_otherParticipantIdMeta);
    }
    if (data.containsKey('other_participant_name')) {
      context.handle(
        _otherParticipantNameMeta,
        otherParticipantName.isAcceptableOrUnknown(
          data['other_participant_name']!,
          _otherParticipantNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_otherParticipantNameMeta);
    }
    if (data.containsKey('last_message')) {
      context.handle(
        _lastMessageMeta,
        lastMessage.isAcceptableOrUnknown(
          data['last_message']!,
          _lastMessageMeta,
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
  Set<GeneratedColumn> get $primaryKey => {chatId};
  @override
  CachedConversation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedConversation(
      chatId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chat_id'],
      )!,
      otherParticipantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}other_participant_id'],
      )!,
      otherParticipantName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}other_participant_name'],
      )!,
      lastMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_message'],
      ),
      lastMessageAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_message_at'],
      ),
      unreadCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unread_count'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CachedConversationsTable createAlias(String alias) {
    return $CachedConversationsTable(attachedDatabase, alias);
  }
}

class CachedConversation extends DataClass
    implements Insertable<CachedConversation> {
  final int chatId;
  final String otherParticipantId;
  final String otherParticipantName;
  final String? lastMessage;
  final DateTime? lastMessageAt;
  final int unreadCount;
  final DateTime updatedAt;
  const CachedConversation({
    required this.chatId,
    required this.otherParticipantId,
    required this.otherParticipantName,
    this.lastMessage,
    this.lastMessageAt,
    required this.unreadCount,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['chat_id'] = Variable<int>(chatId);
    map['other_participant_id'] = Variable<String>(otherParticipantId);
    map['other_participant_name'] = Variable<String>(otherParticipantName);
    if (!nullToAbsent || lastMessage != null) {
      map['last_message'] = Variable<String>(lastMessage);
    }
    if (!nullToAbsent || lastMessageAt != null) {
      map['last_message_at'] = Variable<DateTime>(lastMessageAt);
    }
    map['unread_count'] = Variable<int>(unreadCount);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CachedConversationsCompanion toCompanion(bool nullToAbsent) {
    return CachedConversationsCompanion(
      chatId: Value(chatId),
      otherParticipantId: Value(otherParticipantId),
      otherParticipantName: Value(otherParticipantName),
      lastMessage: lastMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessage),
      lastMessageAt: lastMessageAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastMessageAt),
      unreadCount: Value(unreadCount),
      updatedAt: Value(updatedAt),
    );
  }

  factory CachedConversation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedConversation(
      chatId: serializer.fromJson<int>(json['chatId']),
      otherParticipantId: serializer.fromJson<String>(
        json['otherParticipantId'],
      ),
      otherParticipantName: serializer.fromJson<String>(
        json['otherParticipantName'],
      ),
      lastMessage: serializer.fromJson<String?>(json['lastMessage']),
      lastMessageAt: serializer.fromJson<DateTime?>(json['lastMessageAt']),
      unreadCount: serializer.fromJson<int>(json['unreadCount']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'chatId': serializer.toJson<int>(chatId),
      'otherParticipantId': serializer.toJson<String>(otherParticipantId),
      'otherParticipantName': serializer.toJson<String>(otherParticipantName),
      'lastMessage': serializer.toJson<String?>(lastMessage),
      'lastMessageAt': serializer.toJson<DateTime?>(lastMessageAt),
      'unreadCount': serializer.toJson<int>(unreadCount),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CachedConversation copyWith({
    int? chatId,
    String? otherParticipantId,
    String? otherParticipantName,
    Value<String?> lastMessage = const Value.absent(),
    Value<DateTime?> lastMessageAt = const Value.absent(),
    int? unreadCount,
    DateTime? updatedAt,
  }) => CachedConversation(
    chatId: chatId ?? this.chatId,
    otherParticipantId: otherParticipantId ?? this.otherParticipantId,
    otherParticipantName: otherParticipantName ?? this.otherParticipantName,
    lastMessage: lastMessage.present ? lastMessage.value : this.lastMessage,
    lastMessageAt: lastMessageAt.present
        ? lastMessageAt.value
        : this.lastMessageAt,
    unreadCount: unreadCount ?? this.unreadCount,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CachedConversation copyWithCompanion(CachedConversationsCompanion data) {
    return CachedConversation(
      chatId: data.chatId.present ? data.chatId.value : this.chatId,
      otherParticipantId: data.otherParticipantId.present
          ? data.otherParticipantId.value
          : this.otherParticipantId,
      otherParticipantName: data.otherParticipantName.present
          ? data.otherParticipantName.value
          : this.otherParticipantName,
      lastMessage: data.lastMessage.present
          ? data.lastMessage.value
          : this.lastMessage,
      lastMessageAt: data.lastMessageAt.present
          ? data.lastMessageAt.value
          : this.lastMessageAt,
      unreadCount: data.unreadCount.present
          ? data.unreadCount.value
          : this.unreadCount,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedConversation(')
          ..write('chatId: $chatId, ')
          ..write('otherParticipantId: $otherParticipantId, ')
          ..write('otherParticipantName: $otherParticipantName, ')
          ..write('lastMessage: $lastMessage, ')
          ..write('lastMessageAt: $lastMessageAt, ')
          ..write('unreadCount: $unreadCount, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    chatId,
    otherParticipantId,
    otherParticipantName,
    lastMessage,
    lastMessageAt,
    unreadCount,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedConversation &&
          other.chatId == this.chatId &&
          other.otherParticipantId == this.otherParticipantId &&
          other.otherParticipantName == this.otherParticipantName &&
          other.lastMessage == this.lastMessage &&
          other.lastMessageAt == this.lastMessageAt &&
          other.unreadCount == this.unreadCount &&
          other.updatedAt == this.updatedAt);
}

class CachedConversationsCompanion extends UpdateCompanion<CachedConversation> {
  final Value<int> chatId;
  final Value<String> otherParticipantId;
  final Value<String> otherParticipantName;
  final Value<String?> lastMessage;
  final Value<DateTime?> lastMessageAt;
  final Value<int> unreadCount;
  final Value<DateTime> updatedAt;
  const CachedConversationsCompanion({
    this.chatId = const Value.absent(),
    this.otherParticipantId = const Value.absent(),
    this.otherParticipantName = const Value.absent(),
    this.lastMessage = const Value.absent(),
    this.lastMessageAt = const Value.absent(),
    this.unreadCount = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CachedConversationsCompanion.insert({
    this.chatId = const Value.absent(),
    required String otherParticipantId,
    required String otherParticipantName,
    this.lastMessage = const Value.absent(),
    this.lastMessageAt = const Value.absent(),
    this.unreadCount = const Value.absent(),
    required DateTime updatedAt,
  }) : otherParticipantId = Value(otherParticipantId),
       otherParticipantName = Value(otherParticipantName),
       updatedAt = Value(updatedAt);
  static Insertable<CachedConversation> custom({
    Expression<int>? chatId,
    Expression<String>? otherParticipantId,
    Expression<String>? otherParticipantName,
    Expression<String>? lastMessage,
    Expression<DateTime>? lastMessageAt,
    Expression<int>? unreadCount,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (chatId != null) 'chat_id': chatId,
      if (otherParticipantId != null)
        'other_participant_id': otherParticipantId,
      if (otherParticipantName != null)
        'other_participant_name': otherParticipantName,
      if (lastMessage != null) 'last_message': lastMessage,
      if (lastMessageAt != null) 'last_message_at': lastMessageAt,
      if (unreadCount != null) 'unread_count': unreadCount,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CachedConversationsCompanion copyWith({
    Value<int>? chatId,
    Value<String>? otherParticipantId,
    Value<String>? otherParticipantName,
    Value<String?>? lastMessage,
    Value<DateTime?>? lastMessageAt,
    Value<int>? unreadCount,
    Value<DateTime>? updatedAt,
  }) {
    return CachedConversationsCompanion(
      chatId: chatId ?? this.chatId,
      otherParticipantId: otherParticipantId ?? this.otherParticipantId,
      otherParticipantName: otherParticipantName ?? this.otherParticipantName,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      unreadCount: unreadCount ?? this.unreadCount,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (chatId.present) {
      map['chat_id'] = Variable<int>(chatId.value);
    }
    if (otherParticipantId.present) {
      map['other_participant_id'] = Variable<String>(otherParticipantId.value);
    }
    if (otherParticipantName.present) {
      map['other_participant_name'] = Variable<String>(
        otherParticipantName.value,
      );
    }
    if (lastMessage.present) {
      map['last_message'] = Variable<String>(lastMessage.value);
    }
    if (lastMessageAt.present) {
      map['last_message_at'] = Variable<DateTime>(lastMessageAt.value);
    }
    if (unreadCount.present) {
      map['unread_count'] = Variable<int>(unreadCount.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedConversationsCompanion(')
          ..write('chatId: $chatId, ')
          ..write('otherParticipantId: $otherParticipantId, ')
          ..write('otherParticipantName: $otherParticipantName, ')
          ..write('lastMessage: $lastMessage, ')
          ..write('lastMessageAt: $lastMessageAt, ')
          ..write('unreadCount: $unreadCount, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CachedMessagesTable extends CachedMessages
    with TableInfo<$CachedMessagesTable, CachedMessage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedMessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _chatIdMeta = const VerificationMeta('chatId');
  @override
  late final GeneratedColumn<int> chatId = GeneratedColumn<int>(
    'chat_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _senderIdMeta = const VerificationMeta(
    'senderId',
  );
  @override
  late final GeneratedColumn<String> senderId = GeneratedColumn<String>(
    'sender_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _senderNameMeta = const VerificationMeta(
    'senderName',
  );
  @override
  late final GeneratedColumn<String> senderName = GeneratedColumn<String>(
    'sender_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _messageMeta = const VerificationMeta(
    'message',
  );
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
    'message',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
    chatId,
    senderId,
    senderName,
    message,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_messages';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedMessage> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('chat_id')) {
      context.handle(
        _chatIdMeta,
        chatId.isAcceptableOrUnknown(data['chat_id']!, _chatIdMeta),
      );
    } else if (isInserting) {
      context.missing(_chatIdMeta);
    }
    if (data.containsKey('sender_id')) {
      context.handle(
        _senderIdMeta,
        senderId.isAcceptableOrUnknown(data['sender_id']!, _senderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_senderIdMeta);
    }
    if (data.containsKey('sender_name')) {
      context.handle(
        _senderNameMeta,
        senderName.isAcceptableOrUnknown(data['sender_name']!, _senderNameMeta),
      );
    } else if (isInserting) {
      context.missing(_senderNameMeta);
    }
    if (data.containsKey('message')) {
      context.handle(
        _messageMeta,
        message.isAcceptableOrUnknown(data['message']!, _messageMeta),
      );
    } else if (isInserting) {
      context.missing(_messageMeta);
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
  CachedMessage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedMessage(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      chatId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}chat_id'],
      )!,
      senderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sender_id'],
      )!,
      senderName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sender_name'],
      )!,
      message: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $CachedMessagesTable createAlias(String alias) {
    return $CachedMessagesTable(attachedDatabase, alias);
  }
}

class CachedMessage extends DataClass implements Insertable<CachedMessage> {
  final int id;
  final int chatId;
  final String senderId;
  final String senderName;
  final String message;
  final DateTime createdAt;
  const CachedMessage({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.senderName,
    required this.message,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['chat_id'] = Variable<int>(chatId);
    map['sender_id'] = Variable<String>(senderId);
    map['sender_name'] = Variable<String>(senderName);
    map['message'] = Variable<String>(message);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CachedMessagesCompanion toCompanion(bool nullToAbsent) {
    return CachedMessagesCompanion(
      id: Value(id),
      chatId: Value(chatId),
      senderId: Value(senderId),
      senderName: Value(senderName),
      message: Value(message),
      createdAt: Value(createdAt),
    );
  }

  factory CachedMessage.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedMessage(
      id: serializer.fromJson<int>(json['id']),
      chatId: serializer.fromJson<int>(json['chatId']),
      senderId: serializer.fromJson<String>(json['senderId']),
      senderName: serializer.fromJson<String>(json['senderName']),
      message: serializer.fromJson<String>(json['message']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'chatId': serializer.toJson<int>(chatId),
      'senderId': serializer.toJson<String>(senderId),
      'senderName': serializer.toJson<String>(senderName),
      'message': serializer.toJson<String>(message),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CachedMessage copyWith({
    int? id,
    int? chatId,
    String? senderId,
    String? senderName,
    String? message,
    DateTime? createdAt,
  }) => CachedMessage(
    id: id ?? this.id,
    chatId: chatId ?? this.chatId,
    senderId: senderId ?? this.senderId,
    senderName: senderName ?? this.senderName,
    message: message ?? this.message,
    createdAt: createdAt ?? this.createdAt,
  );
  CachedMessage copyWithCompanion(CachedMessagesCompanion data) {
    return CachedMessage(
      id: data.id.present ? data.id.value : this.id,
      chatId: data.chatId.present ? data.chatId.value : this.chatId,
      senderId: data.senderId.present ? data.senderId.value : this.senderId,
      senderName: data.senderName.present
          ? data.senderName.value
          : this.senderName,
      message: data.message.present ? data.message.value : this.message,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedMessage(')
          ..write('id: $id, ')
          ..write('chatId: $chatId, ')
          ..write('senderId: $senderId, ')
          ..write('senderName: $senderName, ')
          ..write('message: $message, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, chatId, senderId, senderName, message, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedMessage &&
          other.id == this.id &&
          other.chatId == this.chatId &&
          other.senderId == this.senderId &&
          other.senderName == this.senderName &&
          other.message == this.message &&
          other.createdAt == this.createdAt);
}

class CachedMessagesCompanion extends UpdateCompanion<CachedMessage> {
  final Value<int> id;
  final Value<int> chatId;
  final Value<String> senderId;
  final Value<String> senderName;
  final Value<String> message;
  final Value<DateTime> createdAt;
  const CachedMessagesCompanion({
    this.id = const Value.absent(),
    this.chatId = const Value.absent(),
    this.senderId = const Value.absent(),
    this.senderName = const Value.absent(),
    this.message = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CachedMessagesCompanion.insert({
    this.id = const Value.absent(),
    required int chatId,
    required String senderId,
    required String senderName,
    required String message,
    required DateTime createdAt,
  }) : chatId = Value(chatId),
       senderId = Value(senderId),
       senderName = Value(senderName),
       message = Value(message),
       createdAt = Value(createdAt);
  static Insertable<CachedMessage> custom({
    Expression<int>? id,
    Expression<int>? chatId,
    Expression<String>? senderId,
    Expression<String>? senderName,
    Expression<String>? message,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (chatId != null) 'chat_id': chatId,
      if (senderId != null) 'sender_id': senderId,
      if (senderName != null) 'sender_name': senderName,
      if (message != null) 'message': message,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CachedMessagesCompanion copyWith({
    Value<int>? id,
    Value<int>? chatId,
    Value<String>? senderId,
    Value<String>? senderName,
    Value<String>? message,
    Value<DateTime>? createdAt,
  }) {
    return CachedMessagesCompanion(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (chatId.present) {
      map['chat_id'] = Variable<int>(chatId.value);
    }
    if (senderId.present) {
      map['sender_id'] = Variable<String>(senderId.value);
    }
    if (senderName.present) {
      map['sender_name'] = Variable<String>(senderName.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedMessagesCompanion(')
          ..write('id: $id, ')
          ..write('chatId: $chatId, ')
          ..write('senderId: $senderId, ')
          ..write('senderName: $senderName, ')
          ..write('message: $message, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _languageCodeMeta = const VerificationMeta(
    'languageCode',
  );
  @override
  late final GeneratedColumn<String> languageCode = GeneratedColumn<String>(
    'language_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, languageCode];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('language_code')) {
      context.handle(
        _languageCodeMeta,
        languageCode.isAcceptableOrUnknown(
          data['language_code']!,
          _languageCodeMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      languageCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language_code'],
      ),
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final int id;
  final String? languageCode;
  const AppSetting({required this.id, this.languageCode});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || languageCode != null) {
      map['language_code'] = Variable<String>(languageCode);
    }
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      id: Value(id),
      languageCode: languageCode == null && nullToAbsent
          ? const Value.absent()
          : Value(languageCode),
    );
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      id: serializer.fromJson<int>(json['id']),
      languageCode: serializer.fromJson<String?>(json['languageCode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'languageCode': serializer.toJson<String?>(languageCode),
    };
  }

  AppSetting copyWith({
    int? id,
    Value<String?> languageCode = const Value.absent(),
  }) => AppSetting(
    id: id ?? this.id,
    languageCode: languageCode.present ? languageCode.value : this.languageCode,
  );
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      id: data.id.present ? data.id.value : this.id,
      languageCode: data.languageCode.present
          ? data.languageCode.value
          : this.languageCode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('id: $id, ')
          ..write('languageCode: $languageCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, languageCode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.id == this.id &&
          other.languageCode == this.languageCode);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<int> id;
  final Value<String?> languageCode;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.languageCode = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.languageCode = const Value.absent(),
  });
  static Insertable<AppSetting> custom({
    Expression<int>? id,
    Expression<String>? languageCode,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (languageCode != null) 'language_code': languageCode,
    });
  }

  AppSettingsCompanion copyWith({
    Value<int>? id,
    Value<String?>? languageCode,
  }) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      languageCode: languageCode ?? this.languageCode,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('languageCode: $languageCode')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CachedConversationsTable cachedConversations =
      $CachedConversationsTable(this);
  late final $CachedMessagesTable cachedMessages = $CachedMessagesTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    cachedConversations,
    cachedMessages,
    appSettings,
  ];
}

typedef $$CachedConversationsTableCreateCompanionBuilder =
    CachedConversationsCompanion Function({
      Value<int> chatId,
      required String otherParticipantId,
      required String otherParticipantName,
      Value<String?> lastMessage,
      Value<DateTime?> lastMessageAt,
      Value<int> unreadCount,
      required DateTime updatedAt,
    });
typedef $$CachedConversationsTableUpdateCompanionBuilder =
    CachedConversationsCompanion Function({
      Value<int> chatId,
      Value<String> otherParticipantId,
      Value<String> otherParticipantName,
      Value<String?> lastMessage,
      Value<DateTime?> lastMessageAt,
      Value<int> unreadCount,
      Value<DateTime> updatedAt,
    });

class $$CachedConversationsTableFilterComposer
    extends Composer<_$AppDatabase, $CachedConversationsTable> {
  $$CachedConversationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get chatId => $composableBuilder(
    column: $table.chatId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get otherParticipantId => $composableBuilder(
    column: $table.otherParticipantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get otherParticipantName => $composableBuilder(
    column: $table.otherParticipantName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastMessage => $composableBuilder(
    column: $table.lastMessage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastMessageAt => $composableBuilder(
    column: $table.lastMessageAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedConversationsTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedConversationsTable> {
  $$CachedConversationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get chatId => $composableBuilder(
    column: $table.chatId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get otherParticipantId => $composableBuilder(
    column: $table.otherParticipantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get otherParticipantName => $composableBuilder(
    column: $table.otherParticipantName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastMessage => $composableBuilder(
    column: $table.lastMessage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastMessageAt => $composableBuilder(
    column: $table.lastMessageAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedConversationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedConversationsTable> {
  $$CachedConversationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get chatId =>
      $composableBuilder(column: $table.chatId, builder: (column) => column);

  GeneratedColumn<String> get otherParticipantId => $composableBuilder(
    column: $table.otherParticipantId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get otherParticipantName => $composableBuilder(
    column: $table.otherParticipantName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastMessage => $composableBuilder(
    column: $table.lastMessage,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastMessageAt => $composableBuilder(
    column: $table.lastMessageAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get unreadCount => $composableBuilder(
    column: $table.unreadCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CachedConversationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedConversationsTable,
          CachedConversation,
          $$CachedConversationsTableFilterComposer,
          $$CachedConversationsTableOrderingComposer,
          $$CachedConversationsTableAnnotationComposer,
          $$CachedConversationsTableCreateCompanionBuilder,
          $$CachedConversationsTableUpdateCompanionBuilder,
          (
            CachedConversation,
            BaseReferences<
              _$AppDatabase,
              $CachedConversationsTable,
              CachedConversation
            >,
          ),
          CachedConversation,
          PrefetchHooks Function()
        > {
  $$CachedConversationsTableTableManager(
    _$AppDatabase db,
    $CachedConversationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedConversationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedConversationsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CachedConversationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> chatId = const Value.absent(),
                Value<String> otherParticipantId = const Value.absent(),
                Value<String> otherParticipantName = const Value.absent(),
                Value<String?> lastMessage = const Value.absent(),
                Value<DateTime?> lastMessageAt = const Value.absent(),
                Value<int> unreadCount = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CachedConversationsCompanion(
                chatId: chatId,
                otherParticipantId: otherParticipantId,
                otherParticipantName: otherParticipantName,
                lastMessage: lastMessage,
                lastMessageAt: lastMessageAt,
                unreadCount: unreadCount,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> chatId = const Value.absent(),
                required String otherParticipantId,
                required String otherParticipantName,
                Value<String?> lastMessage = const Value.absent(),
                Value<DateTime?> lastMessageAt = const Value.absent(),
                Value<int> unreadCount = const Value.absent(),
                required DateTime updatedAt,
              }) => CachedConversationsCompanion.insert(
                chatId: chatId,
                otherParticipantId: otherParticipantId,
                otherParticipantName: otherParticipantName,
                lastMessage: lastMessage,
                lastMessageAt: lastMessageAt,
                unreadCount: unreadCount,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedConversationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedConversationsTable,
      CachedConversation,
      $$CachedConversationsTableFilterComposer,
      $$CachedConversationsTableOrderingComposer,
      $$CachedConversationsTableAnnotationComposer,
      $$CachedConversationsTableCreateCompanionBuilder,
      $$CachedConversationsTableUpdateCompanionBuilder,
      (
        CachedConversation,
        BaseReferences<
          _$AppDatabase,
          $CachedConversationsTable,
          CachedConversation
        >,
      ),
      CachedConversation,
      PrefetchHooks Function()
    >;
typedef $$CachedMessagesTableCreateCompanionBuilder =
    CachedMessagesCompanion Function({
      Value<int> id,
      required int chatId,
      required String senderId,
      required String senderName,
      required String message,
      required DateTime createdAt,
    });
typedef $$CachedMessagesTableUpdateCompanionBuilder =
    CachedMessagesCompanion Function({
      Value<int> id,
      Value<int> chatId,
      Value<String> senderId,
      Value<String> senderName,
      Value<String> message,
      Value<DateTime> createdAt,
    });

class $$CachedMessagesTableFilterComposer
    extends Composer<_$AppDatabase, $CachedMessagesTable> {
  $$CachedMessagesTableFilterComposer({
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

  ColumnFilters<int> get chatId => $composableBuilder(
    column: $table.chatId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get senderId => $composableBuilder(
    column: $table.senderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get senderName => $composableBuilder(
    column: $table.senderName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedMessagesTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedMessagesTable> {
  $$CachedMessagesTableOrderingComposer({
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

  ColumnOrderings<int> get chatId => $composableBuilder(
    column: $table.chatId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get senderId => $composableBuilder(
    column: $table.senderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get senderName => $composableBuilder(
    column: $table.senderName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedMessagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedMessagesTable> {
  $$CachedMessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get chatId =>
      $composableBuilder(column: $table.chatId, builder: (column) => column);

  GeneratedColumn<String> get senderId =>
      $composableBuilder(column: $table.senderId, builder: (column) => column);

  GeneratedColumn<String> get senderName => $composableBuilder(
    column: $table.senderName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$CachedMessagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedMessagesTable,
          CachedMessage,
          $$CachedMessagesTableFilterComposer,
          $$CachedMessagesTableOrderingComposer,
          $$CachedMessagesTableAnnotationComposer,
          $$CachedMessagesTableCreateCompanionBuilder,
          $$CachedMessagesTableUpdateCompanionBuilder,
          (
            CachedMessage,
            BaseReferences<_$AppDatabase, $CachedMessagesTable, CachedMessage>,
          ),
          CachedMessage,
          PrefetchHooks Function()
        > {
  $$CachedMessagesTableTableManager(
    _$AppDatabase db,
    $CachedMessagesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedMessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedMessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedMessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> chatId = const Value.absent(),
                Value<String> senderId = const Value.absent(),
                Value<String> senderName = const Value.absent(),
                Value<String> message = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CachedMessagesCompanion(
                id: id,
                chatId: chatId,
                senderId: senderId,
                senderName: senderName,
                message: message,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int chatId,
                required String senderId,
                required String senderName,
                required String message,
                required DateTime createdAt,
              }) => CachedMessagesCompanion.insert(
                id: id,
                chatId: chatId,
                senderId: senderId,
                senderName: senderName,
                message: message,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedMessagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedMessagesTable,
      CachedMessage,
      $$CachedMessagesTableFilterComposer,
      $$CachedMessagesTableOrderingComposer,
      $$CachedMessagesTableAnnotationComposer,
      $$CachedMessagesTableCreateCompanionBuilder,
      $$CachedMessagesTableUpdateCompanionBuilder,
      (
        CachedMessage,
        BaseReferences<_$AppDatabase, $CachedMessagesTable, CachedMessage>,
      ),
      CachedMessage,
      PrefetchHooks Function()
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({Value<int> id, Value<String?> languageCode});
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({Value<int> id, Value<String?> languageCode});

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
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

  ColumnFilters<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
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

  ColumnOrderings<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => column,
  );
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSetting,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
          ),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> languageCode = const Value.absent(),
              }) => AppSettingsCompanion(id: id, languageCode: languageCode),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> languageCode = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                id: id,
                languageCode: languageCode,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSetting,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
      ),
      AppSetting,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CachedConversationsTableTableManager get cachedConversations =>
      $$CachedConversationsTableTableManager(_db, _db.cachedConversations);
  $$CachedMessagesTableTableManager get cachedMessages =>
      $$CachedMessagesTableTableManager(_db, _db.cachedMessages);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
}
