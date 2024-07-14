import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Dashboard/main_pos_panel_controller.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';

class MainPosPanel extends StatelessWidget {
  static const String routeName = "/pos-panel";
  final c = Get.find<MainPosPanelController>();
  MainPosPanel({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      // appBar: AppBar(
      //     // actions: [
      //     //   if (c.currnetIndex.value == 0)
      //     //     Padding(
      //     //       padding: const EdgeInsets.all(8.0),
      //     //       child: AnimSearchBar(
      //     //         // textFieldColor: AppColors.fillColor,
      //     //         textFieldIconColor: Colors.white,
      //     //         rtl: true,
      //     //         prefixIcon: const Icon(
      //     //           Icons.search,
      //     //           size: 15,
      //     //           color: AppColors.splashBackgroundColor,
      //     //         ),

      //     //         boxShadow: false,
      //     //         helpText: "Search....",
      //     //         suffixIcon: const Icon(
      //     //           Icons.search,
      //     //           size: 15,
      //     //           color: AppColors.blackColor,
      //     //         ),
      //     //         searchIconColor: AppColors.textColor,
      //     //         color: AppColors.fillColor,
      //     //         width: 250,
      //     //         textController: c.searchMenuController,
      //     //         onSuffixTap: () {},
      //     //         onSubmitted: (String) {},
      //     //       ),
      //     //     ),
      //     //   if (c.currnetIndex.value == 0)
      //     //     Obx(
      //     //       () => IconButton(
      //     //         onPressed: () {
      //     //           // final placeOrderPosController =
      //     //           //     Get.find<PlaceOrderPosController>();
      //     //           Get.toNamed(MakeOrderPosScreen.routeName);
      //     //         },
      //     //         icon: badges.Badge(
      //     //           showBadge: Get.find<PlaceOrderPosController>()
      //     //               .selectedMenuList
      //     //               .isNotEmpty,
      //     //           position: badges.BadgePosition.topEnd(top: -8, end: -5),
      //     //           badgeContent: Text(
      //     //             c.placeOrderPosController.selectedMenuList.length > 9
      //     //                 ? "9+"
      //     //                 : "${c.placeOrderPosController.selectedMenuList.length}",
      //     //             style: CustomTextStyles.f13W400(
      //     //                 color: AppColors.splashBackgroundColor),
      //     //           ),
      //     //           badgeStyle: const badges.BadgeStyle(
      //     //             badgeColor: AppColors.orangeColor,
      //     //             shape: badges.BadgeShape.circle,
      //     //           ),
      //     //           child: SvgPicture.asset(
      //     //             IconPath.placeOrder,
      //     //             height: 20,
      //     //             width: 20,
      //     //           ),
      //     //         ),
      //     //       ),
      //     //     ),
      //     //   const SizedBox(
      //     //     width: 10,
      //     //   ),
      //     // ],
      //     ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          showSelectedLabels: true,
          showUnselectedLabels: true,
          currentIndex: c.currnetIndex.value,
          onTap: c.onUpdatePage,
          items: [
            customNavItem(
                theme: theme, iconPath: IconPath.home, label: "Place Order"),
            customNavItem(
                theme: theme, iconPath: IconPath.calendar, label: "KOT"),
            customNavItem(
                theme: theme, iconPath: IconPath.pos, label: "Checkout"),
            customNavItem(
                theme: theme, iconPath: IconPath.more, label: "Tables"),
            customNavItem(
                theme: theme, iconPath: IconPath.more, label: "Activity"),
          ],
        ),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: c.pageController,
        children: c.pages,
      ),
    );
  }

  BottomNavigationBarItem customNavItem({
    required ThemeData theme,
    required String iconPath,
    required String label,
    Color? color,
  }) {
    return BottomNavigationBarItem(
      label: label,
      icon: SvgPicture.asset(
        iconPath,
        height: 20,
        width: 20,
        colorFilter:
            ColorFilter.mode(theme.colorScheme.outlineVariant, BlendMode.srcIn),
      ),
      activeIcon: SvgPicture.asset(
        iconPath,
        height: 25,
        width: 25,
        colorFilter:
            ColorFilter.mode(theme.colorScheme.primary, BlendMode.srcIn),
      ),
    );
  }
}
