import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/model/grid_builder_home.dart';
import 'package:saralnova/core/utils/constants/colors.dart';

class HomeController extends GetxController {
  List<Data> dashboardList = [
    Data(
        icon: CupertinoIcons.bed_double,
        text: "Total Rooms",
        color: AppColors.box1),
    Data(
        icon: CupertinoIcons.calendar_badge_plus,
        text: "New Bookings",
        color: AppColors.box2),
    Data(
        icon: CupertinoIcons.calendar,
        text: "Total Booking",
        color: AppColors.box3),
    Data(
        icon: CupertinoIcons.house,
        text: "Available Rooms",
        color: AppColors.box4),
    Data(
        icon: CupertinoIcons.calendar_badge_minus,
        text: "Cancelled Bookings",
        color: AppColors.box5),
    Data(
        icon: CupertinoIcons.lock_rotation_open,
        text: "Occupied Rooms",
        color: AppColors.box6),
    Data(
        icon: CupertinoIcons.lock,
        text: "Reserved Rooms",
        color: AppColors.box7),
    Data(
        icon: CupertinoIcons.lock_open,
        text: "Vacant Rooms",
        color: AppColors.box8),
  ];
}
