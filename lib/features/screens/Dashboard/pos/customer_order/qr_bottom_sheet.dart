import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/More/orders/customer_orders/customers_KOT_controller.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/core/utils/helpers/sky_network_image.dart';

class QrBottomSheet extends StatelessWidget {
  final c = Get.find<CustomersKOTCheckoutController>();
  final String? qrString;
  final String? paymentMethod;
  QrBottomSheet({
    super.key,
    required this.qrString,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back,
                  )),
              GestureDetector(
                onTap: () {
                  print(qrString);
                },
                child: Text(
                  "$paymentMethod QR",
                  style: CustomTextStyles.f16W600(
                      color: paymentMethod == "Khalti"
                          ? AppColors.khaltiColor
                          : AppColors.esewaColor),
                ),
              ),
              const SizedBox(
                height: 10,
                width: 10,
              )
            ],
          ),
          const Divider(
            color: AppColors.borderColor,
            endIndent: 10,
            indent: 10,
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: paymentMethod == "Khalti"
                    ? AppColors.khaltiColor
                    : AppColors.esewaColor,
                borderRadius: BorderRadius.circular(10)),
            child: Container(
              color: AppColors.splashBackgroundColor,
              child: SkyNetworkImage(
                imageUrl: qrString ?? "",
                height: 250,
                width: 250,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
