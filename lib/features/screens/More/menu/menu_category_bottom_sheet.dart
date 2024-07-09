import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/More/restaurant/category/category_controller.dart';
import 'package:saralnova/core/model/feature_model/restaurant_model/category_model.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';

class MenuCategoryBottomSheet extends StatelessWidget {
  final c = Get.put(
      CategoryController()); // TODO get . find garne  ekpatak pailai lazyput garera bolaisakepaxi

  final Function(Category categoryType) onSelectCategoryType;
  MenuCategoryBottomSheet({
    super.key,
    // this.selectedRoomType,
    required this.onSelectCategoryType,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        children: [
          Text(
            "Select Menu Category",
            style: CustomTextStyles.f16W600(color: AppColors.blackColor),
          ),
          const Divider(
            color: AppColors.borderColor,
            endIndent: 10,
            indent: 10,
            height: 20,
          ),
          Obx(() {
            if (c.restaurantCategorylist.isEmpty) {
              return const LinearProgressIndicator();
            } else {
              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: c.restaurantCategorylist.length,
                  itemBuilder: (context, index) {
                    var category = c.restaurantCategorylist[index];
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).pop();
                        onSelectCategoryType(category);
                      },
                      title: Text(
                        category.title ?? "",
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
