import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/More/staff/staff_controller.dart';
import 'package:saralnova/core/utils/helpers/validators.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_elevated_button.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_text_field.dart';

import '../../../../core/utils/enums/enums.dart';

class AddStaffScreen extends StatelessWidget {
  final c = Get.find<StaffController>();

  AddStaffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Form(
        key: c.staffKey,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            SkyTextField(
              // fillColor: AppColors.fillColor,
              autofocus: true,
              hint: c.crudState.value == CRUDSTATE.ADD
                  ? "Enter Full Name"
                  : "Update Full Name",
              controller: c.nameController,
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
                  ? "Enter email"
                  : "Update emial",
              controller: c.emailController,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.emailAddress,
              validator: (value) => Validator.validateEmail(value!),
            ),
            const SizedBox(
              height: 10,
            ),
            SkyTextField(
              // fillColor: AppColors.fillColor,
              autofocus: true,
              hint: c.crudState.value == CRUDSTATE.ADD
                  ? "Enter username"
                  : "Update username",
              controller: c.userNameController,
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
                  ? "Enter password"
                  : "Update password",
              controller: c.passwordController,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.name,
              validator: (value) => Validator.validateEmpty(value!),
            ),
            const SizedBox(
              height: 10,
            ),
            c.crudState.value == CRUDSTATE.ADD
                ? SkyElevatedButton(
                    onPressed: c.storeStaff,
                    // onPressed: () {},
                    title: "Add Staff",
                  )
                : SkyElevatedButton(
                    // onPressed: c.updateRoomType,

                    onPressed: c.updateStaff,
                    title: "Update Staff ",
                  )
          ],
        ),
      ),
    );
  }
}
