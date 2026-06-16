import 'dart:async';

import 'package:signalr_netcore/signalr_client.dart';

import '../../../core/config/app_config.dart';
import 'models/chat_message.dart';

class ChatRealtimeService {
  ChatRealtimeService({required Future<String?> Function() tokenProvider})
    : _tokenProvider = tokenProvider;

  final Future<String?> Function() _tokenProvider;

  HubConnection? _connection;
  Future<void>? _starting;

  final StreamController<ChatMessage> _messages =
      StreamController<ChatMessage>.broadcast();
  final StreamController<String> _errors = StreamController<String>.broadcast();
  final StreamController<bool> _connected = StreamController<bool>.broadcast();

  bool _isConnected = false;

  Stream<ChatMessage> get messages => _messages.stream;

  Stream<String> get errors => _errors.stream;

  Stream<bool> get connectionState => _connected.stream;

  bool get isConnected => _isConnected;

  String get _hubUrl => '${AppConfig.apiBaseUrl}/hubs/chat';

  Future<void> start() {
    if (_isConnected) return Future.value();
    return _starting ??= _startInternal();
  }

  Future<void> _startInternal() async {
    try {
      final connection = HubConnectionBuilder()
          .withUrl(
            _hubUrl,
            options: HttpConnectionOptions(
              accessTokenFactory: () async => (await _tokenProvider()) ?? '',
            ),
          )
          .withAutomaticReconnect()
          .build();

      connection.on('ReceiveMessage', _handleReceiveMessage);
      connection.on('Error', _handleError);
      connection.onclose(({error}) => _setConnected(false));
      connection.onreconnecting(({error}) => _setConnected(false));
      connection.onreconnected(({connectionId}) => _setConnected(true));

      await connection.start();
      _connection = connection;
      _setConnected(true);
    } catch (_) {
      _setConnected(false);
    } finally {
      _starting = null;
    }
  }

  Future<void> sendMessage(int chatId, String message) async {
    final connection = _connection;
    if (connection == null || !_isConnected) {
      throw const ChatRealtimeException('Not connected to the chat server.');
    }
    await connection.invoke('SendMessage', args: [chatId, message]);
  }

  Future<void> joinChat(int chatId) async {
    final connection = _connection;
    if (connection == null || !_isConnected) return;
    try {
      await connection.invoke('JoinChat', args: [chatId]);
    } catch (_) {}
  }

  Future<void> stop() async {
    final connection = _connection;
    _connection = null;
    _setConnected(false);
    if (connection != null) {
      try {
        await connection.stop();
      } catch (_) {}
    }
  }

  void dispose() {
    stop();
    _messages.close();
    _errors.close();
    _connected.close();
  }

  void _handleReceiveMessage(List<Object?>? args) {
    if (args == null || args.isEmpty) return;
    final payload = args.first;
    if (payload is Map) {
      _messages.add(ChatMessage.fromJson(Map<String, dynamic>.from(payload)));
    }
  }

  void _handleError(List<Object?>? args) {
    if (args == null || args.isEmpty) return;
    final message = args.first?.toString();
    if (message != null && message.isNotEmpty) _errors.add(message);
  }

  void _setConnected(bool value) {
    _isConnected = value;
    if (!_connected.isClosed) _connected.add(value);
  }
}

class ChatRealtimeException implements Exception {
  const ChatRealtimeException(this.message);
  final String message;
  @override
  String toString() => message;
}
