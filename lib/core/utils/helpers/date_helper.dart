import 'package:intl/intl.dart';
import 'package:saralnova/core/utils/helpers/log_helper.dart';

class DateTimeHelper {
  static String preetyDateOnly(DateTime dateTime) {
    DateFormat formatter = DateFormat("dd  MMMM");
    String formatted = formatter.format(dateTime);
    return formatted;
  }

  static String prettyDate(DateTime dateTime) {
    DateFormat formatter = DateFormat("dd  MMMM, yyyy");
    String formatted = formatter.format(dateTime);
    return formatted;
  }

  static String preetyDay(DateTime dateTime) {
    DateFormat formatter = DateFormat("EEEE");
    String formatted = formatter.format(dateTime);
    return formatted;
  }

  static String prettyDateTime(DateTime dateTime) {
    DateFormat formatter = DateFormat("dd  MMM  y  hh:mm a");
    String formatted = formatter.format(dateTime);
    return formatted;
  }

  static String prettyStrDate(String? stringDate) {
    try {
      if (stringDate == null) throw "Invalid Date";
      DateTime dateTime = DateTime.parse(stringDate);
      DateFormat formatter = DateFormat("dd  MMM  y");
      String formatted = formatter.format(dateTime);
      return formatted;
    } catch (e) {
      return "Invalid Date";
    }
  }

  // static String prettyDatewithDay(DateTime dateTime) {
  //   DateFormat formatter = DateFormat("EEEE, d'${_addSuffix(dateTime.day)}' MMMM yyyy");
  //   String formatted = formatter.format(dateTime);
  //   return formatted;
  // }
  static String? prettyDateWithDay(String? dateString) {
    if (dateString == null) return null;

    DateTime dateTime = DateTime.parse(dateString);
    DateFormat formatter =
        DateFormat("EEEE, d'${_addSuffix(dateTime.day)}' MMMM yyyy");
    String formatted = formatter.format(dateTime);
    return formatted;
  }

  static String _addSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  static String prettyStrDateTime(String? stringDate) {
    try {
      if (stringDate == null) throw "Invalid Date";

      LogHelper.info(stringDate);
      DateTime dateTime = DateTime.parse(stringDate);
      DateFormat formatter = DateFormat("dd  MMM  y  hh:mm a");
      String formatted = formatter.format(dateTime);
      LogHelper.info(formatted);
      return formatted;
    } catch (e) {
      return "Invalid Date";
    }
  }

  static String preetyTime(DateTime dateTime) {
    DateFormat formatter = DateFormat("hh:mm  a");
    String formatted = formatter.format(dateTime);
    return formatted;
  }

  static String yyyymmdd(DateTime dateTime) {
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
