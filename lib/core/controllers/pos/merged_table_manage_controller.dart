import 'package:get/get.dart';
import 'package:saralnova/core/model/feature_model/tables/merge_table_model.dart';
import 'package:saralnova/core/repo/more_repo/pos_repo/pos_repo.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_snack_bar.dart';

class MergedTableManageController extends GetxController {
  RxList<MergeTable> mergedTableList = RxList();
  var pageState = PageState.LOADING.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getMergedTables();
    super.onInit();
  }

  Future<void> getMergedTables() async {
    mergedTableList.clear();
    pageState.value = PageState.LOADING;
    await PosRepo.getMergeTable(onSuccess: (mergedTables) {
      if (mergedTables.isNotEmpty) {
        pageState.value = PageState.NORMAL;
        mergedTableList.addAll(mergedTables);
      } else {
        pageState.value = PageState.EMPTY;
      }
    }, onError: (message) {
      pageState.value = PageState.ERROR;

      SkySnackBar.error(title: "Table", message: message);
    });
  }

  Future<void> unMergeTable(String tableId) async {
    await PosRepo.unmergeTable(
      tableId: tableId,
      onSuccess: (message) {
        getMergedTables();
        SkySnackBar.success(title: "Table", message: message);
      },
      onError: (message) {
        SkySnackBar.error(title: "Table", message: message);
      },
    );
  }
}
