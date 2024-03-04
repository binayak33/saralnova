import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/model/feature_model/facility_model.dart';
import 'package:saralnova/core/repo/feature_repo/facility_repo.dart';
import 'package:saralnova/core/utils/constants/enums.dart';
import 'package:saralnova/core/utils/helpers/log_helper.dart';
import 'package:saralnova/features/screens/Feature/facility_type/add_facility_screen.dart';
import 'package:saralnova/features/widgets/common_widgets/loading_dialog.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_snack_bar.dart';

class FacilityController extends GetxController {
  final facilityKey = GlobalKey<FormState>();
  final LogoLoading loading = LogoLoading();

  RxList<Facility> facilitiesList = RxList();
  var crudState = CRUDSTATE.ADD.obs;
  var pageState = PageState.LOADING.obs;
  // RxnString updateIndex = RxnString();
  Rxn<Facility> facility = Rxn();

  final facilityTitleController = TextEditingController();
  final facilityPriceController = TextEditingController();

  @override
  void onInit() {
    getAllFacilities();
    super.onInit();
  }

  void getAllFacilities() async {
    facilitiesList.clear();
    FacilityRepo.getFacilitiesTypes(
      onSuccess: (facilities) {
        if (facilities.isEmpty) {
          pageState.value = PageState.EMPTY;
        } else {
          facilitiesList.addAll(facilities);
          pageState.value = PageState.NORMAL;
        }
      },
      onError: (message) {
        pageState.value = PageState.ERROR;
        LogHelper.error(message);
      },
    );
  }

  void storeAmenityType() async {
    if (facilityKey.currentState!.validate()) {
      loading.show();
      FacilityRepo.storeFacilityType(
          title: facilityTitleController.text,
          price: int.parse(facilityPriceController.text),
          onSuccess: (room) {
            loading.hide();
            //TODO show page state so that loader will be displayed
            getAllFacilities();
            facilityTitleController.clear();
            facilityPriceController.clear();
            Get.back();
          },
          onError: (message) {
            loading.hide();

            SkySnackBar.error(title: "Facility", message: message);
          });
    }
  }

  openFacilityBottomSheet() async {
    showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AddFacilityTypeScreen(),
        );
      },
    );
  }

  void updateAmenityType() async {
    if (facilityKey.currentState!.validate()) {
      loading.show();
      FacilityRepo.updateFacilityType(
        facilityTitle: facilityTitleController.text,
        // facilityd: updateIndex.value.toString(),
        facilityd: facility.value!.id!,
        price: int.parse(facilityPriceController.text),
        onSuccess: (room) {
          loading.hide();
          //TODO show page state so that loader will be displayed

          getAllFacilities();
          facilityTitleController.clear();
          facilityPriceController.clear();
          Get.back();
          crudState.value = CRUDSTATE.ADD;
        },
        onError: (message) {
          loading.hide();

          SkySnackBar.error(title: "Facility", message: message);
        },
      );
    }
  }

  void deleteFacility(String facilityId) async {
    loading.show();
    // TODO: show confirmation while delete
    FacilityRepo.deleteFacilityType(
      facilityId: facilityId,
      onSuccess: (message) {
        loading.hide();
        SkySnackBar.success(title: "Facility", message: message);

        getAllFacilities();
        Get.back();
      },
      onError: (message) {
        loading.hide();

        SkySnackBar.error(title: "Facility", message: message);
      },
    );
  }
}
