import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:saralnova/core/controllers/Feature/room_type/room_type_controller.dart';
import 'package:saralnova/core/model/feature_model/focusmodel.dart';
import 'package:saralnova/core/utils/helpers/validators.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_elevated_button.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_text_field.dart';

import '../../../../core/utils/constants/enums.dart';

class AddRoomTypeScreen extends StatelessWidget {
  final c = Get.find<RoomTypeController>();
  AddRoomTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => FocusModel()),
          // Add other providers if needed
        ],
        child: Container(
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
                ContainerTextField(
                  // fillColor: AppColors.fillColor,

                  hint: c.crudState.value == CRUDSTATE.ADD
                      ? "Add Room Type"
                      : "Update Room Type",
                  controller: c.titleRoomController,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.name,
                  validator: (value) => Validator.validateEmpty(value!),
                  icon: '', text: 'hello',
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
                      ),
                      
              ],
            ),
          ),
        ));
  }
}
