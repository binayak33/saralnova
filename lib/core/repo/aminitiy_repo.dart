import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:saralnova/core/model/aminity_model.dart';
import 'package:saralnova/core/utils/constants/api.dart';
import 'package:saralnova/core/utils/constants/messages.dart';
import 'package:saralnova/core/utils/helpers/log_helper.dart';
import 'package:saralnova/core/utils/helpers/sky_requests.dart';

class AminityRepo {
  // TODO make name correct
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
    File? image,
    required Function(Aminity amenity) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.storeAminityType;
      var body = {
        "title": title,
        "icon": image,
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
    required String amenityTitle,
    required int amenityId,
    // required String imageUrl TODO
    required Function(Aminity aminity) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.updateAminityType;
      var body = {
        "id": amenityId,
        "title": amenityTitle,
      };

      http.Response response = await SkyRequest.post(
        url,
        body: body,
      );

      var data = json.decode(response.body);

      if (data["status"]) {
        var aminity = Aminity.fromJson(data['data']);
        onSuccess(aminity);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.updateAminityType, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> deleteAminityType({
    required int amenityId,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.deleteAminityType;
      var body = {
        "id": amenityId,
      };

      http.Response response = await SkyRequest.post(
        url,
        body: body,
      );

      var data = json.decode(response.body);

      print(data);

      if (data["status"]) {
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
