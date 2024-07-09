import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/model/feature_model/activity/acitivity_model.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/features/widgets/common_widgets/error_view.dart';

import '../../../../core/controllers/More/activites/activities_controller.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/enums/enums.dart';
import '../../../widgets/common_widgets/empty_view.dart';

class ActivitiesScreen extends StatelessWidget {
  static const String routeName = "/activities-screen";
  final c = Get.find<ActivitiesController>();
  ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Activities"),
        ),
        body: SingleChildScrollView(
          controller: c.scrollController,
          key: const PageStorageKey("Activities"),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Obx(() {
                  if (c.pageState.value == PageState.LOADING) {
                    return const Center(
                      child: LinearProgressIndicator(),
                    );
                  } else if (c.pageState.value == PageState.EMPTY) {
                    return EmptyView(
                      message: "Empty!!",
                      title: "Empty",
                      media: IconPath.empty,
                      mediaSize: Get.height / 2,
                    );
                  } else if (c.pageState.value == PageState.NORMAL) {
                    return ListView.separated(
                      itemCount: c.activityList.length,
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemBuilder: (context, index) {
                        var activity = c.activityList[index];

                        return ActivityTile(
                          index: index + 1,
                          // date: activity.date,
                          activity: activity,
                          // activities: activity.activities,
                        );
                      },
                    );
                  } else {
                    return const ErrorView(
                      errorTitle: "Something went wrong!!",
                      errorMessage: "Something went wrong",
                      imagePath: IconPath.somethingWentWrong,
                    );
                  }
                }),
                Obx(
                  () => c.nextPageUrl.value != null
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            // child: CircularProgressIndicator(),
                            child: CupertinoActivityIndicator(),
                          ),
                        )
                      : Container(),
                )
              ],
            ),
          ),
        ));
  }
}

class ActivityTile extends StatelessWidget {
  final c = Get.find<ActivitiesController>();
  final int index;
  final Activity activity;

  ActivityTile({
    super.key,
    required this.index,
    required this.activity,
  });

  @override
  Widget build(BuildContext context) {
    double parentWidth = MediaQuery.of(context).size.width;
    return Container(
      width: parentWidth,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.borderColor),
          color: AppColors.scaffoldColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "S.N: $index ",
                    style:
                        CustomTextStyles.f12W400(color: AppColors.blackColor),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Date: ",
                        style: CustomTextStyles.f14W400(
                            color: AppColors.borderColor),
                      ),
                      Text(
                        activity.date ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyles.f14W400(
                            color: AppColors.blackColor),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  if (activity.activities!.isNotEmpty) // no need to check null
                    SizedBox(
                      // height: 200,
                      width: parentWidth * 0.85, //TODO width fix
                      child: ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 6,
                          );
                        },
                        itemCount: activity.activities!.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var activitiesData = activity.activities![index];

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  c.showStatusTypeIcon(activitiesData),
                                  // if (activitiesData.description ==
                                  //     "Customer checkout")
                                  //   SvgPicture.asset(
                                  //     IconPath.orderCheckout,
                                  //     height: 20,
                                  //     width: 20,
                                  //   ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          activitiesData.description ?? "",
                                          overflow: TextOverflow.ellipsis,
                                          style: CustomTextStyles.f16W600(
                                              color: AppColors.primary),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        if (activitiesData
                                                .properties?.remarks !=
                                            null)
                                          FittedBox(
                                            child: Text(
                                              activitiesData
                                                      .properties?.remarks ??
                                                  "",
                                              overflow: TextOverflow.ellipsis,
                                              style: CustomTextStyles.f13W400(
                                                  color: AppColors.blackColor),
                                            ),
                                          ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
