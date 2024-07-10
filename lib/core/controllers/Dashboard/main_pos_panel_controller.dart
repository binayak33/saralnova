import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Splash/core_controller.dart';
import 'package:saralnova/features/screens/More/pos/activity_POS_screen.dart';
import 'package:saralnova/features/screens/More/pos/checkout_POS_screen.dart';
import 'package:saralnova/features/screens/More/pos/kot_POS_screen.dart';
import 'package:saralnova/features/screens/More/pos/place_order_POS_screen.dart';
import 'package:saralnova/features/screens/More/pos/tables_POS_screen.dart';

class MainPosPanelController extends GetxController {
  final coreController = Get.find<CoreController>();
  RxInt currnetIndex = RxInt(0);
  PageController pageController = PageController();

  void onUpdatePage(int value) {
    currnetIndex.value = value;
    pageController.animateToPage(currnetIndex.value,
        duration: const Duration(milliseconds: 100), curve: Curves.linear);
  }

  var pages = <Widget>[
    PlaceOrderScreenPOS(),
    KOTScreenPOS(),
    // CustomerOrderScreen(), // this is the later page
    CheckoutScreenPOS(),
    TablesScreenPOS(),
    ActivityScreenPOS(),
  ];
}
