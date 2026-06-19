import 'package:student_lib/l10n/generated/app_localizations.dart';

String _two(int n) => n.toString().padLeft(2, '0');

String formatThreadTime(DateTime dt) => '${_two(dt.hour)}:${_two(dt.minute)}';

String formatConversationTimestamp(AppLocalizations l10n, DateTime? dt) {
  if (dt == null) return '';

  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final day = DateTime(dt.year, dt.month, dt.day);
  final diff = today.difference(day).inDays;

  if (diff <= 0) return formatThreadTime(dt);
  if (diff == 1) return l10n.chatYesterday;
  if (diff < 7) return _weekday(l10n, dt.weekday);
  return '${_two(dt.day)}/${_two(dt.month)}/${_two(dt.year % 100)}';
}

String _weekday(AppLocalizations l10n, int weekday) {
  switch (weekday) {
    case DateTime.monday:
      return l10n.chatWeekdayMon;
    case DateTime.tuesday:
      return l10n.chatWeekdayTue;
    case DateTime.wednesday:
      return l10n.chatWeekdayWed;
    case DateTime.thursday:
      return l10n.chatWeekdayThu;
    case DateTime.friday:
      return l10n.chatWeekdayFri;
    case DateTime.saturday:
      return l10n.chatWeekdaySat;
    default:
      return l10n.chatWeekdaySun;
  }
}
