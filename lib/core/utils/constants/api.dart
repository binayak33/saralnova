class Api {
  // static const String baseUrl = "https://stay.saralnova.com";
  // static const String baseUrl = "http://192.168.100.36:8003";
  static const String baseUrl = "http://192.168.1.109:8003";

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

  static String apiBaseUrl = "$baseUrl/api/v1";

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

  // ------------room_Type
  static String getRoomTypes = "$apiBaseUrl/room-types";
  static String storeRoomType = "$apiBaseUrl/room-types/store";
  static String updateRoomType = "$apiBaseUrl/room-types/update";
  static String deleteRoomType = "$apiBaseUrl/room-types/delete";

  // ---------aminities

  static String getAminityTypes = "$apiBaseUrl/amenities";
  static String storeAminityType = "$apiBaseUrl/amenities/store";
  static String updateAminityType = "$apiBaseUrl/amenities/update";
  static String deleteAminityType = "$apiBaseUrl/amenities/delete";

  // ----------facilities
  static String getFacilityTypes = "$apiBaseUrl/facility";
  static String storeFacilityType = "$apiBaseUrl/facility/store";
  static String updateFacilityType = "$apiBaseUrl/facility/update";
  static String deleteFacilityType = "$apiBaseUrl/facility/delete";

  // ---------------Rooms
  // ----------facilities
  static String getRooms = "$apiBaseUrl/rooms";
  static String storeRooms = "$apiBaseUrl/rooms/store";
  static String updateRooms = "$apiBaseUrl/rooms/update";
  static String deleteRooms = "$apiBaseUrl/rooms/delete";

  // ----------staff
  static String getStaffs = "$apiBaseUrl/staffs";
  static String storeStaffs = "$apiBaseUrl/staffs/store";
  static String updateStaffs = "$apiBaseUrl/staffs/update";
  static String deleteStaffs = "$apiBaseUrl/staffs/delete";

  //---------booking
  static String searchAvailableRooms =
      "$apiBaseUrl/hotel-booking/get-available-rooms";
  // static String storeStaffs = "$apiBaseUrl/staffs/store";
  // static String updateStaffs = "$apiBaseUrl/staffs/update";
  // static String deleteStaffs = "$apiBaseUrl/staffs/delete";
}
