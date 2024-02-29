import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/model/room_model.dart';
import 'package:saralnova/core/repo/room_repo.dart';
import 'package:saralnova/core/utils/constants/enums.dart';
import 'package:saralnova/core/utils/helpers/log_helper.dart';
import 'package:saralnova/features/screens/Feature/room_type/add_rooms_screen.dart';
import 'package:saralnova/features/widgets/common_widgets/loading_dialog.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_snack_bar.dart';

class RoomController extends GetxController {
  final roomKey = GlobalKey<FormState>();
  final LogoLoading loading = LogoLoading();

  RxList<Room> roomTypes = RxList();
  var crudState = CRUDSTATE.ADD.obs;
  var pageState = PageState.LOADING.obs;

  final titleRoomController = TextEditingController();

  @override
  void onInit() {
    getAllMovies();
    // TODO: implement onInit
    super.onInit();
  }

  void getAllMovies() async {
    roomTypes.clear();
    RoomRepo.getRoomsTypes(
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
      RoomRepo.storeRoomType(
          title: titleRoomController.text,
          onSuccess: (room) {
            loading.hide();
            //TODO show page state so that loader will be displayed
            getAllMovies();
            titleRoomController.clear();
            Get.back();
          },
          onError: (message) {
            loading.hide();

            SkySnackBar.error(title: "Room", message: message);
          });
    }
  }

  RxnInt updateIndex = RxnInt();

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
      RoomRepo.updateRoomType(
        roomTitle: titleRoomController.text,
        roomId: int.parse(updateIndex.value.toString()),
        onSuccess: (room) {
          loading.hide();
          //TODO show page state so that loader will be displayed

          getAllMovies();
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

  void deleteRoomType(int roomId) async {
    loading.show();
    // TODO: show confirmation while delete
    RoomRepo.deleteRoomType(
      roomId: roomId,
      onSuccess: (room) {
        loading.hide();

        getAllMovies();
        Get.back();
      },
      onError: (message) {
        loading.hide();

        SkySnackBar.error(title: "Room", message: message);
      },
    );
  }
}
  // ---------
  // final roomTypeScreenController = TextEditingController();
  // RxnInt updateIndex = RxnInt();

  // void onSave() async {
  //   if (roomScreenFormKey.currentState!.validate()) {
  //     Get.find<RoomsController>().roomTypes.add(roomTypeScreenController.text);
  //     roomTypeScreenController.clear();
  //     // Get.until(
  //     //   (route) => route.settings.name == DashPanel.routeName,
  //     // );
  //     // Navigator.of(context1).pop();
  //     pageState.value = PageState.ADD;

  //     Get.back();
  //   }
  // }

  // void onUpdate() async {
  //   if (roomScreenFormKey.currentState!.validate()) {
  //     final index = updateIndex.value;
  //     if (index != null &&
  //         index >= 0 &&
  //         index < Get.find<RoomsController>().roomTypes.length) {
  //       Get.find<RoomsController>().roomTypes[index] =
  //           roomTypeScreenController.text;
  //       roomTypeScreenController.clear();
  //       pageState.value = PageState.ADD;

  //       // Get.until(
  //       //   (route) => route.settings.name == DashPanel.routeName,
  //       // );
  //       Get.back();
  //     }
  //   }
  // }

