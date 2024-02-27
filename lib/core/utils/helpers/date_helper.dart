import 'package:intl/intl.dart';

class DateTimeHelper {
  static String prettyDate(DateTime dateTime) {
    DateFormat formatter = DateFormat("EE, dd  MMM,  y");
    String formatted = formatter.format(dateTime);
    return formatted;
  }

  static String prettyDateWithString(String stringdate) {
    try {
      DateTime dateTime = DateTime.parse(stringdate);
      DateFormat formatter = DateFormat("EE, dd  MMM,  y");
      String formatted = formatter.format(dateTime);
      return formatted;
    } catch (e) {
      return "Invalid Date";
    }
  }

  static String timeOnly(DateTime dateTime) {
    DateFormat formatter = DateFormat("hh:mm  a");
    String formatted = formatter.format(dateTime);
    return formatted;
  }

  static String timeOnlyWithString(String stringDate) {
    try {
      DateTime dateTime = DateTime.parse(stringDate);
      DateFormat formatter = DateFormat("hh:mm  a");
      String formatted = formatter.format(dateTime);
      return formatted;
    } catch (e) {
      return "Invalid Date Time";
    }
  }

  static String yymmdd(DateTime dateTime) {
    DateFormat formatter = DateFormat("yyyy-MM-dd");
    String formatted = formatter.format(dateTime);
    return formatted;
  }

  static bool isSameDate(DateTime date1, DateTime date2) {
    if (date1.year != date2.year) return false;
    if (date1.month != date2.month) return false;
    if (date1.day != date2.day) return false;

    return true;
  }
}
