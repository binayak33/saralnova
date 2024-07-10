import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/pos/place_order_pos_controller.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_elevated_button.dart';

class MakeOrderPosScreen extends StatelessWidget {
  static const String routeName = "/make-order-screen";
  final c = Get.find<PlaceOrderPosController>();
  MakeOrderPosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Ordered Items"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: RichText(
                text: TextSpan(
                  text: 'Items: ',
                  style: CustomTextStyles.f14W400(color: AppColors.blackColor),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' 3',
                      style: CustomTextStyles.f16W600(),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 250,
              width: Get.width,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.borderColor,
                  )),
              child: Text("Upper part"),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 250,
              width: Get.width,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.borderColor,
                  )),
              child: Text("Lower part"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SkyElevatedButton(
          onPressed: () {},
          title: "Place Order",
        ),
      ),
    );
  }
}
