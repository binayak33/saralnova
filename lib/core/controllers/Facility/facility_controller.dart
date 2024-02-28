import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/model/facility_model.dart';
import 'package:saralnova/core/utils/constants/enums.dart';
import 'package:saralnova/core/utils/helpers/validators.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_elevated_button.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_text_field.dart';

class FacilityController extends GetxController {
  final facilityFormKey = GlobalKey<FormState>();
  final facilityTitleController = TextEditingController();
  final facilityPriceController = TextEditingController();
  var pageState = PageState.ADD.obs;
  RxnInt updateFacilityIndex = RxnInt();

  RxList<Facility> facilites = RxList<Facility>.empty();

  void onSave() {
    if (facilityFormKey.currentState!.validate()) {
      var newFacility = Facility(
        title: facilityTitleController.text,
        price: facilityPriceController.text,
      );
      facilites.add(newFacility);
      facilityTitleController.clear();
      facilityPriceController.clear();
      pageState.value = PageState.ADD;
      Get.back();
    }
  }

  void onUpdate() {
    if (facilityFormKey.currentState!.validate()) {
      int index = updateFacilityIndex.value!;
      facilites[index] = Facility(
        title: facilityTitleController.text,
        price: facilityPriceController.text,
      );
      facilityTitleController.clear();
      facilityPriceController.clear();
      pageState.value = PageState.ADD;
      Get.back();
    }
  }

  openFacilityBottomSheet() async {
    showModalBottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      context: Get.context!,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            // margin: const EdgeInsets.only(bottom: 10),
            height: MediaQuery.of(context).size.height * 0.4,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Form(
              key: facilityFormKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SkyTextField(
                    // fillColor: AppColors.fillColor,
                    autofocus: true,
                    hint: " Facility",
                    controller: facilityTitleController,
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.name,
                    validator: (value) => Validator.validateEmpty(value!),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SkyTextField(
                    autofocus: true,
                    hint: " Price",
                    controller: facilityPriceController,
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: (value) => Validator.validateEmpty(value!),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  pageState.value == PageState.ADD
                      ? SkyElevatedButton(
                          onPressed: onSave,
                          title: "Add Facility",
                        )
                      : SkyElevatedButton(
                          onPressed: onUpdate,
                          title: "Update  Facility",
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
