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
                theme: theme, iconPath: IconPath.table, label: "Tables"),
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
