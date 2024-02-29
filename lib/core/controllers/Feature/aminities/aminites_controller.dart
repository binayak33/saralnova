import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/model/aminity_model.dart';
import 'package:saralnova/core/repo/aminitiy_repo.dart';
import 'package:saralnova/core/utils/constants/enums.dart';
import 'package:saralnova/core/utils/helpers/log_helper.dart';
import 'package:saralnova/features/screens/Feature/aminity_type/add_aminity_screen.dart';
import 'package:saralnova/features/widgets/common_widgets/loading_dialog.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_snack_bar.dart';

class AminityController extends GetxController {
  final aminityKey = GlobalKey<FormState>();
  final LogoLoading loading = LogoLoading();

  RxList<Aminity> amenitiesList = RxList();
  var crudState = CRUDSTATE.ADD.obs;
  var pageState = PageState.LOADING.obs;
  RxnInt updateIndex = RxnInt();

  final titleAminityController = TextEditingController();

  @override
  void onInit() {
    getAllAmenities();
    super.onInit();
  }

  void getAllAmenities() async {
    amenitiesList.clear();
    AminityRepo.getAminityTypes(
      onSuccess: (amenities) {
        if (amenities.isEmpty) {
          pageState.value = PageState.EMPTY;
        } else {
          amenitiesList.addAll(amenities);
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
    if (aminityKey.currentState!.validate()) {
      loading.show();
      AminityRepo.storeAmintyType(
          title: titleAminityController.text,
          onSuccess: (room) {
            loading.hide();
            //TODO show page state so that loader will be displayed
            getAllAmenities();
            titleAminityController.clear();
            Get.back();
          },
          onError: (message) {
            loading.hide();

            SkySnackBar.error(title: "Amenity", message: message);
          });
    }
  }

  openAmenityBottomSheet() async {
    showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AddAmenityScreen(),
        );
      },
    );
  }

  void updateAmenityType() async {
    if (aminityKey.currentState!.validate()) {
      loading.show();
      AminityRepo.updateAminityType(
        amenityTitle: titleAminityController.text,
        amenityId: int.parse(updateIndex.value.toString()),
        onSuccess: (room) {
          loading.hide();
          //TODO show page state so that loader will be displayed

          getAllAmenities();
          titleAminityController.clear();
          crudState.value = CRUDSTATE.ADD;
          Get.back();
        },
        onError: (message) {
          loading.hide();

          SkySnackBar.error(title: "Amenity", message: message);
        },
      );
    }
  }

  void deleteAminity(int amenityId) async {
    loading.show();
    // TODO: show confirmation while delete
    AminityRepo.deleteAminityType(
      amenityId: amenityId,
      onSuccess: (message) {
        loading.hide();
        SkySnackBar.success(title: "Amenity", message: message);

        getAllAmenities();
        Get.back();
      },
      onError: (message) {
        loading.hide();

        SkySnackBar.error(title: "Amenity", message: message);
      },
    );
  }
}
