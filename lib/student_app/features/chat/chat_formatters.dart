String _two(int n) => n.toString().padLeft(2, '0');

String formatThreadTime(DateTime dt) => '${_two(dt.hour)}:${_two(dt.minute)}';

String formatConversationTimestamp(DateTime? dt) {
  if (dt == null) return '';

  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final day = DateTime(dt.year, dt.month, dt.day);
  final diff = today.difference(day).inDays;

  if (diff <= 0) return formatThreadTime(dt);
  if (diff == 1) return 'Yesterday';
  if (diff < 7) return _weekday(dt.weekday);
  return '${_two(dt.day)}/${_two(dt.month)}/${_two(dt.year % 100)}';
}

String _weekday(int weekday) {
  const names = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  return names[(weekday - 1).clamp(0, 6)];
}
