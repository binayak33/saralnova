import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/More/restaurant/variants/variant_controller.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/core/utils/helpers/validators.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_elevated_button.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_text_field.dart';



//TODO - REMAINDER :  This feature is currently disabled
class AddVariantScreen extends StatelessWidget {
  static const String routeName = "/add-variant";
  final c = Get.find<VariantController>();
  AddVariantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(c.crudState.value == CRUDSTATE.ADD
            ? "Add Variants"
            : "Update Variants"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(
            16,
          ),
          child: Form(
            key: c.variantKey,
            child: Column(
              children: [
                SkyTextField(
                  hint: "Title",
                  controller: c.titleVariantController,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.name,
                  validator: (value) => Validator.validateEmpty(value!),
                ),

                const SizedBox(
                  height: 10,
                ),
                SkyTextField(
                  hint: "Price",
                  controller: c.priceVariantController,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.name,
                  validator: (value) => Validator.validateEmpty(value!),
                ),
                const SizedBox(
                  height: 10,
                ),
                SkyTextField(
                  hint: "Description",
                  controller: c.descpVariantController,
                  textInputAction: TextInputAction.done,
                  maxLine: 8,
                  textInputType: TextInputType.name,
                  validator: (value) => Validator.validateEmpty(value!),
                ),
                const SizedBox(
                  height: 10,
                ),
                SkyTextField(
                  hint: "Select type",
                  controller: c.typeController,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                  suffixIconPath: IconPath.down,
                  onTap: () {
                    c.showVariantType();
                  },
                  readOnly: true,
                ),
                // const Spacer(),
                const SizedBox(
                  height: 50,
                ),
                SkyElevatedButton(
                  onPressed: c.crudState.value == CRUDSTATE.ADD
                      ? c.storeRestaurantVariant
                      : c.updateRestaurantVariant,
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
