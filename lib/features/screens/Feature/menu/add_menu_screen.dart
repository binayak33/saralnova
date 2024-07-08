import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
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
        title: Text(
            c.crudState.value == CRUDSTATE.ADD ? "Add Menu" : "Update Menu"),
        actions: [
          IconButton(
              onPressed: () {
                print(c.category.value?.id);

                print(c.category.value);

                print(c.menu.value?.imageUrl);
                print(c.category.value?.title);
              },
              icon: Icon(Icons.add))
        ],
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
                        // final imageUrl = c.menu.value?.imageUrl;
                        final imageUrl = c.imageUrl;

                        if (file != null) {
                          return Image.file(
                            file,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          );
                        } else if (imageUrl != null && imageUrl.isNotEmpty) {
                          return SkyNetworkImage(
                            imageUrl: imageUrl,
                            height: 100,
                            width: 100,
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
                  hint: "Title",
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
                  readOnly: true,
                  suffixIconPath: IconPath.down,
                  validator: (value) => Validator.validateEmpty(value!),
                  onTap: () {
                    c.openCategoryTypeBottomSheet();
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                SkyTextField(
                  hint: "Description",
                  // maxLines: null,
                  controller: c.descriptionController,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.multiline,
                  maxLine: 5,

                  validator: (value) => Validator.validateEmpty(value!),
                ),
                const SizedBox(
                  height: 10,
                ),

                //THIS FEATURE IS CURRENTLY DISABLED TODO: REMAINDER==============================START
                // Obx(() {
                //   if (c.menuExtraState.value == MENUEXTRA.Variant &&
                //       c.addedMenuVariants.isNotEmpty) {
                //     return Container(
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(8),
                //       ),
                //       child: Column(
                //         children: [
                //           Obx(
                //             () => ListView.builder(
                //               shrinkWrap: true,
                //               physics: const NeverScrollableScrollPhysics(),
                //               itemCount: c.addedMenuVariants.length,
                //               itemBuilder: (context, index) {
                //                 var variant = c.addedMenuVariants[index];
                //                 return Card(
                //                   child: Padding(
                //                     padding: const EdgeInsets.symmetric(
                //                         horizontal: 10, vertical: 8),
                //                     child: Row(
                //                       mainAxisAlignment:
                //                           MainAxisAlignment.spaceBetween,
                //                       children: [
                //                         Text(
                //                           variant.title ?? "",
                //                           style: CustomTextStyles.f16W600(),
                //                         ),
                //                         Text(
                //                           variant.price.toString(),
                //                           style: CustomTextStyles.f16W600(),
                //                         ),
                //                         Text(
                //                           variant.minQty.toString(),
                //                           style: CustomTextStyles.f16W600(),
                //                         ),
                //                         Text(
                //                           variant.maxQty.toString(),
                //                           style: CustomTextStyles.f16W600(),
                //                         ),
                //                         IconButton(
                //                           onPressed: () {
                //                             c.addedMenuVariants.removeAt(index);
                //                           },
                //                           icon: SvgPicture.asset(
                //                             IconPath.cut,
                //                             height: 20,
                //                             width: 20,
                //                           ),
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                 );
                //               },
                //             ),
                //           ),
                //         ],
                //       ),
                //     );
                //   } else if (c.menuExtraState.value == MENUEXTRA.addons &&
                //       c.addedMenuAddOns.isNotEmpty) {
                //     return Container(
                //       decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(8),
                //       ),
                //       child: Column(
                //         children: [
                //           Obx(
                //             () => ListView.builder(
                //               shrinkWrap: true,
                //               physics: const NeverScrollableScrollPhysics(),
                //               itemCount: c.addedMenuAddOns.length,
                //               itemBuilder: (context, index) {
                //                 var addOns = c.addedMenuAddOns[index];
                //                 return Card(
                //                   child: Padding(
                //                     padding: const EdgeInsets.symmetric(
                //                         horizontal: 10, vertical: 8),
                //                     child: Row(
                //                       mainAxisAlignment:
                //                           MainAxisAlignment.spaceBetween,
                //                       children: [
                //                         Text(
                //                           addOns.title ?? "",
                //                           style: CustomTextStyles.f16W600(),
                //                         ),
                //                         Text(
                //                           addOns.price.toString(),
                //                           style: CustomTextStyles.f16W600(),
                //                         ),
                //                         Text(
                //                           addOns.minQty.toString(),
                //                           style: CustomTextStyles.f16W600(),
                //                         ),
                //                         Text(
                //                           addOns.maxQty.toString(),
                //                           style: CustomTextStyles.f16W600(),
                //                         ),
                //                         IconButton(
                //                           onPressed: () {
                //                             c.addedMenuAddOns.removeAt(index);
                //                           },
                //                           icon: SvgPicture.asset(
                //                             IconPath.cut,
                //                             height: 20,
                //                             width: 20,
                //                           ),
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                 );
                //               },
                //             ),
                //           ),
                //         ],
                //       ),
                //     );
                //   } else {
                //     return const SizedBox.shrink();
                //   }
                // }),
                // const SizedBox(
                //   height: 10,
                // ),
                // Row(
                //   children: [
                //     Expanded(
                //       child: SkyElevatedButton(
                //           onPressed: () {
                //             c.openAddVariantBottomSheet();
                //           },
                //           title: "Add Variant"),
                //     ),
                //     const SizedBox(
                //       width: 10,
                //     ),
                //     Expanded(
                //       child: SkyElevatedButton(
                //           onPressed: () {
                //             c.openAddAddonsBottomSheet();
                //           },
                //           title: "Addons"),
                //     ),
                //   ],
                // ),
                // const Spacer(flex: 2),

                //THIS FEATURE IS CURRENTLY DISABLED TODO: REMAINDER==============================END
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SkyElevatedButton(
            onPressed: () {
              c.crudState.value == CRUDSTATE.ADD
                  ? c.storeMenu()
                  : c.updateMenu();
            },
            title: c.crudState.value == CRUDSTATE.ADD
                ? "Add Menu"
                : "Update Menu"),
      ),
    );
  }
}
