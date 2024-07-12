import 'package:get/get.dart';
import 'package:saralnova/core/model/feature_model/pos/pending_orders_for_kot_model.dart';
import 'package:saralnova/core/repo/more_repo/pos_repo/pos_repo.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_snack_bar.dart';

class PendingOrderController extends GetxController {
  RxList<PendingOrders> pendingOrders = RxList();

  var pageState = PageState.LOADING.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getPendingOrders();
    super.onInit();
  }

  Future<void> getPendingOrders() async {
    pageState.value = PageState.LOADING;

    await PosRepo.getKOTorders(onSuccess: (pendingOrders) {
      if (pendingOrders.isNotEmpty) {
        this.pendingOrders.clear();
        this.pendingOrders.addAll(pendingOrders);
        pageState.value = PageState.NORMAL;
      } else {
        pageState.value = PageState.EMPTY;
      }
    }, onError: (message) {
      pageState.value = PageState.ERROR;

      SkySnackBar.error(title: "Pending Order", message: message);
    });
  }
}
