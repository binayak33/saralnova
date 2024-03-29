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
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(CustomersKotScreen.routeName, arguments: {
                            "customer":customer,
                          });
                        },
                        child: CustomerCard(
                          customer: customer,
                        ),
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
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(8),
          color: customer.isPaid == true
              ? Colors.green[200]
              : AppColors.shadowColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                customer.customerName ?? "",
                style: CustomTextStyles.f16W600(
                  color: AppColors.primary,
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
          Text(
            customer.isPaid == false ? "Not paid" : "Paid",
            style: CustomTextStyles.f12W400(
              color: AppColors.blackColor,
            ),
          ),
        ],
      ),
    );
  }
}
