import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/More/booking/booking_controller.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BookingCalandarBottomSheet extends StatelessWidget {
  final c = Get.find<BookingController>();
  BookingCalandarBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height / 2,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(
            10,
          ),
        ),
      ),
      child: Column(
        children: [
          SfDateRangePicker(
            initialSelectedDate: DateTime.now(),
            initialSelectedRanges: [
              PickerDateRange(
                DateTime.now(),
                DateTime.now().add(const Duration(days: 1)),
              ),
            ],
            enablePastDates: false,
            showActionButtons: true,
            showNavigationArrow: true,
            showTodayButton: false,
            confirmText: "Apply",
            onSubmit: (dynamic value) {
              print("00000000000000000");

              // if (value is PickerDateRange) {
              //   // Process selected date range
              // } else if (value is DateTime) {
              //   // Process selected date
              // }

              Navigator.pop(context); // Close the date picker
            },
            onCancel: () {
              Navigator.pop(context);
            },
            onSelectionChanged: c.onSelectionChanged,
            selectionMode: DateRangePickerSelectionMode.range,
            initialSelectedRange: PickerDateRange(
              // DateTime.now().subtract(const Duration(days: 4)),
              DateTime.now(),
              DateTime.now().add(const Duration(days: 1)),
            ),
          ),
        ],
      ),
    );
  }
}
