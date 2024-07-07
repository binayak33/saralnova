import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Feature/feature_controller.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/features/screens/Feature/Booking/booking_screen.dart';
import 'package:saralnova/features/screens/Feature/activites/activites_screen.dart';
import 'package:saralnova/features/screens/Feature/activity_log/activity_log_screen.dart';
import 'package:saralnova/features/screens/Feature/aminity_type/amenity_screen.dart';
import 'package:saralnova/features/screens/Feature/facility_type/facility_screen.dart';
import 'package:saralnova/features/screens/Feature/menu/menu_screen.dart';
import 'package:saralnova/features/screens/Feature/orders/customer_order/customer_orders_screen.dart';
import 'package:saralnova/features/screens/Feature/restaurant/category/category_screen.dart';
import 'package:saralnova/features/screens/Feature/room_type/room_type_screen.dart';
import 'package:saralnova/features/screens/Feature/rooms/rooms_screen.dart';
import 'package:saralnova/features/screens/Feature/space/space_screen.dart';
import 'package:saralnova/features/screens/Feature/staff/staff_screen.dart';
import 'package:saralnova/features/screens/Feature/tables/tables_screen.dart';
import 'package:saralnova/features/widgets/app_widgets/custom_list_tile.dart';

class FeatureScreen extends StatelessWidget {
  static const String routeName = "/login-screen";
  final c = Get.find<FeatureController>();
  FeatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "More",
          style: CustomTextStyles.f20W600(),
        ),
        actions: [
          SvgPicture.asset(
            IconPath.search,
            height: 20,
            width: 20,
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Hotel",
                  style: CustomTextStyles.f16W500(),
                ),
              ),
              CustomListTile(
                title: "Room Types",
                onTap: () {
                  Get.toNamed(RoomTypeScreen.routeName);
                },
                iconPath: IconPath.roomType,
              ),
              CustomListTile(
                title: "Facilities",
                onTap: () {
                  Get.toNamed(FacilityScreen.routeName);
                },
                iconPath: IconPath.facilities,
              ),
              CustomListTile(
                title: "Aminities",
                onTap: () {
                  Get.toNamed(AmenitiesScreen.routeName);
                },
                iconPath: IconPath.amenities,
              ),
              CustomListTile(
                title: "View Rooms",
                onTap: () {
                  Get.toNamed(RoomsScreen.routeName);
                },
                iconPath: IconPath.viewRooms,
              ),
              CustomListTile(
                title: "View Staffs",
                onTap: () {
                  Get.toNamed(StaffScreen.routeName);
                },
                iconPath: IconPath.staffs,
              ),
              CustomListTile(
                title: "Booking",
                onTap: () {
                  Get.toNamed(BookingScreen.routeName);
                },
                iconPath: IconPath.booking,
              ),
              CustomListTile(
                title: "Activity Log",
                onTap: () {
                  Get.toNamed(ActivityLogScreen.routeName);
                },
                iconPath: IconPath.activity,
              ),
              const Divider(
                height: 0,
                color: AppColors.fillColor,
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Restaurant ",
                  style: CustomTextStyles.f16W500(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
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
              CustomListTile(
                title: "Menus",
                onTap: () {
                  Get.toNamed(MenuScreen.routeName);
                },
                iconPath: IconPath.menu,
              ),
              const Divider(
                height: 0,
                color: AppColors.fillColor,
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Tables ",
                  style: CustomTextStyles.f16W500(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomListTile(
                title: "Space",
                onTap: () {
                  Get.toNamed(SpaceScreen.routeName);
                },
                iconPath: IconPath.space,
              ),
              CustomListTile(
                title: "Tables",
                onTap: () {
                  Get.toNamed(TablesScreen.routeName);
                },
                iconPath: IconPath.tables,
              ),
              const Divider(
                height: 0,
                color: AppColors.fillColor,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Order",
                  style: CustomTextStyles.f16W500(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomListTile(
                title: "Order",
                onTap: () {
                  Get.toNamed(CustomerOrderScreen.routeName);
                },
                iconPath: IconPath.order,
              ),
              const Divider(
                height: 0,
                color: AppColors.fillColor,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Activities",
                  style: CustomTextStyles.f16W500(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomListTile(
                title: "Activities",
                onTap: () {
                  Get.toNamed(ActivitiesScreen.routeName);
                },
                iconPath: IconPath.activities,
              ),
              const Divider(
                height: 0,
                color: AppColors.fillColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
