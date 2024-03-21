import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Feature/space/space_controller.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/features/screens/Feature/space/add_space_screen.dart';
import 'package:saralnova/features/widgets/common_widgets/custom_alert_dialog.dart';
import 'package:saralnova/features/widgets/common_widgets/empty_view.dart';
import 'package:saralnova/features/widgets/common_widgets/error_view.dart';

import '../../../../core/utils/constants/enums.dart';

class SpaceScreen extends StatelessWidget {
  static const String routeName = "/space-screen";
  final c = Get.find<SpaceController>();
  SpaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Spaces"),
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
      floatingActionButton: InkResponse(
        radius: 20,
        onTap: () {
          c.crudState.value = CRUDSTATE.ADD;
          Get.toNamed(AddSpaceScreen.routeName);
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

class SpaceTile extends StatelessWidget {
  final int index;
  final String? title;
  final int? noOfTables;
  final String? desp;
  final Function() onConfirmDelete;
  final Function() onEdit;
  const SpaceTile({
    super.key,
    required this.index,
    this.title,
    this.noOfTables,
    this.desp,
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
              text: "Title:   ",
              style: CustomTextStyles.f14W400(color: AppColors.borderColor),
              children: [
                TextSpan(text: title ?? "", style: CustomTextStyles.f16W500())
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          RichText(
            text: TextSpan(
              text: "Table Count:   ",
              style: CustomTextStyles.f14W400(color: AppColors.borderColor),
              children: [
                TextSpan(
                    text: noOfTables.toString(),
                    style: CustomTextStyles.f16W500())
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          RichText(
            text: TextSpan(
              text: "Descp. :   ",
              style: CustomTextStyles.f14W400(color: AppColors.borderColor),
              children: [
                TextSpan(text: desp ?? "", style: CustomTextStyles.f16W500())
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
