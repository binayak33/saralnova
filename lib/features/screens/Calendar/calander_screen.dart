import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Calendar/calendar_controller.dart';
import 'package:saralnova/core/controllers/Splash/core_controller.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';

class CalendarScreen extends StatelessWidget {
  static const String routeName = "/calender-screen";
  final c = Get.find<CalendarController>();
  final cc = Get.find<CoreController>();
  CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(
          color: AppColors.scaffoldColor,
        ),
        centerTitle: true,
        title: InkResponse(
          onTap: () {
            print(cc.currentUser.value?.hasRestaurant);
          },
          child: Text(
            "Calendar",
            style: CustomTextStyles.f16W600(color: AppColors.scaffoldColor),
          ),
        ),
      ),
    );
  }
}
