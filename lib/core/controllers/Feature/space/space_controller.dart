import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/model/feature_model/tables/space_model.dart';
import 'package:saralnova/core/repo/feature_repo/space_repo.dart';
import 'package:saralnova/core/utils/constants/enums.dart';
import 'package:saralnova/core/utils/helpers/log_helper.dart';
import 'package:saralnova/features/screens/Feature/space/add_space_screen.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_snack_bar.dart';

import '../../../../features/widgets/common_widgets/loading_dialog.dart';

class SpaceController extends GetxController {
  final spaceKey = GlobalKey<FormState>();
  final LogoLoading loading = LogoLoading();
  var crudState = CRUDSTATE.ADD.obs;
  var pageState = PageState.LOADING.obs;
  RxList<Space> spaceList = RxList();

  final nameController = TextEditingController();
  final descpController = TextEditingController();

  Rxn<Space> space = Rxn();

  @override
  void onInit() {
    getAllTableSpaces();
    super.onInit();
  }

  void getAllTableSpaces() async {
    spaceList.clear();
    SpaceRepo.getSpaces(
      onSuccess: (spaces) {
        if (spaces.isEmpty) {
          pageState.value = PageState.EMPTY;
        } else {
          spaceList.addAll(spaces);
          pageState.value = PageState.NORMAL;
        }
      },
      onError: (message) {
        pageState.value = PageState.ERROR;
        LogHelper.error(message);
      },
    );
  }

  void deleteSpace(String spaceId) async {
    loading.show();
    // TODO: show confirmation while delete
    SpaceRepo.deleteSpace(
      spaceId: spaceId,
      onSuccess: (message) {
        loading.hide();

        getAllTableSpaces();
        Get.back();
      },
      onError: (message) {
        loading.hide();

        SkySnackBar.error(title: "Space", message: message);
      },
    );
  }

  void storeRestaurantCategory() async {
    if (spaceKey.currentState!.validate()) {
      loading.show();
      Space spaceRequest = Space(
        name: nameController.text,
        description: descpController.text,
      );
      SpaceRepo.storeRestaurantCategory(
          space: spaceRequest,
          onSuccess: (category) {
            loading.hide();
            //TODO show page state so that loader will be displayed
            getAllTableSpaces();
            nameController.clear();
            descpController.clear();
            Get.back();
          },
          onError: (message) {
            loading.hide();

            SkySnackBar.error(title: "Space", message: message);
          });
    }
  }

  void onEditClick(Space space) async {
    crudState.value = CRUDSTATE.UPDATE;
    this.space.value = space; // assign the id to the model
    Get.toNamed(AddSpaceScreen.routeName);
    nameController.text = space.name.toString();
    descpController.text = space.description.toString();
  }

  void updateSpace() async {
    if (spaceKey.currentState!.validate()) {
      loading.show();
      Space spaceRequest = Space(
        id: space.value?.id,
        name: nameController.text,
        description: descpController.text,
      );
      SpaceRepo.updateSpace(
        spaceModel: spaceRequest,
        onSuccess: (space) {
          loading.hide();
          //TODO show page state so that loader will be displayed

          getAllTableSpaces();
          nameController.clear();
          descpController.clear();
          crudState.value = CRUDSTATE.ADD;
          Get.back();
        },
        onError: (message) {
          loading.hide();

          SkySnackBar.error(title: "Category", message: message);
        },
      );
    }
  }
}
