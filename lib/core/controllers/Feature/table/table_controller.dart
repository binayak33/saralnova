import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/model/feature_model/tables/table_model.dart';
import 'package:saralnova/core/repo/feature_repo/tables_repo.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/core/utils/helpers/log_helper.dart';
import 'package:saralnova/features/screens/Feature/tables/add_tables_screen.dart';
import 'package:saralnova/features/widgets/common_widgets/loading_dialog.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_snack_bar.dart';

import '../../../../features/screens/Feature/rooms/status_bottom_sheet.dart';
import '../../../../features/screens/Feature/tables/space_bottom_sheet.dart';
import '../../../model/feature_model/tables/space_model.dart';

class TableController extends GetxController {
  final tableKey = GlobalKey<FormState>();
  final LogoLoading loading = LogoLoading();
  var crudState = CRUDSTATE.ADD.obs;
  var pageState = PageState.LOADING.obs;
  RxList<TableModel> tablesList = RxList();
  RxList<TableModel> availableTableList = RxList();

  final nameController = TextEditingController();
  final capcityController = TextEditingController();
  final statusController = TextEditingController();
  final spaceController = TextEditingController();
  Rxn<Space> space = Rxn();
  Rxn<TableModel> table = Rxn();

  @override
  void onInit() {
    getAllTables();
    getAllAvailableTables();  
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

  void getAllAvailableTables() async {
    availableTableList.clear();
    TableRepo.getAllAvailableTables(
      onSuccess: (availabletables) {
        if (availabletables.isEmpty) {
          pageState.value = PageState.EMPTY;
        } else {
          availableTableList.addAll(availabletables);
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

  void storeTable() async {
    // print("------------id---------------------${space.value?.id}");
    if (tableKey.currentState!.validate()) {
      loading.show();
      TableModel tableRequest = TableModel(
        name: nameController.text,
        capacity: int.parse(capcityController.text),
        status: statusController.text,
        spaceId: space.value?.id,
      );
      TableRepo.storeTable(
          tableModel: tableRequest,
          onSuccess: (category) {
            loading.hide();
            //TODO show page state so that loader will be displayed
            getAllTables();
            nameController.clear();
            capcityController.clear();
            statusController.clear();
            spaceController.clear();
            Get.back();
          },
          onError: (message) {
            loading.hide();

            SkySnackBar.error(title: "Space", message: message);
          });
    }
  }

  void onEditClick(TableModel table) async {
    crudState.value = CRUDSTATE.UPDATE;
    this.table.value = table; // assign the id to the model
    Get.toNamed(AddTablesScreen.routeName);
    nameController.text = table.name.toString();
    capcityController.text = (table.capacity ?? 1).toString();
    statusController.text = table.status ?? "";
    spaceController.text = table.spaceName ?? "";
  }

  void updateTable() async {
    if (tableKey.currentState!.validate()) {
      loading.show();
      TableModel tableRequest = TableModel(
        id: table.value?.id,
        name: nameController.text,
        spaceId: table.value?.spaceId,
        status: statusController.text,
        capacity: int.parse(capcityController.text),
      );
      TableRepo.updateTable(
        tableModel: tableRequest,
        onSuccess: (table) {
          loading.hide();
          //TODO show page state so that loader will be displayed

          getAllTables();
          nameController.clear();
          capcityController.clear();
          statusController.clear();
          spaceController.clear();
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

  showStatus() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: StatusBottomSheet(
            onSelectRoomStatus: (roomStatus) {
              statusController.text = roomStatus;
            },
          ),
        );
      },
    );
  }

  openSpaceTypeBottomSheet() async {
    showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SpaceBottomSheet(
            onSelectRoomType: (space) {
              spaceController.text = space.name.toString();

              this.space.value = space;
              if (crudState.value == CRUDSTATE.UPDATE) {
                // updateIndex.value = roomType.id;
              }
            },
          ),
        );
      },
    );
  }
}
