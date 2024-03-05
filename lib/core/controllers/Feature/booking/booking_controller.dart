import 'package:get/get.dart';
enum BookingState { DATEROOMS, OPTIONS, INFORMATION, CONFIRM }

class BookingController extends GetxController{
var bookingState = BookingState.DATEROOMS.obs;

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
}