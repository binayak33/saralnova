import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saralnova/core/model/feature_model/amenity_model.dart';
import 'package:saralnova/core/repo/feature_repo/aminitiy_repo.dart';
import 'package:saralnova/core/utils/constants/enums.dart';
import 'package:saralnova/core/utils/helpers/log_helper.dart';
import 'package:saralnova/features/screens/Feature/aminity_type/add_aminity_screen.dart';
import 'package:saralnova/features/widgets/common_widgets/loading_dialog.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_snack_bar.dart';

class AmenityController extends GetxController {
  final aminityKey = GlobalKey<FormState>();
  final LogoLoading loading = LogoLoading();

  RxList<Amenity> amenitiesList = RxList();
  var crudState = CRUDSTATE.ADD.obs;
  var pageState = PageState.LOADING.obs;
  // RxnString updateIndex = RxnString();
  Rxn<Amenity> amenity = Rxn();

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

  //pick image
  final Rx<File?> pickedFile = Rx<File?>(null);

  // Your other controller code...

  Future<void> pickImage(XFile imageFile) async {
    pickedFile.value = File(imageFile.path);
  }

//when image is required
  // void storeAmenityType() async {
  //   if (aminityKey.currentState!.validate()) {
  //     loading.show();
  //     if (pickedFile.value != null) {
  //       AminityRepo.storeAmintyType(
  //           title: titleAminityController.text,
  //           image: pickedFile.value,
  //           onSuccess: (room) {
  //             loading.hide();
  //             //TODO show page state so that loader will be displayed
  //             getAllAmenities();
  //             titleAminityController.clear();
  //             Get.back();
  //           },
  //           onError: (message) {
  //             loading.hide();

  //             SkySnackBar.error(title: "Amenity", message: message);
  //           });
  //     } else {
  //       loading.hide();
  //       SkySnackBar.error(title: "Amenity", message: "Please pick an image");
  //     }
  //   }
  // }

//when image is not mandatory

  void storeAmenityType() async {
    if (aminityKey.currentState!.validate()) {
      loading.show();
      AminityRepo.storeAmintyType(
          title: titleAminityController.text,
          image: pickedFile.value,
          onSuccess: (amenity) {
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
        // amenityId: updateIndex.value.toString(),
        amenityId: amenity.value!.id!,
        onSuccess: (amenity) {
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

  void deleteAminity(String amenityId) async {
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