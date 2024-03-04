import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:saralnova/core/model/feature_model/facility_model.dart';
import 'package:saralnova/core/model/feature_model/room_type_model.dart';
import 'package:saralnova/core/utils/constants/api.dart';
import 'package:saralnova/core/utils/constants/messages.dart';
import 'package:saralnova/core/utils/helpers/log_helper.dart';
import 'package:saralnova/core/utils/helpers/sky_requests.dart';

class FacilityRepo {
  static Future<void> getFacilitiesTypes({
    required Function(List<Facility> facilities) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.getFacilityTypes;

      http.Response response = await SkyRequest.get(
        url,
      );

      var data = json.decode(response.body);

      print(data);
      if (data["status"]) {
        var facilities = facilitiesFromJson(data['data']);
        onSuccess(facilities);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.getFacilityTypes, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> storeFacilityType({
    required String title,
    required num price,
    required Function(Facility facility) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.storeFacilityType;
      var body = {
        "title": title,
        "price": price,
      };

      http.Response response = await SkyRequest.post(
        url,
        body: body,
      );

      var data = json.decode(response.body);

      if (data["status"]) {
        var facility = Facility.fromJson(data['data']);
        onSuccess(facility);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.storeFacilityType, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> updateFacilityType({
    required String facilityTitle,
    required String facilityd,
    required num price,
    required Function(Facility facility) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.updateFacilityType;
      var body = {
        "id": facilityd,
        "title": facilityTitle,
        "price":price,
      };

      http.Response response = await SkyRequest.post(
        url,
        body: body,
      );

      var data = json.decode(response.body);

      if (data["status"]) {
        var facility = Facility.fromJson(data['data']);
        onSuccess(facility);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.updateFacilityType, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> deleteFacilityType({
    required String facilityId,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.deleteFacilityType;
      var body = {
        "id": facilityId,
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
      LogHelper.error(Api.deleteFacilityType, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }
}
