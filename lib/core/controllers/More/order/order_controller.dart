import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/repo/more_repo/order_repo.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/core/utils/helpers/log_helper.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_snack_bar.dart';

import '../../../model/feature_model/order/order_model.dart';

class OrderController extends GetxController {
  RxList<OrderModel> orders = RxList();
  var pageState = PageState.LOADING.obs;

  @override
  void onInit() {
    getOrders();
    initScrollListener();

    super.onInit();
  }

  initScrollListener() {
    scrollController.addListener(
      () {
        if (scrollController.offset >=
                scrollController.position.maxScrollExtent &&
            !scrollController.position.outOfRange) {
          LogHelper.debug("Scroll end reached");
          if (nextPageUrl.value != null && !isLoadingMore.value) {
            getOrders(loadMore: true);
          }
        }
      },
    );
  }

  RxnString nextPageUrl = RxnString();
  final ScrollController scrollController = ScrollController();
  RxBool isLoadingMore = RxBool(false);

  Future<void> getOrders({bool loadMore = false}) async {
    orders.clear();
    if (!loadMore) {
      orders.clear();
    } else {
      isLoadingMore.value = true;
    }
    pageState.value = PageState.LOADING;
    await OrderRepo.getAllCheckedOutOrders(
        nextPageUrl: nextPageUrl.value,
        onSuccess: (checkedOutOrders, nextPageUrl) {
          if (checkedOutOrders.isEmpty) {
            pageState.value = PageState.EMPTY;
          } else {
            orders.addAll(checkedOutOrders);

            pageState.value = PageState.NORMAL;
            this.nextPageUrl.value = nextPageUrl;
            isLoadingMore.value = false;
          }
        },
        onError: (message) {
          pageState.value = PageState.ERROR;
          isLoadingMore.value = false;

          SkySnackBar.error(title: "Order", message: message);
        });
  }
}
