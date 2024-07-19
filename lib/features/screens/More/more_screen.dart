import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/More/more_controller.dart';
import 'package:saralnova/core/controllers/Splash/core_controller.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/features/screens/More/Booking/booking_screen.dart';
import 'package:saralnova/features/screens/More/activity_log/activity_log_screen.dart';
import 'package:saralnova/features/screens/More/aminity_type/amenity_screen.dart';
import 'package:saralnova/features/screens/More/facility_type/facility_screen.dart';
import 'package:saralnova/features/screens/More/menu/menu_screen.dart';
import 'package:saralnova/features/screens/More/order/order_screen.dart';
import 'package:saralnova/features/screens/More/restaurant/category/category_screen.dart';
import 'package:saralnova/features/screens/More/room_type/room_type_screen.dart';
import 'package:saralnova/features/screens/More/rooms/rooms_screen.dart';
import 'package:saralnova/features/screens/More/space/space_screen.dart';
import 'package:saralnova/features/screens/More/staff/staff_screen.dart';
import 'package:saralnova/features/screens/More/tables/tables_screen.dart';
import 'package:saralnova/features/widgets/app_widgets/custom_list_tile.dart';

class MoreScreen extends StatelessWidget {
  static const String routeName = "/more-screen";
  final c = Get.find<MoreController>();
  final coreController = Get.find<CoreController>();
  MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "More",
          style: CustomTextStyles.f20W600(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Column(
            children: [
              if ((coreController.currentUser.value?.role == "admin" ||
                      coreController.currentUser.value?.role == "staffs") &&
                  coreController.currentUser.value?.hasHotel == true)
                Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Adjust the value as needed
                    ),
                    collapsedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Adjust the value as needed
                    ),
                    backgroundColor: AppColors.fillFadedColor,
                    title: Text(
                      "Hotel",
                      style: CustomTextStyles.f16W500(),
                    ),
                    children: [
                      if (coreController.currentUser.value?.role == "admin")
                        CustomListTile(
                          title: "Room Types",
                          onTap: () {
                            Get.toNamed(RoomTypeScreen.routeName);
                          },
                          iconPath: IconPath.roomType,
                        ),
                      if (coreController.currentUser.value?.role == "admin")
                        CustomListTile(
                          title: "Facilities",
                          onTap: () {
                            Get.toNamed(FacilityScreen.routeName);
                          },
                          iconPath: IconPath.facilities,
                        ),
                      if (coreController.currentUser.value?.role == "admin")
                        CustomListTile(
                          title: "Aminities",
                          onTap: () {
                            Get.toNamed(AmenitiesScreen.routeName);
                          },
                          iconPath: IconPath.amenities,
                        ),
                      if (coreController.currentUser.value?.role == "admin")
                        CustomListTile(
                          title: "View Rooms",
                          onTap: () {
                            Get.toNamed(RoomsScreen.routeName);
                          },
                          iconPath: IconPath.viewRooms,
                        ),
                      CustomListTile(
                        title: "Booking",
                        onTap: () {
                          Get.toNamed(BookingScreen.routeName);
                        },
                        iconPath: IconPath.booking,
                      ),
                      if (coreController.currentUser.value?.role == "admin")
                        CustomListTile(
                          title: "Activity Log",
                          onTap: () {
                            Get.toNamed(ActivityLogScreen.routeName);
                          },
                          iconPath: IconPath.activity,
                        ),
                    ],
                  ),
                ),
              const Divider(
                height: 0,
                color: AppColors.fillColor,
              ),
              const SizedBox(
                height: 10,
              ),
              if ((coreController.currentUser.value?.role == "admin" ||
                      coreController.currentUser.value?.role == "staffs") &&
                  coreController.currentUser.value?.hasRestaurant == true)
                Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Adjust the value as needed
                    ),
                    collapsedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          10), // Adjust the value as needed
                    ),
                    backgroundColor: AppColors.fillFadedColor,
                    title: Text(
                      "Restaurant ",
                      style: CustomTextStyles.f16W500(),
                    ),
                    children: [
                      if (coreController.currentUser.value?.role == "admin")
                        CustomListTile(
                          title: "Category",
                          onTap: () {
                            Get.toNamed(CategoryScreen.routeName);
                          },
                          iconPath: IconPath.category,
                        ),
                      // CustomListTile(
                      //   title: "Variants",
                      //   onTap: () {
                      //     Get.toNamed(VariantScreen.routeName);
                      //   },
                      //   iconPath: IconPath.variants,
                      // ),
                      if (coreController.currentUser.value?.role == "admin")
                        CustomListTile(
                          title: "Menus",
                          onTap: () {
                            Get.toNamed(MenuScreen.routeName);
                          },
                          iconPath: IconPath.menu,
                        ),
                      CustomListTile(
                        title: "Order",
                        onTap: () {
                          Get.toNamed(OrderScreen.routeName);
                        },
                        iconPath: IconPath.order,
                      ),
                      if (coreController.currentUser.value?.role == "admin")
                        CustomListTile(
                          title: "Tables",
                          onTap: () {
                            Get.toNamed(TablesScreen.routeName);
                          },
                          iconPath: IconPath.tables,
                        ),
                      if (coreController.currentUser.value?.role == "admin")
                        CustomListTile(
                          title: "Space",
                          onTap: () {
                            Get.toNamed(SpaceScreen.routeName);
                          },
                          iconPath: IconPath.space,
                        ),
                    ],
                  ),
                ),

              if (c.coreConTroller.currentUser.value?.role == "admin")
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      title: Text(
                        "Staffs",
                        style: CustomTextStyles.f16W500(),
                      ),
                      onTap: () {
                        Get.toNamed(StaffScreen.routeName);
                      },
                      // iconPath: IconPath.staffs,
                      leading: SvgPicture.asset(
                        IconPath.staffs,
                        height: 20,
                        width: 20,
                      ),
                    ),
                    const Divider(
                      height: 0,
                      color: AppColors.fillColor,
                    ),
                  ],
                ),
              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: Text(
              //     "Activities",
              //     style: CustomTextStyles.f16W500(),
              //   ),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // CustomListTile(
              //   title: "Activities",
              //   onTap: () {
              //     Get.toNamed(ActivitiesScreen.routeName);
              //   },
              //   iconPath: IconPath.activities,
              // ),

              // const Divider(
              //   height: 0,
              //   color: AppColors.fillColor,
              // ),

              CustomListTile(
                title: "Logout",
                onTap: () {
                  Get.find<CoreController>().logOut();
                },
                iconPath: IconPath.logout,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
