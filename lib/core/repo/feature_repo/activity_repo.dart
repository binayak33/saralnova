import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:saralnova/core/utils/constants/api.dart';
import 'package:saralnova/core/utils/constants/messages.dart';
import 'package:saralnova/core/utils/helpers/log_helper.dart';
import 'package:saralnova/core/utils/helpers/sky_requests.dart';

import '../../model/feature_model/activity/acitivity_model.dart';

class ActivityRepo {
  static Future<void> getAllActivities({
    String? nextPageUrl,
    required Function(List<Activity> activity, String? nextPageUrl) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = nextPageUrl ?? Api.activities;

      http.Response response = await SkyRequest.get(
        url,
      );

      var data = json.decode(response.body);

      if (data["status"]) {
        var activityList = activityFromJson(data['data']['data_by_date']);

        var nextPageUrl = data['data']['next_page_url'];

        onSuccess(activityList, nextPageUrl);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.activities, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }
}
