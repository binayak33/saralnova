import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Feature/booking/booking_controller.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/features/screens/Feature/Booking/booking_confirm_screen.dart';
import 'package:saralnova/features/screens/Feature/Booking/booking_dateRoom_screen.dart';
import 'package:saralnova/features/screens/Feature/Booking/booking_information_screen.dart';
import 'package:saralnova/features/screens/Feature/Booking/booking_options_screen.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/icon_path.dart';
import '../../../widgets/common_widgets/sky_elevated_button.dart';

class BookingScreen extends StatelessWidget {
  static const String routeName = "/booking-screen";
  final c = Get.find<BookingController>();
  BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primary,
        title: Text(
          "Booking",
          style: CustomTextStyles.f16W600(color: AppColors.scaffoldColor),
        ),
        actions: [
          IconButton(
              onPressed: () {
                c.onsubmit();
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
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
                  // activeIndex: c.activeIndex.value,
                  activeIndex: c.currentIndex,
                  verticalGap: 25,
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
                              color: //TODO active value ko color when the first form is validated then make color primary else dark
                                  c.bookingState.value == BookingState.DATEROOMS
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
                              color:
                                  c.bookingState.value == BookingState.OPTIONS
                                      ? AppColors.primary
                                      : AppColors.borderColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
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
                              color: c.bookingState.value ==
                                      BookingState.INFORMATION
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
                              color:
                                  c.bookingState.value == BookingState.CONFIRM
                                      ? AppColors.primary
                                      : AppColors.borderColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: SvgPicture.asset(IconPath.check),
                        )),
                  ],
                ),
              ),
              // Obx(() {
              //   switch (c.bookingState.value) {
              //     case BookingState.DATEROOMS:
              //       return DateRoomScreen();
              //     case BookingState.OPTIONS:
              //       return OptionsScreen();
              //     case BookingState.INFORMATION:
              //       return InformationScreen();
              //     case BookingState.CONFIRM:
              //       return ConfirmScreen();
              //     default:
              //       return Container(); // Handle default case
              //   }
              // }),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: Get.height,
                width: Get.width,
                child: PageView(
                  controller: c.pageController,
                  onPageChanged: (value) {
                    c.changeIndex(value);
                  },
                  children: [
                    DateRoomScreen(),
                    OptionsScreen(),
                    InformationScreen(),
                    ConfirmScreen(),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
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
                      style:
                          CustomTextStyles.f16W500(color: AppColors.blackColor),
                    ),
                    Text(
                      "Rs.3000",
                      style: CustomTextStyles.f16W600(color: AppColors.primary),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: SkyElevatedButton(
                  height: 30,
                  onPressed: () {
                    c.onNext();
                  },
                  title: "Next"),
            ),
          ],
        ),
      ),
    );
  }
}
