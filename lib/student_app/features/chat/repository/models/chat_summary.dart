class ChatSummary {
  const ChatSummary({
    required this.chatId,
    required this.otherParticipantId,
    required this.otherParticipantName,
    required this.lastMessage,
    required this.lastMessageAt,
    required this.unreadCount,
  });

  final int chatId;
  final String otherParticipantId;
  final String otherParticipantName;
  final String? lastMessage;
  final DateTime? lastMessageAt;
  final int unreadCount;

  ChatSummary copyWith({
    String? lastMessage,
    DateTime? lastMessageAt,
    int? unreadCount,
  }) {
    return ChatSummary(
      chatId: chatId,
      otherParticipantId: otherParticipantId,
      otherParticipantName: otherParticipantName,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  factory ChatSummary.fromJson(Map<String, dynamic> json) {
    return ChatSummary(
      chatId: _toInt(json['chatId']),
      otherParticipantId: (json['otherParticipantId'] ?? '').toString(),
      otherParticipantName: (json['otherParticipantName'] ?? '').toString(),
      lastMessage: _toNullableString(json['lastMessage']),
      lastMessageAt: _toNullableDate(json['lastMessageAt']),
      unreadCount: _toInt(json['unreadCount']),
    );
  }
}

int _toInt(dynamic value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString() ?? '') ?? 0;
}

String? _toNullableString(dynamic value) {
  if (value == null) return null;
  final text = value.toString();
  return text.isEmpty ? null : text;
}

DateTime? _toNullableDate(dynamic value) {
  if (value == null) return null;
  return DateTime.tryParse(value.toString())?.toLocal();
}
