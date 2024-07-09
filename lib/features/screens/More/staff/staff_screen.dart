import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/More/staff/staff_controller.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/features/widgets/app_widgets/hotel_feature_widget.dart';
import 'package:saralnova/features/widgets/common_widgets/custom_floating_action_button.dart';
import 'package:saralnova/features/widgets/common_widgets/empty_view.dart';
import 'package:saralnova/features/widgets/common_widgets/error_view.dart';
import 'package:saralnova/features/widgets/shimmers/list_shimmer.dart';

class StaffScreen extends StatelessWidget {
  static const String routeName = "/staff-screen";
  final c = Get.find<StaffController>();
  StaffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(
          color: AppColors.scaffoldColor, //change your color here
        ),
        centerTitle: true,
        title: Text(
          "Staff",
          style: CustomTextStyles.f16W600(color: AppColors.scaffoldColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Obx(() {
                if (c.pageState.value == PageState.LOADING) {
                  return SaralNovaShimmer.listShimmerheigh50();
                } else if (c.pageState.value == PageState.EMPTY) {
                  return EmptyView(
                    message: "Empty!!",
                    title: "Empty",
                    media: IconPath.empty,
                    mediaSize: Get.height / 2,
                  );
                } else if (c.pageState.value == PageState.NORMAL) {
                  return ListView.builder(
                    itemCount: c.staffList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var staff = c.staffList[index];
                      return Container(
                        decoration: BoxDecoration(
                            color: AppColors.splashBackgroundColor,
                            borderRadius: BorderRadius.circular(4)),
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Slidable(
                            key: ValueKey(index),
                            endActionPane: ActionPane(
                              extentRatio: 0.5,
                              motion: ScrollMotion(),
                              children: [
                                SlidableAction(
                                  padding: EdgeInsets.zero,
                                  onPressed: (value) {
                                    // c.updateIndex.value = staff.id.toString();
                                    c.staff.value = staff;
                                    c.crudState.value = CRUDSTATE.UPDATE;
                                    c.nameController.text =
                                        staff.name.toString();

                                    c.emailController.text =
                                        staff.email.toString();
                                    c.userNameController.text =
                                        staff.username.toString();
                                    c.openStaffBottomSheet();
                                  },
                                  backgroundColor: AppColors.orangeColor,
                                  foregroundColor: Colors.white,
                                  icon: Icons.edit,
                                  label: 'Edit',
                                ),
                                SlidableAction(
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(4),
                                    bottomRight: Radius.circular(4),
                                  ),
                                  padding: EdgeInsets.zero,
                                  onPressed: (value) {
                                    c.deleteStaff(staff.id!);
                                  },
                                  backgroundColor: AppColors.errorColor,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                              ],
                            ),
                            child: HotelFeatureWidget(
                              title: staff.name,
                            )),
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
          c.openStaffBottomSheet();
        },
      ),
    );
  }
}
