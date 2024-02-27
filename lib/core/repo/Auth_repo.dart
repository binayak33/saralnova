import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:saralnova/core/model/access_model.dart';
import 'package:saralnova/core/utils/constants/api.dart';
import 'package:saralnova/core/utils/constants/messages.dart';
import 'package:saralnova/core/utils/helpers/log_helper.dart';
import 'package:saralnova/core/utils/helpers/sky_requests.dart';
import 'package:saralnova/core/utils/helpers/storage_helper.dart';

import '../model/user_model.dart';

class AuthRepo {
  static Future<void> login({
    required String email,
    required String password,
    required Function(User user, AccessToken accessToken) onSuccess,
    required Function(String message) onError,
  }) async {
    try {
      String url = Api.loginApi;

      var body = {
        "email": email,
        "password": password,
      };

      http.Response response = await SkyRequest.post(
        url,
        body: body,
      );

      var data = json.decode(response.body);

      if (data["status"]) {
        var user = User.fromJson(data['data']['user']);
        var accessToken = AccessToken.fromJson(data['data']['token']);
        StorageHelper.saveAccessToken(accessToken);
        StorageHelper.saveUser(user);
        onSuccess(user, accessToken);
      } else {
        onError(data['message']);
      }
    } catch (e, s) {
      LogHelper.error(Api.loginApi, error: e, stackTrace: s);
      onError(Messages.error);
    }
  }
}
