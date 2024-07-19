import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Splash/core_controller.dart';
import 'package:saralnova/core/repo/Auth_repo.dart';
import 'package:saralnova/features/screens/Dashboard/dashboard_panel.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_snack_bar.dart';

import '../../../features/widgets/common_widgets/loading_dialog.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final LogoLoading loading = LogoLoading();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final CoreController coreController = Get.find();

  RxBool showPassword = RxBool(false);

  void forgetPassword() {
    // Get.toNamed(BrowserView.routeName);
  }

  void onSubmit() async {
    if (formKey.currentState!.validate()) {
      loading.show();
      var email = emailController.text;
      var password = passwordController.text;

      await AuthRepo.login(
        email: email,
        password: password,
        onSuccess: (user, accessToken) {
          loading.hide();
          coreController.loadCurrentUser();
          Get.offAllNamed(DashPanel.routeName);
          SkySnackBar.success(title: "Login", message: "Logged in Succesfully");
        },
        onError: (message) {
          loading.hide();

          SkySnackBar.error(title: "Login", message: message);
        },
      );
    }
  }
}
