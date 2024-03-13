import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Feature/booking/booking_controller.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';

class ConfirmScreen extends StatelessWidget {
  final c = Get.put(BookingController());
  ConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ListView.separated(
          //     physics: const NeverScrollableScrollPhysics(),
          //     itemCount: 14,
          //     shrinkWrap: true,
          //     scrollDirection: Axis.vertical,
          //     separatorBuilder: (context, index) {
          //       return const SizedBox(
          //         height: 10,
          //       );
          //     },
          //     itemBuilder: (context, index) {
          //       return OptionsListTile(
          //         title: "Breakfast 200",
          //       );
          //     })

          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Check-In : 2024-02-28"),
              Text("Check-Out : 2024-02-28")
            ],
          ),

          Text(
            "Booking Summary",
            style: CustomTextStyles.f16W500(),
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
                  label: Text("S.N"),
                ),
                DataColumn(
                  label: Text("Country"),
                ),
                DataColumn(
                  label: Text("Rate"),
                ),
                DataColumn(
                  label: Text("Total"),
                ),
              ],
              rows: (c.dataList ?? [])
                  .map(
                    (data) => DataRow(
                      cells: [
                        DataCell(Container(
                          width: 10,
                          child: Text(
                            "1",
                          ),
                        )),
                        DataCell(Container(
                          width: 100,
                          child: Text(
                            data.country,
                          ),
                        )),
                        DataCell(Container(
                          width: 50,
                          child: Text(
                            data.totalDeaths.toString(),
                          ),
                        )),
                        DataCell(Container(
                          width: 30,
                          child: Text(
                            data.totalConfirmed.toString(),
                          ),
                        )),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Options Summary",
            style: CustomTextStyles.f16W500(),
          )
        ],
      ),
    );
  }
}
