import 'package:get/get.dart';
import 'package:saralnova/core/repo/feature_repo/order_repo/order_repo.dart';
import 'package:saralnova/core/utils/helpers/log_helper.dart';
import 'package:saralnova/features/widgets/common_widgets/loading_dialog.dart';

import '../../../../model/feature_model/order/order_customers_model.dart';
import '../../../../utils/enums/enums.dart';

class CustomerOrderController extends GetxController {
  final LogoLoading loading = LogoLoading();

  RxList<Customer> customerList = RxList();
  var pageState = PageState.LOADING.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    getAllCustomers();
    super.onInit();
  }

  void getAllCustomers() async {
    customerList.clear();
    OrderRepo.getAllOrdersByCustomers(onSuccess: (customersData) {
      if (customersData.isEmpty) {
        pageState.value = PageState.EMPTY;
      } else {
        customerList.addAll(customersData);
        pageState.value = PageState.NORMAL;
      }
    }, onError: (message) {
      pageState.value = PageState.ERROR;
      LogHelper.error(message);
    });
  }
}
