import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:saralnova/core/model/feature_model/order/order_model.dart';
import 'package:saralnova/core/utils/constants/api.dart';
import 'package:saralnova/core/utils/constants/messages.dart';
import 'package:saralnova/core/utils/helpers/log_helper.dart';
import 'package:saralnova/core/utils/helpers/sky_requests.dart';

class OrderRepo {
  static Future<void> getAllCheckedOutOrders({
    String? nextPageUrl,
    required Function(List<OrderModel> checkedOutOrders, String? nextPageUrl)
        onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = nextPageUrl ?? Api.checkedOutOrders;

      http.Response response = await SkyRequest.get(
        url,
      );

      var data = json.decode(response.body);

      if (data["status"]) {
        var checkedOutOrders = ordersFromJson(data['data']['data']);
        var nextPageUrl = data['data']['next_page_url'];

        onSuccess(checkedOutOrders, nextPageUrl);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.checkedOutOrders, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }
}
