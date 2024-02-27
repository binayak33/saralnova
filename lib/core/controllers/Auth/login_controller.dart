import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/repo/Auth_repo.dart';
import 'package:saralnova/features/screens/Dashboard/dashboard_panel.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_toast.dart';

import '../../../features/widgets/common_widgets/loading_dialog.dart';
import '../../../features/widgets/common_widgets/sky_snack_bar.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final CustomLoadingDialog loading = CustomLoadingDialog();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  RxBool showPassword = RxBool(false);

  void forgetPassword() {
    // Get.toNamed(BrowserView.routeName);
  }

  void onSubmit(BuildContext context) async {
    if (formKey.currentState!.validate()) {
   showLoadingDialog(context);
      var email = emailController.text;
      var password = passwordController.text;

      await AuthRepo.login(
        email: email,
        password: password,
        onSuccess: (user, accessToken) {
          // loading.hide();
          hideLoadingDialog(context);

          Get.offAllNamed(DashPanel.routeName);
          // SkySnackBar.success(title: "Login", message: "Logged in Succesfully");
          SkyToast.showSuccessToast("Login Successfully");
        },
        onError: (message) {
          hideLoadingDialog(context);
          // SkySnackBar.error(title: "Login", message: message);
          SkyToast.showErrorToast(message);
        },
      );
    }
  }
}
