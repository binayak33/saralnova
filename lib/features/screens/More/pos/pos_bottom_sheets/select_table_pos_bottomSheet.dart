import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/More/table/table_controller.dart';
import 'package:saralnova/core/model/feature_model/tables/table_model.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/features/widgets/common_widgets/empty_view.dart';
import 'package:saralnova/features/widgets/common_widgets/error_view.dart';

class SelectAvailableTableBottomSheet extends StatelessWidget {
  final c = Get.put(TableController());
  final Function(TableModel table) onSelectAvailableTable;
  SelectAvailableTableBottomSheet({
    super.key,
    required this.onSelectAvailableTable,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Text(
                "Select Available Table",
                style: CustomTextStyles.f16W600(color: AppColors.blackColor),
              ),
              GestureDetector(
                onTap: () {
                  c.getAllAvailableTables(); //TODO animation of reloading here
                },
                child: SvgPicture.asset(
                  IconPath.reload,
                  height: 20,
                  width: 20,
                ),
              ),
            ],
          ),
          const Divider(
            color: AppColors.borderColor,
            endIndent: 10,
            indent: 10,
            height: 20,
          ),
          // Obx(() {
          //   if (c.availableTableList.isEmpty) {
          //     return const LinearProgressIndicator();
          //   } else {
          //     return Expanded(
          //       child: ListView.builder(
          //         shrinkWrap: true,
          //         physics: const ClampingScrollPhysics(),
          //         itemCount: c.availableTableList.length,
          //         itemBuilder: (context, index) {
          //           var avTable = c.availableTableList[index];
          //           return ListTile(
          //             onTap: () {
          //               Navigator.of(context).pop();
          //               onSelectAvailableTable(avTable);
          //             },
          //             title: Text(
          //               avTable.name ?? "",
          //               style: CustomTextStyles.f16W400(),
          //             ),
          //             dense: true,
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(10),
          //             ),
          //             tileColor: AppColors.errorColor,
          //             selected: true,
          //             style: ListTileStyle.drawer,
          //           );
          //         },
          //       ),
          //     );
          //   }
          // })

          Obx(() {
            if (c.pageState.value == PageState.LOADING) {
              return const LinearProgressIndicator();
            } else if (c.pageState.value == PageState.EMPTY) {
              return EmptyView(
                  mediaSize: 100,
                  media: IconPath.nodata,
                  message: "No data available",
                  title: "No Data");
            } else if (c.pageState.value == PageState.NORMAL) {
              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: c.availableTableList.length,
                  itemBuilder: (context, index) {
                    var avTable = c.availableTableList[index];
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).pop();
                        onSelectAvailableTable(avTable);
                      },
                      title: Text(
                        avTable.name ?? "",
                        style: CustomTextStyles.f16W400(),
                      ),
                      dense: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      tileColor: AppColors.errorColor,
                      selected: true,
                      style: ListTileStyle.drawer,
                    );
                  },
                ),
              );
            } else {
              return const ErrorView(
                imagePath: IconPath.somethingWentWrong,
                errorMessage: "Something went wrong",
              );
            }
          })
        ],
      ),
    );
  }
}
