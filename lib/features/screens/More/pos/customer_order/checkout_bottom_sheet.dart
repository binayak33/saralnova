import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/More/orders/customer_orders/customers_KOT_controller.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/core/utils/helpers/sky_network_image.dart';
import 'package:saralnova/features/widgets/common_widgets/empty_view.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_elevated_button.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_text_field.dart';

class CheckoutBottomSheet extends StatelessWidget {
  // final c = Get.put(CustomerOrderController());
  final c = Get.find<CustomersKOTCheckoutController>();
  // final Function(Customer alreadyOrderedCustomer) onSelectOrderedCustomer;
  CheckoutBottomSheet({
    super.key,
    // required this.onSelectOrderedCustomer,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Selected menu items",
              style: CustomTextStyles.f16W600(color: AppColors.blackColor),
            ),
            const Divider(
              color: AppColors.borderColor,
              endIndent: 10,
              indent: 10,
              height: 20,
            ),
            Obx(
              () => Align(
                alignment: Alignment.centerRight,
                child: RichText(
                  text: TextSpan(
                      text: 'Subtotal = ',
                      style:
                          CustomTextStyles.f14W400(color: AppColors.textColor),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Rs. ${c.calculateSubtotal()}',
                          style: CustomTextStyles.f16W600(),
                        )
                      ]),
                ),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 100,
                child: SkyTextField(
                  controller: c.discountController,
                  hint: "Discount",
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.number,
                  // onValueChange: (value) {
                  //   c.discountText.value = value;
                  // },
                  onValueChange: (value) {
                    if (double.tryParse(value) != null) {
                      double discountValue = double.parse(value);
                      if (discountValue > c.calculateSubtotal().toDouble()) {
                        c.discountController.text =
                            c.calculateSubtotal().toString();
                        c.discountText.value = c.calculateSubtotal().toString();
                      } else {
                        c.discountText.value = value;
                      }
                    }
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Obx(
              () => Align(
                alignment: Alignment.centerRight,
                child: RichText(
                  text: TextSpan(
                      text: 'Grandtotal = ',
                      style:
                          CustomTextStyles.f14W400(color: AppColors.textColor),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Rs. ${c.calculateGrandTotal()}',
                          style: CustomTextStyles.f16W600(),
                        )
                      ]),
                ),
              ),
            ),
            Obx(
              () {
                if (c.selectedMenuItemsId.isNotEmpty) {
                  return ListView.separated(
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 6,
                      );
                    },
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: c.selectedMenuItemsId.length,
                    itemBuilder: (context, index) {
                      var item = c.selectedMenuItemsId[
                          index]; //instead of only id whole item store garnu paryo
                      return ListTile(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              color: AppColors.orangeColor, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onTap: () {
                          c.toggleMenuItemSelection(item);
                        },
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SkyNetworkImage(
                            imageUrl: item.menuImg ?? "",
                            width: 50,
                            height: 50,
                          ),
                        ),
                        title: Text(
                          item.menuTitle ?? "",
                          style: CustomTextStyles.f16W500(),
                        ),
                        subtitle:
                            Text(item.price != null ? "Rs. ${item.price}" : ""),
                        trailing: Text(
                            item.quantity != null ? "x ${item.quantity}" : ""),
                        dense: true,
                        tileColor: AppColors.errorColor,
                        selected: true,
                        style: ListTileStyle.drawer,
                      );
                    },
                  );
                } else {
                  return EmptyView(
                    mediaSize: 80,
                    message: "No items are selected",
                    title: "No Items",
                    media: IconPath.nodata,
                  );
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            SkyTextField(
              hint: "Paid By",
              controller: c.paidByController,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.name,
            ),
            const SizedBox(
              height: 10,
            ),
            SkyElevatedButton(onPressed: () {}, title: "Confirm checkout")
          ],
        ),
      ),
    );
  }
}
