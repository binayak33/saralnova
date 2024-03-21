import 'package:flutter/material.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/core/utils/constants/enums.dart';

class VariantTypeBottomSheet extends StatelessWidget {
  final Function(String variantType) onSelectRoomStatus;
  const VariantTypeBottomSheet({
    super.key,
    required this.onSelectRoomStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        children: [
          Text(
            "Select Type",
            style: CustomTextStyles.f16W600(color: AppColors.blackColor),
          ),
          const Divider(
            color: AppColors.borderColor,
            endIndent: 10,
            indent: 10,
            height: 20,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: VariantState.values.length,
            itemBuilder: (context, index) {
              final type = VariantState.values[index];
              return ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  onSelectRoomStatus(type.toString().split('.').last);
                },
                title: Text(
                  type.toString().split('.').last,
                  style: CustomTextStyles.f16W400(),
                ),
                dense: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                tileColor: AppColors.errorColor,
                selected: true,
                style: ListTileStyle.drawer,
              );
            },
          ),
        ],
      ),
    );
  }
}
