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

  static Future<void> getAllAvailableTables({
    required Function(List<TableModel> tables) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.getAvailableTables;

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
      LogHelper.error(Api.getAvailableTables, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> storeTable({
    // required String title,
    required TableModel? tableModel,
    required String spaceId,
    required Function(TableModel table) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.storeTables;
      // var body = tableModel?.toJson();
      // var body = {
      //   "spaceId":spaceId
      // };
      Map<String, dynamic> body = tableModel?.toJson() ?? {};
      body['space_id'] = spaceId;

      http.Response response = await SkyRequest.post(
        url,
        body: body,
      );

      var data = json.decode(response.body);

      if (data["status"]) {
        var table = TableModel.fromJson(data['data']);
        onSuccess(table);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.storeTables, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> updateTable({
    required TableModel? tableModel,
    required String spaceId,
    required Function(TableModel table) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.updateTables;
      // var body = tableModel?.toJson();
      Map<String, dynamic> body = tableModel?.toJson() ?? {};
      body['space_id'] = spaceId;

      http.Response response = await SkyRequest.post(
        url,
        body: body,
      );

      var data = json.decode(response.body);

      if (data["status"]) {
        var table = TableModel.fromJson(data['data']);
        onSuccess(table);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.updateTables, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

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
