import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saralnova/core/model/feature_model/restaurant_model/menu_variant_model.dart';
import 'package:saralnova/core/utils/constants/enums.dart';
import 'package:saralnova/features/screens/Feature/menu/add_addons_bottom_sheet.dart';
import 'package:saralnova/features/screens/Feature/menu/add_variant_bottom_sheet.dart';
import 'package:saralnova/features/screens/Feature/menu/variants_api_bottom_sheets/menu_addon_types_bottom_sheet.dart';
import 'package:saralnova/features/widgets/common_widgets/loading_dialog.dart';

import '../../../features/screens/Feature/menu/variants_api_bottom_sheets/menu_variant_types_bottom_sheet.dart';

class AddMenuController extends GetxController {
  final menuKey = GlobalKey<FormState>();
  final LogoLoading loading = LogoLoading();
  var crudState = CRUDSTATE.ADD.obs;
  var pageState = PageState.LOADING.obs;
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

  openAddVariantBottomSheet() {
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
            //room type jasari api call garne

            onSelectVariantType: (type) {
              variantCategoryController.text = type.title.toString();
            },
          ),
        );
      },
    );
  }
//STEP 1 Open add on bottom sheet ---> step 2 show addons

  openAddAddonsBottomSheet() {
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
            //room type jasari api call garne
            onSelectAddOnType: (type) {
              categoryAddOnController.text = type.title.toString();
            },
          ),
        );
      },
    );
  }

  RxList<MenuVariant> addedMenuVariants = RxList();

  submitAddMenutVariant() {
    MenuVariant requestMenuVariant = MenuVariant(
        price: int.parse(priceVariantController.text),
        minQty: int.parse(minQtyVariantController.text),
        maxQty: int.parse(maxQtyVariantController.text));
    addedMenuVariants.add(requestMenuVariant);
    priceVariantController.clear();
    minQtyVariantController.clear();
    maxQtyVariantController.clear();
    // Navigator.of(context).pop;
    Get.back();
  }
}
