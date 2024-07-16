import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/More/orders/customer_orders/customers_KOT_controller.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/core/utils/helpers/sky_network_image.dart';
import 'package:saralnova/core/utils/helpers/validators.dart';
import 'package:saralnova/features/widgets/common_widgets/empty_view.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_elevated_button.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_text_field.dart';

class CheckoutBottomSheet extends StatelessWidget {
  final c = Get.find<CustomersKOTCheckoutController>();
  CheckoutBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Obx(
      () => Container(
        height: c.enlarge == true
            ? MediaQuery.of(context).size.height * 0.95
            : MediaQuery.of(context).size.height * 0.75,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: SingleChildScrollView(
          child: Form(
            key: c.checkoutFormKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      height: 10,
                      width: 10,
                    ),
                    Text(
                      "Selected menu items",
                      style:
                          CustomTextStyles.f16W600(color: AppColors.blackColor),
                    ),
                    Obx(
                      () => GestureDetector(
                          onTap: () {
                            c.toggleBottomSheet();
                            // print(c.enlarge.value);
                          },
                          child: c.enlarge.value == false
                              ? SvgPicture.asset(
                                  IconPath.up,
                                )
                              : SvgPicture.asset(IconPath.down)),
                    )
                  ],
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
                          text: 'Sub Total = ',
                          style: CustomTextStyles.f14W400(
                              color: AppColors.textColor),
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
                      onTap: () {
                        c.enlarge.value = true;
                      },
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.number,
                      // onValueChange: (value) { //This doesnot handles when the textfield is empty
                      //   if (double.tryParse(value) != null) {
                      //     double discountValue = double.parse(value);
                      //     if (discountValue >
                      //         c.calculateSubtotal().toDouble()) {
                      //       c.discountController.text =
                      //           c.calculateSubtotal().toString();
                      //       c.discountText.value =
                      //           c.calculateSubtotal().toString();
                      //     } else {
                      //       c.discountText.value = value;
                      //     }
                      //   }

                      // },
                      onValueChange: (value) {
                        if (value.isEmpty) {
                          // Set discount to 0 if input is empty
                          c.discountText.value = '0';
                        } else if (double.tryParse(value) != null) {
                          double discountValue = double.parse(value);
                          if (discountValue >
                              c.calculateSubtotal().toDouble()) {
                            c.discountController.text =
                                c.calculateSubtotal().toString();
                            c.discountText.value =
                                c.calculateSubtotal().toString();
                          } else {
                            c.discountText.value = value;
                          }
                        } else {
                          // Set discount to 0 if input is invalid
                          c.discountText.value = '0';
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
                          text: 'Grand Total = ',
                          style: CustomTextStyles.f14W400(
                              color: AppColors.textColor),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Rs. ${c.calculateGrandTotal()}',
                              style: CustomTextStyles.f16W600(),
                            )
                          ]),
                    ),
                  ),
                ),
                if (c.isWholeCheckout.value == false)
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
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(item.price != null
                                      ? "Rs. ${item.price}"
                                      : ""),
                                  Text(item.total != null
                                      ? "Total Rs. ${item.total}"
                                      : ""),
                                ],
                              ),
                              trailing: Text(item.quantity != null
                                  ? "x ${item.quantity}"
                                  : ""),
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
                if (c.isWholeCheckout.value == true)
                  Obx(() {
                    return ListView.separated(
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 6,
                        );
                      },
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: c.wholeMenuItems.length,
                      itemBuilder: (context, index) {
                        var item = c.wholeMenuItems[
                            index]; //instead of only id whole item store garnu paryo
                        return ListTile(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: AppColors.orangeColor, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onTap: () {
                            // c.toggleMenuItemSelection(item);
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
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(item.price != null
                                  ? "Rs. ${item.price}"
                                  : ""),
                              Text(item.total != null
                                  ? "Total Rs. ${item.total}"
                                  : ""),
                            ],
                          ),
                          trailing: Text(item.quantity != null
                              ? "x ${item.quantity}"
                              : ""),
                          dense: true,
                          tileColor: AppColors.errorColor,
                          selected: true,
                          style: ListTileStyle.drawer,
                        );
                      },
                    );
                  }),
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
                SkyTextField(
                  readOnly: true,
                  onTap: () {
                    c.openPaymentMethodBottomSheet();
                  },
                  hint: "Payment method",
                  controller: c.paymentTypeController,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.name,
                  validator: (value) => Validator.validateEmpty(value!),
                ),
                const SizedBox(
                  height: 10,
                ),
                SkyElevatedButton(
                    onPressed: () {
                      if (c.isWholeCheckout.value == false) {
                        c.splitCheckout();
                      } else {
                        c.wholeCheckout();
                      }
                    },
                    title: "Confirm checkout")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
