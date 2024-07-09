import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/More/booking/booking_controller.dart';
import 'package:saralnova/core/controllers/More/facility/facility_controller.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';

import '../../../../../core/utils/constants/colors.dart';
import '../../../../../core/utils/constants/icon_path.dart';
import '../../../../widgets/common_widgets/empty_view.dart';

class OptionsScreen extends StatelessWidget {
  final facilityController = Get.find<FacilityController>();
  final bookingController = Get.find<BookingController>();
  OptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () {
              if (facilityController.facilitiesList.isNotEmpty) {
                return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: facilityController.facilitiesList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemBuilder: (context, index) {
                    var facility = facilityController.facilitiesList[index];

                    return Obx(
                      () => OptionsListTile(
                        title: facility.title.toString(),
                        price: facility.price.toString(),
                        value:
                            bookingController.facilitiesList.contains(facility),
                        onChange: (value) {
                          log("${bookingController.facilitiesList}");
                          if (value != null && value) {
                            bookingController.facilitiesList.add(facility);
                            bookingController.calculateEstimatedCost();
                          } else {
                            bookingController.facilitiesList.remove(facility);
                            bookingController.calculateEstimatedCost();
                          }
                        },
                      ),
                    );
                  },
                );
              } else {
                return EmptyView(
                  message: "Empty!!",
                  title: "Empty",
                  media: IconPath.empty,
                  mediaSize: 500,
                );
              }
            },
          )
        ],
      ),
    );
  }
}

class OptionsListTile extends StatelessWidget {
  final String title;
  final String price;
  final bool value;
  final void Function(bool?)? onChange;

  const OptionsListTile({
    super.key,
    required this.title,
    required this.price,
    required this.value,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Card(
      child: ListTile(
        title: Text(
          title,
          style: CustomTextStyles.f18W500(),
        ),
        subtitle: Text(
          "Rs. $price",
          style: CustomTextStyles.f14W500(),
        ),
        trailing: Checkbox(
          visualDensity: VisualDensity.comfortable,
          value: value,
          side: MaterialStateBorderSide.resolveWith(
            (states) => BorderSide(
              color: value
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurfaceVariant,
              strokeAlign: 5,
              width: .8,
            ),
          ),
          fillColor: MaterialStateColor.resolveWith(
            (states) => value ? theme.primaryColor : Colors.transparent,
          ),
          // checkColor: AppColors.primary,
          activeColor: AppColors.primary,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          onChanged: onChange,
        ),
      ),
    );
  }
}
