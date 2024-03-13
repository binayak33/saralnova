import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:saralnova/core/model/rooms_model.dart';
import 'package:saralnova/core/utils/helpers/sky_requests.dart';

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

      print(data);

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
}
