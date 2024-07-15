import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/repo/more_repo/pos_repo/pos_repo.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/features/screens/More/pos/customer_order/checkout_bottom_sheet.dart';
import 'package:saralnova/features/widgets/common_widgets/loading_dialog.dart';

import '../../../../../features/widgets/common_widgets/sky_snack_bar.dart';
import '../../../../model/feature_model/pos/order_customers_model.dart';
import '../../../../model/feature_model/pos/order_kot_model.dart';
import '../../../../utils/helpers/log_helper.dart';

class CustomersKOTCheckoutController extends GetxController {
  Rxn<Customer> customer = Rxn();
  final LogoLoading loading = LogoLoading();

  var pageState = PageState.LOADING.obs;
  RxList<KitchenOrderTicket> kitchenOrderTicketList = RxList();
  @override
  void onInit() {
    var args = Get.arguments;
    if (args != null) {
      customer.value = args['customer'];
    }
    getCustomerKots();
    super.onInit();
  }

  void getCustomerKots() async {
    if (customer.value != null) {
      PosRepo.getKotsByCustomer(
          customerId: customer.value!.id,
          onSuccess: (customerKots) {
            if (customerKots.isEmpty) {
              pageState.value = PageState.EMPTY;
            } else {
              kitchenOrderTicketList.clear();
              kitchenOrderTicketList.addAll(customerKots);
              pageState.value = PageState.NORMAL;
            }
          },
          onError: (message) {
            pageState.value = PageState.ERROR;
            LogHelper.error(message);
          });
    } else {
      SkySnackBar.error(
          title: "Kitchen Order Ticket", message: "Something went wrong");
    }
  }

  final RxList<Items> selectedMenuItemsId =
      RxList(); // KitchenOrderTicket model => Items

  void toggleMenuItemSelection(Items item) {
    if (selectedMenuItemsId.contains(item)) {
      selectedMenuItemsId.remove(item);
    } else {
      selectedMenuItemsId.add(item);
    }
  }

  TextEditingController paidByController = TextEditingController();

  Future<void> splitCheckout() async {
    await PosRepo.splitCheckout(
        // kotItemsIds: selectedMenuItemsId.id,
        kotItemsIds: [], //TODO
        paidBy: paidByController.text,
        method: "Cash", //TODO implement
        onSuccess: (message) {
          SkySnackBar.success(title: "Checkout", message: message);
        },
        onError: (message) {
          SkySnackBar.success(title: "Checkout", message: message);
        });
  }

  openCheckoutBottomSheet() async {
    showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: CheckoutBottomSheet(),
        );
      },
    );
  }

  TextEditingController discountController = TextEditingController();
  RxString discountText = ''.obs;

  // int calculateSubtotal() {
  //   int subtotal = 0;
  //   for (var item in selectedMenuItemsId) {
  //     subtotal += (item.price ?? 0) * (item.quantity ?? 1);
  //   }
  //   return subtotal;
  // }

  // double calculateDiscount() {
  //   double discount = double.tryParse(discountText.value) ?? 0.0;
  //   int subtotal = calculateSubtotal();
  //   return discount > subtotal ? subtotal.toDouble() : discount;
  // }

  // double calculateGrandTotal() {
  //   int subtotal = calculateSubtotal();
  //   double discount = calculateDiscount();
  //   return subtotal - discount;
  // }

  int calculateSubtotal() {
    int subtotal = 0;
    for (var item in selectedMenuItemsId) {
      subtotal += (item.price ?? 0) * (item.quantity ?? 1);
    }
    return subtotal;
  }

  int calculateGrandTotal() {
    int subtotal = calculateSubtotal();
    int discount = int.tryParse(discountController.text) ?? 0;

    // If discount is greater than subtotal, grand total should be zero
    if (discount > subtotal) {
      return calculateSubtotal();
    } else {
      return subtotal - discount;
    }
  }
  // double calculateGrandTotal() {}

  RxBool enlarge = RxBool(false);

  void toggleBottomSheet() {
    enlarge.value = !enlarge.value;
  }
}
