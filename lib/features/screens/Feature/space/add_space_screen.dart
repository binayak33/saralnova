import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Feature/space/space_controller.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/core/utils/helpers/validators.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_elevated_button.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_text_field.dart';

class AddSpaceScreen extends StatelessWidget {
  static const String routeName = "/add-space";
  final c = Get.find<SpaceController>();
  AddSpaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            c.crudState.value == CRUDSTATE.ADD ? "Add Space" : "Update Space"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(
            16,
          ),
          child: Form(
            key: c.spaceKey,
            child: Column(
              children: [
                SkyTextField(
                  hint: "Name",
                  controller: c.nameController,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.name,
                  validator: (value) => Validator.validateEmpty(value!),
                ),
                const SizedBox(
                  height: 10,
                ),
                SkyTextField(
                  hint: "Description",
                  controller: c.descpController,
                  textInputAction: TextInputAction.done,
                  maxLine: 8,
                  textInputType: TextInputType.name,
                  validator: (value) => Validator.validateEmpty(value!),
                ),
                const SizedBox(
                  height: 10,
                ),
                SkyElevatedButton(
                  onPressed: c.crudState.value == CRUDSTATE.ADD
                      ? c.storeRestaurantCategory
                      : c.updateSpace,
                  title:
                      c.crudState.value == CRUDSTATE.ADD ? "Submit" : "Update",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
