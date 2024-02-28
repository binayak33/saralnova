import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/utils/constants/enums.dart';
import 'package:saralnova/core/utils/helpers/validators.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_elevated_button.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_text_field.dart';

class RoomsController extends GetxController {
  final roomScreenFormKey = GlobalKey<FormState>();
  RxList<String> roomTypes = RxList<String>.empty();
  final roomTypeScreenController = TextEditingController();
  var pageState = PageState.ADD.obs;
  RxnInt updateIndex = RxnInt();

  void onSave() async {
    if (roomScreenFormKey.currentState!.validate()) {
      Get.find<RoomsController>().roomTypes.add(roomTypeScreenController.text);
      roomTypeScreenController.clear();
      // Get.until(
      //   (route) => route.settings.name == DashPanel.routeName,
      // );
      // Navigator.of(context1).pop();
      pageState.value = PageState.ADD;

      Get.back();
    }
  }

  void onUpdate() async {
    if (roomScreenFormKey.currentState!.validate()) {
      final index = updateIndex.value;
      if (index != null &&
          index >= 0 &&
          index < Get.find<RoomsController>().roomTypes.length) {
        Get.find<RoomsController>().roomTypes[index] =
            roomTypeScreenController.text;
        roomTypeScreenController.clear();
        pageState.value = PageState.ADD;

        // Get.until(
        //   (route) => route.settings.name == DashPanel.routeName,
        // );
        Get.back();
      }
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
                    // fillColor: AppColors.fillColor,
                    autofocus: true,
                    hint: "Add Room Type",
                    controller: roomTypeScreenController,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.name,
                    validator: (value) => Validator.validateEmpty(value!),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  pageState.value == PageState.ADD
                      ? SkyElevatedButton(
                          onPressed: onSave,
                          title: "Add Room Type",
                        )
                      : SkyElevatedButton(
                          onPressed: onUpdate,
                          title: "Update Room Type",
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
