import 'package:get/get.dart';
import 'package:saralnova/core/model/feature_model/pos/pending_orders_for_kot_model.dart';
import 'package:saralnova/core/repo/more_repo/pos_repo/pos_repo.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
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

  List<String> selectedMenuItemListId = RxList();
  RxList<PendingOrders> pendingOrders = RxList();

  // void toggleSelection(String menuItemId, PendingOrders pendingOrder) {
  //   if (selectedMenuItemListId.contains(menuItemId)) {
  //     selectedMenuItemListId.remove(menuItemId);
  //   } else {
  //     selectedMenuItemListId.add(menuItemId);
  //   }
  // }

  void toggleSelection(String menuItemId, String orderId) {
    if (lastSelectedOrderId != orderId) {
      selectedMenuItemListId.clear();
      lastSelectedOrderId = orderId;
    }
    if (selectedMenuItemListId.contains(menuItemId)) {
      selectedMenuItemListId.remove(menuItemId);
    } else {
      selectedMenuItemListId.add(menuItemId);
    }
  }

  void clearSelections() {
    selectedMenuItemListId.clear();
    lastSelectedOrderId = null;
  }
  // TODO handle if user didn't select any items then that container must be able to post

  // Future<void> serveKotItems(
  //     {PendingOrders? pOrder, List<String>? menuIds}) async {
  //   // loading.show();

  //   List<String> idsToServe = menuIds ?? selectedMenuItemListId;

  //   print("====ids to serve======>${idsToServe}");

  //   // List<String> matchedIds = [];

  //   // if (pOrder != null) {
  //   //   for (var p in pOrder.items!) {
  //   //     if (idsToServe.contains(p.id)) {
  //   //       matchedIds.add(p.id!);
  //   //     }
  //   //   }
  //   // }
  //   // print("====ids of not selecting to serve======>${menuIds}");

  //   // print("====ids matched to serve======>${matchedIds}");

  //   // await PosRepo.serveKotItems(
  //   //     // kotItemsIds: selectedMenuItemListId ,
  //   //     kotItemsIds: idsToServe,
  //   //     onSuccess: (message) {
  //   //       loading.hide();
  //   //       selectedMenuItemListId.clear();

  //   //       getPendingOrders(); //TODO either update all or insert the response index to that list (api bata bannu parxa)
  //   //       SkySnackBar.success(title: "Kot", message: message);
  //   //     },
  //   //     onError: (message) {
  //   //       loading.hide();

  //   //       SkySnackBar.error(title: "Kot", message: message);
  //   //     });
  // }

  // Future<void> cancelKotItems({List<String>? menuIds}) async {
  //   print(menuIds);
  //   //   loading.show();
  //   //   List<String> idsToCancel = menuIds ?? selectedMenuItemListId;

  //   List<String> idsToCancel = menuIds ?? selectedMenuItemListId;

  //   print("====ids to cancel======>${idsToCancel}");

  //   //   await PosRepo.cancelKotItems(
  //   //       kotItemsIds: idsToCancel,
  //   //       onSuccess: (message) {
  //   //         loading.hide();
  //   //         selectedMenuItemListId.clear();

  //   //         getPendingOrders();
  //   //         SkySnackBar.success(title: "Kot", message: message);
  //   //       },
  //   //       onError: (message) {
  //   //         loading.hide();

  //   //         SkySnackBar.error(title: "Kot", message: message);
  //   //       });
  // }

  Future<void> serveKotItems({PendingOrders? pOrder}) async {
    List<String> matchedIds = [];
    if (selectedMenuItemListId.isNotEmpty) {
      matchedIds.addAll(selectedMenuItemListId);
    } else {
      if (pOrder != null) {
        for (var item in pOrder.items!) {
          if (!item.isCancelled! && !item.isServed! && !item.isPaid!) {
            matchedIds.add(item.id!);
          }
        }
      }
    }

    print("======>${matchedIds}");
    // await PosRepo.serveKotItems(
    //     kotItemsIds: matchedIds,
    //     onSuccess: (message) {
    //       loading.hide();
    //       selectedMenuItemListId.clear();

    //       getPendingOrders(); //TODO either update all or insert the response index to that list (api bata bannu parxa)
    //       SkySnackBar.success(title: "Kot", message: message);
    //     },
    //     onError: (message) {
    //       loading.hide();

    //       SkySnackBar.error(title: "Kot", message: message);
    //     });
  }

  Future<void> cancelKotItems({PendingOrders? pOrder}) async {
    // loading.show();
    List<String> matchedIds = [];
    if (selectedMenuItemListId.isNotEmpty) {
      matchedIds.addAll(selectedMenuItemListId);
    } else {
      if (pOrder != null) {
        for (var item in pOrder.items!) {
          if (!item.isCancelled! && !item.isServed! && !item.isPaid!) {
            matchedIds.add(item.id!);
          }
        }
      }
    }

    print("============${matchedIds}");
    // await PosRepo.cancelKotItems(
    //     kotItemsIds: matchedIds,
    //     onSuccess: (message) {
    //       loading.hide();
    //       selectedMenuItemListId.clear();

    //       getPendingOrders();
    //       SkySnackBar.success(title: "Kot", message: message);
    //     },
    //     onError: (message) {
    //       loading.hide();

    //       SkySnackBar.error(title: "Kot", message: message);
    //     });
  }
}
