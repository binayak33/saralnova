import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/More/restaurant/category/category_controller.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/core/utils/helpers/validators.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_elevated_button.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_text_field.dart';

class AddCategoryScreen extends StatelessWidget {
  final c = Get.find<CategoryController>();
  AddCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Form(
        key: c.categoryKey,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            SkyTextField(
              autofocus: true,
              hint: c.crudState.value == CRUDSTATE.ADD
                  ? "Add Category"
                  : "Update Category",
              controller: c.categoryController,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.name,
              validator: (value) => Validator.validateEmpty(value!),
            ),
            const SizedBox(
              height: 10,
            ),
            c.crudState.value == CRUDSTATE.ADD
                ? SkyElevatedButton(
                    onPressed: c.storeRestaurantCategory,
                    title: "Add Category",
                  )
                : SkyElevatedButton(

                    onPressed: c.updateRestaurantCategory,
                    title: "Update Category",
                  )
          ],
        ),
      ),
    );
  }
}
