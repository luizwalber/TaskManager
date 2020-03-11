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
