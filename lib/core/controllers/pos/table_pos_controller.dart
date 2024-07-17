import 'package:get/get.dart';
import 'package:saralnova/core/model/feature_model/tables/available_table_by_space_model.dart';
import 'package:saralnova/core/repo/more_repo/pos_repo/pos_repo.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_snack_bar.dart';

class TablesPosController extends GetxController {
  RxList<AvailableTableBySpace> availableTablesBySpace = RxList();
  var pageState = PageState.LOADING.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    getAllAvailabletablesBySpace();
    super.onInit();
  }

  Future<void> getAllAvailabletablesBySpace() async {
    pageState.value = PageState.LOADING;
    availableTablesBySpace.clear();
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

  Future<void> mergeTable() async {
    await PosRepo.mergeTable(
        tableIds: [], //TODO grab id
        onSuccess: (message) {
          SkySnackBar.success(title: "Table", message: message);
        },
        onError: (message) {
          SkySnackBar.success(title: "Table", message: message);
        });
  }
}
