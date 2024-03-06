import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/features/screens/Feature/rooms/room_type_bottom_sheet.dart';

enum BookingState { DATEROOMS, OPTIONS, INFORMATION, CONFIRM }

class BookingController extends GetxController {
  var bookingState = BookingState.DATEROOMS.obs;

  final roomTypeController = TextEditingController();
  RxInt guestNumber = RxInt(0);

  onIncrement() {
    if (guestNumber.value >= 0) {
      print("hahaha");

      guestNumber.value += 1;
    }
  }

  onDecrement() {
    if (guestNumber.value > 0) {
      guestNumber.value -= 1;
    }
  }

  var activeIndex = 0.obs; // Track active index

  setActiveIndex(int index) {
    print("-current Index--------------->${index}");
    switch (index) {
      case 0:
        bookingState.value = BookingState.DATEROOMS;
        break;
      case 1:
        bookingState.value = BookingState.OPTIONS;
        break;
      case 2:
        bookingState.value = BookingState.INFORMATION;
        break;
      default:
        bookingState.value = BookingState.CONFIRM;
        break;
    }
  }

  onNext() {
    if (activeIndex.value >= 0 && activeIndex.value < 3) {
      activeIndex.value += 1;
      setActiveIndex(activeIndex.value);
    }
  }

  onBack() {
    if (activeIndex.value > 0 && activeIndex.value <= 3) {
      activeIndex.value -= 1;
      setActiveIndex(activeIndex.value);
    }
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

                //     this.roomType.value = roomType;
                // if (crudState.value == CRUDSTATE.UPDATE) {
                //   updateIndex.value = roomType.id;
                // }
              },
            ),
          );
        });
  }
}
