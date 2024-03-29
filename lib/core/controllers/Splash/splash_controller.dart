import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Splash/core_controller.dart';
import 'package:saralnova/features/screens/Auth/login_screen.dart';
import 'package:saralnova/features/screens/Dashboard/dashboard_panel.dart';

class SplashController extends GetxController {
  final coreController = Get.find<CoreController>();
  @override
  void onInit() {
    Future.delayed(
      const Duration(
        seconds: 3,
      ),
      () {
        if (coreController.isUserLoggedIn()) {
          Get.offAllNamed(DashPanel.routeName);
        } else {
          Get.offAllNamed(LoginScreen.routeName);
        }
      },
    );
    super.onInit();
  }
}
