import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Feature/booking/booking_controller.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';

class ConfirmScreen extends StatelessWidget {
  // final c = Get.put(BookingController());
  final c = Get.find<BookingController>();
  ConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
