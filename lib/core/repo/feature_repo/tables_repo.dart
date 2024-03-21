import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:saralnova/core/model/feature_model/tables/table_model.dart';
import 'package:saralnova/core/utils/constants/messages.dart';
import 'package:saralnova/core/utils/helpers/log_helper.dart';

import '../../utils/constants/api.dart';
import '../../utils/helpers/sky_requests.dart';

class TableRepo {
  static Future<void> getAllTables({
    required Function(List<TableModel> tables) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.getTables;

      http.Response response = await SkyRequest.get(
        url,
      );

      var data = json.decode(response.body);
      if (data["status"]) {
        var tables = tablesJson(data['data']);
        onSuccess(tables);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.getTables, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  // static Future<void> storeRestaurantCategory({
  //   // required String title,
  //   required Space? space,
  //   required Function(Space space) onSuccess,
  //   required Function(String message) onError,
  // }) async {
  //   try {
  //     String url = Api.storeSpace;
  //     var body = space?.toJson();

  //     http.Response response = await SkyRequest.post(
  //       url,
  //       body: body,
  //     );

  //     var data = json.decode(response.body);

  //     if (data["status"]) {
  //       var space = Space.fromJson(data['data']);
  //       onSuccess(space);
  //     } else {
  //       onError(data['message']);
  //     }
  //   } catch (e, s) {
  //     LogHelper.error(Api.storeSpace, error: e, stackTrace: s);
  //     onError(Messages.error);
  //   }
  // }

  // static Future<void> updateSpace({
  //   required Space? spaceModel,
  //   required Function(Space space) onSuccess,
  //   required Function(String message) onError,
  // }) async {
  //   try {
  //     String url = Api.updateSpace;
  //     var body = spaceModel?.toJson();

  //     http.Response response = await SkyRequest.post(
  //       url,
  //       body: body,
  //     );

  //     var data = json.decode(response.body);

  //     if (data["status"]) {
  //       var space = Space.fromJson(data['data']);
  //       onSuccess(space);
  //     } else {
  //       onError(data['message']);
  //     }
  //   } catch (e, s) {
  //     LogHelper.error(Api.updateSpace, error: e, stackTrace: s);
  //     onError(Messages.error);
  //   }
  // }

  static Future<void> deleteTable({
    required tableId,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.deleteTable;
      var body = {
        "id": tableId,
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
      LogHelper.error(Api.deleteTable, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }
}
