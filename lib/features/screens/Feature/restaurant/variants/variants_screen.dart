import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Feature/restaurant/variants/variant_controller.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/core/utils/constants/enums.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
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
        title: const Text("Category"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Obx(() {
                if (c.pageState.value == PageState.LOADING) {
                  return Center(
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
                  return ListView.builder(
                    itemCount: c.restaurantVariantlist.length,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var variant = c.restaurantVariantlist[index];
                      return RestaurantVariantTile(
                        index: index + 1,
                        title: variant.title,
                        price: variant.price.toString(),
                      );
                    },
                  );
                } else {
                  return ErrorView(
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
          // c.categoryController.clear();
          // c.openCategoryBottomSheet();
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
  //TODO make 2 functions to edit and delete
  const RestaurantVariantTile(
      {super.key, required this.index, this.title, this.price});

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
                  onPressed: () {},
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
                                // onConfirm: onConfirmDelete,
                                onConfirm: () {},
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
