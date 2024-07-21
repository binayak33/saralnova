import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/pos/merged_table_manage_controller.dart';
import 'package:saralnova/core/model/feature_model/tables/merge_table_model.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/features/widgets/common_widgets/empty_view.dart';
import 'package:saralnova/features/widgets/common_widgets/error_view.dart';
import 'package:saralnova/features/widgets/shimmers/list_shimmer.dart';

class MergedTableViewScreen extends StatelessWidget {
  static const String routeName = "/view-merged-tables";
  final c = Get.find<MergedTableManageController>();
  MergedTableViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Merged tables"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                if (c.pageState.value == PageState.LOADING) {
                  return SaralNovaShimmer.listShimmerheigh75();
                } else if (c.pageState.value == PageState.EMPTY) {
                  return EmptyView(
                    message: "No merged tables at the moment.",
                    title: "No data",
                    media: IconPath.nodata,
                    mediaSize: 400,
                  );
                } else if (c.pageState.value == PageState.NORMAL) {
                  return Obx(
                    () => ListView.separated(
                      separatorBuilder: (context, index) {
                        return const Divider(
                          height: 30,
                          color: AppColors.hintTextColor,
                        );
                      },
                      key: const PageStorageKey("merged tables"),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: c.mergedTableList.length,
                      itemBuilder: (context, index) {
                        var table = c.mergedTableList[index];

                        return MergedTableWidget(
                          mergeTable: table,
                          onCancel: (tableId) {
                            c.unMergeTable(tableId);
                          },
                        );
                      },
                    ),
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
      ),
    );
  }
}

class MergedTableWidget extends StatelessWidget {
  final MergeTable mergeTable;
  final Function(String tableId)? onCancel;
  const MergedTableWidget({
    super.key,
    this.onCancel,
    required this.mergeTable,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              mergeTable.mergeName ?? "",
              style: CustomTextStyles.f16W500(),
            ),
            InkResponse(
              onTap: () {
                if (onCancel != null) {
                  onCancel!(mergeTable.tableId!);
                }
              },
              child: SvgPicture.asset(
                IconPath.circleCross,
                height: 20,
                width: 20,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        if (mergeTable.tables != null && mergeTable.tables!.isNotEmpty)
          GridView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10),
            key: const PageStorageKey("merge tables"),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
            ),
            itemCount: mergeTable.tables!.length,
            itemBuilder: (context, index) {
              var mTable = mergeTable.tables![index];

              return Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: AppColors.fillFadedColor,
                    border: Border.all(color: AppColors.fillColor),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      mTable.name ?? "",
                      style:
                          CustomTextStyles.f14W500(color: AppColors.textColor),
                    ),
                    if (mTable.status != null)
                      Text(
                        "${mTable.status.toString()}",
                        style: CustomTextStyles.f10W400(
                            color: AppColors.blackColor),
                      ),
                  ],
                ),
              );
            },
          )
      ],
    );
  }
}
