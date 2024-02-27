import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Rooms/rooms_controller.dart';
import 'package:saralnova/features/screens/Dashboard/dashboard_panel.dart';

enum PageState { ADD, UPDATE }

class AddRoomController extends GetxController {
  final formKey = GlobalKey<FormState>();

  var pageState = PageState.ADD.obs;

  final roomTypeController = TextEditingController();

  RxnInt updateIndex = RxnInt();

  @override
  void onInit() {
    var args = Get.arguments;

    if (args != null) {
      roomTypeController.text = args['update'];
      pageState.value = PageState.UPDATE;
      updateIndex.value = args['index'];
    }

    super.onInit();
  }

  void onSave() async {
    if (formKey.currentState!.validate()) {
      Get.find<RoomsController>().roomTypes.add(roomTypeController.text);
      roomTypeController.clear();
      Get.until(
        (route) => route.settings.name == DashPanel.routeName,
      );
    }
  }

  // void onUpdate() async {
  //   if (formKey.currentState!.validate()) {
  //     final index = updateIndex.value ?? 0; // Get the index from updateIndex
  //     final roomTypeInstance = Get.find<RoomsController>().roomTypes;
  //     if (index >= 0 && index < roomTypeInstance.length) {
  //       roomTypeInstance[index] = roomTypeController.text;
  //     }
  //     roomTypeController.clear();
  //     Get.until(
  //       (route) => route.settings.name == DashPanel.routeName,
  //     );
  //   }
  // }

  void onUpdate() async {
    if (formKey.currentState!.validate()) {
      final index = updateIndex.value;
      if (index != null &&
          index >= 0 &&
          index < Get.find<RoomsController>().roomTypes.length) {
        Get.find<RoomsController>().roomTypes[index] = roomTypeController.text;
        roomTypeController.clear();
        Get.until(
          (route) => route.settings.name == DashPanel.routeName,
        );
      }
    }
  }
}
