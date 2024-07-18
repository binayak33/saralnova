import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt currentIndex = RxInt(0);
  final PageController pageController = PageController();
  final ScrollController scrollController = ScrollController();
  void updatePage(int index) {
    currentIndex.value = index;
    pageController.animateToPage(currentIndex.value,
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
  }
}
