import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/model/grid_builder_home.dart';

class HomeController extends GetxController {
  List<Data> dashboardList = [
    Data(icon: CupertinoIcons.bed_double, text: "Total Rooms"),
    Data(icon: CupertinoIcons.calendar_badge_plus, text: "New Bookings"),
    Data(icon: CupertinoIcons.calendar, text: "Total Booking"),
    Data(icon: CupertinoIcons.house, text: "Available Rooms"),
    Data(icon: CupertinoIcons.calendar_badge_minus, text: "Cancelled Bookings"),
    Data(icon: CupertinoIcons.lock_rotation_open, text: "Occupied Rooms"),
    Data(icon: CupertinoIcons.lock, text: "Reserved Rooms"),
    Data(icon: CupertinoIcons.lock_open, text: "Vacant Rooms"),
  ];
}