import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/model/user_model.dart';
import 'package:saralnova/core/repo/feature_repo/staff_repo.dart';
import 'package:saralnova/core/utils/helpers/log_helper.dart';
import 'package:saralnova/features/screens/Feature/staff/add_staff_screen.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_snack_bar.dart';

import '../../../../features/widgets/common_widgets/loading_dialog.dart';
import '../../../model/feature_model/staff_model.dart';
import '../../../utils/enums/enums.dart';

class StaffController extends GetxController {
  final LogoLoading loading = LogoLoading();
  final staffKey = GlobalKey<FormState>();

  RxList<Staff> staffList = RxList();
  var crudState = CRUDSTATE.ADD.obs;
  var pageState = PageState.LOADING.obs;

  final nameController = TextEditingController();
  final emailController = TextEditingController();

  final userNameController = TextEditingController();

  final passwordController = TextEditingController();

  // RxnString updateIndex = RxnString();

  Rxn<Staff> staff = Rxn();

  @override
  void onInit() {
    getStaffs();
    super.onInit();
  }

  void getStaffs() async {
    staffList.clear();
    StaffRepo.getStaff(
      onSuccess: (staffs) {
        if (staffs.isEmpty) {
          pageState.value = PageState.EMPTY;
        } else {
          staffList.addAll(staffs);
          pageState.value = PageState.NORMAL;
        }
      },
      onError: (message) {
        pageState.value = PageState.ERROR;
        LogHelper.error(message);
      },
    );
  }

  openStaffBottomSheet() async {
    showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AddStaffScreen(),
        );
      },
    );
  }

  void storeStaff() async {
    if (staffKey.currentState!.validate()) {
      loading.show();
      var user = User(
        name: nameController.text,
        email: emailController.text,
        username: userNameController.text,
      );
      await StaffRepo.storeStaff(
        user: user,
        password: passwordController.text,
        onSuccess: (staff) {
          loading.hide();
          //TODO show page state so that loader will be displayed
          getStaffs();
          nameController.clear();
          emailController.clear();
          userNameController.clear();
          Get.back();
        },
        onError: (message) {
          loading.hide();

          SkySnackBar.error(title: "Staff", message: message);
        },
      );
    }
  }

  void updateStaff() async {
    if (staffKey.currentState!.validate()) {
      loading.show();
      var user = User(
        name: nameController.text,
        email: emailController.text,
        username: userNameController.text,
      );
      await StaffRepo.updateStaff(
        staffId: staff.value!.id!,
        user: user,
        password: passwordController.text,
        onSuccess: (staff) {
          loading.hide();
          //TODO show page state so that loader will be displayed
          getStaffs();
          nameController.clear();
          emailController.clear();
          userNameController.clear();
          Get.back();
        },
        onError: (message) {
          loading.hide();

          SkySnackBar.error(title: "Staff", message: message);
        },
      );
    }
  }

  void deleteStaff(String staffId) async {
    loading.show();

    await StaffRepo.deleteStaff(
      staffId: staffId,
      onSuccess: (message) {
        loading.hide();
        getStaffs();
        Get.back();
        SkySnackBar.success(title: "Staff", message: message);
      },
      onError: (message) {
        loading.hide();

        SkySnackBar.error(title: "Staff", message: message);
      },
    );
  }
}
