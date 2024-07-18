import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/model/hotel_dashboard_model.dart';
import 'package:saralnova/core/model/restaurant_dashboard_model.dart';
import 'package:saralnova/core/repo/dashboard_repo/dashboard_repo.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_snack_bar.dart';

class HomeController extends GetxController {
  var pageState = PageState.LOADING.obs;
  RxInt currentIndex = RxInt(0);
  final PageController pageController = PageController();
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    getRestaurantDashboard();
    getHotelDashboard();
    super.onInit();
  }

  void updatePage(int index) {
    //for tab controller
    currentIndex.value = index;
    pageController.animateToPage(currentIndex.value,
        duration: const Duration(milliseconds: 500), curve: Curves.linear);
  }

  Rxn<HotelDashboard> hotelDashboard = Rxn();
  Future<void> getHotelDashboard() async {
    pageState.value = PageState.LOADING;
    await DashBoardRepo.getHotelDashboard(onSuccess: (hotel) {
      hotelDashboard.value = hotel;
      pageState.value = PageState.NORMAL;
    }, onError: (message) {
      pageState.value = PageState.ERROR;

      SkySnackBar.error(title: "Hotel", message: message);
    });
  }

  Rxn<RestaurantDashboard> restaurantDashboard = Rxn();
  Future<void> getRestaurantDashboard() async {
    pageState.value = PageState.LOADING;
    await DashBoardRepo.getRestaurantDashboard(onSuccess: (restaurant) {
      restaurantDashboard.value = restaurant;
      pageState.value = PageState.NORMAL;
    }, onError: (message) {
      pageState.value = PageState.ERROR;

      SkySnackBar.error(title: "Restaurant", message: message);
    });
  }
}
