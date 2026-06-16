class Chat {
  const Chat({required this.chatId, required this.participantIds});

  final int chatId;
  final List<String> participantIds;

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      chatId: _toInt(json['chatId']),
      participantIds: _toStringList(json['participantIds']),
    );
  }
}

int _toInt(dynamic value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString() ?? '') ?? 0;
}

List<String> _toStringList(dynamic value) {
  if (value is List) return value.map((e) => e.toString()).toList();
  return const [];
}
