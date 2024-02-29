import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:saralnova/core/model/aminity_model.dart';
import 'package:saralnova/core/model/room_model.dart';
import 'package:saralnova/core/utils/constants/api.dart';
import 'package:saralnova/core/utils/constants/messages.dart';
import 'package:saralnova/core/utils/helpers/log_helper.dart';
import 'package:saralnova/core/utils/helpers/sky_requests.dart';

class AminityRepo {
  static Future<void> getAminityTypes({
    required Function(List<Aminity> amenities) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.getAminityTypes;

      http.Response response = await SkyRequest.get(
        url,
      );

      var data = json.decode(response.body);

      if (data["status"]) {
        var amenities = amenitiesFromJson(data['data']);
        onSuccess(amenities);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.getAminityTypes, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> storeAmintyType({
    required String title,
    // TODO : upload image
    required Function(Aminity amenity) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.storeAminityType;
      var body = {
        "title": title,
        //add image
      };

      http.Response response = await SkyRequest.post(
        url,
        body: body,
      );

      var data = json.decode(response.body);

      print(data);
      if (data["status"]) {
        var amenity = Aminity.fromJson(data['data']);
        onSuccess(amenity);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.storeAminityType, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> updateAminityType({
    required String roomTitle,
    required int roomId,
    required Function(Room room) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.updateAminityType;
      var body = {
        "id": roomId,
        "title": roomTitle,
      };

      http.Response response = await SkyRequest.post(
        url,
        body: body,
      );

      var data = json.decode(response.body);

      if (data["status"]) {
        var room = Room.fromJson(data['data']);
        onSuccess(room);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.updateAminityType, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> deleteAminityType({
    required int roomId,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.deleteAminityType;
      var body = {
        "id": roomId,
      };

      http.Response response = await SkyRequest.post(
        url,
        body: body,
      );

      var data = json.decode(response.body);

      print(data);

      if (data["status"]) {
        print("status--------------${data['message']}");
        String msg = data['message'];
        onSuccess(msg);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.deleteAminityType, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }
}
