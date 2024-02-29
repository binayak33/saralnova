import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/model/facility_model.dart';
import 'package:saralnova/core/repo/facility_repo.dart';
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
  RxnInt updateIndex = RxnInt();

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
        facilityd: int.parse(updateIndex.value.toString()),
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

  void deleteFacility(int facilityId) async {
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

  // ------------------------------------
  // ------------------------------------
  // ------------------------------------
  // ------------------------------------
  // final facilityFormKey = GlobalKey<FormState>();
  // final facilityTitleController = TextEditingController();
  // final facilityPriceController = TextEditingController();
  // var pageState = CRUDSTATE.ADD.obs;
  // RxnInt updateFacilityIndex = RxnInt();

  // RxList<Facility> facilites = RxList<Facility>.empty();

  // void onSave() {
  //   if (facilityFormKey.currentState!.validate()) {
  //     var newFacility = Facility(
  //       title: facilityTitleController.text,
  //       price: facilityPriceController.text,
  //     );
  //     facilites.add(newFacility);
  //     facilityTitleController.clear();
  //     facilityPriceController.clear();
  //     pageState.value = CRUDSTATE.ADD;
  //     Get.back();
  //   }
  // }

  // void onUpdate() {
  //   if (facilityFormKey.currentState!.validate()) {
  //     int index = updateFacilityIndex.value!;
  //     facilites[index] = Facility(
  //       title: facilityTitleController.text,
  //       price: facilityPriceController.text,
  //     );
  //     facilityTitleController.clear();
  //     facilityPriceController.clear();
  //     pageState.value = CRUDSTATE.ADD;
  //     Get.back();
  //   }
  // }

  // openFacilityBottomSheet() async {
  //   showModalBottomSheet(
  //     isScrollControlled: true,
  //     enableDrag: true,
  //     context: Get.context!,
  //     builder: (context) {
  //       return Padding(
  //         padding: EdgeInsets.only(
  //           bottom: MediaQuery.of(context).viewInsets.bottom,
  //         ),
  //         child: Container(
  //           // margin: const EdgeInsets.only(bottom: 10),
  //           height: MediaQuery.of(context).size.height * 0.4,
  //           padding: const EdgeInsets.symmetric(
  //             horizontal: 16,
  //           ),
  //           child: Form(
  //             key: facilityFormKey,
  //             child: Column(
  //               children: [
  //                 const SizedBox(
  //                   height: 20,
  //                 ),
  //                 SkyTextField(
  //                   // fillColor: AppColors.fillColor,
  //                   autofocus: true,
  //                   hint: " Facility",
  //                   controller: facilityTitleController,
  //                   textInputAction: TextInputAction.done,
  //                   textInputType: TextInputType.name,
  //                   validator: (value) => Validator.validateEmpty(value!),
  //                 ),
  //                 const SizedBox(
  //                   height: 10,
  //                 ),
  //                 SkyTextField(
  //                   autofocus: true,
  //                   hint: " Price",
  //                   controller: facilityPriceController,
  //                   textInputType: TextInputType.number,
  //                   textInputAction: TextInputAction.done,
  //                   inputFormatters: <TextInputFormatter>[
  //                     FilteringTextInputFormatter.digitsOnly
  //                   ],
  //                   validator: (value) => Validator.validateEmpty(value!),
  //                 ),
  //                 const SizedBox(
  //                   height: 10,
  //                 ),
  //                 pageState.value == CRUDSTATE.ADD
  //                     ? SkyElevatedButton(
  //                         onPressed: onSave,
  //                         title: "Add Facility",
  //                       )
  //                     : SkyElevatedButton(
  //                         onPressed: onUpdate,
  //                         title: "Update  Facility",
  //                       )
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
