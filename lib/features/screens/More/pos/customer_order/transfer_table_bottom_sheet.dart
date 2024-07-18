import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/More/orders/customer_orders/customers_KOT_controller.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/core/utils/helpers/validators.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_elevated_button.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_text_field.dart';

class TransferTableBottomSheet extends StatelessWidget {
  final c = Get.find<CustomersKOTCheckoutController>();
  TransferTableBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(),
      // height: MediaQuery.of(context).size.height * 0.75,
      width: Get.width,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: SingleChildScrollView(
        child: Form(
            key: c.transferTableKey,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    print(c.table.value?.id);
                    print(c.transferringTableController.text);
                  },
                  child: Text(
                    "Transfer table",
                    style:
                        CustomTextStyles.f16W600(color: AppColors.blackColor),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    width: Get.width,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.borderColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("${c.customer.value?.tables?[0].name}"))),
                const SizedBox(
                  height: 10,
                ),
                // SkyTextField(
                //   hint: "Select table",
                //   textInputAction: TextInputAction.done,
                //   textInputType: TextInputType.name,
                //   readOnly: true,
                //   onTap: () {},
                // ),
                SkyTextField(
                  hint: "Select a table",
                  controller: c.transferringTableController,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                  readOnly: true,
                  suffixIconPath: IconPath.down,
                  validator: (value) => Validator.validateEmpty(value!),
                  onTap: () {
                    // c.openTransferTableBottomSheet();
                    c.openAvailableTableBottomSheet();
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                SkyElevatedButton(
                  onPressed: () {
                    c.transferTable();
                  },
                  title: "Transfer",
                ),
              ],
            )),
      ),
    );
  }
}
