import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/model/feature_model/activity/acitivity_model.dart';
import 'package:saralnova/core/repo/feature_repo/activity_repo.dart';
import 'package:saralnova/core/utils/helpers/log_helper.dart';
import 'package:saralnova/features/widgets/common_widgets/loading_dialog.dart';

import '../../../utils/constants/icon_path.dart';
import '../../../utils/enums/enums.dart';

class ActivitiesController extends GetxController {
  final LogoLoading loading = LogoLoading();
  var crudState = CRUDSTATE.ADD.obs;
  var pageState = PageState.LOADING.obs;

  RxList<Activity> activityList =
      RxList(); //this list has date and teh activities
  RxBool isLoadingMore = RxBool(false);
  RxnString nextPageUrl = RxnString();
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    getRestaurantActivities();
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
            getRestaurantActivities(loadMore: true);
          }
        }
      },
    );
  }

  void getRestaurantActivities({bool loadMore = false}) async {
    if (!loadMore) {
      activityList.clear();
    } else {
      isLoadingMore.value = true;
    }

    ActivityRepo.getAllActivities(
      nextPageUrl: nextPageUrl.value,
      onSuccess: (activityList, nextPageUrl) {
        if (activityList.isEmpty) {
          pageState.value = PageState.EMPTY;
        } else {
          pageState.value = PageState.NORMAL;
          this.activityList.addAll(activityList);

          this.nextPageUrl.value = nextPageUrl;
          isLoadingMore.value = false;
        }
      },
      onError: (message) {
        pageState.value = PageState.ERROR;
        LogHelper.error(message);
        isLoadingMore.value = false;
      },
    );
  }

  Widget showStatusTypeIcon(Activities activitiesData) {
    switch (activitiesData.description) {
      case "Order recieved":
        return SizedBox(
          height: 25,
          width: 25,
          child: SvgPicture.asset(
            IconPath.orderReceived,
          ),
        ); // IconPath.orderCheckout,

      case "Customer checkout":
        return SvgPicture.asset(
          IconPath.orderCheckout,
          height: 25,
          width: 25,
        );
      case "Just created a dish":
        return SvgPicture.asset(
          IconPath.justCteatedDish,
          height: 25,
          width: 25,
        );
      case "Bill deleted":
        return SvgPicture.asset(
          IconPath.billDelete,
          height: 25,
          width: 25,
        );
      case "Order cancelled":
        return SvgPicture.asset(
          IconPath.billCancel,
          height: 25,
          width: 25,
        );
      case "Order item cancelled":
        return SvgPicture.asset(
          IconPath.cut,
          height: 20,
          width: 20,
        );
      default:
        return SvgPicture.asset(
          IconPath.check,
          height: 25,
          width: 25,
        );
    }
  }
}
