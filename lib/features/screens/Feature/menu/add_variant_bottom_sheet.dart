import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/menu/add_menu_controller.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/core/utils/helpers/validators.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_elevated_button.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_text_field.dart';

class AddVariantBottomSheet extends StatelessWidget {
  final c = Get.find<AddMenuController>();
  AddVariantBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16),
        height: Get.height * 0.7,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Form(
          key: c.addVariantKey,
          child: Column(
            children: [
              Text(
                "Add Variant",
                style: CustomTextStyles.f16W600(color: AppColors.blackColor),
              ),
              const Divider(
                color: AppColors.borderColor,
                endIndent: 10,
                indent: 10,
                height: 40,
              ),
              SkyTextField(
                hint: "Select variant category",
                controller: c.variantCategoryController,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.name,
                suffixIconPath: IconPath.down,
                validator: (value) => Validator.validateEmpty(value!),
                onTap: () {
                  c.showVariants();
                },
                readOnly: true,
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
                hint: "min quantity",
                readOnly: true,
                controller: c.minQtyVariantController,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.name,
                validator: (value) => Validator.validateEmpty(value!),
              ),
              const SizedBox(
                height: 10,
              ),
              SkyTextField(
                hint: "max quantity",
                readOnly: true,
                controller: c.maxQtyVariantController,
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.name,
                validator: (value) => Validator.validateEmpty(value!),
              ),
              const SizedBox(
                height: 10,
              ),
              SkyElevatedButton(
                  onPressed: () {
                    c.submitAddMenutVariant();
                  },
                  title: "Submit"),
            ],
          ),
        ),
      ),
    );
  }
}
