import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:saralnova/core/model/feature_model/tables/space_model.dart';
import 'package:saralnova/core/utils/helpers/sky_requests.dart';

import '../../utils/constants/api.dart';
import '../../utils/constants/messages.dart';
import '../../utils/helpers/log_helper.dart';

class SpaceRepo {
  static Future<void> getSpaces({
    required Function(List<Space> spaces) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.getSpaces;

      http.Response response = await SkyRequest.get(
        url,
      );

      var data = json.decode(response.body);
      if (data["status"]) {
        var spaces = tableSpaceJson(data['data']);
        onSuccess(spaces);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.getSpaces, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> storeRestaurantCategory({
    // required String title,
    required Space? space,
    required Function(Space space) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.storeSpace;
      var body = space?.toJson();

      http.Response response = await SkyRequest.post(
        url,
        body: body,
      );

      var data = json.decode(response.body);

      if (data["status"]) {
        var space = Space.fromJson(data['data']);
        onSuccess(space);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.storeSpace, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> updateSpace({
    required Space? spaceModel,
    required Function(Space space) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.updateSpace;
      var body = spaceModel?.toJson();

      http.Response response = await SkyRequest.post(
        url,
        body: body,
      );

      var data = json.decode(response.body);

      if (data["status"]) {
        var space = Space.fromJson(data['data']);
        onSuccess(space);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.updateSpace, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> deleteSpace({
    required spaceId,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.deleteSpace;
      var body = {
        "id": spaceId,
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
      LogHelper.error(Api.deleteSpace, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }
}
