import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/More/restaurant/category/category_controller.dart';
import 'package:saralnova/core/model/feature_model/pos/order_customers_model.dart';
import 'package:saralnova/core/model/feature_model/pos/pos_request_model.dart/place_order_request_model.dart';
import 'package:saralnova/core/model/feature_model/restaurant_model/category_model.dart';
import 'package:saralnova/core/model/feature_model/restaurant_model/menu_model.dart';
import 'package:saralnova/core/model/feature_model/tables/table_model.dart';
import 'package:saralnova/core/repo/more_repo/pos_repo/pos_repo.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/features/screens/More/pos/pos_bottom_sheets/select_customer_pos_bottomsheet.dart';
import 'package:saralnova/features/screens/More/pos/pos_bottom_sheets/select_table_pos_bottomSheet.dart';
import 'package:saralnova/features/widgets/common_widgets/loading_dialog.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_snack_bar.dart';

class PlaceOrderPosController extends GetxController {
  RxList<Category> categories = RxList();
  final categoryController = Get.put(CategoryController());
  var pageState = PageState.LOADING.obs;
  LogoLoading loading = LogoLoading();

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

// ============ beginning of place order

  Rxn<TableModel> table = Rxn();
  TextEditingController tableController = TextEditingController();

  Rxn<Customer> customer = Rxn();
  TextEditingController selectedCustomerNameController =
      TextEditingController();
  TextEditingController newlyAddedCustomerNameController =
      TextEditingController();

  RxBool isCustomerNameFieldEnabled = RxBool(false);

  final FocusNode customerNameFocusNode = FocusNode();

  openSelectCustomerBottomSheet() async {
    showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SelectCustomerBottomSheet(
            onSelectOrderedCustomer: (Customer alreadyOrderedCustomer) {
              selectedCustomerNameController.text =
                  alreadyOrderedCustomer.customerName.toString();

              customer.value = alreadyOrderedCustomer;
            },
            onTap: (isEnabled) {
              isCustomerNameFieldEnabled.value = isEnabled;
              if (isCustomerNameFieldEnabled.value == true) {
                //when not selected clear the selectedController value
                selectedCustomerNameController.clear();
                customerNameFocusNode.requestFocus();
              }
              if (isCustomerNameFieldEnabled.value == false) {
                //when selected clear the typedController value

                newlyAddedCustomerNameController.clear();
              }
            },
          ),
        );
      },
    );
  }

  openAvailableTableBottomSheet() async {
    showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SelectAvailableTableBottomSheet(
            onSelectAvailableTable: (TableModel table) {
              tableController.text = table.name.toString();

              this.table.value = table;
            },
          ),
        );
      },
    );
  }

  //added/selected product menu list

  RxList<Menu> selectedMenuList = RxList();

  void removeFromSelected(Menu selectedMenu) {
    selectedMenuList.removeWhere(
        (item) => item.id == selectedMenu.id); //to remove  menu when click icon
    itemQuantities
        .remove(selectedMenu.id); // to remove quantity of that particular id
    updateTotalAmount(); // to update calculation when the menu is removed
  }

  void onSelectMenu(Menu menuItem) {
    if (selectedMenuList.any((item) => item.id == menuItem.id)) {
      selectedMenuList.removeWhere((item) => item.id == menuItem.id);
      //
      itemQuantities.remove(menuItem.id);
    } else {
      selectedMenuList.add(menuItem);

      itemQuantities[menuItem.id!] = 1; // Set the initial quantity to 1
    }
    updateTotalAmount();
  }

  int getQuantity(Menu menuItem) {
    return itemQuantities[menuItem.id] ?? 1;
  }

  void incrementQuantity(Menu menuItem) {
    if (itemQuantities.containsKey(menuItem.id)) {
      itemQuantities[menuItem.id!] = (itemQuantities[menuItem.id] ?? 1) + 1;
    } else {
      itemQuantities[menuItem.id!] = 1;
    }
    updateTotalAmount();
    selectedMenuList.refresh();
  }

  void decrementQuantity(Menu menuItem) {
    if (itemQuantities.containsKey(menuItem.id) &&
        (itemQuantities[menuItem.id] ?? 1) > 1) {
      itemQuantities[menuItem.id!] = (itemQuantities[menuItem.id] ?? 1) - 1;
      updateTotalAmount();
      selectedMenuList.refresh();
    }
  }

  final Rx<int> totalAmount = Rx<int>(0);

  void updateTotalAmount() {
    int total = 0;
    for (var menu in selectedMenuList) {
      total += menu.price! * getQuantity(menu);
    }
    totalAmount.value = total;
    print('Total amount: $totalAmount');
  }

  RxMap<String, int> itemQuantities = <String, int>{}
      .obs; //item quantites are being stored here {id:1} like this

  final placeKotFormKey = GlobalKey<FormState>();

  Future<void> placeKotOrder() async {
    if (placeKotFormKey.currentState!.validate()) {
      if (selectedMenuList.isNotEmpty) {
        loading.show();

        List<Items> itemsList = itemQuantities.entries.map((entry) {
          return Items(menuId: entry.key, quantity: entry.value, variants: []);
        }).toList();
        PlaceOrderRequestModel requestPlaceOrderModel = PlaceOrderRequestModel(
          // guestData: GuestData(
          //   name: nameController.text,
          //   contact: contactController.text,
          //   email: emailController.text,
          //   address: addressController.text,
          //   nationality: countryController.text,

          // ),

          restaurantCustomerId: customer.value?.id,
          tableId: table.value?.id,
          customerName: selectedCustomerNameController.text.isNotEmpty
              ? selectedCustomerNameController.text
              : newlyAddedCustomerNameController.text,
          customerEmail: customer.value?.customerEmail,
          customerPhone: customer.value?.customerPhone,
          items: itemsList,
        );
        PosRepo.placeKOT(
            placeOrderRequestModel: requestPlaceOrderModel,
            onSuccess: (message) {
              loading.hide();
              Get.back();
              selectedMenuList.clear();
              totalAmount.value = 0;
              selectedCustomerNameController.clear();
              newlyAddedCustomerNameController.clear();
              tableController.clear();
              table.value = null;
              customer.value = null;
              // Get.offNamed(PlaceOrderScreenPOS.routeName); // can't go back because it always throw null check error so we have to do back and make all null

              SkySnackBar.success(title: "KOT Order", message: message);
            },
            onError: (message) {
              loading.hide();

              SkySnackBar.error(title: "KOT Order", message: message);
            });
      }
    }
  }
}
