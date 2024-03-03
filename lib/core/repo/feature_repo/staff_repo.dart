import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:saralnova/core/model/feature_model/staff_model.dart';
import 'package:saralnova/core/model/user_model.dart';
import 'package:saralnova/core/utils/constants/messages.dart';
import 'package:saralnova/core/utils/helpers/log_helper.dart';
import 'package:saralnova/core/utils/helpers/sky_requests.dart';

import '../../utils/constants/api.dart';

class StaffRepo {
  static Future<void> getStaff({
    required Function(List<Staff> staffs) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.getStaffs;

      http.Response response = await SkyRequest.get(
        url,
      );

      var data = json.decode(response.body);

      if (data["status"]) {
        var staffs = staffFromJson(data['data']);
        onSuccess(staffs);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.getRoomTypes, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> storeStaff({
    required User user,
    required String password,
    required Function(Staff staff) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.storeStaffs;
      var body = {
        "name": user.name,
        "email": user.email,
        "username": user.username,
        "password": password
      };

      http.Response response = await SkyRequest.post(
        url,
        body: body,
      );

      var data = json.decode(response.body);

      if (data["status"]) {
        var staff = Staff.fromJson(data['data']);
        onSuccess(staff);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.storeStaffs, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> updateStaff({
    required String staffId,
    required User user,
    required String password,
    required Function(Staff staff) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.updateStaffs;
      var body = {
        "id": staffId,
        "name": user.name,
        "email": user.email,
        "username": user.username,
        "password": password,
      };

      http.Response response = await SkyRequest.post(
        url,
        body: body,
      );

      var data = json.decode(response.body);

      if (data["status"]) {
        var staff = Staff.fromJson(data['data']);
        onSuccess(staff);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.updateStaffs, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> deleteStaff({
    required String staffId,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.deleteStaffs;
      var body = {
        "id": staffId,
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
      LogHelper.error(Api.deleteStaffs, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }
}
