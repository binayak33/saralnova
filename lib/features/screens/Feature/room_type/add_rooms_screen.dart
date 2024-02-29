import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Feature/room/rooms_controller.dart';
import 'package:saralnova/core/utils/helpers/validators.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_elevated_button.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_text_field.dart';

import '../../../../core/utils/constants/enums.dart';

class AddRoomTypeScreen extends StatelessWidget {
  final c = Get.find<RoomController>();
  AddRoomTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Form(
        key: c.roomKey,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            SkyTextField(
              // fillColor: AppColors.fillColor,
              autofocus: true,
              hint: c.crudState.value == CRUDSTATE.ADD
                  ? "Add Room Type"
                  : "Update Room Type",
              controller: c.titleRoomController,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.name,
              validator: (value) => Validator.validateEmpty(value!),
            ),
            const SizedBox(
              height: 10,
            ),
            c.crudState.value == CRUDSTATE.ADD
                ? SkyElevatedButton(
                    onPressed: c.storeRoomType,
                    title: "Add Room Type",
                  )
                : SkyElevatedButton(
                    onPressed: c.updateRoomType,
                    title: "Update Room Type",
                  )
          ],
        ),
      ),
    );
  }
}
