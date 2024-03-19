import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Feature/feature_controller.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/features/screens/Feature/Booking/booking_screen.dart';
import 'package:saralnova/features/screens/Feature/aminity_type/aminities_screen.dart';
import 'package:saralnova/features/screens/Feature/facility_type/facility_screen.dart';
import 'package:saralnova/features/screens/Feature/room_type/room_type_screen.dart';
import 'package:saralnova/features/screens/Feature/rooms/rooms_screen.dart';
import 'package:saralnova/features/screens/Feature/staff/staff_screen.dart';

class FeatureScreen extends StatelessWidget {
  static const String routeName = "/login-screen";
  final c = Get.find<FeatureController>();
  FeatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text(
          "Features",
          style:
              CustomTextStyles.f20W600(color: AppColors.splashBackgroundColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Card(
                child: ListTile(
                  title: const Text("Rooms Types"),
                  onTap: () {
                    Get.toNamed(RoomTypeScreen.routeName);
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text("Facilities"),
                  onTap: () {
                    Get.toNamed(FacilityScreen.routeName);
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text("Aminities"),
                  onTap: () {
                    Get.toNamed(AmenitiesScreen.routeName);
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text("View Rooms"),
                  onTap: () {
                    Get.toNamed(RoomsScreen.routeName);
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text("View staffs"),
                  onTap: () {
                    Get.toNamed(StaffScreen.routeName);
                  },
                ),
              ),
              Card(
                child: ListTile(
                  title: const Text("Booking"),
                  onTap: () {
                    Get.toNamed(BookingScreen.routeName);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
