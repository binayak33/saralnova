import 'package:get/get.dart';
import 'package:saralnova/core/model/feature_model/tables/available_table_by_space_model.dart';
import 'package:saralnova/core/model/feature_model/tables/table_model.dart';
import 'package:saralnova/core/repo/more_repo/pos_repo/pos_repo.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/features/widgets/common_widgets/loading_dialog.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_snack_bar.dart';

class TablesPosController extends GetxController {
  RxList<AvailableTableBySpace> availableTablesBySpace = RxList();
  var pageState = PageState.LOADING.obs;
  final LogoLoading loading = LogoLoading();

  @override
  void onInit() {
    getAllAvailabletablesBySpace();
    super.onInit();
  }

  Future<void> getAllAvailabletablesBySpace() async {
    availableTablesBySpace.clear();

    pageState.value = PageState.LOADING;
    await PosRepo.getAvailableTablesBySpace(
        onSuccess: (availableTablesBySpace) {
      if (availableTablesBySpace.isNotEmpty) {
        pageState.value = PageState.NORMAL;

        this.availableTablesBySpace.addAll(availableTablesBySpace);
      } else {
        pageState.value = PageState.EMPTY;
      }
    }, onError: (message) {
      pageState.value = PageState.ERROR;

      SkySnackBar.error(title: "Table", message: message);
    });
  }

  RxList<TableModel> selectedTableList = RxList();

  // void toggleSelectionTable(TableModel table) {
  //   if (selectedTableList.contains(table)) {
  //     selectedTableList.remove(table);
  //   } else {
  //     selectedTableList.add(table);
  //   }
  // }

  // =========================================================
  void toggleSelectionTable(TableModel table) {
    if (selectedTableList.contains(table)) {
      selectedTableList.remove(table);
    } else {
      // Check conditions before adding the table
      if (table.mergedChild == true) {
        // If table is mergedChild, it should not be added
        SkySnackBar.error(
          title: "Selection Error",
          message: "Merged Child tables cannot be selected",
        );
        return;
      }

      if (table.mergedMain == true) {
        // Check if there is already a mergedMain in the list
        bool hasMergedMain = selectedTableList.any((t) => t.mergedMain == true);
        if (hasMergedMain) {
          SkySnackBar.error(
            title: "Selection Error",
            message: "Another Main table cannot be select",
          );
          return;
        }
      }

      selectedTableList.add(table);
    }
  }

  // =========================================================
  Future<void> mergeTable() async {
    loading.show();

    List<String> tableIds = selectedTableList.map((item) => item.id!).toList();

    print("tableIds====================================>${tableIds}");
    await PosRepo.mergeTable(
        tableIds: tableIds,
        onSuccess: (message) {
          //now call get api
          selectedTableList.clear();

          getAllAvailabletablesBySpace();
          loading.hide();

          //TODO
          //in response i need the index of that merged list so that i can update
          //TODO another idea
          // in response i need all the array so that i can replace the previous array which ultimately prevent reload
          SkySnackBar.success(title: "Table", message: message);
        },
        onError: (message) {
          loading.hide();

          SkySnackBar.error(title: "Table", message: message);
        });
  }
}
