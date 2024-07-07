import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:saralnova/core/utils/constants/api.dart';
import 'package:saralnova/core/utils/constants/messages.dart';
import 'package:saralnova/core/utils/helpers/log_helper.dart';
import 'package:saralnova/core/utils/helpers/sky_requests.dart';

import '../../../model/feature_model/order/order_customers_model.dart';
import '../../../model/feature_model/order/order_kot_model.dart';

class OrderRepo {
  static Future<void> getAllOrdersByCustomers({
    required Function(List<Customer> customers) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.getAllCustomersOrders;

      http.Response response = await SkyRequest.get(
        url,
      );

      var data = json.decode(response.body);

      if (data["status"]) {
        var customers = customersFromJson(data['data']);
        onSuccess(customers);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.getAllCustomersOrders, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

//getKotsByCustomer is the api of individual customers KOT's
  static Future<void> getKotsByCustomer({
    required customerId,
    required Function(List<KitchenOrderTicket> kitchenOrderTickets) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      // String url = Api.getCustomersOrder;
      String url = (Api.getCustomersOrder.replaceAll("#id#", customerId));

      http.Response response = await SkyRequest.get(
        url,
      );

      var data = json.decode(response.body);

      if (data["status"]) {
        var kots = kitchenOrderTicketsFromJson(data['data']);
        onSuccess(kots);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.getCustomersOrder, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }
}
