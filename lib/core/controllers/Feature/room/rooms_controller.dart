import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Feature/amenities/amenities_controller.dart';
import 'package:saralnova/core/model/feature_model/amenity_model.dart';
import 'package:saralnova/core/model/feature_model/room_type_model.dart';
import 'package:saralnova/core/repo/rooms_repo.dart';
import 'package:saralnova/core/utils/constants/messages.dart';
import 'package:saralnova/core/utils/helpers/log_helper.dart';
import 'package:saralnova/features/screens/Feature/rooms/room_type_bottom_sheet.dart';
import 'package:saralnova/features/screens/Feature/rooms/status_bottom_sheet.dart';
import 'package:saralnova/features/widgets/common_widgets/loading_dialog.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_snack_bar.dart';

import '../../../../features/screens/Feature/rooms/add_rooms_screen.dart';
import '../../../model/rooms_model.dart';
import '../../../utils/constants/enums.dart';

class RoomsController extends GetxController {
  // final amenitiesList = Get.find<AmenityController>().amenitiesList;
  final amenityController = Get.put(AmenityController());
  final addRoomKey = GlobalKey<FormState>();
  final LogoLoading loading = LogoLoading();

  RxList<Rooms> roomsList = RxList();
  var crudState = CRUDSTATE.ADD.obs;
  var pageState = PageState.LOADING.obs;

  final roomTypeController = TextEditingController();
  final roomStatusController = TextEditingController();
  final roomTitleController = TextEditingController();
  final rateController = TextEditingController();

  Rxn<Rooms> rooms = Rxn();

  Rxn<RoomType> roomType = Rxn();

  RxList<Amenity> amenitiesDataList = RxList();
  // RxList<String> amenitiesDataList = RxList();

  RxString ameinitiesDataString = RxString("");
  @override
  void onInit() {
    getAllRooms();

    rateController.clear();

    super.onInit();
  }

  void getAllRooms() async {
    roomsList.clear();
    RoomsRepo.getRooms(
      onSuccess: (rooms) {
        if (rooms.isEmpty) {
          pageState.value = PageState.EMPTY;
        } else {
          roomsList.addAll(rooms);
          pageState.value = PageState.NORMAL;
        }
      },
      onError: (message) {
        pageState.value = PageState.ERROR;
        LogHelper.error(message);
      },
    );
  }

  clearVariables() {
    roomTypeController.clear();
    roomStatusController.clear();
    roomTitleController.clear();
    rateController.clear();

    rooms.value =
        null; //disposing the model before user creates /updates the  rooms
    roomType.value = null;
    amenitiesDataList.clear();
    crudState.value = CRUDSTATE.ADD;
    Get.toNamed(AddRoomsScreen.routeName);
  }

  RxnString updateIndex = RxnString();
  void onEditClick(Rooms room) async {
    Get.toNamed(
      AddRoomsScreen.routeName,
    );
    rooms.value = room;

    crudState.value = CRUDSTATE.UPDATE;

    if (rooms.value != null && crudState.value == CRUDSTATE.UPDATE) {
      log("====roomTypeId ==${rooms.value?.roomTypeId}");
      roomTypeController.text = rooms.value?.roomTypeName ?? " ";

      updateIndex.value = rooms.value?.roomTypeId;
      roomTitleController.text = rooms.value?.title ?? " ";
      roomStatusController.text = rooms.value?.status ?? " ";
      rateController.text = (rooms.value?.rate?.toString() ?? "0.00");
    }
    update();
  }

  openRoomTypeBottomSheet() async {
    showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: RoomTypeBottomSheet(
            onSelectRoomType: (roomType) {
              roomTypeController.text = roomType.title.toString();

              this.roomType.value = roomType;
              if (crudState.value == CRUDSTATE.UPDATE) {
                updateIndex.value = roomType.id;
              }
            },
          ),
        );
      },
    );
  }

  showStatus() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: Get.context!,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: StatusBottomSheet(
            onSelectRoomStatus: (roomStatus) {
              roomStatusController.text = roomStatus;
            },
          ),
        );
      },
    );
  }

  void storeRoom() async {
    if (addRoomKey.currentState!.validate()) {
      if (roomType.value?.id != null) {
        String amenitiesString =
            amenitiesDataList.map((amenity) => amenity.id!).join(',');

        print("------->${amenitiesString}");

        loading.show();
        RoomsRepo.storeRoom(
            roomTypeId: (roomType.value!.id).toString(),
            title: roomTitleController.text,
            status: roomStatusController.text,
            roomRate: int.parse(
              rateController.text,
            ),
            amenities: amenitiesString,
            onSuccess: (room) {
              loading.hide();
              //TODO show page state so that loader will be displayed
              getAllRooms();
              roomTypeController.clear();
              roomStatusController.clear();

              roomTitleController.clear();
              rateController.clear();
              Get.back();
            },
            onError: (message) {
              loading.hide();

              SkySnackBar.error(title: "Room", message: message);
            });
      } else {
        loading.hide();

        SkySnackBar.error(title: "Room", message: Messages.error);
      }
    }
  }

  void updateRoom() async {
    log("room id ${rooms.value!.id}");
    log("update index:--------${updateIndex.value}");
    if (addRoomKey.currentState!.validate()) {
      loading.show();
      RoomsRepo.updateRoomType(
          roomId: (rooms.value?.id).toString(),
          // roomTypeId: (roomType.value!.id).toString(),
          roomTypeId: updateIndex.value.toString(),
          roomTitle: roomTitleController.text,
          status: roomStatusController.text,
          rate: int.parse(
            rateController.text,
          ),
          // amenities: "DEMO",
          onSuccess: (room) {
            loading.hide();
            //TODO show page state so that loader will be displayed
            getAllRooms();
            roomTypeController.clear();
            roomStatusController.clear();

            roomTitleController.clear();
            rateController.clear();
            Get.back();
          },
          onError: (message) {
            loading.hide();

            SkySnackBar.error(title: "Room", message: message);
          });
    }
  }

  void deleteRoom(String roomIndex) {
    RoomsRepo.deleteRoomType(
        roomId: roomIndex,
        onSuccess: (message) {
          getAllRooms();
          Get.back();
          SkySnackBar.success(title: "Room", message: message);
        },
        onError: (message) {});
  }
}
