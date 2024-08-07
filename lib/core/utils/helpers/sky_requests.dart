import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:saralnova/core/controllers/Splash/core_controller.dart';
import 'package:saralnova/core/utils/constants/messages.dart';
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

      // LogHelper.info("Post Request Header ==> $url",
      //     error: json.encode(headers));
      // LogHelper.info("Post Request Payload ==> $url", error: json.encode(body));
      // LogHelper.info("Post Request Response ==> $url", error: response.body);

      LogHelper.error(token.toString());

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

//before the new sprint

  // static Future<http.StreamedResponse> multiPart({
  //   String type = "POST",
  //   required String url,
  //   Map<String, String>? headers,
  //   dynamic fields,
  //   required List<http.MultipartFile> files,
  // }) async {
  //   try {
  //     var token = StorageHelper.getAccessToken();
  //     headers ??= <String, String>{};
  //     headers["Content-Type"] =
  //         "multipart/form-data"; // Change content type to multipart/form-data
  //     headers["Accept"] = "application/json";
  //     headers["Authorization"] = token.toString();

  //     http.MultipartRequest request =
  //         http.MultipartRequest(type, Uri.parse(url));

  //     request.headers.addAll(headers);

  //     if (fields != null) {
  //       // Check if fields are provided and encode them as JSON
  //       request.fields['data'] = json.encode(fields);
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

  //new request for image

  static Future<http.StreamedResponse> multiPart({
    String type = "POST",
    required String url,
    Map<String, String>? headers,
    Map<String, String>? fields,
    Map<String, List<dynamic>>? additionalListFields,
    required List<http.MultipartFile> files,
  }) async {
    try {
      var token = StorageHelper.getAccessToken();
      headers ??= <String, String>{};
      headers["Content-Type"] = "application/json";
      headers["Accept"] = "application/json";
      headers["Authorization"] = token.toString();

      http.MultipartRequest request =
          http.MultipartRequest(type, Uri.parse(url));

      request.headers.addAll(headers);
      if (fields != null) {
        request.fields.addAll(fields);
      }

      request.files.addAll(files);

      if (additionalListFields != null) {
        var keys = additionalListFields.keys;
        for (var key in keys) {
          additionalListFields[key]
              ?.map((value) => request.fields[key] = value.toString())
              .toList();
        }
      }

      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      log(json.encode(headers), name: "Get Request Header ==> $url");

      if (response.statusCode == 401) {
        Get.find<CoreController>().logOut();
        Get.closeAllSnackbars();
        SkySnackBar.info(
            title: "Session Expired", message: Messages.sessionExpiredMessage);
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
