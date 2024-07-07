import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/model/feature_model/order/order_customers_model.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/core/utils/helpers/date_helper.dart';
import 'package:saralnova/features/screens/Feature/orders/customer_order/customer_kot_screen.dart';
import 'package:saralnova/features/widgets/common_widgets/empty_view.dart';
import 'package:saralnova/features/widgets/common_widgets/error_view.dart';

import '../../../../../core/controllers/Feature/orders/customer_orders/customer_order_controller.dart';
import '../../../../../core/utils/constants/colors.dart';

class CustomerOrderScreen extends StatelessWidget {
  static const String routeName = "/customer-order";
  final c = Get.find<CustomerOrderController>();
  CustomerOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(
          color: AppColors.scaffoldColor, //change your color here
        ),
        centerTitle: true,
        title: Text(
          "Customer Orders",
          style: CustomTextStyles.f16W600(color: AppColors.scaffoldColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Obx(() {
                if (c.pageState.value == PageState.LOADING) {
                  return const Center(
                    child: LinearProgressIndicator(),
                  );
                } else if (c.pageState.value == PageState.EMPTY) {
                  return EmptyView(
                    message: "Empty!!",
                    title: "Empty",
                    media: IconPath.empty,
                    mediaSize: 500,
                  );
                } else if (c.pageState.value == PageState.NORMAL) {
                  return ListView.separated(
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: c.customerList.length,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var customer = c.customerList[index];
                      return CustomerCard(
                        customer: customer,
                      );
                    },
                  );
                } else {
                  return const ErrorView(
                    errorTitle: "Something went wrong!!",
                    errorMessage: "Something went wrong",
                    imagePath: IconPath.somethingWentWrong,
                  );
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}

class CustomerCard extends StatelessWidget {
  final Customer customer;
  CustomerCard({
    super.key,
    required this.customer,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          CustomersKotScreen.routeName,
          arguments: {
            "customer": customer,
            "customer_name": customer.customerName,
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderColor),
            borderRadius: BorderRadius.circular(8),
            color: customer.isPaid == true
                ? Colors.green[200]
                : AppColors.fillColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customer.tables != null && customer.tables!.isNotEmpty
                ? SizedBox(
                    height: 20, //height of the listview
                    child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemCount: customer.tables!.length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            width: 5,
                          );
                        },
                        itemBuilder: (context, index) {
                          var table = customer.tables![index];

                          return Text(
                            table.name ?? "",
                            style: CustomTextStyles.f14W400(
                              color: AppColors.blackColor,
                            ),
                          );
                        }),
                  )
                : const SizedBox.shrink(),
            const Divider(
              color: AppColors.secondaryTextColor,
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  customer.customerName ?? "",
                  style: CustomTextStyles.f16W600(
                    color: AppColors.blackColor,
                  ),
                ),
                customer.createdAt != null
                    ? Text(
                        DateTimeHelper.prettyDateWithDay(customer.createdAt)!,
                        style: CustomTextStyles.f14W400(
                          color: AppColors.blackColor,
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              customer.customerPhone ?? "",
              style: CustomTextStyles.f12W400(
                color: AppColors.blackColor,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            if (customer.kotCount != null)
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'KOT: ',
                      style: CustomTextStyles.f12W400(
                        color: AppColors.secondaryTextColor,
                      ),
                    ),
                    TextSpan(
                      text: customer.kotCount.toString(),
                      style: CustomTextStyles.f12W400(
                        color: AppColors
                            .blackColor, // Example of different color for this segment
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (customer.isPaid != null)
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Status: ',
                          style: CustomTextStyles.f12W400(
                            color: AppColors.secondaryTextColor,
                          ),
                        ),
                        TextSpan(
                          text: customer.isPaid == false ? "Not paid" : "Paid",
                          style: CustomTextStyles.f12W400(
                            color: AppColors
                                .blackColor, // Example of different color for this segment
                          ),
                        ),
                      ],
                    ),
                  ),
                if (customer.kotCount != null)
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Total Amount: ',
                          style: CustomTextStyles.f12W400(
                            color: AppColors.secondaryTextColor,
                          ),
                        ),
                        TextSpan(
                          text: "Rs. ${customer.total.toString()}",
                          style: CustomTextStyles.f12W400(
                            color: AppColors
                                .blackColor, // Example of different color for this segment
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
