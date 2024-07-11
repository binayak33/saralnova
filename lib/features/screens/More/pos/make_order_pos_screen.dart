import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/pos/place_order_pos_controller.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/core/utils/helpers/sky_network_image.dart';
import 'package:saralnova/core/utils/helpers/validators.dart';
import 'package:saralnova/features/widgets/common_widgets/empty_view.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_elevated_button.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_text_field.dart';

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
        actions: [
          Obx(
            () => RichText(
              text: TextSpan(
                text: 'Items: ',
                style: CustomTextStyles.f12W400(color: AppColors.blackColor),
                children: <TextSpan>[
                  TextSpan(
                    text: c.selectedMenuList.length.toString(),
                    style: CustomTextStyles.f16W600(),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Container(
                height: 300,
                width: Get.width,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.borderColor,
                    )),
                child: Obx(() {
                  if (c.selectedMenuList.isEmpty) {
                    return EmptyView(
                      message: "Please select menu that you want to order.",
                      title: "No menu is selected",
                      media: IconPath.nodata,
                      mediaSize: 150,
                    );
                  } else {
                    return ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var selectedMenu = c.selectedMenuList[index];

                          return Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                    color: AppColors.fillColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        8,
                                      ),
                                    )),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: SkyNetworkImage(
                                        imageUrl: selectedMenu.imageUrl ?? "",
                                        height: 50,
                                        width: 50,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        selectedMenu.title ?? "",
                                        style: CustomTextStyles.f14W400(
                                            color: AppColors.blackColor),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 70,
                                      height: 60,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  c.decrementQuantity(
                                                      selectedMenu);
                                                },
                                                child: SvgPicture.asset(
                                                  IconPath.circleMinus,
                                                  height: 15,
                                                  width: 15,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              Obx(
                                                () => Text(
                                                  c
                                                      .getQuantity(selectedMenu)
                                                      .toString(),
                                                  style: CustomTextStyles
                                                      .f18W500(),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  c.incrementQuantity(
                                                      selectedMenu);
                                                },
                                                child: SvgPicture.asset(
                                                  IconPath.circlePlus,
                                                  height: 15,
                                                  width: 15,
                                                ),
                                              )
                                            ],
                                          ),
                                          Text(
                                              "Total: ${selectedMenu.price! * c.getQuantity(selectedMenu)}")
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Positioned(
                                  left: 0,
                                  top: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      // c.selectedMenuList.removeWhere(
                                      //     (item) => item.id == selectedMenu.id);
                                      // c.itemQuantities.remove(selectedMenu.id);
                                      // c.updateTotalAmount();
                                      c.removeFromSelected(selectedMenu);
                                    },
                                    child: SvgPicture.asset(
                                      IconPath.billCancel,
                                      height: 20,
                                      width: 20,
                                    ),
                                  ))
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemCount: c.selectedMenuList.length);
                  }
                }),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: Get.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.borderColor,
                  ),
                ),
                child: Form(
                  key: c.placeKotFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => RichText(
                          text: TextSpan(
                              text: 'Total: ',
                              style: CustomTextStyles.f14W400(),
                              children: <TextSpan>[
                                TextSpan(
                                  text: "Rs. ${c.totalAmount.value.toString()}",
                                  style: CustomTextStyles.f16W600(),
                                )
                              ]),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Obx(
                        () => SkyTextField(
                          hint: c.isCustomerNameFieldEnabled.value == true
                              ? "Add new customer"
                              : "Select customer",
                          controller: c.selectedCustomerNameController,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.name,
                          readOnly: true,
                          suffixIconPath: IconPath.down,
                          onTap: () {
                            c.openSelectCustomerBottomSheet();
                          },
                        ),
                      ),
                      Obx(() {
                        if (c.isCustomerNameFieldEnabled.value == true) {
                          return const SizedBox(
                            height: 16,
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      }),
                      Obx(() {
                        if (c.isCustomerNameFieldEnabled.value == true) {
                          return SkyTextField(
                            hint: "Customer Name",
                            focusNode: c.customerNameFocusNode,
                            controller: c.newlyAddedCustomerNameController,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.name,
                            validator: (value) =>
                                Validator.validateEmpty(value!),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      }),
                      const SizedBox(
                        height: 16,
                      ),
                      SkyTextField(
                        hint: "Select a table",
                        controller: c.tableController,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.name,
                        readOnly: true,
                        suffixIconPath: IconPath.down,
                        validator: (value) => Validator.validateEmpty(value!),
                        onTap: () {
                          c.openAvailableTableBottomSheet();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => SkyElevatedButton(
            color: c.selectedMenuList.isNotEmpty
                ? AppColors.primary
                : AppColors.borderColor,
            onPressed: () {
              if (c.selectedMenuList.isNotEmpty) {
                c.placeKotOrder();
              }
            },
            title: "Place Order",
          ),
        ),
      ),
    );
  }
}
