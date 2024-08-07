import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/core/utils/helpers/validators.dart';
import 'package:saralnova/features/widgets/common_widgets/error_view.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_elevated_button.dart';

import '../../../../../core/controllers/More/booking/booking_controller.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/custom_text_style.dart';
import '../../../../../core/utils/constants/icon_path.dart';
import '../../../../widgets/common_widgets/sky_text_field.dart';

class DateRoomScreen extends StatelessWidget {
  // final c = Get.put(BookingController());
  final c = Get.find<BookingController>();

  DateRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: c.dateRoomKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkyTextField(
            hint: "Room Type",
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.emailAddress,
            readOnly: true,
            controller: c.roomTypeController,
            suffixIconPath: IconPath.down,
            onTap: () {
              c.openRoomTypeBottomSheet();
            },
          ),
          const SizedBox(
            height: 10,
          ),
          SkyTextField(
            hint: "Check-In Check-Out",
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.emailAddress,
            readOnly: true,
            validator: (value) => Validator.validateEmpty(value!),
            controller: c.checkInOutRangeController,
            suffixIcon: const Icon(
              Icons.calendar_month,
              color: AppColors.primary,
            ),
            onTap: () {
              c.openCalendarBottomSheet();
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Exptected Guest Count"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => Text(
                              c.guestNumber.value.toString(),
                              style: CustomTextStyles.f35W600(),
                            ),
                          ),
                          Row(
                            children: [
                              InkResponse(
                                onTap: () {
                                  c.onDecrement();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    shape: BoxShape.rectangle,
                                    color: AppColors.fillColor,
                                  ),
                                  child: SvgPicture.asset(IconPath.minus),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InkResponse(
                                onTap: () {
                                  c.onIncrement();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    shape: BoxShape.rectangle,
                                    color: AppColors.fillColor,
                                  ),
                                  child: SvgPicture.asset(IconPath.plus),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      showPicker(
                        context: context,
                        value: c.selectedTime.value,
                        sunrise:
                            const TimeOfDay(hour: 6, minute: 0), // optional
                        sunset:
                            const TimeOfDay(hour: 18, minute: 0), // optional
                        duskSpanInMinutes: 120, // optional
                        onChange: c.onTimeChanged,
                      ),
                    );
                  },
                  child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Arrival Time",
                                style: CustomTextStyles.f12W500(),
                              ),
                              SvgPicture.asset(
                                IconPath.clock,
                                height: 20,
                                width: 20,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Obx(() {
                            final time = c.selectedTime.value;
                            final formattedTime = DateFormat.jm().format(
                              DateTime(0, 0, 0, time.hour, time.minute),
                            );
                            return Text(
                              formattedTime,
                              style: CustomTextStyles.f16W600(),
                            );
                          }),
                        ],
                      )),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SkyElevatedButton(
            onPressed: () {
              c.getAvailableRooms();
            },
            title: "Search Available Rooms",
          ),
          const SizedBox(
            height: 10,
          ),
          Obx(() {
            if (c.pageState.value == PageState.EMPTY) {
              return const SizedBox();
            } else if (c.pageState.value == PageState.LOADING) {
              return const Center(child: CupertinoActivityIndicator());
            } else if (c.pageState.value == PageState.NORMAL) {
              return Obx(
                () => Expanded(
                  child: SizedBox(
                    child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: c.availableRoomList.length,
                        scrollDirection: Axis.vertical,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 100,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 2,
                        ),
                        itemBuilder: (context, index) {
                          var availableRoom = c.availableRoomList[index];

                          return Obx(
                            () => AvailableRoomBox(
                              title: availableRoom.title,
                              value: c.bookedRoomList.contains(availableRoom),
                              onTap: () {
                                if (c.bookedRoomList != null &&
                                    c.bookedRoomList.contains(availableRoom)) {
                                  c.bookedRoomList.remove(availableRoom);
                                  c.calculateEstimatedCost();
                                } else {
                                  c.bookedRoomList.add(availableRoom);
                                  c.calculateEstimatedCost();
                                }
                              },
                            ),
                          );
                        }),
                  ),
                ),
              );
            } else {
              return ErrorView(
                imagePath: IconPath.nodata,
                imageHeight: 150,
                errorMessage:
                    "This room type doesn't have any rooms on this day.",
                errorTitle: "No available rooms",
              );
              //TODO No Available rooms  error svg pictrue
            }
          }),
        ],
      ),
    );
  }
}

class AvailableRoomBox extends StatelessWidget {
  final String? title;
  final void Function()? onTap;
  final bool? value;
  const AvailableRoomBox({
    super.key,
    required this.title,
    this.onTap,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: value == true ? AppColors.primary : AppColors.scaffoldColor,
          border: Border.all(
            color: value == true ? Colors.transparent : AppColors.primary,
          ),
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        child: Center(
          child: Text(
            title ?? "",
            style: CustomTextStyles.f14W600(
                color: value == true
                    ? AppColors.scaffoldColor
                    : AppColors.primary),
          ),
        ),
      ),
    );
  }
}
