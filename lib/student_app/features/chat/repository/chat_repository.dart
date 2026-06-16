import 'dart:convert';

import 'package:dio/dio.dart';

import 'models/chat.dart';
import 'models/chat_message.dart';
import 'models/chat_summary.dart';

class ChatException implements Exception {
  const ChatException(this.message);
  final String message;
  @override
  String toString() => message;
}

class ChatRepository {
  ChatRepository(this._dio);

  final Dio _dio;

  Future<Chat> startChat({int? roomId, String? participantUserId}) async {
    try {
      final res = await _dio.post(
        '/api/chats',
        data: {'roomId': ?roomId, 'participantUserId': ?participantUserId},
      );
      return Chat.fromJson(Map<String, dynamic>.from(res.data as Map));
    } on DioException catch (e) {
      throw _mapError(e, 'Could not start the chat.');
    }
  }

  Future<List<ChatSummary>> listChats() async {
    try {
      final res = await _dio.get('/api/chats');
      final data = res.data;
      if (data is! List) return const [];
      return data
          .whereType<Map>()
          .map((e) => ChatSummary.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } on DioException catch (e) {
      throw _mapError(e, 'Could not load your chats.');
    }
  }

  Future<List<ChatMessage>> fetchMessages(
    int chatId, {
    int? beforeMessageId,
    int pageSize = 30,
  }) async {
    try {
      final res = await _dio.get(
        '/api/chats/$chatId/messages',
        queryParameters: {
          'beforeMessageId': ?beforeMessageId,
          'pageSize': pageSize,
        },
      );
      final data = res.data;
      if (data is! List) return const [];
      return data
          .whereType<Map>()
          .map((e) => ChatMessage.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } on DioException catch (e) {
      throw _mapError(e, 'Could not load messages.');
    }
  }

  Future<void> markRead(int chatId, int lastMessageId) async {
    try {
      await _dio.put(
        '/api/chats/$chatId/read',
        data: {'lastMessageId': lastMessageId},
      );
    } on DioException catch (e) {
      throw _mapError(e, 'Could not update the chat.');
    }
  }

  ChatException _mapError(DioException e, String fallback) {
    if (e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return const ChatException(
        'Cannot reach the server. Make sure the backend is running.',
      );
    }
    final data = e.response?.data;
    if (data is Map) {
      final dynamic msg = data['detail'] ?? data['message'] ?? data['title'];
      if (msg is String && msg.trim().isNotEmpty) return ChatException(msg);
    }
    if (data is String && data.trim().isNotEmpty && data.length < 200) {
      final decoded = _tryDecode(data);
      if (decoded != null) return ChatException(decoded);
      return ChatException(data);
    }
    return ChatException(fallback);
  }

  String? _tryDecode(String data) {
    try {
      final decoded = jsonDecode(data);
      if (decoded is Map) {
        final dynamic msg =
            decoded['detail'] ?? decoded['message'] ?? decoded['title'];
        if (msg is String && msg.trim().isNotEmpty) return msg;
      }
    } catch (_) {}
    return null;
  }
}
