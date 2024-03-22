import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_elevated_button.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_text_field.dart';

import '../../../../core/controllers/menu/add_menu_controller.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../../../core/utils/helpers/image_helper.dart';
import '../../../../core/utils/helpers/sky_network_image.dart';
import '../../../../core/utils/helpers/validators.dart';

class AddMenuScreen extends StatelessWidget {
  static const String routeName = "/add-menu-screen";
  final c = Get.find<AddMenuController>();
  AddMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add Menu"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: c.menuKey,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Obx(() {
                        final file = c.pickedFile.value;
                        if (file != null) {
                          return Image.file(
                            file,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          );
                        } else {
                          return const SkyNetworkImage(
                            imageUrl: "",
                            height: 100,
                            width: 100,
                          );
                        }
                      }),
                    ),
                    // --------------------
                    // ClipRRect(
                    //   borderRadius: BorderRadius.circular(100),
                    //   child: SkyNetworkImage(
                    //     imageUrl: "",
                    //     // imageUrl: "",
                    //     height: 70,
                    //     width: 70,
                    //   ),
                    // ),
                    Positioned(
                      bottom: 5,
                      right: 10,
                      child: InkResponse(
                        onTap: () {
                          ImageHelper.pickImage(
                              imageSource: ImageSource.gallery,
                              onPickImage: (imageFile) {
                                c.pickImage(imageFile);
                              });
                        },
                        child: SvgPicture.asset(
                          IconPath.camera,
                          height: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SkyTextField(
                  hint: "Price",
                  controller: c.titleController,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.name,
                  validator: (value) => Validator.validateEmpty(value!),
                ),
                const SizedBox(
                  height: 10,
                ),
                SkyTextField(
                  hint: "Price",
                  controller: c.priceController,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.name,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  validator: (value) => Validator.validateEmpty(value!),
                ),
                const SizedBox(
                  height: 10,
                ),
                SkyTextField(
                  hint: "Select Category",
                  controller: c.categoryController,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.name,
                  validator: (value) => Validator.validateEmpty(value!),
                ),
                const SizedBox(
                  height: 10,
                ),
                SkyTextField(
                  hint: "Description",
                  controller: c.descriptionController,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.name,
                  maxLine: 10,
                  validator: (value) => Validator.validateEmpty(value!),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (c.addedMenuVariants.isNotEmpty)
                  Obx(() {
                    return Text("haha");
                  }),
                Row(
                  children: [
                    Expanded(
                      child: SkyElevatedButton(
                          onPressed: () {
                            c.openAddVariantBottomSheet();
                          },
                          title: "Add Variant"),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: SkyElevatedButton(
                          onPressed: () {
                            c.openAddAddonsBottomSheet();
                          },
                          title: "Addons"),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
