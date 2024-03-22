import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/core/utils/constants/enums.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/features/widgets/common_widgets/empty_view.dart';
import 'package:saralnova/features/widgets/common_widgets/error_view.dart';

import '../../../../core/controllers/menu/menu_controller.dart';
import '../../../../core/utils/helpers/sky_network_image.dart';
import '../../../widgets/common_widgets/custom_alert_dialog.dart';

class MenuScreen extends StatelessWidget {
  static const String routeName = "/menu-screen";
  final c = Get.find<MenuRestaurantController>();
  MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Menu"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
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
                  return ListView.separated(
                    itemCount: c.menuList.length,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemBuilder: (context, index) {
                      var menu = c.menuList[index];
                      return MenuTile(
                        index: index + 1,
                        menuTitle: menu.title,
                        price: menu.price.toString(),
                        imageUrl: menu.imageUrl,
                        onEdit: () {},
                        // onConfirmDelete: () {},
                        onConfirmDelete: () => c.deleteRestaurantMenu(menu.id!),
                      );
                    },
                  );
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
        onTap: () {},
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

class MenuTile extends StatelessWidget {
  final int index;
  final String? menuTitle;
  final String? imageUrl;
  final String? price;
  final Function() onConfirmDelete;
  final Function() onEdit;
  const MenuTile({
    super.key,
    required this.index,
    this.menuTitle,
    this.imageUrl,
    this.price,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "S.N: $index ",
                    style:
                        CustomTextStyles.f12W400(color: AppColors.blackColor),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Menu Name: ",
                        style: CustomTextStyles.f14W400(
                            color: AppColors.borderColor),
                      ),
                      Text(
                        menuTitle ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyles.f14W400(
                            color: AppColors.blackColor),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  RichText(
                    text: TextSpan(
                      text: "Price:   ",
                      style: CustomTextStyles.f14W400(
                          color: AppColors.borderColor),
                      children: [
                        TextSpan(
                            text: price ?? "",
                            style: CustomTextStyles.f16W500())
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: SkyNetworkImage(
                  imageUrl: imageUrl ?? "",
                  // imageUrl: "",
                  height: 70,
                  width: 70,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
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
