import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Dashboard/dashboard_panel_controller.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';

class DashPanel extends StatelessWidget {
  static const String routeName = "/dashscreen";
  final c = Get.find<DashPanelController>();
  DashPanel({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      // appBar: CustomAppBar(
      //   actions: [
      //     IconButton(
      //       onPressed: c.logout,
      //       icon: SvgPicture.asset(
      //         IconPath.logout,
      //         height: 24,
      //         width: 24,
      //         colorFilter: const ColorFilter.mode(
      //           Colors.white,
      //           BlendMode.srcIn,
      //         ),
      //       ),
      //     )
      //   ],
      // ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: c.currnetIndex.value,
          onTap: c.onUpdatePage,
          items: [
            customNavItem(theme: theme, iconPath: IconPath.home, label: "Home"),
            customNavItem(
                theme: theme, iconPath: IconPath.calendar, label: "Calendar"),
            customNavItem(
                theme: theme, iconPath: IconPath.personInfo, label: "Expenses"),
            customNavItem(
                theme: theme, iconPath: IconPath.roomDoor, label: "Rooms"),
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
        colorFilter:
            ColorFilter.mode(theme.colorScheme.outlineVariant, BlendMode.srcIn),
      ),
      activeIcon: SvgPicture.asset(
        iconPath,
        colorFilter:
            ColorFilter.mode(theme.colorScheme.primary, BlendMode.srcIn),
      ),
    );
  }
}
