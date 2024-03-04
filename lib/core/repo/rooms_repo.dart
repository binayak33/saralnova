import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:saralnova/core/model/rooms_model.dart';
import 'package:saralnova/core/utils/constants/api.dart';
import 'package:saralnova/core/utils/constants/messages.dart';
import 'package:saralnova/core/utils/helpers/log_helper.dart';
import 'package:saralnova/core/utils/helpers/sky_requests.dart';

class RoomsRepo {
  static Future<void> getRooms({
    required Function(List<Rooms> rooms) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.getRooms;

      http.Response response = await SkyRequest.get(
        url,
      );

      var data = json.decode(response.body);

      print(data);
      if (data["status"]) {
        var rooms = roomFromJson(data['data']);
        onSuccess(rooms);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.getRooms, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> storeRoom({
    required String roomTypeId,
    required String title,
    required String status,
    required String amenities,
    required num roomRate,
    required Function(Rooms rooms) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.storeRooms;

      var body = {
        "room_type_id": roomTypeId,
        "title": title,
        "status": status,
        "rate": roomRate,
        "selectedAmenities": amenities,
      };

      http.Response response = await SkyRequest.post(
        url,
        body: body,
      );

      var data = json.decode(response.body);

      if (data["status"] == true) {
        var rooms = Rooms.fromJson(data['data']);
        onSuccess(rooms);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.storeRooms, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> updateRoomType({
    required String roomId,
    required String roomTypeId,
    required String roomTitle,
    required String status,
    required num rate,
    // required String? amenities,
    required Function(Rooms rooms) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.updateRooms;
      var body = {
        "id": roomId,
        "room_type_id": roomTypeId,
        "title": roomTitle,
        "status": status,
        "rate": rate,
        // "selectedAmenities":amenities
      };

      http.Response response = await SkyRequest.post(
        url,
        body: body,
      );

      var data = json.decode(response.body);

      if (data["status"]) {
        var room = Rooms.fromJson(data['data']);
        onSuccess(room);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.updateRooms, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> deleteRoomType({
    required String roomId,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.deleteRooms;
      var body = {
        "id": roomId,
      };

      http.Response response = await SkyRequest.post(
        url,
        body: body,
      );

      var data = json.decode(response.body);

      if (data["status"]) {
        String msg = data['message'];
        onSuccess(msg);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.deleteRooms, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }
}
