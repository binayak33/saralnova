import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/model/feature_model/activity/acitivity_model.dart';
import 'package:saralnova/core/repo/feature_repo/activity_repo.dart';
import 'package:saralnova/core/utils/helpers/log_helper.dart';
import 'package:saralnova/features/widgets/common_widgets/loading_dialog.dart';

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

  // void getRestaurantActivities() async {
  //         activityList.clear();
  //   ActivityRepo.getAllActivities(
  //     onSuccess: (activityList, nextPageUrl) {
  //       if (activityList.isEmpty) {
  //         pageState.value = PageState.EMPTY;
  //       } else {
  //         pageState.value = PageState.NORMAL;
  //         activityList.addAll(activityList);

  //         this.nextPageUrl.value = nextPageUrl;
  //         isLoadingMore.value = false;
  //       }
  //     },
  //     onError: (message) {
  //       pageState.value = PageState.ERROR;
  //       LogHelper.error(message);
  //       isLoadingMore.value = false;
  //     },
  //   );
  // }
}
