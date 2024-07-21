import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/pos/table_pos_controller.dart';
import 'package:saralnova/core/model/feature_model/tables/available_table_by_space_model.dart';
import 'package:saralnova/core/model/feature_model/tables/table_model.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/core/utils/constants/image_path.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/features/screens/Dashboard/pos/table/merged_table_view_screen.dart';
import 'package:saralnova/features/widgets/common_widgets/empty_view.dart';
import 'package:saralnova/features/widgets/common_widgets/error_view.dart';
import 'package:saralnova/features/widgets/shimmers/list_shimmer.dart';

class TablesScreenPOS extends StatelessWidget {
  static const String routeName = "/available-table-by-space";
  final c = Get.find<TablesPosController>();
  TablesScreenPOS({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text("Tables"),
        actions: [
          PopupMenuButton(
            surfaceTintColor: AppColors.fillFadedColor,
            icon: const Icon(
              Icons.more_vert,
              color: AppColors.textColor,
            ),
            onSelected: (value) {
              // your logic
            },
            itemBuilder: (BuildContext bc) {
              return [
                PopupMenuItem(
                  onTap: () {},
                  value: '/hello',
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Occupied",
                            style: CustomTextStyles.f14W400(),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Container(
                            height: 10,
                            width: 10,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.errorAccent,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Available",
                            style: CustomTextStyles.f14W400(),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Container(
                            height: 10,
                            width: 10,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.bookingColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Unavailable",
                            style: CustomTextStyles.f14W400(),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Container(
                            height: 10,
                            width: 10,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.reservedColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  onTap: () {
                    c.selectedTableList.clear();
                  },
                  value: '/hello',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Clear selected",
                        style: CustomTextStyles.f14W400(),
                      ),
                      SvgPicture.asset(IconPath.clear)
                    ],
                  ),
                ),
                // PopupMenuItem(
                //   onTap: () {
                //     Get.toNamed(MergeTableScreen.routeName);
                //   },
                //   value: '/hello',
                //   child: Text(
                //     "Merge Tables",
                //     style: CustomTextStyles.f14W400(),
                //   ),
                // ),
                PopupMenuItem(
                  onTap: () {
                    Get.toNamed(MergedTableViewScreen.routeName);
                  },
                  value: '/hello',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "See merged tables",
                        style: CustomTextStyles.f14W400(),
                      ),
                      SvgPicture.asset(
                        IconPath.merged,
                        height: 20,
                        width: 20,
                      )
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Obx(() {
                if (c.pageState.value == PageState.LOADING) {
                  return SaralNovaShimmer.menuGridShimmer();
                } else if (c.pageState.value == PageState.EMPTY) {
                  return EmptyView(
                    message: "No data available",
                    title: "No Data",
                    media: IconPath.nodata,
                  );
                } else if (c.pageState.value == PageState.NORMAL) {
                  return Obx(
                    () => ListView.separated(
                      padding: const EdgeInsets.only(bottom: 100),
                      key: const PageStorageKey("tablePos"),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemCount: c.availableTablesBySpace.length,
                      itemBuilder: (context, index) {
                        var availabTableBySpace =
                            c.availableTablesBySpace[index];

                        return TableWidget(
                          availableTableBySpace: availabTableBySpace,
                          ontap: (tableModel) {
                            c.toggleSelectionTable(tableModel);
                          },
                          selectedTableList: c.selectedTableList,
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
      floatingActionButton: Obx(() {
        if (c.selectedTableList.length >= 2) {
          return FloatingActionButton(
            onPressed: () {
              c.mergeTable();
            },
            child: Text(
              "Merge",
              style: CustomTextStyles.f16W600(
                  color: AppColors.splashBackgroundColor),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      }),
    );
  }
}

class TableWidget extends StatelessWidget {
  final AvailableTableBySpace availableTableBySpace;
  final Function(TableModel tableModel)? ontap;
  final RxList<TableModel> selectedTableList;

  const TableWidget({
    super.key,
    required this.availableTableBySpace,
    this.ontap,
    required this.selectedTableList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          availableTableBySpace.spaceName ?? "",
          style: CustomTextStyles.f14W500(color: AppColors.textColor),
        ),
        const SizedBox(
          height: 4,
        ),
        if (availableTableBySpace.tables != null &&
            availableTableBySpace.tables!.isNotEmpty)
          GridView.builder(
            key: const PageStorageKey("tables"),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
            ),
            itemCount: availableTableBySpace.tables!.length,
            itemBuilder: (context, index) {
              var table = availableTableBySpace.tables![index];

              Color color;
              if (table.status == "Occupied") {
                color = AppColors.errorAccent;
              } else if (table.status == "Available") {
                color = AppColors.bookingColor;
              } else {
                color = AppColors.reservedColor;
              }

              return Obx(() {
                var isSelected = selectedTableList.contains(table);
                var hasSelectedTable = selectedTableList.isNotEmpty;
                var isDisabled =
                    hasSelectedTable && table.mergedMain == true && !isSelected;

                return GestureDetector(
                    onTap: () {
                      if (ontap != null &&
                          table.status != "Unavailable" &&
                          !table.mergedChild! &&
                          !isDisabled) {
                        ontap!(table);
                      }
                    },
                    child: Container(
                      // padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: color,
                          border: Border.all(
                            width: 2,
                            color: isSelected
                                ? AppColors.orangeColor
                                : AppColors.borderColor,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: Stack(alignment: Alignment.center, children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            if (table.status == "Occupied")
                              Image.asset(
                                ImagePath.fullDining,
                                fit: BoxFit.cover,
                                height: 50,
                                width: 50,
                              ),
                            if (table.status == "Available")
                              Image.asset(
                                ImagePath.dining,
                                fit: BoxFit.cover,
                                height: 50,
                                width: 50,
                              ),
                            if (table.status == "Unavailable")
                              Image.asset(
                                ImagePath.dining,
                                fit: BoxFit.cover,
                                height: 50,
                                width: 50,
                              ),
                            Text(
                              table.name ?? "",
                              style: CustomTextStyles.f14W500(
                                  color: AppColors.primary),
                            ),
                            if (table.capacity != null)
                              Text(
                                "capacity: ${table.capacity.toString()}",
                                style: CustomTextStyles.f10W400(
                                    color: AppColors.blackColor),
                              ),
                            if (table.mergedMessage != null)
                              FittedBox(
                                child: Text(
                                  table.mergedMessage ?? "",
                                  style: CustomTextStyles.f10W400(
                                      color: AppColors.blackColor),
                                ),
                              ),
                          ],
                        ),
                        if (table.mergedMain == true)
                          Positioned(
                              top: 0,
                              right: 0,
                              child: SvgPicture.asset(
                                IconPath.mergeMain,
                                height: 20,
                                width: 20,
                              )),
                        if (table.mergedChild == true)
                          Positioned(
                              top: 0,
                              right: 0,
                              child: SvgPicture.asset(
                                IconPath.mergedTable,
                                height: 20,
                                width: 20,
                              ))
                      ]),
                    ));
              });
            },
          )
      ],
    );
  }
}
