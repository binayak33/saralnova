import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/model/feature_model/room_type_model.dart';
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

  Rxn<Rooms> rooms = Rxn();

  Rxn<RoomType> roomType = Rxn();

  @override
  void onInit() {
    getAllRooms();

    // var args = Get.arguments;
    // if (args != null && args['room'] != null) {
    //   rooms.value = args['room'];

    //   print("-----------------------${args['room']}");
    // }
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

  // void onEditClick(Rooms room) async {
  //   var result = await Get.toNamed(AddRoomsScreen.routeName, arguments: {
  //     "room": room,
  //   });
  //   print("0000000000000000000000-${result}");
  //   try {
  //     if (result != null) {
  //       if ((result).containsKey("room")) {
  //         rooms.value = result['room'];
  //       } else {
  //         return;
  //       }
  //     } else {
  //       print("xxxxxxxxxxxxxx");
  //     }
  //   } catch (_) {
  //     getAllRooms();
  //   }
  // }

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
      // print(roomType.value?.id);
      // print(roomTitleController.text);
      // print(roomStatusController.text);
      // print(rateController.text);
      if (roomType.value?.id != null) {
        loading.show();
        RoomsRepo.storeRoom(
            roomTypeId: (roomType.value!.id).toString(),
            title: roomTitleController.text,
            status: roomStatusController.text,
            roomRate: int.parse(
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
      } else {
        loading.hide();

        SkySnackBar.error(title: "Room", message: Messages.error);
      }
    }
  }
}
