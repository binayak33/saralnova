import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saralnova/core/controllers/menu/menu_controller.dart';
import 'package:saralnova/core/model/feature_model/restaurant_model/menu_request_model.dart';
import 'package:saralnova/core/model/feature_model/restaurant_model/menu_variant_model.dart';
import 'package:saralnova/core/repo/feature_repo/restaurant_repo.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/features/screens/Feature/menu/add_addons_bottom_sheet.dart';
import 'package:saralnova/features/screens/Feature/menu/add_variant_bottom_sheet.dart';
import 'package:saralnova/features/screens/Feature/menu/menu_screen.dart';
import 'package:saralnova/features/screens/Feature/menu/variants_api_bottom_sheets/menu_addon_types_bottom_sheet.dart';
import 'package:saralnova/features/widgets/common_widgets/loading_dialog.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_snack_bar.dart';

import '../../../features/screens/Feature/menu/menu_category_bottom_sheet.dart';
import '../../../features/screens/Feature/menu/variants_api_bottom_sheets/menu_variant_types_bottom_sheet.dart';
import '../../model/feature_model/restaurant_model/category_model.dart';
import '../../model/feature_model/restaurant_model/variant_model.dart';

enum MENUEXTRA { Variant, addons }

class AddMenuController extends GetxController {
  final menuKey = GlobalKey<FormState>();
  final addVariantKey = GlobalKey<FormState>();

  final addOnsKey = GlobalKey<FormState>();

  final LogoLoading loading = LogoLoading();
  var crudState = CRUDSTATE.ADD.obs;
  var pageState = PageState.LOADING.obs;
  var menuExtraState = MENUEXTRA.Variant.obs;
  final titleController = TextEditingController();
  final categoryController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

//variant bottom sheet controllers
  final priceVariantController = TextEditingController();
  final variantCategoryController = TextEditingController();
  final minQtyVariantController = TextEditingController(text: 1.toString());
  final maxQtyVariantController = TextEditingController(text: 1.toString());

//add on bottom sheet controllers
  final categoryAddOnController = TextEditingController();
  final priceAddOnController = TextEditingController();
  final minQtyAddonController = TextEditingController();
  final maxQtyAddonController = TextEditingController();

  Rxn<Category> category = Rxn();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  //pick image
  final Rx<File?> pickedFile = Rx<File?>(null);

  // Your other controller code...

  Future<void> pickImage(XFile imageFile) async {
    pickedFile.value = File(imageFile.path);
  }

  openCategoryTypeBottomSheet() async {
    showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: MenuCategoryBottomSheet(
            onSelectCategoryType: (categoryType) {
              categoryController.text = categoryType.title.toString();

              this.category.value = categoryType;
              // if (crudState.value == CRUDSTATE.UPDATE) {
              //   updateIndex.value = roomType
              //       .id; //instaed of new variable id assing  the id to roomType
              // }
            },
          ),
        );
      },
    );
  }

  openAddVariantBottomSheet() {
    menuExtraState.value = MENUEXTRA.Variant;

    showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AddVariantBottomSheet(),
        );
      },
    );
  }

//STEP 1 Open variant bottom sheet ---> step 2 show variants

  Rxn<Variant> variant = Rxn();
  showVariants() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SelectVariantTypeButtomSheet(
            onSelectVariantType: (variant) {
              variantCategoryController.text = variant.title.toString();
              priceVariantController.text = variant.price.toString();
              this.variant.value = variant;
            },
          ),
        );
      },
    );
  }

//STEP 1 Open add on bottom sheet ---> step 2 show addons
  Rxn<Variant> addOn = Rxn();

  openAddAddonsBottomSheet() {
    menuExtraState.value = MENUEXTRA.addons;

    showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AddAddonsBottomSheet(),
        );
      },
    );
  }

  showAddons() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SelectAddOnTypeButtomSheet(
            onSelectAddOnType: (addOns) {
              categoryAddOnController.text = addOns.title.toString();
              this.addOn.value = addOns;
            },
          ),
        );
      },
    );
  }

  RxList<MenuVariant> addedMenuVariants = RxList();

  submitAddMenutVariant() {
    if (addVariantKey.currentState!.validate()) {
      MenuVariant requestMenuVariant = MenuVariant(
          id: variant.value?.id,
          title: variantCategoryController.text,
          price: int.parse(priceVariantController.text),
          minQty: int.parse(minQtyVariantController.text),
          maxQty: int.parse(maxQtyVariantController.text));
      addedMenuVariants.add(
          requestMenuVariant); //TODO clear this list after the submission of whole menu
      variantCategoryController.clear();
      priceVariantController.clear();
      Get.back();
    }
  }

  RxList<MenuVariant> addedMenuAddOns = RxList();

  submitAddMenutAddOns() {
    if (addOnsKey.currentState!.validate()) {
      MenuVariant requestMenuAddOn = MenuVariant(
          id: addOn.value?.id,
          title: categoryAddOnController.text,
          price: int.parse(priceAddOnController.text),
          minQty: int.parse(minQtyAddonController.text),
          maxQty: int.parse(maxQtyAddonController.text));

      addedMenuAddOns.add(
          requestMenuAddOn); //TODO clear this list after the submission of whole menu
      categoryAddOnController.clear();
      priceAddOnController.clear();
      minQtyAddonController.clear();
      maxQtyAddonController.clear();
      Get.back();
    }
  }

  // RxList<MenuVariant> mergedVariantAndAddonList = RxList();
  RxList<Map<String, dynamic>> mergedVariantAndAddonList = RxList();

  void storeMenu() async {
    if (menuKey.currentState!.validate()) {
      // Merge the addedMenuVarients and addedMenuAddOns

      for (MenuVariant variant in addedMenuVariants) {
        mergedVariantAndAddonList.add({
          'id': variant.id,
          'price': variant.price,
          'minQty': variant.minQty,
          'maxQty': variant.maxQty,
        });
      }
      for (MenuVariant addon in addedMenuAddOns) {
        mergedVariantAndAddonList.add({
          'id': addon.id,
          'price': addon.price,
          'minQty': addon.minQty,
          'maxQty': addon.maxQty,
        });
      }
      //making each map to list

      List<Variants> convertedVariantsList =
          mergedVariantAndAddonList.map((map) {
        return Variants(
          id: map['id'].toString(),
          price: map['price'],
          minQty: map['minQty'],
          maxQty: map['maxQty'],
        );
      }).toList();

      loading.show();
      MenuRequestParams menuRequest = MenuRequestParams(
        title: titleController.text,
        price: int.parse(priceController.text),
        categoryId: category.value?.id,
        description: descriptionController.text,
        variants: convertedVariantsList,

        // menuImage: pickedFile.value,
      );

      RestaurantRepo.storeRestaurantMenu(
          menuRequestParams: menuRequest,
          file: pickedFile.value,
          onSuccess: (menu) {
            loading.hide();
            SkySnackBar.success(
                title: "Menu", message: "Menu created successfully");

            Get.find<MenuRestaurantController>().getAllRestaurantMenus();
            Get.offNamed(MenuScreen.routeName);
            titleController.clear();
          },
          onError: (message) {
            loading.hide();
            SkySnackBar.error(title: "Menu", message: message);
          });
    }
  }
}
