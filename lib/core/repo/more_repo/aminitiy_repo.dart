import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:saralnova/core/model/feature_model/amenity_model.dart';
import 'package:saralnova/core/utils/constants/api.dart';
import 'package:saralnova/core/utils/constants/messages.dart';
import 'package:saralnova/core/utils/helpers/log_helper.dart';
import 'package:saralnova/core/utils/helpers/sky_requests.dart';

class AminityRepo {
  // TODO make name correct
  static Future<void> getAminityTypes({
    required Function(List<Amenity> amenities) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.getAminityTypes;

      http.Response response = await SkyRequest.get(
        url,
      );

      var data = json.decode(response.body);

      if (data["status"]) {
        var amenities = amenitiesFromJson(data['data']);
        onSuccess(amenities);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.getAminityTypes, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  // static Future<void> storeAmintyType({
  //   required String title,
  //   // TODO : upload image
  //   File? image,
  //   required Function(Amenity amenity) onSuccess,
  //   required Function(String message) onError,
  // }) async {
  //   try {
  //     String url = Api.storeAminityType;
  //     var body = {
  //       "title": title,
  //       "icon": image,
  //     };

  //     http.Response response = await SkyRequest.post(
  //       url,
  //       body: body,
  //     );

  //     var data = json.decode(response.body);

  //     print(data);
  //     if (data["status"]) {
  //       var amenity = Amenity.fromJson(data['data']);
  //       onSuccess(amenity);
  //     } else {
  //       onError(data['message']);
  //     }
  //   } catch (e, s) {
  //     LogHelper.error(Api.storeAminityType, error: e, stackTrace: s);
  //     onError(Messages.error);
  //   }
  // }
  static Future<void> storeAmintyType({
    required String title,
    File? image,
    required Function(Amenity amenity) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.storeAminityType;

      var body = <String, String>{};
      if (title.isNotEmpty) {
        body["title"] = title;
      }

      List<http.MultipartFile> multipartFiles = [];
      if (image != null) {
        multipartFiles.add(
          http.MultipartFile.fromBytes(
            "icon",
            await image.readAsBytes(),
            filename: "${DateTime.now().microsecondsSinceEpoch}.jpg",
            contentType: MediaType("image", "*"),
          ),
        );
      }
      http.StreamedResponse response = await SkyRequest.multiPart(
        url: url,
        files: multipartFiles,
        type: "POST",
        fields: body,
      );

      print(multipartFiles[0]);
      var data = json.decode(await response.stream.bytesToString());
      LogHelper.info(json.encode(data));

      print(data);
      if (data["status"]) {
        var amenity = Amenity.fromJson(data['data']);
        onSuccess(amenity);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.storeAminityType, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> updateAminityType({
    required String amenityTitle,
    required String amenityId,
    // required String imageUrl TODO
    required Function(Amenity aminity) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.updateAminityType;
      var body = {
        "id": amenityId,
        "title": amenityTitle,
      };

      http.Response response = await SkyRequest.post(
        url,
        body: body,
      );

      var data = json.decode(response.body);

      if (data["status"]) {
        var aminity = Amenity.fromJson(data['data']);
        onSuccess(aminity);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.updateAminityType, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }

  static Future<void> deleteAminityType({
    required String amenityId,
    required Function(String message) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.deleteAminityType;
      var body = {
        "id": amenityId,
      };

      http.Response response = await SkyRequest.post(
        url,
        body: body,
      );

      var data = json.decode(response.body);

      print(data);

      if (data["status"]) {
        String msg = data['message'];
        onSuccess(msg);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.deleteAminityType, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }
}
