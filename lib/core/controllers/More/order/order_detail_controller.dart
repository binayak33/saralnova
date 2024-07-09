import 'package:get/get.dart';
import 'package:saralnova/core/model/feature_model/order/order_model.dart';

class OrderDetailController extends GetxController {
  Rxn<OrderModel> order = Rxn();

  @override
  void onInit() {
    var args = Get.arguments;
    if (args != null) {
      order.value = args['order'];
    }
    super.onInit();
  }
}
