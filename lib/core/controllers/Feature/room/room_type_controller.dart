import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:saralnova/core/model/feature_model/room_type_model.dart';
import 'package:saralnova/core/repo/feature_repo/room_type_repo.dart';
import 'package:saralnova/core/utils/constants/enums.dart';
import 'package:saralnova/core/utils/helpers/log_helper.dart';
import 'package:saralnova/features/screens/Feature/room_type/add_roomType_screen.dart';
import 'package:saralnova/features/widgets/common_widgets/loading_dialog.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_snack_bar.dart';

class RoomTypeController extends GetxController {
  final roomKey = GlobalKey<FormState>();
  final LogoLoading loading = LogoLoading();

  RxList<RoomType> roomTypes = RxList();
  var crudState = CRUDSTATE.ADD.obs;
  var pageState = PageState.LOADING.obs;

  final titleRoomController = TextEditingController();

  @override
  void onInit() {
    getAllRoomTypes();
    // TODO: implement onInit
    super.onInit();
  }

  void getAllRoomTypes() async {
    roomTypes.clear();
    RoomTypeRepo.getRoomsTypes(
      onSuccess: (rooms) {
        if (rooms.isEmpty) {
          pageState.value = PageState.EMPTY;
        } else {
          roomTypes.addAll(rooms);
          pageState.value = PageState.NORMAL;
        }
      },
      onError: (message) {
        pageState.value = PageState.ERROR;
        LogHelper.error(message);
      },
    );
  }

  void storeRoomType() async {
    if (roomKey.currentState!.validate()) {
      loading.show();
      RoomTypeRepo.storeRoomType(
          title: titleRoomController.text,
          onSuccess: (room) {
            loading.hide();
            //TODO show page state so that loader will be displayed
            getAllRoomTypes();
            titleRoomController.clear();
            Get.back();
          },
          onError: (message) {
            loading.hide();

            SkySnackBar.error(title: "Room", message: message);
          });
    }
  }

  RxnString updateIndex = RxnString();

  openRoomsBottomSheet() async {
    showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AddRoomTypeScreen(),
        );
      },
    );
  }

  void updateRoomType() async {
    if (roomKey.currentState!.validate()) {
      loading.show();
      RoomTypeRepo.updateRoomType(
        roomTitle: titleRoomController.text,
        roomId: updateIndex.value.toString(),
        onSuccess: (room) {
          loading.hide();
          //TODO show page state so that loader will be displayed

          getAllRoomTypes();
          titleRoomController.clear();
          crudState.value = CRUDSTATE.ADD;
          Get.back();
        },
        onError: (message) {
          loading.hide();

          SkySnackBar.error(title: "Room", message: message);
        },
      );
    }
  }

  void deleteRoomType(String roomId) async {
    loading.show();
    // TODO: show confirmation while delete
    RoomTypeRepo.deleteRoomType(
      roomId: roomId,
      onSuccess: (room) {
        loading.hide();

        getAllRoomTypes();
        Get.back();
      },
      onError: (message) {
        loading.hide();

        SkySnackBar.error(title: "Room", message: message);
      },
    );
  }
}
