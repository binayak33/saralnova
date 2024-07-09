import 'package:get/get.dart';
import 'package:saralnova/core/repo/more_repo/pos_repo/pos_repo.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/features/widgets/common_widgets/loading_dialog.dart';

import '../../../../../features/widgets/common_widgets/sky_snack_bar.dart';
import '../../../../model/feature_model/pos/order_customers_model.dart';
import '../../../../model/feature_model/pos/order_kot_model.dart';
import '../../../../utils/helpers/log_helper.dart';

class CustomersKOTController extends GetxController {
  Rxn<Customer> customer = Rxn();
  final LogoLoading loading = LogoLoading();

  var pageState = PageState.LOADING.obs;
  RxList<KitchenOrderTicket> kitchenOrderTicketList = RxList();
  RxnString individualKotName = RxnString();
  @override
  void onInit() {
    // TODO: implement onInit
    var args = Get.arguments;
    if (args != null) {
      customer.value = args['customer'];
      individualKotName.value = args['customer_name'];
    }
    getCustomerKots();
    super.onInit();
  }

  void getCustomerKots() async {
    kitchenOrderTicketList();
    if (customer.value != null) {
      PosRepo.getKotsByCustomer(
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
