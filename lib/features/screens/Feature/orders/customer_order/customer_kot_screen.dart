import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Feature/orders/customer_orders/customers_KOT_controller.dart';
import 'package:saralnova/core/model/feature_model/order/order_kot_model.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';

import '../../../../../core/utils/constants/icon_path.dart';
import '../../../../../core/utils/enums/enums.dart';
import '../../../../../core/utils/helpers/date_helper.dart';
import '../../../../widgets/common_widgets/empty_view.dart';
import '../../../../widgets/common_widgets/error_view.dart';

class CustomersKotScreen extends StatelessWidget {
  static const String routeName = "/customer-kot-screen";
  final c = Get.find<CustomersKOTController>();
  CustomersKotScreen({super.key});

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
          "Customer KOT Orders",
          style: CustomTextStyles.f16W600(color: AppColors.scaffoldColor),
        ),
        actions: [
          IconButton(
              onPressed: () {
                print(c.customer);
              },
              icon: Icon(Icons.add))
        ],
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
                    itemCount: c.kitchenOrderTicketList.length,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var customerKot = c.kitchenOrderTicketList[index];
                      return CustomerKotCard(
                        kot: customerKot,
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

class CustomerKotCard extends StatelessWidget {
  final KitchenOrderTicket kot;
  CustomerKotCard({
    super.key,
    required this.kot,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                kot.restaurantCustomer?.customerName ?? "",
                style: CustomTextStyles.f16W600(
                  color: AppColors.primary,
                ),
              ),
              kot.restaurantCustomer?.createdAt != null
                  ? Text(
                      DateTimeHelper.prettyDateWithDay(
                          kot.restaurantCustomer?.createdAt)!,
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
          if (kot.salesTotal != null)
            Text(
              "Total Sales: ${kot.salesTotal.toString()}",
              style: CustomTextStyles.f12W400(
                color: AppColors.blackColor,
              ),
            ),
          if (kot.remainingAmount != null)
            Text(
              "Remaining Amount: ${kot.remainingAmount.toString()}",
              style: CustomTextStyles.f12W400(
                color: AppColors.blackColor,
              ),
            ),
          if (kot.paidAmount != null)
            Text(
              "Paid Amount: ${kot.paidAmount.toString()}",
              style: CustomTextStyles.f12W400(
                color: AppColors.blackColor,
              ),
            ),
          if (kot.advanceAmount != null)
            Text(
              "Advance Amount: ${kot.advanceAmount.toString()}",
              style: CustomTextStyles.f12W400(
                color: AppColors.blackColor,
              ),
            ),
          if (kot.items!.isNotEmpty)
            SizedBox(
              height: 150,
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: kot.items?.length ?? 0,
                itemBuilder: (context, index) {
                  var item = kot.items?[index];

                  if (item != null) {
                    return Container(
                      padding: const EdgeInsets.all(4),
                      child: Text("hahaha"),
                    );
                  } else {
                    return const Text("No Items Available");
                  }
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 5,
                  );
                },
              ),
            )
        ],
      ),
    );
  }
}
