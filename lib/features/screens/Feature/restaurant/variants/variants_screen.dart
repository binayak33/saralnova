import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Feature/restaurant/variants/variant_controller.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/features/screens/Feature/restaurant/variants/add_variant_screen.dart';
import 'package:saralnova/features/widgets/common_widgets/custom_alert_dialog.dart';
import 'package:saralnova/features/widgets/common_widgets/empty_view.dart';
import 'package:saralnova/features/widgets/common_widgets/error_view.dart';

class VariantScreen extends StatelessWidget {
  static const String routeName = "/variant-screen";
  final c = Get.find<VariantController>();
  VariantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Variants"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: GestureDetector(
                          onTap: () {
                            c.restaurantState.value = RestaurantState.VARIANT;
                          },
                          child: Obx(
                            () => Container(
                              decoration: BoxDecoration(
                                color: c.restaurantState.value ==
                                        RestaurantState.VARIANT
                                    ? AppColors.primary
                                    : AppColors.borderColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                    10,
                                  ),
                                  bottomLeft: Radius.circular(
                                    10,
                                  ),
                                ),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Center(
                                child: Text(
                                  "Variants",
                                  style: CustomTextStyles.f14W600(
                                    color: c.restaurantState.value ==
                                            RestaurantState.VARIANT
                                        ? AppColors.scaffoldColor
                                        : AppColors.primary,
                                  ),
                                ),
                              ),
                            ),
                          )),
                    ),
                    Expanded(
                      child: GestureDetector(
                          onTap: () {
                            c.restaurantState.value = RestaurantState.ADDONS;
                          },
                          child: Obx(
                            () => Container(
                              decoration: BoxDecoration(
                                  color: c.restaurantState.value ==
                                          RestaurantState.ADDONS
                                      ? AppColors.primary
                                      : AppColors.borderColor,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(
                                      10,
                                    ),
                                    bottomRight: Radius.circular(
                                      10,
                                    ),
                                  )),
                              padding: const EdgeInsets.all(10),
                              child: Center(
                                child: Text(
                                  "Addons",
                                  style: CustomTextStyles.f14W600(
                                    color: c.restaurantState.value ==
                                            RestaurantState.ADDONS
                                        ? AppColors.scaffoldColor
                                        : AppColors.primary,
                                  ),
                                ),
                              ),
                            ),
                          )),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(() {
                if (c.pageState.value == PageState.LOADING) {
                  return const Center(
                    child: LinearProgressIndicator(),
                  );
                } else if (c.pageState.value == PageState.EMPTY) {
                  return EmptyView(
                    message: "Empty!!",
                    title: "Empty",
                    media: IconPath.empty,
                    mediaSize: Get.height / 2,
                  );
                } else if (c.pageState.value == PageState.NORMAL) {
                  if (c.restaurantState.value == RestaurantState.VARIANT) {
                    return c.filteredVariantList.isNotEmpty
                        ? ListView.separated(
                            itemCount: c.filteredVariantList.length,
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 10,
                              );
                            },
                            itemBuilder: (context, index) {
                              var variant = c.filteredVariantList[index];
                              return RestaurantVariantTile(
                                index: index + 1,
                                title: variant.title,
                                price: variant.price.toString(),
                                type: variant.type,
                                onEdit: () => c.onEditClick(variant),
                                onConfirmDelete: () {
                                  c.deleteRestaurantVariant(
                                      variant.id.toString());
                                },
                              );
                            },
                          )
                        : EmptyView(
                            message: "Empty!!",
                            title: "Empty",
                            media: IconPath.empty,
                            mediaSize: Get.height / 2,
                          );
                  } else {
                    return c.filteredAddonsList.isNotEmpty
                        ? ListView.separated(
                            itemCount: c.filteredAddonsList.length,
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 10,
                              );
                            },
                            itemBuilder: (context, index) {
                              var addOn = c.filteredAddonsList[index];
                              return RestaurantVariantTile(
                                index: index + 1,
                                title: addOn.title,
                                price: addOn.price.toString(),
                                type: addOn.type,
                                onEdit: () => c.onEditClick(addOn),
                                onConfirmDelete: () {
                                  c.deleteRestaurantVariant(
                                      addOn.id.toString());
                                },
                              );
                            },
                          )
                        : EmptyView(
                            message: "Empty!!",
                            title: "Empty",
                            media: IconPath.empty,
                            mediaSize: Get.height / 2,
                          );
                  }
                } else {
                  return const ErrorView(
                    errorTitle: "Something went wrong!!",
                    errorMessage: "Something went wrong",
                    imagePath: IconPath.somethingWentWrong,
                  );
                }
              })
            ],
          ),
        ),
      ),
      floatingActionButton: InkResponse(
        radius: 20,
        onTap: () {
          c.crudState.value = CRUDSTATE.ADD;
          Get.toNamed(AddVariantScreen.routeName);
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: AppColors.primary,
          ),
          child: Text(
            "Create",
            style: CustomTextStyles.f16W600(
              color: AppColors.scaffoldColor,
            ),
          ),
        ),
      ),
    );
  }
}

class RestaurantVariantTile extends StatelessWidget {
  final int index;
  final String? title;
  final String? price;
  final String? type;
  final Function() onConfirmDelete;
  final Function() onEdit;
  const RestaurantVariantTile({
    super.key,
    required this.index,
    this.title,
    this.price,
    this.type,
    required this.onConfirmDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.borderColor),
          color: AppColors.scaffoldColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "S.N: $index ",
            style: CustomTextStyles.f12W400(color: AppColors.blackColor),
          ),
          const SizedBox(
            height: 8,
          ),
          RichText(
            text: TextSpan(
              text: "Title:   ",
              style: CustomTextStyles.f14W400(color: AppColors.borderColor),
              children: [
                TextSpan(text: title ?? "", style: CustomTextStyles.f16W500())
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          RichText(
            text: TextSpan(
              text: "Type:   ",
              style: CustomTextStyles.f14W400(color: AppColors.borderColor),
              children: [
                TextSpan(text: type ?? "", style: CustomTextStyles.f16W500())
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          RichText(
            text: TextSpan(
              text: "Price:   ",
              style: CustomTextStyles.f14W400(color: AppColors.borderColor),
              children: [
                TextSpan(text: price ?? "", style: CustomTextStyles.f16W500())
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: AppColors.orangeColor,
                child: IconButton(
                  onPressed: onEdit,
                  icon: SvgPicture.asset(
                    IconPath.edit,
                    height: 18,
                    width: 18,
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              CircleAvatar(
                  radius: 15,
                  backgroundColor: AppColors.errorColor,
                  child: IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext ctx) {
                            return CustomAlertDialog(
                                title: "Do you really want to delete ?",
                                message: "You cannot undo this action",
                                onConfirm: onConfirmDelete,
                                confirmText: "Yes");
                          });
                    },
                    icon: SvgPicture.asset(
                      IconPath.delete,
                      colorFilter:
                          const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
