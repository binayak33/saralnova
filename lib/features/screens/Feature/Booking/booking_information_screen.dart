import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Feature/booking/booking_controller.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/core/utils/helpers/validators.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_text_field.dart';

class InformationScreen extends StatelessWidget {
  final c = Get.put(BookingController());
  InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SkyTextField(
            hint: "Name",
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.name,
            validator: (value) => Validator.validateName(value!),
          ),
          const SizedBox(
            height: 10,
          ),
          SkyTextField(
            hint: "Contact",
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.number,
            validator: (value) => Validator.validateMobile(value!),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SkyTextField(
            hint: "Email",
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.emailAddress,
            validator: (value) => Validator.validateEmail(value!),
          ),
          const SizedBox(
            height: 10,
          ),
          SkyTextField(
            hint: "Address",
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.emailAddress,
            validator: (value) => Validator.validateEmpty(value!),
          ),
          const SizedBox(
            height: 10,
          ),
          SkyTextField(
            hint: "Country",
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.name,
            readOnly: true,
            controller: c.countryController,
            suffixIconPath: IconPath.down,
            onTap: () {
              c.openCountryBottomSheet();
            },
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
