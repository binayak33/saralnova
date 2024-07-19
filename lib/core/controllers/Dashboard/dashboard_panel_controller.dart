import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Splash/core_controller.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/features/screens/Calendar/calander_screen.dart';
import 'package:saralnova/features/screens/Dashboard/main_pos_panel.dart';
import 'package:saralnova/features/screens/Home/home_screen.dart';
import 'package:saralnova/features/screens/More/more_screen.dart';
import 'package:saralnova/features/widgets/common_widgets/custom_alert_dialog.dart';

class DashPanelController extends GetxController {
  final coreController = Get.find<CoreController>();
  RxInt currnetIndex = RxInt(0);
  PageController pageController = PageController();
  

  var pages = <Widget>[
    HomeScreen(),
    CalendarScreen(),
    MoreScreen(),
  ];

  void onUpdatePage(int value) {
    currnetIndex.value = value;
    pageController.animateToPage(currnetIndex.value,
        duration: const Duration(milliseconds: 100), curve: Curves.linear);

    if ((coreController.currentUser.value?.role == "admin" ||
            coreController.currentUser.value?.role == "staffs") &&
        coreController.currentUser.value?.hasRestaurant == true) {
      if (value == 2) {
        Get.toNamed(MainPosPanel.routeName);

        return;
      }
    }
  }

  void logout() {
    showDialog(
      context: Get.context!,
      builder: (context) => CustomAlertDialog(
          title: "Logout Confirmation",
          confirmColor: AppColors.errorColor,
          message: "Are you sure you want to logout?",
          onConfirm: () {
            coreController.logOut();
          },
          confirmText: "Logout"),
    );
  }
}
