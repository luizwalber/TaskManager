import 'package:intl/intl.dart';

/// Generates a hash with day month and year to be used in keys for maps
/// @author: luiz walber
String dateDayHash(DateTime day) {
  return day != null ? DateFormat('yyyy-MM-dd').format(day) : null;
}

/// Generates a hash with day month and year to be used in keys for maps
/// @author: luiz walber
String dateMonthHash(DateTime day) {
  return day != null ? DateFormat('yyyy-MM').format(day) : null;
}

/// Check if two dates is in the same day
bool isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}
