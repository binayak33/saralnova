import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/model/feature_model/activity/acitivity_model.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/features/widgets/common_widgets/error_view.dart';

import '../../../../core/controllers/Feature/activites/activities_controller.dart';
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
          actions: [
            IconButton(
                onPressed: () {
                  print(c.activityList);
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: SingleChildScrollView(
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
                })
              ],
            ),
          ),
        ));
  }
}

class ActivityTile extends StatelessWidget {
  final int index;
  final Activity activity;

  const ActivityTile({
    super.key,
    required this.index,
    required this.activity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40,
                      width: 100, //make dynamic width
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.blackColor),
                          borderRadius: BorderRadius.circular(10)),
                      child: Expanded(
                        child: ListView.builder(
                          itemCount: 4,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Text("hahahha");
                          },
                        ),
                      ),
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
