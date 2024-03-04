import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';

class RoomsWidget extends StatelessWidget {
  final String? title;
  final String? price;
  final String? roomType;
  final String? status;

  const RoomsWidget({
    super.key,
    required this.title,
    required this.price,
    required this.roomType,
    this.status,
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
              style: CustomTextStyles.f18W600(
                color: AppColors.blackColor,
              ),
            ),
            Row(
              children: [
                Text(
                  "Rs. $price",
                  style: CustomTextStyles.f16W400(
                    color: AppColors.secondaryTextColor,
                  ),
                ),
                Text(
                  " | ",
                  style: CustomTextStyles.f20W600(
                    color: AppColors.secondaryTextColor,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.borderColor,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                  child: Text(
                    roomType ?? "",
                    style: CustomTextStyles.f16W400(
                      color: AppColors.secondaryTextColor,
                    ),
                  ),
                ),
                if (status != null)
                  Text(
                    " | ",
                    style: CustomTextStyles.f20W600(
                      color: AppColors.secondaryTextColor,
                    ),
                  ),
                if (status != null)
                  Text(
                    status!,
                    style: CustomTextStyles.f16W400(
                      color: AppColors.secondaryTextColor,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
