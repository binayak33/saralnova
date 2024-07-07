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
        title: Obx(
          () => Text(
            c.individualKotName.value ?? "Customer KOT",
            style: CustomTextStyles.f16W600(color: AppColors.scaffoldColor),
          ),
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
      floatingActionButton: InkResponse(
        radius: 20,
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: AppColors.primary,
          ),
          child: Text(
            "Checkout",
            style: CustomTextStyles.f16W600(
              color: AppColors.scaffoldColor,
            ),
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
    Color kotColor;
    if (kot.isServed == true) {
      kotColor = Colors.green[100]!;
    } else if (kot.isCancelled == true) {
      kotColor = Colors.red[100]!;
    } else if (kot.isPaid == true) {
      kotColor = Colors.yellow[100]!;
    } else {
      kotColor = Colors.white; // Default color
    }
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(8),
        color: kotColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            kot.kotNumber != null ? "KOT #${kot.kotNumber.toString()}" : "KOT",
            style: CustomTextStyles.f14W600(
              color: AppColors.blackColor,
            ),
          ),
          const Divider(
            color: AppColors.fillColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                kot.table?.name ?? "",
                style: CustomTextStyles.f12W400(
                  color: AppColors.blackColor,
                ),
              ),
              kot.createdAt != null
                  ? Text(
                      DateTimeHelper.prettyDateWithDay(kot.createdAt)!,
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
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Total: ',
                    style: CustomTextStyles.f12W400(
                      color: AppColors.secondaryTextColor,
                    ),
                  ),
                  TextSpan(
                    text: " Rs.${kot.salesTotal.toString()}",
                    style: CustomTextStyles.f12W400(
                      color: AppColors
                          .blackColor, // Example of different color for this segment
                    ),
                  ),
                ],
              ),
            ),
          if (kot.remainingAmount != null)
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Remaining: ',
                    style: CustomTextStyles.f12W400(
                      color: AppColors.secondaryTextColor,
                    ),
                  ),
                  TextSpan(
                    text: " Rs.${kot.remainingAmount.toString()}",
                    style: CustomTextStyles.f12W400(
                      color: AppColors
                          .blackColor, // Example of different color for this segment
                    ),
                  ),
                ],
              ),
            ),
          if (kot.discount != null && kot.discount != 0)
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Discount: ',
                    style: CustomTextStyles.f12W400(
                      color: AppColors.secondaryTextColor,
                    ),
                  ),
                  TextSpan(
                    text: " Rs.${kot.discount.toString()}",
                    style: CustomTextStyles.f12W400(
                      color: AppColors
                          .blackColor, // Example of different color for this segment
                    ),
                  ),
                ],
              ),
            ),
          if (kot.items!.isNotEmpty)
            SizedBox(
              // height: 150,
              child: ListView.separated(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: kot.items?.length ?? 0,
                itemBuilder: (context, index) {
                  var item = kot.items?[index];

                  if (item != null) {
                    Color itemColor;
                    if (item.isServed == true) {
                      itemColor = Colors.green[100]!;
                    } else if (item.isCancelled == true) {
                      itemColor = Colors.red[100]!;
                    } else if (item.isPaid == true) {
                      itemColor = Colors.yellow[100]!;
                    } else {
                      itemColor = Colors.white; // Default color
                    }
                    return Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          width: 1,
                          color: AppColors.borderColor,
                        ),
                        color: itemColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (item.menuTitle != null)
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Name: ',
                                        style: CustomTextStyles.f12W400(
                                          color: AppColors.secondaryTextColor,
                                        ),
                                      ),
                                      TextSpan(
                                        text: item.menuTitle,
                                        style: CustomTextStyles.f12W400(
                                          color: AppColors
                                              .blackColor, // Example of different color for this segment
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              if (item.quantity != null)
                                Text(
                                  "x ${item.quantity}",
                                  style: CustomTextStyles.f14W400(),
                                ),
                            ],
                          ),
                          if (item.total != null)
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Price: ',
                                    style: CustomTextStyles.f12W400(
                                      color: AppColors.secondaryTextColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "Rs. ${item.total}",
                                    style: CustomTextStyles.f12W400(
                                      color: AppColors
                                          .blackColor, // Example of different color for this segment
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(
                            height: 4,
                          ),
                          if (item.variantData != null &&
                              item.variantData!.isNotEmpty)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 2,
                                  );
                                },
                                itemCount: item.variantData!.length,
                                itemBuilder: (context, index) {
                                  var variant = item.variantData![index];
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          if (variant.title != null)
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: variant.type ?? "",
                                                    style: CustomTextStyles
                                                        .f12W400(
                                                      color: AppColors
                                                          .secondaryTextColor,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        " - ${variant.title ?? ""}",
                                                    style: CustomTextStyles
                                                        .f12W400(
                                                      color: AppColors
                                                          .blackColor, // Example of different color for this segment
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                      if (variant.price != null)
                                        Text("Rs. ${variant.price.toString()}"),
                                    ],
                                  );
                                },
                              ),
                            )
                        ],
                      ),
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
