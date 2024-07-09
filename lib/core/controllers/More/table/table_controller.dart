import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/model/feature_model/tables/table_model.dart';
import 'package:saralnova/core/repo/more_repo/tables_repo.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/core/utils/helpers/log_helper.dart';
import 'package:saralnova/features/screens/More/tables/add_tables_screen.dart';
import 'package:saralnova/features/widgets/common_widgets/loading_dialog.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_snack_bar.dart';

import '../../../../features/screens/More/rooms/status_bottom_sheet.dart';
import '../../../../features/screens/More/tables/space_bottom_sheet.dart';
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
  Rxn<TableModel> table = Rxn();
  Rxn<Space> space = Rxn();

  @override
  void onInit() {
    getAllTables();
    getAllAvailableTables();
    super.onInit();
  }

  void getAllTables() async {
    pageState.value = PageState.LOADING;

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
    print("------------id---------------------${space.value?.id}");
    if (tableKey.currentState!.validate()) {
      loading.show();
      TableModel tableRequest = TableModel(
        name: nameController.text,
        capacity: int.parse(capcityController.text),
        status: statusController.text,
        // spaceId: space.value?.id,
        // space:
      );
      TableRepo.storeTable(
          tableModel: tableRequest,
          spaceId: space.value!.id!,
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
    this.space.value = table.space;
    Get.toNamed(AddTablesScreen.routeName);
    nameController.text = table.name ?? "";
    capcityController.text = (table.capacity ?? 1).toString();
    statusController.text = table.status ?? "";
    // spaceController.text = table.spaceName ?? "";
    spaceController.text = table.space?.name ?? "";

    // space.value = table.space ;
  }

  void updateTable() async {
    if (tableKey.currentState!.validate()) {
      loading.show();
      TableModel tableRequest = TableModel(
        id: table.value?.id,
        name: nameController.text,
        // spaceId: table.value?.spaceId,
        status: statusController.text,
        capacity: int.parse(capcityController.text),
      );
      TableRepo.updateTable(
        tableModel: tableRequest,
        spaceId: space.value!.id!,
        onSuccess: (table) {
          loading.hide();

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

      // print("Space id ============>${table.value?.spaceId}");
    }

    // print("------------id---------------------${space.value?.id}");
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
            onSelectRoomType: (Space space) {
              spaceController.text = space.name.toString();

              this.space.value = space;
              if (crudState.value == CRUDSTATE.UPDATE) {
                this.space.value = space;
              }
            },
          ),
        );
      },
    );
  }
}
