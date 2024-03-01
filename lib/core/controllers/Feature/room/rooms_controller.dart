import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/repo/rooms_repo.dart';
import 'package:saralnova/core/utils/constants/messages.dart';
import 'package:saralnova/core/utils/helpers/log_helper.dart';
import 'package:saralnova/features/screens/Feature/rooms/room_type_bottom_sheet.dart';
import 'package:saralnova/features/screens/Feature/rooms/status_bottom_sheet.dart';
import 'package:saralnova/features/widgets/common_widgets/loading_dialog.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_snack_bar.dart';

import '../../../model/rooms_model.dart';
import '../../../utils/constants/enums.dart';

class RoomsController extends GetxController {
  final addRoomKey = GlobalKey<FormState>();
  final LogoLoading loading = LogoLoading();

  RxList<Rooms> roomsList = RxList();
  var crudState = CRUDSTATE.ADD.obs;
  var pageState = PageState.LOADING.obs;

  final roomTypeController = TextEditingController();
  final roomStatusController = TextEditingController();
  final roomTitleController = TextEditingController();
  final rateController = TextEditingController();

  RxnString roomTypeId = RxnString();

  @override
  void onInit() {
    getAllRooms();
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
              roomTypeId.value = roomType.id.toString();
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
      // print(roomTypeId.value);
      if (roomTypeId.value != null) {
        loading.show();
        RoomsRepo.storeRoom(
            roomTypeId: roomTypeId.value.toString(),
            title: roomTitleController.text,
            status: roomStatusController.text,
            roomRate: int.parse(
              rateController.text,
            ),
            amenities: "DEMO",
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
}
