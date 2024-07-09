import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/features/widgets/common_widgets/custom_alert_dialog.dart';

class SpaceTile extends StatelessWidget {
  final int index;
  final String? title;
  final int? noOfTables;
  final String? desp;
  final Function() onConfirmDelete;
  final Function() onEdit;
  const SpaceTile({
    super.key,
    required this.index,
    this.title,
    this.noOfTables,
    this.desp,
    required this.onConfirmDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.borderColor),
          color: AppColors.scaffoldColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "S.N: $index ",
            style: CustomTextStyles.f12W400(color: AppColors.blackColor),
          ),
          const SizedBox(
            height: 8,
          ),
          RichText(
            text: TextSpan(
              text: "Title:   ",
              style: CustomTextStyles.f14W400(color: AppColors.borderColor),
              children: [
                TextSpan(text: title ?? "", style: CustomTextStyles.f16W500())
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          RichText(
            text: TextSpan(
              text: "Table Count:   ",
              style: CustomTextStyles.f14W400(color: AppColors.borderColor),
              children: [
                TextSpan(
                    text: noOfTables.toString(),
                    style: CustomTextStyles.f16W500())
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          if (desp != null)
            RichText(
              text: TextSpan(
                text: "Descp. :   ",
                style: CustomTextStyles.f14W400(color: AppColors.borderColor),
                children: [
                  TextSpan(text: desp ?? "", style: CustomTextStyles.f16W500())
                ],
              ),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: AppColors.orangeColor,
                child: IconButton(
                  onPressed: onEdit,
                  icon: SvgPicture.asset(
                    IconPath.edit,
                    height: 18,
                    width: 18,
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              CircleAvatar(
                  radius: 15,
                  backgroundColor: AppColors.errorColor,
                  child: IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext ctx) {
                            return CustomAlertDialog(
                                title: "Do you really want to delete ?",
                                message: "You cannot undo this action",
                                onConfirm: onConfirmDelete,
                                confirmText: "Yes");
                          });
                    },
                    icon: SvgPicture.asset(
                      IconPath.delete,
                      colorFilter:
                          const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
