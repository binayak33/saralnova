import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/More/booking/booking_controller.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';

class ConfirmScreen extends StatelessWidget {
  // final c = Get.put(BookingController());
  final c = Get.find<BookingController>();
  ConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int index = 0;

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(
            color: AppColors.blackColor,
            height: 20,
            // endIndent: 10,
            // indent: 10,
          ),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                      text: 'Check-In: ',
                      style: CustomTextStyles.f14W400(),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' ${c.startFromDate.toString()}',
                          style: CustomTextStyles.f16W600(),
                        )
                      ]),
                ),
                RichText(
                  text: TextSpan(
                      text: 'Check-Out: ',
                      style: CustomTextStyles.f14W400(),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' ${c.endToDate.toString()}',
                          style: CustomTextStyles.f16W600(),
                        )
                      ]),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            "Booking Summary",
            style: CustomTextStyles.f16W500(),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              sortColumnIndex: 1,
              showCheckboxColumn: false,
              border: TableBorder.all(width: 1),
              columnSpacing: 10,
              columns: const [
                DataColumn(
                  label: Expanded(child: Center(child: Text("S.N"))),
                ),
                DataColumn(
                  label: Expanded(
                      child: Center(child: Text("Room Title(x Days)"))),
                ),
                DataColumn(
                  label: Expanded(child: Center(child: Text("Rate"))),
                ),
                DataColumn(
                  label: Expanded(child: Center(child: Text("Total"))),
                ),
              ],
              rows: (c.bookedRoomList ?? []).asMap().entries.map((entry) {
                final index = entry.key + 1;
                final room = entry.value;
                return DataRow(
                  cells: [
                    DataCell(
                      SizedBox(
                        width: 10,
                        child: Text(
                          index.toString(),
                        ),
                      ),
                    ),
                    DataCell(
                      SizedBox(
                        width: 100,
                        child: Text(
                          '${room.title}',
                        ),
                      ),
                    ),
                    DataCell(
                      SizedBox(
                        width: 50,
                        child: Text(
                          '${room.rate ?? 0}',
                        ),
                      ),
                    ),
                    DataCell(
                      SizedBox(
                        width: 30,
                        child: Text(
                          '${((room.rate) * (c.daysCount))}',
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Options Summary",
            style: CustomTextStyles.f16W500(),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                sortColumnIndex: 1,
                showCheckboxColumn: false,
                border: TableBorder.all(width: 1),
                columnSpacing: 10,
                columns: const [
                  DataColumn(
                    label: Expanded(
                        child: Center(
                            child: Text("S.N", textAlign: TextAlign.center))),
                  ),
                  DataColumn(
                    label: Expanded(
                        child: Center(
                            child: Text("Title(x Days)",
                                textAlign: TextAlign.center))),
                  ),
                  DataColumn(
                    label: Expanded(
                        child: Center(
                            child: Text("Rate", textAlign: TextAlign.center))),
                  ),
                  DataColumn(
                    label: Expanded(
                        child: Center(
                            child: Text("Guest No.",
                                textAlign: TextAlign.center))),
                  ),
                  DataColumn(
                    label: Expanded(
                        child: Center(
                            child: Text("Total", textAlign: TextAlign.center))),
                  ),
                ],
                rows: (c.facilitiesList ?? []).asMap().entries.map((entry) {
                  final index = entry.key + 1;
                  final facility = entry.value;
                  return DataRow(
                    cells: [
                      DataCell(
                        SizedBox(
                          width: 10,
                          child: Text(
                            index.toString(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: 100,
                          child: Text(
                            '${facility.title}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: 50,
                          child: Text(
                            '${facility.price ?? 0}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: 50,
                          child: Text(
                            '${c.guestNumber}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      DataCell(
                        SizedBox(
                          width: 30,
                          child: Text(
                            '${(facility.price) * (c.daysCount)}',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
