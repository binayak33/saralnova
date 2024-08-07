import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saralnova/core/model/user_model.dart';
import 'package:saralnova/core/utils/helpers/storage_helper.dart';
import 'package:saralnova/features/screens/Auth/login_screen.dart';

class CoreController extends GetxController {
  final navigatorKey = GlobalKey<NavigatorState>();
  Rxn<User> currentUser = Rxn();

  @override
  void onInit() {
    loadCurrentUser();
    super.onInit();
  }

  bool isUserLoggedIn() => currentUser.value != null;

  void loadCurrentUser() {
    currentUser.value = StorageHelper.getUser();
  }

  

  void logOut() async {
    // final ProgressDialog loading = ProgressDialog();
    // loading.show(message: "Logging out");
    StorageHelper.clear();
    loadCurrentUser();
    // loading.hide();
    Get.offAllNamed(LoginScreen.routeName);
  }

  Future<bool> checkCameraPermission() async {
    bool hasAccess = false;

    var status = await Permission.camera.status;

    hasAccess = status != PermissionStatus.denied &&
        status != PermissionStatus.permanentlyDenied;

    if (hasAccess) {
      return hasAccess;
    }

    var permission = await Permission.camera.request();

    hasAccess = permission != PermissionStatus.denied &&
        permission != PermissionStatus.permanentlyDenied;

    return hasAccess;
  }
}
