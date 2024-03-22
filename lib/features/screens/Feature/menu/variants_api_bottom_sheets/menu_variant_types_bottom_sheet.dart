import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Feature/restaurant/variants/variant_controller.dart';
import 'package:saralnova/core/model/feature_model/restaurant_model/variant_model.dart';

import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/custom_text_style.dart';

class SelectVariantTypeButtomSheet extends StatelessWidget {
  final c = Get.put(
      VariantController()); // TODO get . find garne  ekpatak pailai lazyput garera bolaisakepaxi

  final Function(Variant variant) onSelectVariantType;
  SelectVariantTypeButtomSheet({
    super.key,
    required this.onSelectVariantType,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        children: [
          Text(
            "Select Variant Type",
            style: CustomTextStyles.f16W600(color: AppColors.blackColor),
          ),
          const Divider(
            color: AppColors.borderColor,
            endIndent: 10,
            indent: 10,
            height: 20,
          ),
          Obx(() {
            if (c.filteredVariantList.isEmpty) {
              return const LinearProgressIndicator();
            } else {
              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: c.filteredVariantList.length,
                  itemBuilder: (context, index) {
                    var variant = c.filteredVariantList[index];
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).pop();
                        onSelectVariantType(variant);
                      },
                      title: Text(
                        variant.title ?? "",
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
              );
            }
          })
        ],
      ),
    );
  }
}
