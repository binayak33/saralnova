import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:saralnova/core/model/hotel_dashboard_model.dart';
import 'package:saralnova/core/model/restaurant_dashboard_model.dart';
import 'package:saralnova/core/utils/constants/api.dart';
import 'package:saralnova/core/utils/constants/messages.dart';
import 'package:saralnova/core/utils/helpers/log_helper.dart';
import 'package:saralnova/core/utils/helpers/sky_requests.dart';

class DashBoardRepo {
  static Future<void> getHotelDashboard({
    required Function(HotelDashboard hotelDashboard) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.hotelDashboard;

      http.Response response = await SkyRequest.get(
        url,
      );

      var data = json.decode(response.body);

      if (data["status"]) {
        var hotel = HotelDashboard.fromJson(data['data']);
        onSuccess(hotel);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.hotelDashboard, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> getRestaurantDashboard({
    required Function(RestaurantDashboard restaurantDashboard) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.restaurantDashboard;

      http.Response response = await SkyRequest.get(
        url,
      );

      var data = json.decode(response.body);

      if (data["status"]) {
        var restaurant = RestaurantDashboard.fromJson(data['data']);
        onSuccess(restaurant);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.restaurantDashboard, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }
}
