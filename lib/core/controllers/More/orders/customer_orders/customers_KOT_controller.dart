import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/More/orders/customer_orders/customer_order_controller.dart';
import 'package:saralnova/core/model/feature_model/pos/payment_method_model.dart';
import 'package:saralnova/core/model/feature_model/tables/table_model.dart';
import 'package:saralnova/core/repo/more_repo/pos_repo/pos_repo.dart';
import 'package:saralnova/core/utils/constants/messages.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/features/screens/Dashboard/pos/customer_order/checkout_bottom_sheet.dart';
import 'package:saralnova/features/screens/Dashboard/pos/customer_order/payment_method_bottomsheet.dart';
import 'package:saralnova/features/screens/Dashboard/pos/customer_order/qr_bottom_sheet.dart';
import 'package:saralnova/features/screens/Dashboard/pos/customer_order/transfer_table_bottom_sheet.dart';
import 'package:saralnova/features/screens/Dashboard/pos/pos_bottom_sheets/select_table_pos_bottomSheet.dart';
import 'package:saralnova/features/widgets/common_widgets/loading_dialog.dart';

import '../../../../../features/widgets/common_widgets/sky_snack_bar.dart';
import '../../../../model/feature_model/pos/order_customers_model.dart';
import '../../../../model/feature_model/pos/order_kot_model.dart';
import '../../../../utils/helpers/log_helper.dart';

class CustomersKOTCheckoutController extends GetxController {
  Rxn<Customer> customer = Rxn();
  final LogoLoading loading = LogoLoading();
  final checkoutFormKey = GlobalKey<FormState>();

  var pageState = PageState.LOADING.obs;
  RxList<KitchenOrderTicket> kitchenOrderTicketList = RxList();

  TextEditingController paymentTypeController = TextEditingController();
  RxList<PaymentMethod> paymentMethods = RxList();

  final RxList<Items> selectedMenuItemsId =
      RxList(); // KitchenOrderTicket model => Items
  TextEditingController paidByController = TextEditingController();

  TextEditingController discountController = TextEditingController();

  RxString discountText = ''.obs;
  RxBool enlarge = RxBool(false);

  RxBool isLoadingPaymentMethod = RxBool(false);
  RxBool isWholeCheckout = RxBool(false);

  final RxList<Items> wholeMenuItems =
      RxList(); // KitchenOrderTicket model => Items (only served and nonserve but not cancelled and paid)

  @override
  void onInit() {
    var args = Get.arguments;
    if (args != null) {
      customer.value = args['customer'];
    }
    getCustomerKots();
    getPaymentMethods();
    super.onInit();
  }

