import 'package:get/get.dart';
import 'package:saralnova/core/repo/feature_repo/order_repo/order_repo.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/features/widgets/common_widgets/loading_dialog.dart';

import '../../../../../features/widgets/common_widgets/sky_snack_bar.dart';
import '../../../../model/feature_model/order/order_customers_model.dart';
import '../../../../model/feature_model/order/order_kot_model.dart';
import '../../../../utils/helpers/log_helper.dart';

class CustomersKOTController extends GetxController {
  Rxn<Customer> customer = Rxn();
  final LogoLoading loading = LogoLoading();

  var pageState = PageState.LOADING.obs;
  RxList<KitchenOrderTicket> kitchenOrderTicketList = RxList();
  @override
  void onInit() {
    // TODO: implement onInit
    var args = Get.arguments;
    if (args != null) {
      customer.value = args['customer'];
    }
    getCustomerKots();
    super.onInit();
  }

  void getCustomerKots() async {
    kitchenOrderTicketList();
    if (customer.value != null) {
      OrderRepo.getKotsByCustomer(
          customerId: customer.value!.id,
          onSuccess: (customerKots) {
            if (customerKots.isEmpty) {
              pageState.value = PageState.EMPTY;
            } else {
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
}
