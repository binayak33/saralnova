import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/features/widgets/app_widgets/menu_tile.dart';
import 'package:saralnova/features/widgets/common_widgets/custom_appBar.dart';
import 'package:saralnova/features/widgets/common_widgets/custom_floating_action_button.dart';
import 'package:saralnova/features/widgets/common_widgets/empty_view.dart';
import 'package:saralnova/features/widgets/common_widgets/error_view.dart';
import 'package:saralnova/features/widgets/shimmers/list_shimmer.dart';

import '../../../../core/controllers/menu/menu_controller.dart';
import 'add_menu_screen.dart';

class MenuScreen extends StatelessWidget {
  static const String routeName = "/menu-screen";
  final c = Get.find<MenuRestaurantController>();
  MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SaralNovaApppBar(
        title: "Menus",
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
                  return SaralNovaShimmer.bookingShimmer();
                } else if (c.pageState.value == PageState.EMPTY) {
                  return EmptyView(
                    message: "Empty!!",
                    title: "Empty",
                    media: IconPath.empty,
                    mediaSize: Get.height / 2,
                  );
                } else if (c.pageState.value == PageState.NORMAL) {
                  return ListView.separated(
                    padding: const EdgeInsets.only(bottom: 100),
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
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          Get.toNamed(AddMenuScreen.routeName);
        },
      ),
    );
  }
}
