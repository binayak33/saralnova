import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Splash/core_controller.dart';
import 'package:saralnova/core/controllers/pos/pending_order_pos_controller.dart';
import 'package:saralnova/core/controllers/pos/place_order_pos_controller.dart';
import 'package:saralnova/features/screens/More/pos/activity_POS_screen.dart';
import 'package:saralnova/features/screens/More/pos/customer_order/customer_orders_screen.dart';
import 'package:saralnova/features/screens/More/pos/kot_POS_screen.dart';
import 'package:saralnova/features/screens/More/pos/place_order_POS_screen.dart';
import 'package:saralnova/features/screens/More/pos/tables_POS_screen.dart';

class MainPosPanelController extends GetxController {
  final coreController = Get.find<CoreController>();
  RxInt currnetIndex = RxInt(0);
  PageController pageController = PageController();

  final placeOrderPosController = Get.find<PlaceOrderPosController>();

  void onUpdatePage(int value) {
    currnetIndex.value = value;
    pageController.animateToPage(currnetIndex.value,
        duration: const Duration(milliseconds: 100), curve: Curves.linear);

    if (currnetIndex.value == 1) {
      Get.find<PendingOrderController>().getPendingOrders();
    }
  }

  var pages = <Widget>[
    PlaceOrderScreenPOS(),
    KotScreenPOS(),
    CustomerOrderScreen(), // this is the later page
    // CheckoutScreenPOS(),
    TablesScreenPOS(),
    ActivityScreenPOS(),
  ];

  TextEditingController searchMenuController =
      TextEditingController(); // This should be in PlaceOrderScreenController
}
