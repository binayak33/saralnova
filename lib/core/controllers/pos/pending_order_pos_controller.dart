import 'package:get/get.dart';
import 'package:saralnova/core/model/feature_model/pos/pending_orders_for_kot_model.dart';
import 'package:saralnova/core/repo/more_repo/pos_repo/pos_repo.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/core/utils/helpers/log_helper.dart';
import 'package:saralnova/features/widgets/common_widgets/loading_dialog.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_snack_bar.dart';

class PendingOrderController extends GetxController {
  var pageState = PageState.LOADING.obs;
  final LogoLoading loading = LogoLoading();

  @override
  void onInit() {
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

  String? lastSelectedOrderId;

  // List<String> selectedMenuItemListId = RxList();
  RxList<PendingOrders> pendingOrders = RxList();

  RxMap<String, List<String>> selectedItems = <String, List<String>>{}.obs;

  void toggleSelection(String orderId, String menuItemId) {
    if (selectedItems.containsKey(orderId)) {
      if (selectedItems[orderId]!.contains(menuItemId)) {
        selectedItems[orderId]!.remove(menuItemId);
      } else {
        selectedItems[orderId]!.add(menuItemId);
      }
    } else {
      selectedItems[orderId] = [menuItemId];
    }

    // Explicitly notify observers of the change
    selectedItems.refresh();
  }

  void clearSelections() {
    selectedItems.clear();
  }

  Future<void> serveKotItems({
    PendingOrders? pOrder,
    required List<String> kotItemsIds,
  }) async {
    loading.show();
    List<String> allMenuItemsIdsOfpOrder = [];
    if (kotItemsIds.isEmpty) {
      if (pOrder != null) {
        if (pOrder.items != null && pOrder.items!.isNotEmpty) {
          // for (var i in pOrder.items!) {
          //   allMenuItemsIdsOfpOrder.add(i.id!);
          // }
          for (var i in pOrder.items!) {
            if (!(i.isCancelled ?? false) &&
                !(i.isPaid ?? false) &&
                !(i.isServed ?? false)) {
              allMenuItemsIdsOfpOrder.add(i.id!);
            }
          }
        }
      }
    }

    LogHelper.warning("===kotItemsSelected========>${kotItemsIds}");

    LogHelper.warning(
        "===kotItems--NotSelected========>${allMenuItemsIdsOfpOrder}");
    await PosRepo.serveKotItems(
        kotItemsIds:
            kotItemsIds.isEmpty ? allMenuItemsIdsOfpOrder : kotItemsIds,
        onSuccess: (message) {
          loading.hide();
          getPendingOrders();
          selectedItems.clear();
          SkySnackBar.success(title: "KOT order", message: message);
        },
        onError: (message) {
          loading.hide();

          SkySnackBar.success(title: "KOT order", message: message);
        });
  }

  Future<void> cancelKotItems({
    PendingOrders? pOrder,
    required List<String> kotItemsIds,
  }) async {
    loading.show();
    List<String> allMenuItemstoCancelpOrder = [];
    if (kotItemsIds.isEmpty) {
      if (pOrder != null) {
        if (pOrder.items != null && pOrder.items!.isNotEmpty) {
          // for (var i in pOrder.items!) {
          //   allMenuItemsIdsOfpOrder.add(i.id!);
          // }
          for (var i in pOrder.items!) {
            if (!(i.isCancelled ?? false) &&
                !(i.isPaid ?? false) &&
                !(i.isServed ?? false)) {
              allMenuItemstoCancelpOrder.add(i.id!);
            }
          }
        }
      }
    }

    LogHelper.warning("===kotItemsSelected========>${kotItemsIds}");

    LogHelper.warning(
        "===kotItems--NotSelected========>${allMenuItemstoCancelpOrder}");
    await PosRepo.cancelKotItems(
        kotItemsIds:
            kotItemsIds.isEmpty ? allMenuItemstoCancelpOrder : kotItemsIds,
        onSuccess: (message) {
          loading.hide();
          getPendingOrders();
          selectedItems.clear();
          SkySnackBar.info(title: "KOT order", message: message);
        },
        onError: (message) {
          loading.hide();

          SkySnackBar.success(title: "KOT order", message: message);
        });
  }
}
