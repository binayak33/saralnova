import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_elevated_button.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_text_field.dart';

class RoomsController extends GetxController {
  final roomScreenFormKey = GlobalKey<FormState>();
  RxList<String> roomTypes = RxList<String>.empty();
  final roomTypeScreenController = TextEditingController();

  void onSave() async {
    if (roomScreenFormKey.currentState!.validate()) {
      Get.find<RoomsController>().roomTypes.add(roomTypeScreenController.text);
      roomTypeScreenController.clear();
      // Get.until(
      //   (route) => route.settings.name == DashPanel.routeName,
      // );
      // Navigator.of(context1).pop();
      Get.back();
    }
  }

  openBottomSheet() async {
    showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            // margin: const EdgeInsets.only(bottom: 10),
            height: MediaQuery.of(context).size.height * 0.2,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Form(
              key: roomScreenFormKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SkyTextField(
                    autofocus: true,
                    hint: "Add Room Type",
                    controller: roomTypeScreenController,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.name,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SkyElevatedButton(
                    onPressed: onSave,
                    title: "Add Room Type",
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
