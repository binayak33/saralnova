import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/features/screens/More/menu/add_menu_screen.dart';
import 'package:saralnova/features/widgets/common_widgets/loading_dialog.dart';

import '../../../features/widgets/common_widgets/sky_snack_bar.dart';
import '../../model/feature_model/restaurant_model/menu_model.dart';
import '../../repo/more_repo/restaurant_repo.dart';
import '../../utils/helpers/log_helper.dart';

class MenuRestaurantController extends GetxController {
  final menuKey = GlobalKey<FormState>();
  final LogoLoading loading = LogoLoading();
  var crudState = CRUDSTATE.ADD.obs;
  var pageState = PageState.LOADING.obs;

  RxList<Menu> menuList = RxList();

  @override
  void onInit() {
    getAllRestaurantMenus();
    super.onInit();
  }

  void getAllRestaurantMenus() async {
    menuList.clear();
    pageState.value = PageState.LOADING;

    RestaurantRepo.getRestaurnatMenus(
      onSuccess: (menus) {
        if (menus.isEmpty) {
          pageState.value = PageState.EMPTY;
        } else {
          menuList.addAll(menus);
          pageState.value = PageState.NORMAL;
        }
      },
      onError: (message) {
        pageState.value = PageState.ERROR;
        LogHelper.error(message);
      },
    );
  }

  void deleteRestaurantMenu(String menuId) async {
    loading.show();
    // TODO: show confirmation while delete
    Menu menuRequest = Menu(
      id: menuId,
    );
    RestaurantRepo.deleteRestaurantMenu(
      menuModel: menuRequest,
      onSuccess: (message) {
        loading.hide();

        getAllRestaurantMenus();
        Get.back();
      },
      onError: (message) {
        loading.hide();

        SkySnackBar.error(title: "Menu", message: message);
      },
    );
  }

  void onMenuEdit(Menu menu) async {
    Get.toNamed(AddMenuScreen.routeName, arguments: {"menu": menu});
  }
}
