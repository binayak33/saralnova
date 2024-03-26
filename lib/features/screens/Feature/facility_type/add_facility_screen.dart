import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Feature/facility/facility_controller.dart';
import 'package:saralnova/core/utils/helpers/validators.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_elevated_button.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_text_field.dart';

import '../../../../core/utils/enums/enums.dart';

class AddFacilityTypeScreen extends StatelessWidget {
  final c = Get.find<FacilityController>();
  AddFacilityTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Form(
        key: c.facilityKey,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            SkyTextField(
              // fillColor: AppColors.fillColor,
              autofocus: true,
              hint: c.crudState.value == CRUDSTATE.ADD
                  ? "Add Facility Type"
                  : "Update Facility Type",
              controller: c.facilityTitleController,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.name,
              validator: (value) => Validator.validateEmpty(value!),
            ),
            const SizedBox(
              height: 10,
            ),
            SkyTextField(
              // fillColor: AppColors.fillColor,
              autofocus: true,
              hint: c.crudState.value == CRUDSTATE.ADD
                  ? "Add Facility Price"
                  : "Update Facility Price",
              controller: c.facilityPriceController,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              validator: (value) => Validator.validateEmpty(value!),
            ),
            const SizedBox(
              height: 10,
            ),
            c.crudState.value == CRUDSTATE.ADD
                ? SkyElevatedButton(
                    onPressed: c.storeAmenityType,
                    title: "Add Facility Type",
                  )
                : SkyElevatedButton(
                    onPressed: c.updateAmenityType,
                    title: "Update Facility Type",
                  )
          ],
        ),
      ),
    );
  }
}
