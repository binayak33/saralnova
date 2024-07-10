import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/model/feature_model/restaurant_model/category_model.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/core/utils/helpers/log_helper.dart';
import 'package:saralnova/features/screens/More/restaurant/category/add_category_screen.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_snack_bar.dart';

import '../../../../../features/widgets/common_widgets/loading_dialog.dart';
import '../../../../repo/more_repo/restaurant_repo.dart';

class CategoryController extends GetxController {
  final categoryKey = GlobalKey<FormState>();
  final LogoLoading loading = LogoLoading();
  var crudState = CRUDSTATE.ADD.obs;
  var pageState = PageState.LOADING.obs;

  final categoryController = TextEditingController();

  RxList<Category> restaurantCategorylist = RxList();
  Rxn<Category> category = Rxn();

  @override
  void onInit() {
    getAllRestaurantCategories();
    super.onInit();
  }

 Future<void> getAllRestaurantCategories() async {
    restaurantCategorylist.clear();
    RestaurantRepo.getRestaurantCategories(
      onSuccess: (categories) {
        if (categories.isEmpty) {
          pageState.value = PageState.EMPTY;
        } else {
          restaurantCategorylist.addAll(categories);
          pageState.value = PageState.NORMAL;
        }
      },
      onError: (message) {
        pageState.value = PageState.ERROR;
        LogHelper.error(message);
      },
    );
  }
  openCategoryBottomSheet() async {
    showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AddCategoryScreen(),
        );
      },
    );
  }

  void storeRestaurantCategory() async {
    if (categoryKey.currentState!.validate()) {
      loading.show();
      RestaurantRepo.storeRestaurantCategory(
          title: categoryController.text,
          onSuccess: (category) {
            loading.hide();
            //TODO show page state so that loader will be displayed
            getAllRestaurantCategories();
            categoryController.clear();
            Get.back();
          },
          onError: (message) {
            loading.hide();

            SkySnackBar.error(title: "Category", message: message);
          });
    }
  }

 

  void deleteRestaurantCategory(String categoryId) async {
    loading.show();
    // TODO: show confirmation while delete
    RestaurantRepo.deleteRestaurantCategory(
      categoryId: categoryId,
      onSuccess: (message) {
        loading.hide();

        getAllRestaurantCategories();
        Get.back();
      },
      onError: (message) {
        loading.hide();

        SkySnackBar.error(title: "Category", message: message);
      },
    );
  }

  void updateRestaurantCategory() async {
    if (categoryKey.currentState!.validate()) {
      loading.show();
      RestaurantRepo.updateRestaurantCategory(
        categoryTitle: categoryController.text,
        // roomId: updateIndex.value.toString(),
        categoryId: category.value!.id!,
        onSuccess: (category) {
          loading.hide();
          //TODO show page state so that loader will be displayed

          getAllRestaurantCategories();
          categoryController.clear();
          crudState.value = CRUDSTATE.ADD;
          Get.back();
        },
        onError: (message) {
          loading.hide();

          SkySnackBar.error(title: "Category", message: message);
        },
      );
    }
  }
}
