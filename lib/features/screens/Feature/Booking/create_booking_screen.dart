import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Feature/booking/booking_controller.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/features/screens/Feature/Booking/booking_steppers/book_success_screen.dart';
import 'package:saralnova/features/screens/Feature/Booking/booking_steppers/booking_confirm_screen.dart';
import 'package:saralnova/features/screens/Feature/Booking/booking_steppers/booking_dateRoom_screen.dart';
import 'package:saralnova/features/screens/Feature/Booking/booking_steppers/booking_information_screen.dart';
import 'package:saralnova/features/screens/Feature/Booking/booking_steppers/booking_options_screen.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../../widgets/common_widgets/sky_elevated_button.dart';

class CreateBookingScreen extends StatelessWidget {
  static const String routeName = "/create-booking-screen";
  final c = Get.find<BookingController>();
  CreateBookingScreen({super.key});

// TODO : BACK bUTTON HUDA EHI APP ma ehi rakhdineyuser lai

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppColors.scaffoldColor,
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        title: Text(
          "Booking",
          style: CustomTextStyles.f16W600(color: AppColors.scaffoldColor),
        ),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         c.onsubmit();
        //         c.storeBooking();
        //       },
        //       icon: const Icon(Icons.add))
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            Obx(
              () => AnotherStepper(
                inverted: true,
                key: UniqueKey(),
                scrollPhysics: const NeverScrollableScrollPhysics(),
                stepperDirection: Axis.horizontal,
                barThickness: 2,
                activeBarColor: AppColors.primary,

                iconWidth: 40,
                iconHeight: 40,
                activeIndex: c.currentIndex,
                // verticalGap: 25,
                inActiveBarColor: AppColors.borderColor,
                // stepperList: c.stepperData,
                stepperList: [
                  StepperData(
                      title: StepperText(
                        "Date & Rooms",
                        textStyle: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      iconWidget: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: c.currentIndex >= 0
                                ? AppColors.primary
                                : AppColors.borderColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: SvgPicture.asset(IconPath.calendar),
                      )),
                  StepperData(
                      title: StepperText(
                        "Options",
                        textStyle: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      iconWidget: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: c.currentIndex >= 1
                              ? AppColors.primary
                              : AppColors.borderColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: SvgPicture.asset(IconPath.list),
                      )),
                  StepperData(
                      title: StepperText(
                        "Information",
                        textStyle: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      iconWidget: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: c.currentIndex >= 2
                                ? AppColors.primary
                                : AppColors.borderColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: SvgPicture.asset(IconPath.info),
                      )),
                  StepperData(
                    title: StepperText(
                      "Confirm",
                      textStyle: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    iconWidget: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: c.currentIndex >= 3
                              ? AppColors.primary
                              : AppColors.borderColor,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: SvgPicture.asset(IconPath.check),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: SizedBox(
                width: Get.width,
                child: PageView(
                  controller: c.pageController,
                  physics: NeverScrollableScrollPhysics(),
                  onPageChanged: (value) {
                    c.changeIndex(value); //TODO validate when swipe
                  },
                  children: [
                    DateRoomScreen(),
                    OptionsScreen(),
                    InformationScreen(),
                    ConfirmScreen(),
                    BookSuccessScreen()
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () {
          if (c.currentIndex != 4) {
            return Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text("haha"),

                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 40, //TODO: fix the height issue on device preview
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Estimated Cost",
                            style: CustomTextStyles.f16W500(
                                color: AppColors.blackColor),
                          ),
                          Obx(
                            () => Text(
                              "Rs. ${c.estimatedCost}",
                              style: CustomTextStyles.f16W600(
                                  color: AppColors.primary),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // if (c.currentIndex > 0)
                  //   Flexible(

                  Obx(() {
                    if (c.currentIndex > 0 && c.currentIndex <= 3) {
                      return Flexible(
                        child: SkyElevatedButton(
                          height: 30,
                          onPressed: () {
                            c.onBack();
                          },
                          title: "Back",
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),
                  const SizedBox(
                    width: 10,
                  ),

                  if (c.currentIndex != 4)
                    Flexible(
                        child: Obx(
                      () => SkyElevatedButton(
                          height: 30,
                          onPressed: () {
                            c.onNext();
                          },
                          title: c.currentIndex < 3 ? "Next" : "Book"),
                    )),
                ],
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
