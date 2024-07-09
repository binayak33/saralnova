import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/model/feature_model/order/order_model.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/features/screens/More/order/order_detail_screen.dart';

class OrderWidget extends StatelessWidget {
  final OrderModel order;
  final int index;

  const OrderWidget({
    super.key,
    required this.order,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Get.toNamed(OrderDetailScreen.routeName, arguments: {"order": order});
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: theme.cardColor,
          border: Border.all(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "S.N: $index ",
                          style: CustomTextStyles.f12W400(
                              color: AppColors.blackColor),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          order.createdAt ?? "",
                          style: CustomTextStyles.f12W600(
                              color: AppColors.blackColor),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    RichText(
                      text: TextSpan(
                        text: "Customer Name:   ",
                        style: CustomTextStyles.f14W400(
                            color: AppColors.borderColor),
                        children: [
                          TextSpan(
                              text:
                                  order.restaurantCustomer?.customerName ?? "",
                              style: CustomTextStyles.f16W500())
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    RichText(
                      text: TextSpan(
                        text: "Payment Method:   ",
                        style: CustomTextStyles.f14W400(
                            color: AppColors.borderColor),
                        children: [
                          TextSpan(
                              text: order.paymentMethod ?? "",
                              style: CustomTextStyles.f16W500())
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    RichText(
                      text: TextSpan(
                        text: "Paid By:   ",
                        style: CustomTextStyles.f14W400(
                            color: AppColors.borderColor),
                        children: [
                          TextSpan(
                              text: order.paidBy ?? "",
                              style: CustomTextStyles.f16W500())
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Details...",
                  style:
                      CustomTextStyles.f12W400(color: AppColors.hintTextColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
