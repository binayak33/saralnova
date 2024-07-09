import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/More/space/space_controller.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';

import '../../../../core/model/feature_model/tables/space_model.dart';

class SpaceBottomSheet extends StatelessWidget {
  final c = Get.put(
      SpaceController()); // TODO get . find garne  ekpatak pailai lazyput garera bolaisakepaxi

  final Function(Space space) onSelectRoomType;
  SpaceBottomSheet({
    super.key,
    // this.selectedRoomType,
    required this.onSelectRoomType,
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
            "Select Space",
            style: CustomTextStyles.f16W600(color: AppColors.blackColor),
          ),
          const Divider(
            color: AppColors.borderColor,
            endIndent: 10,
            indent: 10,
            height: 20,
          ),
          Obx(() {
            if (c.spaceList.isEmpty) {
              return const LinearProgressIndicator();
            } else {
              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: c.spaceList.length,
                  itemBuilder: (context, index) {
                    var space = c.spaceList[index];
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).pop();
                        onSelectRoomType(space);
                      },
                      title: Text(
                        space.name ?? "",
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
