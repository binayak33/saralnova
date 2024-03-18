import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:saralnova/core/model/rooms_model.dart';
import 'package:saralnova/core/utils/helpers/sky_requests.dart';

import '../../model/feature_model/booking_model/booking_model.dart';
import '../../model/feature_model/request_model/store_request_model.dart';
import '../../utils/constants/api.dart';
import '../../utils/constants/messages.dart';
import '../../utils/helpers/log_helper.dart';

class BookingRepo {
  static Future<void> searchAvailableRooms({
    required String? roomType,
    required String? checkInDate,
    required String? checkOutDate,
    required String? guestCount,
    required Function(List<Rooms> availableRooms) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.searchAvailableRooms;
      var body = {
        "room_type": roomType,
        "checkin": checkInDate,
        "checkout": checkOutDate,
        "guest_count": guestCount,
      };
      http.Response response = await SkyRequest.post(url, body: body);
      var data = json.decode(response.body);

      if (data['status']) {
        var availableRooms = roomFromJson(data['data']);
        onSuccess(availableRooms);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.searchAvailableRooms, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> createBooking({
    required StoreBookingRequestModel? storeBookingmodel,
    required Function(Booking booking, String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.createHotelBooking;
      // String body = json.encode(storeBookingmodel.toString());
      // http.Response response = await SkyRequest.post(url, body: body);

      // var body = json.encode(storeBookingmodel);
      http.Response response =
          await SkyRequest.post(url, body: storeBookingmodel?.toJson());
      var data = json.decode(response.body);

      if (data['status']) {
        var booking = Booking.fromJson(data['data']);
        var message = data['message'];
        onSuccess(booking, message);
        // var x = data['data'];
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.createHotelBooking, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }
}
