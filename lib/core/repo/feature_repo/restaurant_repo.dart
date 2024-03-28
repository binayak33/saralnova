import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:saralnova/core/model/feature_model/restaurant_model/category_model.dart';
import 'package:saralnova/core/model/feature_model/restaurant_model/menu_request_model.dart';
import 'package:saralnova/core/model/feature_model/restaurant_model/variant_model.dart';
import 'package:saralnova/core/utils/constants/api.dart';
import 'package:saralnova/core/utils/constants/messages.dart';
import 'package:saralnova/core/utils/helpers/log_helper.dart';
import 'package:saralnova/core/utils/helpers/sky_requests.dart';

////import 'package:http_parser/http_parser.dart';
import '../../model/feature_model/restaurant_model/menu_model.dart';

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

  static Future<void> storeRestaurantVariants({
    required Variant? variantModel,
    required Function(Variant variant) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.storeVariants;

      var body = variantModel?.toJson();
      http.Response response = await SkyRequest.post(
        url,
        body: body,
      );

      var data = json.decode(response.body);

      if (data["status"]) {
        var variant = Variant.fromJson(data['data']);
        onSuccess(variant);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.storeVariants, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> deleteRestaurantVariants({
    // required String variantsId,
    required Variant? variantModel,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.deleteVariants;
      // var body = {
      //   "id": categoryId,
      // };
      var body = variantModel?.toJson();

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
      LogHelper.error(Api.deleteVariants, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> updateRestaurantVariant({
    required Variant? variantModel,
    required Function(Variant variant) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.updateVariants;

      var body = variantModel?.toJson();

      http.Response response = await SkyRequest.post(
        url,
        body: body,
      );

      var data = json.decode(response.body);

      if (data["status"]) {
        var variant = Variant.fromJson(data['data']);
        onSuccess(variant);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.updateVariants, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  // restaurant's menu api's
  static Future<void> getRestaurnatMenus({
    required Function(List<Menu> menus) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.getMenus;

      http.Response response = await SkyRequest.get(
        url,
      );

      var data = json.decode(response.body);
      if (data["status"]) {
        var menus = menusRestaurantJson(data['data']);
        onSuccess(menus);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.getMenus, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> deleteRestaurantMenu({
    required Menu? menuModel,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.deleteMenus;

      var body = menuModel?.toJson();

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
      LogHelper.error(Api.deleteMenus, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

// api to post only map without img
  // static Future<void> storeRestaurantMenu({
  //   required MenuRequestParams? menuRequestParams,
  //   File? file,
  //   required Function(Menu menu) onSuccess,
  //   required Function(String message) onError,
  // }) async {
  //   try {
  //     String url = Api.storeMenus;

  //     var body = menuRequestParams?.toJson();

  //     http.Response response = await SkyRequest.post(
  //       url,
  //       body: body,
  //     );

  //     var data = json.decode(response.body);

  //     if (data["status"]) {
  //       var menu = Menu.fromJson(data['data']);
  //       onSuccess(menu);
  //     } else {
  //       onError(data['message']);
  //     }
  //   } catch (e, s) {
  //     LogHelper.error(Api.storeMenus, error: e, stackTrace: s);
  //     onError(Messages.error);
  //   }
  // }

// -------------------------------
  static Future<void> storeRestaurantMenu({
    required MenuRequestParams? menuRequestParams,
    File? file,
    required Function(Menu menu) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.storeMenus;

      // List<http.MultipartFile> images = [];

      // if (file != null) {
      //   images = [
      //     http.MultipartFile.fromBytes(
      //       "image",
      //       await file.readAsBytes(),
      //       filename: "image",
      //       contentType: MediaType("image", "*"),
      //     )
      //   ];
      // }

      // http.StreamedResponse response = await SkyRequest.multiPart(
      //   url: url,
      //   file: http.MultipartFile.fromBytes(
      //     "image",
      //     await file!.readAsBytes(),
      //     filename: "image",
      //     contentType: MediaType("image", "*"),
      //   ), // Pass single file
      //   fields: menuRequestParams?.toJson(),
      // );

      // -------------------
      http.StreamedResponse response = await SkyRequest.multiPart(
        url: url,
        file: file!, // Pass single file
        fields: menuRequestParams?.toJson(),
      );
      dynamic data = json.decode(await response.stream.bytesToString());

      print("--------------response-------------$data");

      if (data["status"]) {
        var menu = Menu.fromJson(data['data']);

        print(
            "---------------------------------------menu-------------------${menu}");
        onSuccess(menu);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.storeMenus, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }
}
