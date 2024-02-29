import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';

class FacilityWidget extends StatelessWidget {
  final String? title;
  // final String? subtitle;
  const FacilityWidget({
    super.key,
    this.title,
    // this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: Get.width,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? "",
              style: CustomTextStyles.f18W400(
                color: AppColors.blackColor,
              ),
            ),
            // Text(
            //  subtitle?? "",
            //   style: CustomTextStyles.f16W400(
            //     color: AppColors.secondaryTextColor,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
