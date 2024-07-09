import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/More/order/order_detail_controller.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/core/utils/helpers/sky_network_image.dart';
import 'package:saralnova/features/widgets/common_widgets/custom_appBar.dart';

class OrderDetailScreen extends StatelessWidget {
  //This screen is checkedOutOrderDetailScreen
  static const String routeName = "/orderDetail-screen";
  final c = Get.find<OrderDetailController>();
  OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SaralNovaApppBar(
        title: "${c.order.value?.restaurantCustomer?.customerName}'s Order",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Container(
          width: Get.width,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.hintTextColor,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: "Customer Name:   ",
                  style: CustomTextStyles.f14W400(color: AppColors.borderColor),
                  children: [
                    TextSpan(
                        text: c.order.value?.restaurantCustomer?.customerName ??
                            "",
                        style: CustomTextStyles.f16W500())
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                  text: "Payment Method:   ",
                  style: CustomTextStyles.f14W400(color: AppColors.borderColor),
                  children: [
                    TextSpan(
                        text: c.order.value?.paymentMethod ?? "",
                        style: CustomTextStyles.f16W500())
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                  text: "Paid By:   ",
                  style: CustomTextStyles.f14W400(color: AppColors.borderColor),
                  children: [
                    TextSpan(
                        text: c.order.value?.paidBy ?? "",
                        style: CustomTextStyles.f16W500())
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                  text: "Payment Status:   ",
                  style: CustomTextStyles.f14W400(color: AppColors.borderColor),
                  children: [
                    TextSpan(
                        text: c.order.value?.isPaid == true ? "Paid" : "Unpaid",
                        style: CustomTextStyles.f16W500())
                  ],
                ),
              ),
              const Divider(
                height: 10,
                color: AppColors.hintTextColor,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  c.order.value?.createdAt ?? "",
                  style: CustomTextStyles.f16W600(color: AppColors.blackColor),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              if (c.order.value!.items!.isNotEmpty)
                SizedBox(
                  // width: double.infinity,
                  width: Get.width,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      sortColumnIndex: 1,
                      showCheckboxColumn: false,
                      border: TableBorder.all(
                          width: 1, color: AppColors.hintTextColor),
                      columnSpacing: 6,
                      columns: const [
                        DataColumn(
                          label: Expanded(child: Center(child: Text("S.N"))),
                        ),
                        DataColumn(
                          label: Expanded(child: Center(child: Text("Image"))),
                        ),
                        DataColumn(
                          label: Expanded(child: Center(child: Text("Menu"))),
                        ),
                        DataColumn(
                          label: Expanded(child: Center(child: Text("Qty"))),
                        ),
                        DataColumn(
                          label: Expanded(child: Center(child: Text("Total"))),
                        ),
                      ],
                      rows: (c.order.value?.items ?? [])
                          .asMap()
                          .entries
                          .map((entry) {
                        final index = entry.key + 1;
                        final item = entry.value;
                        return DataRow(
                          cells: [
                            DataCell(
                              SizedBox(
                                // width: 2,
                                child: Center(
                                  child: Text(
                                    index.toString(),
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                child: SkyNetworkImage(
                                  imageUrl: item.image ?? "",
                                  height: 60,
                                  width: 60,
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 110,
                                child: Center(
                                  child: Text(
                                    '${item.menuTitle}',
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 30,
                                child: Center(
                                  child: Text(
                                    'x${item.quantity ?? ""}',
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 40,
                                child: Center(
                                  child: Text(
                                    'Rs. ${item.total ?? ""}',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              const SizedBox(
                height: 30,
              ),
              if (c.order.value?.salesTotal != null)
                Align(
                  alignment: Alignment.bottomRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Total Sales: ",
                          style: CustomTextStyles.f14W400(
                              color: AppColors.borderColor),
                          children: [
                            TextSpan(
                                text:
                                    "Rs. ${c.order.value?.salesTotal.toString()}",
                                style: CustomTextStyles.f16W500())
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Discount: ",
                          style: CustomTextStyles.f14W400(
                              color: AppColors.borderColor),
                          children: [
                            TextSpan(
                                text:
                                    "Rs. ${c.order.value?.discount.toString()}",
                                style: CustomTextStyles.f16W500())
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Total: ",
                          style: CustomTextStyles.f14W400(
                              color: AppColors.borderColor),
                          children: [
                            TextSpan(
                                text: "Rs. ${c.order.value?.total.toString()}",
                                style: CustomTextStyles.f16W500())
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class TableTile extends StatelessWidget {
  final String sn;
  final String? img;
  final String? menu;
  final String? qty;
  final String? total;
  const TableTile({
    super.key,
    required this.sn,
    this.img,
    this.menu,
    this.qty,
    this.total,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              sn,
              style: CustomTextStyles.f14W400(color: AppColors.blackColor),
            ),
          ),
          Expanded(
            flex: 1,
            child: SkyNetworkImage(
              imageUrl: img ?? "",
              height: 30,
              width: 30,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              menu ?? "",
              style: CustomTextStyles.f14W400(color: AppColors.blackColor),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              qty ?? "",
              style: CustomTextStyles.f14W400(color: AppColors.blackColor),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              total ?? "",
              style: CustomTextStyles.f14W400(color: AppColors.blackColor),
            ),
          ),
        ],
      ),
    );
  }
}
