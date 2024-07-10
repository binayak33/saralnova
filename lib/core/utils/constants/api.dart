import 'package:flutter_dotenv/flutter_dotenv.dart';

class Api {
  // static const String baseUrl = "https://stay.saralnova.com";
  // static const String baseUrl = "http://192.168.100.36:8003";
  // static const String baseUrl = "http://192.168.1.109:8003";
  // static const String baseUrl = "http://192.168.1.106:8888";

  static String get baseUrl {
    final apiMode = dotenv.env['API_MODE'];
    if (apiMode == "live") {
      return "https://stay.saralnova.com";
    } else if (apiMode == "uat") {
      return "https://uat-app.saralnova.com";
    } else {
      return dotenv.env['API_LOCAL_URL'] ?? "http://0.0.0.0:8000";
    }
  }

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
  static String getAllBookings = "$apiBaseUrl/hotel-booking/bookings";
  static String createHotelBooking =
      "$apiBaseUrl/hotel-booking/bookings/create";

  // --restaurants
  // ----restaurant category
  static String getCategory = "$apiBaseUrl/restaurant/category";
  static String storeCategory = "$apiBaseUrl/restaurant/category/store";
  static String updateCategory = "$apiBaseUrl/restaurant/category/update";
  static String deleteCategory = "$apiBaseUrl/restaurant/category/delete";

  //----restaurant variants
  static String getVariants = "$apiBaseUrl/restaurant/variants";
  static String storeVariants = "$apiBaseUrl/restaurant/variants/store";
  static String updateVariants = "$apiBaseUrl/restaurant/variants/update";
  static String deleteVariants = "$apiBaseUrl/restaurant/variants/delete";

  //-----restaurant menus
  static String getMenus = "$apiBaseUrl/restaurant/menu";
  static String storeMenus = "$apiBaseUrl/restaurant/menu/store";
  static String updateMenus =
      "$apiBaseUrl/restaurant/menu/update"; //TODO implement
  static String deleteMenus = "$apiBaseUrl/restaurant/menu/delete";

// ------------tables
  static String getTables = "$apiBaseUrl/restaurant/tables";
  static String getAvailableTables = "$apiBaseUrl/restaurant/available-tables";
  static String storeTables = "$apiBaseUrl/restaurant/tables/store";
  static String updateTables = "$apiBaseUrl/restaurant/tables/update";
  static String deleteTable = "$apiBaseUrl/restaurant/tables/delete";

  // ------------space
  static String getSpaces = "$apiBaseUrl/restaurant/space";
  static String storeSpace = "$apiBaseUrl/restaurant/space/store";
  static String updateSpace = "$apiBaseUrl/restaurant/space/update";
  static String deleteSpace = "$apiBaseUrl/restaurant/space/delete";

// -------------activities
  static String activities = "$apiBaseUrl/restaurant/activities";

  

  //-------------order new sprint
    static String checkedOutOrders = "$apiBaseUrl/restaurant/checked-out-orders";



// ------------pos
  static String getAllCustomersOrders =
      "$apiBaseUrl/restaurant/customer/all-orders-by-customer";
  static String getCustomersOrder =
      "$apiBaseUrl/restaurant/customer/orders?id=#id#";


static String getMenuByCategory =
      "$apiBaseUrl/restaurant/category/menus?id=#id#";
}
