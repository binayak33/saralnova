import 'package:flutter_dotenv/flutter_dotenv.dart';

class Api {
  // static const String baseUrl = "https://stay.saralnova.com";
  static const String baseUrl = "http://192.168.100.36:8003";

  // static String get baseUrl {
  //   final apiMode = dotenv.env['API_MODE'];
  //   if (apiMode == "live") {
  //     return "https://stay.saralnova.com";
  //   } else if (apiMode == "uat") {
  //     return "https://stay.saralnova.com";
  //   } else {
  //     return dotenv.env['API_LOCAL_URL'] ?? "http://0.0.0.0:8000";
  //   }
  // }

  static String apiBaseUrl = "$baseUrl/api";

  static String loginApi = "$apiBaseUrl/login";
  static String dashboardApi = "$apiBaseUrl/dashboard";
  static String calendarViewApi = "$apiBaseUrl/calendar-view";
  static String bookingExpenseApi = "$apiBaseUrl/booking-expense";
  static String guestApi = "$apiBaseUrl/guests";
  static String roomTypeApi = "$apiBaseUrl/room-types";
  static String roomAvaviApi = "$apiBaseUrl/room/type";
  static String roomOccupancyApi = "$apiBaseUrl/room-occupancy";

  static String login = "$baseUrl/login";
  static String forgetPassword = "$baseUrl/forgot-password";
  static String dashboard = "$baseUrl/dashboard";
}
