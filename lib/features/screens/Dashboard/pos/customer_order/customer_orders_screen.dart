import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/model/feature_model/pos/order_customers_model.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/features/screens/Dashboard/pos/customer_order/customer_kot_checkout_screen.dart';
import 'package:saralnova/features/widgets/common_widgets/empty_view.dart';
import 'package:saralnova/features/widgets/common_widgets/error_view.dart';
import 'package:saralnova/features/widgets/shimmers/list_shimmer.dart';

import '../../../../../core/controllers/More/orders/customer_orders/customer_order_controller.dart';
import '../../../../../core/utils/constants/colors.dart';

class CustomerOrderScreen extends StatelessWidget {
  static const String routeName = "/customer-order";
  final c = Get.find<CustomerOrderController>();
  CustomerOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Customer Orders",
          style: CustomTextStyles.f14W600(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Obx(() {
                if (c.pageState.value == PageState.LOADING) {
                  return SaralNovaShimmer.customerOrderShimmer();
                } else if (c.pageState.value == PageState.EMPTY) {
                  return EmptyView(
                    message: "No checkout orders at the moment",
                    title: "No checkout orders",
                    media: IconPath.empty,
                    // mediaSize: 500,
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
          CustomersKotCheckoutScreen.routeName,
          arguments: {
            "customer": customer,
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.fillColor),
            borderRadius: BorderRadius.circular(8),
            color: customer.isPaid == true
                ? Colors.green[200]
                : AppColors.fillFadedColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customer.tables != null && customer.tables!.isNotEmpty
                    ? Text(customer.tables?[0].name ?? "")
                    : const SizedBox.shrink(),
                // customer.createdAt != null
                //     ? Text(
                //         DateTimeHelper.prettyDateWithDay(customer.createdAt)!,
                //         style: CustomTextStyles.f14W400(
                //           color: AppColors.blackColor,
                //         ),
                //       )
                customer.createdAt != null
                    ? Text(
                        customer.createdAt!,
                        style: CustomTextStyles.f14W400(
                          color: AppColors.occupiedColor,
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            ),
            const Divider(
              color: AppColors.fillColor,
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  customer.customerName ?? "",
                  style: CustomTextStyles.f18W500(color: AppColors.primary),
                ),
                // if (customer.tableEmptyStatus == true)
                //   Container(
                //     padding:
                //         const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                //     decoration:
                //         BoxDecoration(borderRadius: BorderRadius.circular(8)),
                //     child: Text(
                //       "Empty Table",
                //       style:
                //           CustomTextStyles.f12W400(color: AppColors.errorColor),
                //     ),
                //   ),
                if (customer.isCancelled == true)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      "Cancelled",
                      style:
                          CustomTextStyles.f12W400(color: AppColors.errorColor),
                    ),
                  ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // if (customer.isPaid != null)
                //   RichText(
                //     text: TextSpan(
                //       children: [
                //         TextSpan(
                //           text: 'Status: ',
                //           style: CustomTextStyles.f12W400(
                //             color: AppColors.secondaryTextColor,
                //           ),
                //         ),
                //         TextSpan(
                //           text: customer.isPaid == false ? "Not paid" : "Paid",
                //           style: CustomTextStyles.f12W400(
                //             color: AppColors
                //                 .blackColor, // Example of different color for this segment
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),

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
                // const SizedBox(
                //   height: 5,
                // ),
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
                                .occupiedColor, // Example of different color for this segment
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
