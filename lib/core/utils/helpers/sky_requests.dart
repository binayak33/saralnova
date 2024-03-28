import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:saralnova/core/controllers/Splash/core_controller.dart';
import 'package:saralnova/core/utils/helpers/log_helper.dart';
import 'package:saralnova/core/utils/helpers/storage_helper.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_snack_bar.dart';

class SkyRequest {
  static Future<http.Response> post(String url,
      {Map<String, String>? headers, Object? body}) async {
    try {
      var token = StorageHelper.getAccessToken();

      headers ??= <String, String>{};
      headers["Content-Type"] = "application/json";
      headers["Accept"] = "application/json";
      headers["Authorization"] = token.toString();

      http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body != null ? json.encode(body) : null,
      );

      LogHelper.info("Post Request Header ==> $url",
          error: json.encode(headers));
      LogHelper.info("Post Request Payload ==> $url", error: json.encode(body));
      LogHelper.info("Post Request Response ==> $url", error: response.body);

      if (response.statusCode == 401) {
        Get.find<CoreController>().logOut();
        Get.closeAllSnackbars();
        SkySnackBar.info(
            title: "Session Expired",
            message: "Your session has expired!!. Please Log in to continue");
      }

      return response;
    } catch (e, s) {
      LogHelper.error("$url POST", error: e, stackTrace: s);
      throw "Server Error";
    }
  }

  static Future<http.Response> get(String url,
      {Map<String, String>? headers}) async {
    try {
      var token = StorageHelper.getAccessToken();
      LogHelper.warning(token.toString());
      headers ??= <String, String>{};
      headers["Content-Type"] = "application/json";
      headers["Accept"] = "application/json";
      headers["Authorization"] = token.toString();

      http.Response response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      LogHelper.info("Post Request Header ==> $url",
          error: json.encode(headers));
      LogHelper.info("Post Request Response ==> $url", error: response.body);

      if (response.statusCode == 401) {
        Get.find<CoreController>().logOut();
        Get.closeAllSnackbars();
        SkySnackBar.info(
            title: "Session Expired",
            message: "Your session has expired!!. Please Log in to continue");
      }
      return response;
    } catch (e) {
      log(e.toString());
      throw "Server Error";
    }
  }

  // static Future<http.StreamedResponse> multiPart({
  //   String type = "POST",
  //   required String url,
  //   Map<String, String>? headers,
  //   Map<String, String>? fields,
  //   required List<http.MultipartFile> files,
  // }) async {
  //   try {
  //     var token = StorageHelper.getAccessToken();
  //     headers ??= <String, String>{};
  //     headers["Content-Type"] = "application/json";
  //     headers["Accept"] = "application/json";
  //     headers["Authorization"] = token.toString();

  //     http.MultipartRequest request =
  //         http.MultipartRequest(type, Uri.parse(url));

  //     request.headers.addAll(headers);
  //     if (fields != null) {
  //       request.fields.addAll(fields);
  //     }

  //     request.files.addAll(files);

  //     request.headers.addAll(headers);
  //     http.StreamedResponse response = await request.send();

  //     log(json.encode(headers), name: "Get Request Header ==> $url");

  //     if (response.statusCode == 401) {
  //       Get.find<CoreController>().logOut();
  //       Get.closeAllSnackbars();
  //       SkySnackBar.info(
  //           title: "Session Expired",
  //           message: "Your session has expired!!. Please Log in to continue");
  //     }
  //     return response;
  //   } catch (e, s) {
  //     log(
  //       "Server Error",
  //       error: e,
  //       stackTrace: s,
  //     );
  //     throw "Server Error";
  //   }
  // }

  // ------------------------------- mine worked multipart

  // static Future<http.StreamedResponse> multiPart({
  //   String type = "POST",
  //   required String url,
  //   Map<String, String>? headers,
  //   Map<String, String>? fields,
  //   required List<http.MultipartFile> files,
  // }) async {
  //   try {
  //     var token = StorageHelper.getAccessToken();
  //     headers ??= <String, String>{};
  //     headers["Content-Type"] = "application/json";
  //     headers["Accept"] = "application/json";
  //     headers["Authorization"] = token.toString();

  //     http.MultipartRequest request =
  //         http.MultipartRequest(type, Uri.parse(url));

  //     request.headers.addAll(headers);
  //     if (fields != null) {
  //       request.fields.addAll(fields);

  //     }

  //     request.files.addAll(files);

  //     request.headers.addAll(headers);
  //     http.StreamedResponse response = await request.send();

  //     log(json.encode(headers), name: "Get Request Header ==> $url");

  //     if (response.statusCode == 401) {
  //       Get.find<CoreController>().logOut();
  //       Get.closeAllSnackbars();
  //       SkySnackBar.info(
  //           title: "Session Expired",
  //           message: "Your session has expired!!. Please Log in to continue");
  //     }
  //     return response;
  //   } catch (e, s) {
  //     log(
  //       "Server Error",
  //       error: e,
  //       stackTrace: s,
  //     );
  //     throw "Server Error";
  //   }
  // }

  // ------------------------------- New  multipart to handle lists

  static Future<http.StreamedResponse> multiPart({
    String type = "POST",
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? fields, // Changed to Map<String, dynamic>
    // required List<http.MultipartFile> files,
    // required http.MultipartFile file,
    required File file,
  }) async {
    try {
      var token = StorageHelper.getAccessToken();
      headers ??= <String, String>{};
      headers["Content-Type"] = "application/json";
      headers["Accept"] = "application/json";
      headers["Authorization"] = token.toString();

      http.MultipartRequest request =
          http.MultipartRequest(type, Uri.parse(url));

      request.files.add(await http.MultipartFile.fromPath('image', file.path));

      request.headers.addAll(headers);
      if (fields != null) {
        fields.forEach((key, value) {
          if (value is List) {
            // Convert list to JSON string
            request.fields[key] = value.toString();
          } else {
            // For other types, convert to string
            request.fields[key] = value.toString();
          }
        });
      }

      // request.files.addAll(fields);

      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      log(json.encode(headers), name: "Get Request Header ==> $url");

      if (response.statusCode == 401) {
        Get.find<CoreController>().logOut();
        Get.closeAllSnackbars();
        SkySnackBar.info(
            title: "Session Expired",
            message: "Your session has expired!!. Please Log in to continue");
      }
      return response;
    } catch (e, s) {
      log(
        "Server Error",
        error: e,
        stackTrace: s,
      );
      throw "Server Error";
    }
  }
}
