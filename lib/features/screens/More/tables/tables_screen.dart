import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/features/screens/More/tables/add_tables_screen.dart';
import 'package:saralnova/features/widgets/app_widgets/tables_tile.dart';
import 'package:saralnova/features/widgets/common_widgets/custom_appBar.dart';
import 'package:saralnova/features/widgets/common_widgets/custom_floating_action_button.dart';
import 'package:saralnova/features/widgets/common_widgets/empty_view.dart';
import 'package:saralnova/features/widgets/common_widgets/error_view.dart';
import 'package:saralnova/features/widgets/shimmers/list_shimmer.dart';

import '../../../../core/controllers/More/table/table_controller.dart';

class TablesScreen extends StatelessWidget {
  static const String routeName = "/table-screen";
  final c = Get.find<TableController>();
  TablesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SaralNovaApppBar(title: "Table"),
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
                  return SaralNovaShimmer.bookingShimmer();
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
                    padding: const EdgeInsets.only(bottom: 70),
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
                        space: table.space?.name,
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
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          c.nameController.clear();
          c.capcityController.clear();
          c.statusController.clear();
          c.spaceController.clear();
          c.crudState.value = CRUDSTATE.ADD;
          Get.toNamed(AddTablesScreen.routeName);
        },
      ),
    );
  }
}
