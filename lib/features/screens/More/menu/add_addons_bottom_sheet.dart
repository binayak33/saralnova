import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/More/restaurant/variants/variant_controller.dart';
import 'package:saralnova/core/controllers/menu/add_menu_controller.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';

class AddAddonsBottomSheet extends StatelessWidget {
  final c = Get.find<AddMenuController>();
  final variantController = Get.put(VariantController());
  AddAddonsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: Get.height * 0.7,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Form(
        key: c.addOnsKey,
        child: Column(
          children: [
            Text(
              "Add Addons",
              style: CustomTextStyles.f16W600(color: AppColors.blackColor),
            ),
            const Divider(
              color: AppColors.borderColor,
              endIndent: 10,
              indent: 10,
              height: 40,
            ),
            // SkyTextField(
            //   hint: "Select addon category",
            //   controller: c.categoryAddOnController,
            //   textInputAction: TextInputAction.next,
            //   textInputType: TextInputType.name,
            //   suffixIconPath: IconPath.down,
            //   validator: (value) => Validator.validateEmpty(value!),
            //   onTap: () {
            //     c.showAddons();
            //   },
            //   readOnly: true,
            // ),
            const SizedBox(
              height: 10,
            ),
            // SkyTextField(
            //   hint: "Price",
            //   controller: c.priceAddOnController,
            //   textInputAction: TextInputAction.done,
            //   textInputType: TextInputType.name,
            //   validator: (value) => Validator.validateEmpty(value!),
            // ),
            const SizedBox(
              height: 10,
            ),
            // SkyTextField(
            //   hint: "Max quantity",
            //   controller: c.minQtyAddonController,
            //   textInputAction: TextInputAction.done,
            //   textInputType: TextInputType.name,
            //   validator: (value) => Validator.validateEmpty(value!),
            // ),
            const SizedBox(
              height: 10,
            ),
            // SkyTextField(
            //   hint: "Max quantity",
            //   controller: c.maxQtyAddonController,
            //   textInputAction: TextInputAction.done,
            //   textInputType: TextInputType.name,
            //   validator: (value) => Validator.validateEmpty(value!),
            // ),
            const SizedBox(
              height: 10,
            ),
            // SkyElevatedButton(
            //     onPressed: () {
            //       c.submitAddMenutAddOns();
            //     },
            //     title: "Submit"),
          ],
        ),
      ),
    );
  }
}
