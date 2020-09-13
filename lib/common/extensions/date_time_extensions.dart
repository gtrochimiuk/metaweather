import 'package:intl/intl.dart';
import 'package:metaweather/presentation/texts/app_texts.dart';

extension DateTimeExtentions on DateTime {
  String formatWeekDay() {
    return _todayOrTomorrow() ?? DateFormat('EEEE').format(this);
  }

  String formatLong() {
    final prefix = _todayOrTomorrow();
    if (prefix != null) {
      return '$prefix, ${DateFormat('d MMMM').format(this)}';
    }
    return DateFormat('EEEE, d MMMM').format(this);
  }

  String _todayOrTomorrow() {
    final now = DateTime.now();
    if (isSameDay(now)) {
      return AppTexts.current.today();
    } else if (isSameDay(now.add(Duration(days: 1)))) {
      return AppTexts.current.tomorrow();
    }
    return null;
  }

  bool isSameDay(DateTime other) => year == other.year && month == other.month && day == other.day;
}
