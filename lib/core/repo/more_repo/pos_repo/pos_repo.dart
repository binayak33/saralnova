import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:saralnova/core/model/feature_model/pos/pending_orders_for_kot_model.dart';
import 'package:saralnova/core/model/feature_model/pos/pos_request_model.dart/place_order_request_model.dart';
import 'package:saralnova/core/model/feature_model/restaurant_model/menu_model.dart';
import 'package:saralnova/core/utils/constants/api.dart';
import 'package:saralnova/core/utils/constants/messages.dart';
import 'package:saralnova/core/utils/helpers/log_helper.dart';
import 'package:saralnova/core/utils/helpers/sky_requests.dart';

import '../../../model/feature_model/pos/order_customers_model.dart';
import '../../../model/feature_model/pos/order_kot_model.dart';

class PosRepo {
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

  //get menu by categories

  static Future<void> getMenuByCategoy({
    String? categoryId,
    required Function(List<Menu> menus) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = categoryId != null
          ? Api.getMenuByCategory.replaceAll("#id#", categoryId)
          : Api.getMenuByCategory.replaceAll("#id#", "");
      http.Response response = await SkyRequest.get(
        url,
      );

      var data = json.decode(response.body);

      if (data["status"]) {
        var kots = menusRestaurantJson(data['data']);
        onSuccess(kots);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.getMenuByCategory, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  //request place order

  static Future<void> placeKOT({
    required PlaceOrderRequestModel? placeOrderRequestModel,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.placeKotOrder;
      var body = placeOrderRequestModel?.toJson();
      http.Response response = await SkyRequest.post(url, body: body);
      var data = json.decode(response.body);

      if (data['status']) {
        // var booking = Booking.fromJson(data['data']);
        var message = data['message'];
        onSuccess(message);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.placeKotOrder, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  //getKOT orders  // These are pending orders
  static Future<void> getKOTorders({
    required Function(List<PendingOrders> pendingOrders) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.getKotOrders;

      http.Response response = await SkyRequest.get(
        url,
      );

      var data = json.decode(response.body);

      if (data["status"]) {
        var pendingOrders = pendingKOTordersFromJson(data['data']);
        onSuccess(pendingOrders);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.getKotOrders, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  // KOT --Pending Order
  static Future<void> serveKotItems({
    required List<String> kotItemsIds,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.serveKotItems;
      var body = {"kot_item_ids": kotItemsIds};
      http.Response response = await SkyRequest.post(url, body: body);
      var data = json.decode(response.body);

      if (data['status']) {
        var message = data['message'];
        onSuccess(message);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.serveKotItems, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> cancelKotItems({
    required List<String> kotItemsIds,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.cancelKotItems;
      var body = {"kot_item_ids": kotItemsIds};
      http.Response response = await SkyRequest.post(url, body: body);
      var data = json.decode(response.body);

      if (data['status']) {
        var message = data['message'];
        onSuccess(message);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.cancelKotItems, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }
}
