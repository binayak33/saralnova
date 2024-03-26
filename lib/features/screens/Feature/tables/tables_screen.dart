import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/features/screens/Feature/tables/add_tables_screen.dart';
import 'package:saralnova/features/widgets/common_widgets/custom_alert_dialog.dart';
import 'package:saralnova/features/widgets/common_widgets/empty_view.dart';
import 'package:saralnova/features/widgets/common_widgets/error_view.dart';

import '../../../../core/controllers/Feature/table/table_controller.dart';
import '../../../../core/utils/constants/colors.dart';

class TablesScreen extends StatelessWidget {
  static const String routeName = "/table-screen";
  final c = Get.find<TableController>();
  TablesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Table"),
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
                    itemCount: c.tablesList.length,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemBuilder: (context, index) {
                      var table = c.tablesList[index];
                      return TableTile(
                        index: index + 1,
                        tableName: table.name,
                        capacity: int.parse(
                          table.capacity.toString(),
                        ),
                        status: table.status,
                        space: table.spaceName,
                        onEdit: () => c.onEditClick(table),
                        onConfirmDelete: () {
                          c.deleteTable(table.id.toString());
                        },
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
      ),
      floatingActionButton: InkResponse(
        radius: 20,
        onTap: () {
          c.statusController.clear();
          c.spaceController.clear();
          c.crudState.value = CRUDSTATE.ADD;
          Get.toNamed(AddTablesScreen.routeName);
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: AppColors.primary,
          ),
          child: Text(
            "Create",
            style: CustomTextStyles.f16W600(
              color: AppColors.scaffoldColor,
            ),
          ),
        ),
      ),
    );
  }
}

class TableTile extends StatelessWidget {
  final int index;
  final String? tableName;
  final String? space;
  final num? capacity;
  final String? status;
  final Function() onConfirmDelete;
  final Function() onEdit;
  const TableTile({
    super.key,
    required this.index,
    this.tableName,
    this.space,
    this.capacity,
    this.status,
    required this.onConfirmDelete,
    required this.onEdit,
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
          Text(
            "S.N: $index ",
            style: CustomTextStyles.f12W400(color: AppColors.blackColor),
          ),
          const SizedBox(
            height: 8,
          ),
          RichText(
            text: TextSpan(
              text: "Table Name:   ",
              style: CustomTextStyles.f14W400(color: AppColors.borderColor),
              children: [
                TextSpan(
                    text: tableName ?? "", style: CustomTextStyles.f16W500())
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          RichText(
            text: TextSpan(
              text: "Space:   ",
              style: CustomTextStyles.f14W400(color: AppColors.borderColor),
              children: [
                TextSpan(text: space ?? "", style: CustomTextStyles.f16W500())
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          RichText(
            text: TextSpan(
              text: "Status:   ",
              style: CustomTextStyles.f14W400(color: AppColors.borderColor),
              children: [
                TextSpan(text: status ?? "", style: CustomTextStyles.f16W500())
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          RichText(
            text: TextSpan(
              text: "Capcaity. :   ",
              style: CustomTextStyles.f14W400(color: AppColors.borderColor),
              children: [
                TextSpan(
                    text: capacity.toString(),
                    style: CustomTextStyles.f16W500())
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: AppColors.orangeColor,
                child: IconButton(
                  onPressed: onEdit,
                  icon: SvgPicture.asset(
                    IconPath.edit,
                    height: 18,
                    width: 18,
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              CircleAvatar(
                  radius: 15,
                  backgroundColor: AppColors.errorColor,
                  child: IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext ctx) {
                            return CustomAlertDialog(
                                title: "Do you really want to delete ?",
                                message: "You cannot undo this action",
                                onConfirm: onConfirmDelete,
                                confirmText: "Yes");
                          });
                    },
                    icon: SvgPicture.asset(
                      IconPath.delete,
                      colorFilter:
                          const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
