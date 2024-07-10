import 'package:get/get.dart';
import 'package:saralnova/core/controllers/More/restaurant/category/category_controller.dart';
import 'package:saralnova/core/model/feature_model/restaurant_model/category_model.dart';
import 'package:saralnova/core/model/feature_model/restaurant_model/menu_model.dart';
import 'package:saralnova/core/repo/more_repo/pos_repo/pos_repo.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_snack_bar.dart';

class PlaceOrderPosController extends GetxController {
  RxList<Category> categories = RxList();
  final categoryController = Get.put(CategoryController());
  var pageState = PageState.LOADING.obs;

  RxList<Menu> menuList = RxList();

  @override
  void onInit() {
    super.onInit();
    onLoad();
    // Listen to changes in restaurantCategorylist
    ever(categoryController.restaurantCategorylist,
        (List<Category> categoryList) {
      if (categoryList.isNotEmpty) {
        categories.clear();
        categories.assignAll(categoryList);
      } else {
        // pageState.value = PageState.EMPTY;
      }
    });
    getMenuItems();
  }

  var selectedCategory = Rxn<String>();

  void selectCategory(String? id) {
    selectedCategory.value = id;
  }

  // void onLoad() { //or calling api from here tooo TODO if below approach doesnot work then use this approach
  //   categoryController.getAllRestaurantCategories(
  //     onSuccess: (categoriesList) {
  //       if (categoriesList.isNotEmpty) {
  //         categories.assignAll(categoriesList);
  //         pageState.value = PageState.NORMAL;
  //       } else {
  //         pageState.value = PageState.EMPTY;
  //       }
  //     },
  //     onError: (message) {
  //       pageState.value = PageState.ERROR;
  //       LogHelper.error(message);
  //     },
  //   );
  // }
  void onLoad() {
    categoryController.getAllRestaurantCategories();
  }

  Future<void> getMenuItems({String? categoryId}) async {
    print("------category id ----------${categoryId}");
    pageState.value = PageState.LOADING;

    await PosRepo.getMenuByCategoy(
      categoryId: categoryId,
      onSuccess: (menus) {
        if (menus.isNotEmpty) {
          menuList.clear();

          menuList.addAll(menus);

          pageState.value = PageState.NORMAL;
        } else {
          pageState.value = PageState.EMPTY;
        }
      },
      onError: (message) {
        pageState.value = PageState.EMPTY;

        SkySnackBar.error(title: "Menu", message: message);
      },
    );
  }
}
