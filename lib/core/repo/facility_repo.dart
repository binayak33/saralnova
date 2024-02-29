import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:saralnova/core/model/room_model.dart';
import 'package:saralnova/core/utils/constants/api.dart';
import 'package:saralnova/core/utils/constants/messages.dart';
import 'package:saralnova/core/utils/helpers/log_helper.dart';
import 'package:saralnova/core/utils/helpers/sky_requests.dart';

class FacilityRepo {
  // static Future<void> getFacilitiesTypes({
  //   required Function(List<Room> rooms) onSuccess,
  //   required Function(String message) onError,
  // }) async {
  //   try {
  //     String url = Api.getRoomTypes;

  //     http.Response response = await SkyRequest.get(
  //       url,
  //     );

  //     var data = json.decode(response.body);

  //     print(data);
  //     if (data["status"]) {
  //       var rooms = moviesFromJson(data['data']);
  //       onSuccess(rooms);
  //     } else {
  //       onError(data['message']);
  //     }
  //   } catch (e, s) {
  //     LogHelper.error(Api.getRoomTypes, error: e, stackTrace: s);
  //     onError(Messages.error);
  //   }
  // }

  // static Future<void> storeFacilityType({
  //   required String title,
  //   required Function(Room room) onSuccess,
  //   required Function(String message) onError,
  // }) async {
  //   try {
  //     String url = Api.storeRoomType;
  //     var body = {
  //       "title": title,
  //     };

  //     http.Response response = await SkyRequest.post(
  //       url,
  //       body: body,
  //     );

  //     var data = json.decode(response.body);

  //     print(data);
  //     if (data["status"]) {
  //       var room = Room.fromJson(data['data']);
  //       onSuccess(room);
  //     } else {
  //       onError(data['message']);
  //     }
  //   } catch (e, s) {
  //     LogHelper.error(Api.storeRoomType, error: e, stackTrace: s);
  //     onError(Messages.error);
  //   }
  // }

  // static Future<void> updateFacilityType({
  //   required String roomTitle,
  //   required int roomId,
  //   required Function(Room room) onSuccess,
  //   required Function(String message) onError,
  // }) async {
  //   try {
  //     String url = Api.updateRoomType;
  //     var body = {
  //       "id": roomId,
  //       "title": roomTitle,
  //     };

  //     http.Response response = await SkyRequest.post(
  //       url,
  //       body: body,
  //     );

  //     var data = json.decode(response.body);

  //     if (data["status"]) {
  //       var room = Room.fromJson(data['data']);
  //       onSuccess(room);
  //     } else {
  //       onError(data['message']);
  //     }
  //   } catch (e, s) {
  //     LogHelper.error(Api.updateRoomType, error: e, stackTrace: s);
  //     onError(Messages.error);
  //   }
  // }

  // static Future<void> deleteFacilityType({
  //   required int roomId,
  //   required Function(String message) onSuccess,
  //   required Function(String message) onError,
  // }) async {
  //   try {
  //     String url = Api.deleteRoomType;
  //     var body = {
  //       "id": roomId,
  //     };

  //     http.Response response = await SkyRequest.post(
  //       url,
  //       body: body,
  //     );

  //     var data = json.decode(response.body);

  //     print(data);

  //     if (data["status"]) {
  //       print("status--------------${data['message']}");
  //       String msg = data['message'];
  //       onSuccess(msg);
  //     } else {
  //       onError(data['message']);
  //     }
  //   } catch (e, s) {
  //     LogHelper.error(Api.deleteRoomType, error: e, stackTrace: s);
  //     onError(Messages.error);
  //   }
  // }
}