  void getCustomerKots() async {
    pageState.value = PageState.LOADING;

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

  void toggleMenuItemSelection(Items item) {
    if (selectedMenuItemsId.contains(item)) {
      selectedMenuItemsId.remove(item);
    } else {
      selectedMenuItemsId.add(item);
    }
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

  // int calculateSubtotal() {
  //   int subtotal = 0;
  //   for (var item in selectedMenuItemsId) {
  //     subtotal += (item.total ?? 0) * (item.quantity ?? 1);
  //   }
  //   return subtotal;
  // }
  int calculateSubtotal() {
    int subtotal = 0;
    if (isWholeCheckout.value == false) {
      for (var item in selectedMenuItemsId) {
        subtotal += (item.price ?? 0) * (item.quantity ?? 1);
      }
    } else {
      for (var item in wholeMenuItems) {
        subtotal += (item.price ?? 0) * (item.quantity ?? 1);
      }
    }
    return subtotal;
  }

  int calculateGrandTotal() {
    int subtotal = calculateSubtotal();
    int discount = int.tryParse(discountText.value) ?? 0;

    // If discount is greater than subtotal, grand total should be zero
    if (discount > subtotal) {
      return subtotal;
    } else {
      return subtotal - discount;
    }
  }

  void toggleBottomSheet() {
    enlarge.value = !enlarge.value;
  }

  Future<void> splitCheckout() async {
    List<String> kotItemsIds =
        selectedMenuItemsId.map((item) => item.id!).toList();

    if (checkoutFormKey.currentState!.validate()) {
      loading.show();
      await PosRepo.splitCheckout(
          kotItemsIds: kotItemsIds,
          discount: discountController.text.isNotEmpty
              ? int.parse(discountController.text)
              : 0,
          paidBy: paidByController.text.isNotEmpty
              ? paidByController.text
              : customer.value!.customerName!,
          method: paymentTypeController.text, //TODO implement
          onSuccess: (message) {
            getCustomerKots();
            selectedMenuItemsId.clear();
            paymentTypeController.clear();
            loading.hide();

            Get.back();
            // Get.back();
            // Get.find<DashPanelController>().currnetIndex.value = 2;
            // Get.offNamed(CustomerOrderScreen.routeName);

            SkySnackBar.success(title: "Checkout", message: message);
          },
          onError: (message) {
            SkySnackBar.error(title: "Checkout", message: message);
          });
    }
  }

  Future<void> getPaymentMethods() async {
    pageState.value = PageState.LOADING;
    isLoadingPaymentMethod.value = true;
    await PosRepo.getPaymentMethod(
      onSuccess: (paymentMethods) {
        if (paymentMethods.isNotEmpty) {
          pageState.value = PageState.NORMAL;

          this.paymentMethods.addAll(paymentMethods);
        } else {
          pageState.value = PageState.EMPTY;
        }
      },
      onError: (String message) {
        pageState.value = PageState.ERROR;

        SkySnackBar.error(title: "Payment method", message: message);
      },
    );
  }

  openPaymentMethodBottomSheet() async {
    showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: PaymentMethodBottomSheet(
            onSelectedPaymentMethod: (paymentMethod) {
              paymentTypeController.text = paymentMethod;
//  if (paymentTypeController.text == "khalti") {
//                 openQrBottomSheet(String );
//               }
            },
          ),
        );
      },
    );
  }

  openQrBottomSheet(String qr, String paymentMethod) async {
    showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: QrBottomSheet(
            qrString: qr,
            paymentMethod: paymentMethod,
          ),
        );
      },
    );
  }

  Future<void> wholeCheckout() async {
    if (checkoutFormKey.currentState!.validate()) {
      loading.show();
      if (customer.value?.id != null) {
        await PosRepo.wholeCheckout(
            restaurantCustomerId: customer.value!.id!, //TODO implement
            discount: discountController.text.isNotEmpty
                ? int.parse(discountController.text)
                : 0,
            paidBy: paidByController.text.isNotEmpty
                ? paidByController.text
                : customer.value!.customerName!,
            method: paymentTypeController.text, //TODO implement
            onSuccess: (message) {
              getCustomerKots();
              selectedMenuItemsId.clear();
              paymentTypeController.clear();
              loading.hide();
              Get.find<CustomerOrderController>().getAllCustomers();
              Get.back();
              Get.back();
              // Get.find<MainPosPanelController>().currnetIndex.value = 2;
              // Get.offNamed(CustomerOrderScreen.routeName);

              SkySnackBar.success(title: "Checkout", message: message);
            },
            onError: (message) {
              SkySnackBar.error(title: "Checkout", message: message);
            });
      } else {
        SkySnackBar.error(title: "Checkout", message: Messages.error);
      }
    }
  }

  void addAllServedValue() {
    wholeMenuItems.clear();

    for (var data in kitchenOrderTicketList) {
      if (data.items != null) {
        for (var item in data.items!) {
          if (item.isCancelled != true && item.isPaid != true) {
            wholeMenuItems.add(item);
          }
        }
      }
    }
  }

  final transferTableKey = GlobalKey<FormState>();
  final TextEditingController transferringTableController =
      TextEditingController();

  Rxn<TableModel> table = Rxn();
  openTransferTableBottomSheet() async {
    showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: TransferTableBottomSheet(),
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
              transferringTableController.text = table.name.toString();

              this.table.value = table;
            },
          ),
        );
      },
    );
  }

  Future<void> transferTable() async {
    log("customer id ============>${customer.value!.id!}");
    log("customerId ============>${customer.value!.tables![0].id!}");

    log("newTableId  ============>${table.value!.id!}");

    if (transferTableKey.currentState!.validate()) {
      loading.show();

      if (customer.value != null &&
          customer.value!.tables != null &&
          customer.value!.tables!.isNotEmpty) {
        await PosRepo.transferTable(
            currentTableId: customer.value!.tables![0].id!,
            newTableId: table.value!.id!, //select garera aako
            customerId: customer.value!.id!,
            onSuccess: (message) {
              loading.hide();
              getCustomerKots();
              Get.back();
              transferringTableController.clear();
              table.value = null;
              SkySnackBar.success(title: "Table", message: message);
            },
            onError: (message) {
              loading.hide();

              SkySnackBar.error(title: "Table", message: message);
            });
      } else {
        loading.hide();

        SkySnackBar.error(
          title: "Table",
          message: Messages.error,
        );
      }
    }
  }

  Future<void> emptyTable() async {
    loading.show();
    log("customer id ============>${customer.value!.id!}");

    log("tableId  ============>${customer.value!.tables![0].id!}");
    log("tableName  ============>${customer.value!.tables![0].name!}");

    if (customer.value != null && customer.value!.tables != null) {
      if (customer.value!.tables!.isNotEmpty) {
        await PosRepo.emptyTable(
            tableId: customer.value!.tables![0].id!,
            customerId: customer.value!.id!,
            onSuccess: (message) {
              Get.find<CustomerOrderController>().getAllCustomers();
              loading.hide();
              Get.back();
              transferringTableController.clear();
              table.value = null;
              SkySnackBar.success(title: "Table", message: message);
            },
            onError: (message) {
              loading.hide();

              SkySnackBar.error(title: "Table", message: message);
            });
      } else {
        loading.hide();

        SkySnackBar.error(title: "Table", message: Messages.error);
      }
    } else {
      loading.hide();

      SkySnackBar.error(title: "Table", message: Messages.error);
    }
  }
}
