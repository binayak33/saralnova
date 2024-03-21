import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/model/feature_model/tables/table_model.dart';
import 'package:saralnova/core/repo/feature_repo/tables_repo.dart';
import 'package:saralnova/core/utils/constants/enums.dart';
import 'package:saralnova/core/utils/helpers/log_helper.dart';
import 'package:saralnova/features/widgets/common_widgets/loading_dialog.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_snack_bar.dart';

class TableController extends GetxController {
  final tableKey = GlobalKey<FormState>();
  final LogoLoading loading = LogoLoading();
  var crudState = CRUDSTATE.ADD.obs;
  var pageState = PageState.LOADING.obs;
  RxList<TableModel> tablesList = RxList();

  @override
  void onInit() {
    getAllTables();
    super.onInit();
  }

  void getAllTables() async {
    tablesList.clear();
    TableRepo.getAllTables(
      onSuccess: (tables) {
        if (tables.isEmpty) {
          pageState.value = PageState.EMPTY;
        } else {
          tablesList.addAll(tables);
          pageState.value = PageState.NORMAL;
        }
      },
      onError: (message) {
        pageState.value = PageState.ERROR;
        LogHelper.error(message);
      },
    );
  }

  void deleteTable(String tableId) async {
    loading.show();
    // TODO: show confirmation while delete
    TableRepo.deleteTable(
      tableId: tableId,
      onSuccess: (message) {
        loading.hide();

        getAllTables();
        Get.back();
      },
      onError: (message) {
        loading.hide();

        SkySnackBar.error(title: "Table", message: message);
      },
    );
  }

  void storeRestaurantCategory() async {
    // if (spaceKey.currentState!.validate()) {
    //   loading.show();
    //   Space spaceRequest = Space(
    //     name: nameController.text,
    //     description: descpController.text,
    //   );
    //   SpaceRepo.storeRestaurantCategory(
    //       space: spaceRequest,
    //       onSuccess: (category) {
    //         loading.hide();
    //         //TODO show page state so that loader will be displayed
    //         getAllTableSpaces();
    //         nameController.clear();
    //         descpController.clear();
    //         Get.back();
    //       },
    //       onError: (message) {
    //         loading.hide();

    //         SkySnackBar.error(title: "Space", message: message);
    //       });
    // }
  }

  void onEditClick(TableModel table) async {
    // crudState.value = CRUDSTATE.UPDATE;
    // this.space.value = space; // assign the id to the model
    // Get.toNamed(AddSpaceScreen.routeName);
    // nameController.text = space.name.toString();
    // descpController.text = space.description.toString();
  }

  void updateSpace() async {
    // if (spaceKey.currentState!.validate()) {
    //   loading.show();
    //   Space spaceRequest = Space(
    //     id: space.value?.id,
    //     name: nameController.text,
    //     description: descpController.text,
    //   );
    //   SpaceRepo.updateSpace(
    //     spaceModel: spaceRequest,
    //     onSuccess: (space) {
    //       loading.hide();
    //       //TODO show page state so that loader will be displayed

    //       getAllTableSpaces();
    //       nameController.clear();
    //       descpController.clear();
    //       crudState.value = CRUDSTATE.ADD;
    //       Get.back();
    //     },
    //     onError: (message) {
    //       loading.hide();

    //       SkySnackBar.error(title: "Category", message: message);
    //     },
    //   );
    // }
  }
}
