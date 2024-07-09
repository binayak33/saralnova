import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Feature/space/space_controller.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/features/screens/Feature/space/add_space_screen.dart';
import 'package:saralnova/features/widgets/app_widgets/space_tile.dart';
import 'package:saralnova/features/widgets/common_widgets/custom_appBar.dart';
import 'package:saralnova/features/widgets/common_widgets/custom_floating_action_button.dart';
import 'package:saralnova/features/widgets/common_widgets/empty_view.dart';
import 'package:saralnova/features/widgets/common_widgets/error_view.dart';
import 'package:saralnova/features/widgets/shimmers/list_shimmer.dart';

import '../../../../core/utils/enums/enums.dart';

class SpaceScreen extends StatelessWidget {
  static const String routeName = "/space-screen";
  final c = Get.find<SpaceController>();
  SpaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SaralNovaApppBar(title: "Space"),
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
                    padding: const EdgeInsets.only(bottom: 60),
                    itemCount: c.spaceList.length,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemBuilder: (context, index) {
                      var space = c.spaceList[index];
                      return SpaceTile(
                        index: index + 1,
                        title: space.name,
                        noOfTables: int.parse(space.tableCount.toString()),
                        desp: space.description,
                        onEdit: () => c.onEditClick(space),
                        onConfirmDelete: () {
                          c.deleteSpace(space.id.toString());
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
          c.crudState.value = CRUDSTATE.ADD;
          Get.toNamed(AddSpaceScreen.routeName);
        },
      ),
    );
  }
}
