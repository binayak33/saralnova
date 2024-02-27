import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:saralnova/core/model/access_model.dart';
import 'package:saralnova/core/model/user_model.dart';
import 'package:saralnova/core/utils/constants/storage_keys.dart';

class StorageHelper {
  static saveAccessToken(AccessToken token) {
    try {
      final box = GetStorage();
      box.write(StorageKeys.ACCESSTOKEN, json.encode(token.toJson()));
    } catch (_) {
      throw "Unable to save token";
    }
  }

  static AccessToken? getAccessToken() {
    try {
      final box = GetStorage();
      AccessToken token = AccessToken.fromJson(
          json.decode(box.read(StorageKeys.ACCESSTOKEN)) ?? "");
      return token;
    } catch (_) {
      return null;
    }
  }

  static saveUser(User user) {
    try {
      final box = GetStorage();
      box.write(StorageKeys.USER, json.encode(user.toJson()));
    } catch (_) {
      throw "Unable to save user";
    }
  }

  static User? getUser() {
    try {
      final box = GetStorage();
      User user = User.fromJson(json.decode(box.read(StorageKeys.USER)) ?? "");

      return user;
    } catch (_) {
      return null;
    }
  }

  static void clear() {
    final box = GetStorage();
    box.erase();
  }
}
