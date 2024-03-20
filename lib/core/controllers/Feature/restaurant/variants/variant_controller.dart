import 'package:get/get.dart';
import 'package:saralnova/core/model/feature_model/restaurant_model/variant_model.dart';
import 'package:saralnova/core/repo/feature_repo/restaurant_repo.dart';
import 'package:saralnova/core/utils/constants/enums.dart';
import 'package:saralnova/core/utils/helpers/log_helper.dart';
import 'package:saralnova/features/widgets/common_widgets/loading_dialog.dart';

class VariantController extends GetxController{
  final LogoLoading loading = LogoLoading();
  var crudState = CRUDSTATE.ADD.obs;
  var pageState = PageState.LOADING.obs;

    RxList<Variant> restaurantVariantlist = RxList();
 @override
  void onInit() {
    getAllRestaurantVariants();
    super.onInit();
  }

  void getAllRestaurantVariants() async {
    restaurantVariantlist.clear();
    RestaurantRepo.getRestaurantVariants(
      onSuccess: (variants) {
        if (variants.isEmpty) {
          pageState.value = PageState.EMPTY;
        } else {
          restaurantVariantlist.addAll(variants);
          pageState.value = PageState.NORMAL;
        }
      },
      onError: (message) {
        pageState.value = PageState.ERROR;
        LogHelper.error(message);
      },
    );
  }
}