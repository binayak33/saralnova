import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/model/feature_model/restaurant_model/variant_model.dart';
import 'package:saralnova/core/repo/more_repo/restaurant_repo.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/core/utils/helpers/log_helper.dart';
import 'package:saralnova/features/screens/More/restaurant/variants/add_variant_screen.dart';
import 'package:saralnova/features/screens/More/restaurant/variants/variant_type_bottom_sheet.dart';
import 'package:saralnova/features/widgets/common_widgets/loading_dialog.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_snack_bar.dart';

enum RestaurantState { VARIANT, ADDONS }

class VariantController extends GetxController {
  final variantKey = GlobalKey<FormState>();
  final LogoLoading loading = LogoLoading();
  var crudState = CRUDSTATE.ADD.obs;
  var pageState = PageState.LOADING.obs;
  var restaurantState = RestaurantState.VARIANT.obs;

  RxList<Variant> filteredVariantList = RxList();
  RxList<Variant> filteredAddonsList = RxList();
  Rxn<Variant> variant = Rxn();
  // add variants screen
  final titleVariantController = TextEditingController();
  final priceVariantController = TextEditingController();
  final descpVariantController = TextEditingController();
  final typeController = TextEditingController();

  @override
  void onInit() {
    getAllRestaurantVariants();
    super.onInit();
  }

  void getAllRestaurantVariants() async {
    RestaurantRepo.getRestaurantVariants(
      onSuccess: (variants) {
        if (variants.isEmpty) {
          pageState.value = PageState.EMPTY;
        } else {
          filteredVariantList.clear();
          filteredAddonsList.clear();
          pageState.value = PageState.NORMAL;

          for (var data in variants) {
            if (data.type == "Variant") {
              filteredVariantList.add(data);
            } else {
              //if data.type == "addOn"
              filteredAddonsList.add(data);
            }
          }
        }
      },
      onError: (message) {
        pageState.value = PageState.ERROR;
        LogHelper.error(message);
      },
    );
  }

  void storeRestaurantVariant() async {
    if (variantKey.currentState!.validate()) {
      loading.show();

      Variant variantModel = Variant(
        title: titleVariantController.text,
        price: int.parse(priceVariantController.text),
        type: typeController.text,
        description: descpVariantController.text,
      );
      RestaurantRepo.storeRestaurantVariants(
          variantModel: variantModel,
          onSuccess: (variant) {
            loading.hide();
            //TODO show page state so that loader will be displayed
            getAllRestaurantVariants();
            titleVariantController.clear();
            priceVariantController.clear();
            typeController.clear();
            descpVariantController.clear();
            Get.back();
          },
          onError: (message) {
            loading.hide();

            SkySnackBar.error(title: "Variants", message: message);
          });
    }
  }

  showVariantType() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: VariantTypeBottomSheet(
            onSelectRoomStatus: (type) {
              typeController.text = type;
            },
          ),
        );
      },
    );
  }

  void deleteRestaurantVariant(String variantId) async {
    loading.show();
    // TODO: show confirmation while delete
    Variant variantModel = Variant(
      id: variantId,
    );
    RestaurantRepo.deleteRestaurantVariants(
      variantModel: variantModel,
      onSuccess: (message) {
        loading.hide();

        getAllRestaurantVariants();
        Get.back();
      },
      onError: (message) {
        loading.hide();

        SkySnackBar.error(title: "Category", message: message);
      },
    );
  }

  void onEditClick(Variant variant) async {
    crudState.value = CRUDSTATE.UPDATE;
    this.variant.value = variant; // assign the id to the model
    Get.toNamed(AddVariantScreen.routeName);
    titleVariantController.text = variant.title.toString();
    priceVariantController.text = variant.price.toString();
    typeController.text = variant.type.toString();
    descpVariantController.text = variant.description.toString();
  }

  void updateRestaurantVariant() async {
    if (variantKey.currentState!.validate()) {
      loading.show();
      Variant variantModel = Variant(
        id: variant.value?.id,
        title: titleVariantController.text,
        price: int.parse(priceVariantController.text),
        type: typeController.text,
        description: descpVariantController.text,
      );
      RestaurantRepo.updateRestaurantVariant(
        variantModel: variantModel,
        onSuccess: (category) {
          loading.hide();
          //TODO show page state so that loader will be displayed

          getAllRestaurantVariants();
          titleVariantController.clear();
          priceVariantController.clear();
          typeController.clear();
          descpVariantController.clear();
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
