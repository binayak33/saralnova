import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/More/orders/customer_orders/customers_KOT_controller.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';

class PaymentMethodBottomSheet extends StatelessWidget {
  final c = Get.find<CustomersKOTCheckoutController>();
  final Function(String paymentMethod) onSelectedPaymentMethod;
  PaymentMethodBottomSheet({
    super.key,
    required this.onSelectedPaymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        children: [
          Text(
            "Select payment methods",
            style: CustomTextStyles.f16W600(color: AppColors.blackColor),
          ),
          const Divider(
            color: AppColors.borderColor,
            endIndent: 10,
            indent: 10,
            height: 20,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              // onTap!(false);
              onSelectedPaymentMethod("Cash");
            },
            title: Text(
              "Cash",
              style: CustomTextStyles.f16W400(),
            ),
            dense: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            selected: true,
            style: ListTileStyle.drawer,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              // onTap!(false);
              onSelectedPaymentMethod("Card");
            },
            title: Text(
              "Card",
              style: CustomTextStyles.f16W400(),
            ),
            dense: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            selected: true,
            style: ListTileStyle.drawer,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
              // onTap!(false);
              onSelectedPaymentMethod("Credit");
            },
            title: Text(
              "Credit",
              style: CustomTextStyles.f16W400(),
            ),
            dense: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            selected: true,
            style: ListTileStyle.drawer,
          ),
          Obx(() {
            if (c.paymentMethods.isEmpty) {
              return const LinearProgressIndicator();
            } else {
              return ListView.builder(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: c.paymentMethods.length,
                itemBuilder: (context, index) {
                  var paymentType = c.paymentMethods[index];
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).pop();
                      // onTap!(false);
                      onSelectedPaymentMethod(paymentType.title ?? "Cash");
                    },
                    title: Text(
                      paymentType.title ?? "",
                      style: CustomTextStyles.f16W400(),
                    ),
                    dense: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    selected: true,
                    style: ListTileStyle.drawer,
                  );
                },
              );
            }
          }),
        ],
      ),
    );
  }
}
