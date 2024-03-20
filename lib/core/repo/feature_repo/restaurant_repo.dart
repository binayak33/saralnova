import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:saralnova/core/model/feature_model/restaurant_model/category_model.dart';
import 'package:saralnova/core/model/feature_model/restaurant_model/variant_model.dart';
import 'package:saralnova/core/utils/constants/api.dart';
import 'package:saralnova/core/utils/constants/messages.dart';
import 'package:saralnova/core/utils/helpers/log_helper.dart';
import 'package:saralnova/core/utils/helpers/sky_requests.dart';

class RestaurantRepo {
  static Future<void> getRestaurantCategories({
    required Function(List<Category> categories) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.getCategory;

      http.Response response = await SkyRequest.get(
        url,
      );

      var data = json.decode(response.body);
//TODO api null check on a boolean fix this
      if (data["status"]) {
        var categories = restaurantCategoriesJson(data['data']);
        onSuccess(categories);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.getCategory, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> storeRestaurantCategory({
    required String title,
    required Function(Category category) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.storeCategory;
      var body = {
        "title": title,
      };

      http.Response response = await SkyRequest.post(
        url,
        body: body,
      );

      var data = json.decode(response.body);

      print(data);
      if (data["status"]) {
        var category = Category.fromJson(data['data']);
        onSuccess(category);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.storeCategory, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> updateRestaurantCategory({
    required String categoryTitle,
    required String categoryId,
    required Function(Category category) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.updateCategory;
      var body = {
        "id": categoryId,
        "title": categoryTitle,
      };

      http.Response response = await SkyRequest.post(
        url,
        body: body,
      );

      var data = json.decode(response.body);

      if (data["status"]) {
        var room = Category.fromJson(data['data']);
        onSuccess(room);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.updateCategory, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> deleteRestaurantCategory({
    required String categoryId,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.deleteCategory;
      var body = {
        "id": categoryId,
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
      LogHelper.error(Api.deleteCategory, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  //variants

  static Future<void> getRestaurantVariants({
    required Function(List<Variant> variants) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.getVariants;

      http.Response response = await SkyRequest.get(
        url,
      );

      var data = json.decode(response.body);
      if (data["status"]) {
        var variants = restaurantVariantsJson(data['data']);
        onSuccess(variants);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.getVariants, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }
}
