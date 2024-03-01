import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Feature/room/room_type_controller.dart';
import 'package:saralnova/core/model/feature_model/room_type_model.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';

class RoomTypeBottomSheet extends StatelessWidget {
  final c = Get.put(
      RoomTypeController()); // TODO get . find garne  ekpatak pailai lazyput garera bolaisakepaxi

  final Function(RoomType roomType) onSelectRoomType;
  RoomTypeBottomSheet({
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
            "Select Room Type",
            style: CustomTextStyles.f16W600(color: AppColors.blackColor),
          ),
       const   Divider(
            color: AppColors.borderColor,
            endIndent: 10,
            indent: 10,
            height: 20,
          ),
          Obx(() {
            if (c.roomTypes.isEmpty) {
              return const LinearProgressIndicator();
            } else {
              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: c.roomTypes.length,
                  itemBuilder: (context, index) {
                    var room = c.roomTypes[index];
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).pop();
                        onSelectRoomType(room);
                      },
                      title: Text(
                        room.title ?? "",
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
