import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Feature/booking/booking_controller.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_text_field.dart';

class DateRoomScreen extends StatelessWidget {
  final c = Get.put(BookingController());
  DateRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
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
            hint: "Check-IN Check-OUT",
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.emailAddress,
            readOnly: true,
            controller: c.roomTypeController,
            onTap: () {},
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(4)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Exptected Guest Count"),
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
                              color: AppColors.reservedColor,
                            ),
                            child: const Icon(Icons.minimize_outlined),
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
                              color: AppColors.reservedColor,
                            ),
                            child: const Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
