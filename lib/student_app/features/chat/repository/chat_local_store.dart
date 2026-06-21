import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import 'models/chat_message.dart';
import 'models/chat_summary.dart';

class ChatLocalStore {
  ChatLocalStore(this._db);

  final AppDatabase _db;

  Stream<List<ChatSummary>> watchConversations() {
    return _db.watchCachedConversations().map(
      (rows) => rows.map(_toSummary).toList(),
    );
  }

  Future<ChatSummary?> getConversation(int chatId) async {
    final row = await _db.getCachedConversation(chatId);
    return row == null ? null : _toSummary(row);
  }

  Future<void> saveConversations(List<ChatSummary> conversations) {
    return _db.upsertCachedConversations(
      conversations.map(_toConversationCompanion).toList(),
    );
  }

  Future<void> upsertConversation(ChatSummary conversation) {
    return _db.upsertCachedConversation(_toConversationCompanion(conversation));
  }

  Future<List<ChatMessage>> getMessages(
    int chatId, {
    int? beforeId,
    int limit = 30,
  }) async {
    final rows = await _db.getCachedMessages(
      chatId,
      beforeId: beforeId,
      limit: limit,
    );
    return rows.map(_toMessage).toList();
  }

  Stream<List<ChatMessage>> watchMessages(int chatId) {
    return _db.watchCachedMessages(chatId).map(
      (rows) => rows.map(_toMessage).toList(),
    );
  }

  Future<void> saveMessages(List<ChatMessage> messages) {
    if (messages.isEmpty) return Future.value();
    return _db.upsertCachedMessages(messages.map(_toMessageCompanion).toList());
  }

  ChatSummary _toSummary(CachedConversation row) {
    return ChatSummary(
      chatId: row.chatId,
      otherParticipantId: row.otherParticipantId,
      otherParticipantName: row.otherParticipantName,
      otherParticipantImageUrl: row.otherParticipantImageUrl,
      lastMessage: row.lastMessage,
      lastMessageAt: row.lastMessageAt,
      unreadCount: row.unreadCount,
    );
  }

  CachedConversationsCompanion _toConversationCompanion(ChatSummary s) {
    return CachedConversationsCompanion(
      chatId: Value(s.chatId),
      otherParticipantId: Value(s.otherParticipantId),
      otherParticipantName: Value(s.otherParticipantName),
      otherParticipantImageUrl: Value(s.otherParticipantImageUrl),
      lastMessage: Value(s.lastMessage),
      lastMessageAt: Value(s.lastMessageAt),
      unreadCount: Value(s.unreadCount),
      updatedAt: Value(DateTime.now()),
    );
  }

  ChatMessage _toMessage(CachedMessage row) {
    return ChatMessage(
      id: row.id,
      chatId: row.chatId,
      senderId: row.senderId,
      senderName: row.senderName,
      message: row.message,
      createdAt: row.createdAt,
    );
  }

  CachedMessagesCompanion _toMessageCompanion(ChatMessage m) {
    return CachedMessagesCompanion(
      id: Value(m.id),
      chatId: Value(m.chatId),
      senderId: Value(m.senderId),
      senderName: Value(m.senderName),
      message: Value(m.message),
      createdAt: Value(m.createdAt),
    );
  }
}
