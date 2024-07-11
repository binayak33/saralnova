import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/More/orders/customer_orders/customer_order_controller.dart';
import 'package:saralnova/core/model/feature_model/pos/order_customers_model.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';

class SelectCustomerBottomSheet extends StatelessWidget {
  final c = Get.put(CustomerOrderController());
  final Function(Customer alreadyOrderedCustomer) onSelectOrderedCustomer;
  final Function(bool isEnabled)? onTap;
  SelectCustomerBottomSheet({
    super.key,
    required this.onSelectOrderedCustomer,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        children: [
          Text(
            "Select Ordered Customer",
            style: CustomTextStyles.f16W600(color: AppColors.blackColor),
          ),
          const Divider(
            color: AppColors.borderColor,
            endIndent: 10,
            indent: 10,
            height: 20,
          ),
          ListTile(
            dense: true,
            title: Text(
              "Add new customer",
              style: CustomTextStyles.f16W400(),
            ),
            onTap: () {
              if (onTap != null) {
                onTap!(true);
              }
              Navigator.of(context).pop();
            },
          ),
          Obx(() {
            if (c.customerList.isEmpty) {
              return const LinearProgressIndicator();
            } else {
              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: c.customerList.length,
                  itemBuilder: (context, index) {
                    var alreadyOrderedCustomer = c.customerList[index];
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).pop();
                        onTap!(false);
                        onSelectOrderedCustomer(alreadyOrderedCustomer);
                      },
                      title: Text(
                        alreadyOrderedCustomer.customerName ?? "",
                        style: CustomTextStyles.f16W400(),
                      ),
                      dense: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      tileColor: AppColors.errorColor,
                      selected: true,
                      style: ListTileStyle.drawer,
                    );
                  },
                ),
              );
            }
          })
        ],
      ),
    );
  }
}