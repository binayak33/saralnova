import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/pos/table_pos_controller.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/features/screens/More/pos/tables_POS_screen.dart';
import 'package:saralnova/features/widgets/common_widgets/empty_view.dart';
import 'package:saralnova/features/widgets/common_widgets/error_view.dart';
import 'package:saralnova/features/widgets/shimmers/list_shimmer.dart';

class MergeTableScreen extends StatelessWidget {
  static const String routeName = "/manage-table";
  final c = Get.find<TablesPosController>();
  MergeTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: const Text("Manage Tables"),
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Obx(() {
                if (c.pageState.value == PageState.LOADING) {
                  return Expanded(child: SaralNovaShimmer.menuGridShimmer());
                } else if (c.pageState.value == PageState.EMPTY) {
                  return EmptyView(
                    message: "No data available",
                    title: "No Data",
                    media: IconPath.nodata,
                  );
                } else if (c.pageState.value == PageState.NORMAL) {
                  return Obx(
                    () => ListView.separated(
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
