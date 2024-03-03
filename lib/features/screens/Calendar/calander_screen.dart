import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Calendar/calendar_controller.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/features/widgets/app_widgets/hotel_feature_widget.dart';

class CalendarScreen extends StatelessWidget {
  static const String routeName = "/calender-screen";
  final c = Get.find<CalendarController>();
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
        title: Text(
          "Calendar",
          style: CustomTextStyles.f16W600(color: AppColors.scaffoldColor),
        ),
      ),
      
    );
  }
}
