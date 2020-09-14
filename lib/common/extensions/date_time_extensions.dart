import 'package:intl/intl.dart';
import 'package:metaweather/presentation/texts/app_texts.dart';

extension DateTimeExtentions on DateTime {
  String formatWeekDay() {
    return _contextName() ?? DateFormat('EEEE').format(this);
  }

  String formatDayTime() {
    final contextName = _contextName();
    if (contextName != null) {
      return '$contextName at ${DateFormat('HH:mm').format(this)}';
    }
    return DateFormat('EEEE HH:mm').format(this);
  }

  String formatLong() {
    final contextName = _contextName();
    if (contextName != null) {
      return '$contextName, ${DateFormat('d MMMM').format(this)}';
    }
    return DateFormat('EEEE, d MMMM').format(this);
  }

  String _contextName() {
    final now = DateTime.now();
    if (isSameDay(now)) {
      return AppTexts.current.today();
    } else if (isSameDay(now.add(Duration(days: 1)))) {
      return AppTexts.current.tomorrow();
    } else if (isSameDay(now.subtract(Duration(days: 1)))) {
      return AppTexts.current.yesterday();
    }
    return null;
  }

  bool isSameDay(DateTime other) => year == other.year && month == other.month && day == other.day;
}
