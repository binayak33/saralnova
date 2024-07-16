import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/More/orders/customer_orders/customers_KOT_controller.dart';
import 'package:saralnova/core/model/feature_model/pos/order_kot_model.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/core/utils/helpers/sky_network_image.dart';
import 'package:saralnova/features/widgets/shimmers/list_shimmer.dart';

import '../../../../../core/utils/constants/icon_path.dart';
import '../../../../../core/utils/enums/enums.dart';
import '../../../../widgets/common_widgets/empty_view.dart';
import '../../../../widgets/common_widgets/error_view.dart';

class CustomersKotCheckoutScreen extends StatelessWidget {
  static const String routeName = "/customer-kot-checkout-screen";
  final c = Get.find<CustomersKOTCheckoutController>();
  CustomersKotCheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppColors.primary,
        ),
        centerTitle: true,
        title: Obx(
          () => Text(
            "${c.customer.value?.customerName}- ${c.customer.value?.tables?[0].name}" ??
                "Customer KOT Checkout",
            style: CustomTextStyles.f16W600(),
          ),
        ),
        actions: [
          // GestureDetector(
          //   onTap: () {
          //     c.selectedMenuItemsId.clear();
          //   },
          //   child: Padding(
          //     padding: const EdgeInsets.only(right: 10),
          //     child: SvgPicture.asset(
          //       IconPath.clear,
          //       height: 20,
          //       width: 20,
          //     ),
          //   ),
          // ),

          Obx(
            () => IconButton(
              onPressed: () {
                c.selectedMenuItemsId.clear();
              },
              icon: badges.Badge(
                showBadge: c.selectedMenuItemsId.isNotEmpty,
                position: badges.BadgePosition.topEnd(top: -8, end: -5),
                badgeContent: Text(
                  c.selectedMenuItemsId.length > 9
                      ? "9+"
                      : "${c.selectedMenuItemsId.length}",
                  style: CustomTextStyles.f13W400(
                      color: AppColors.splashBackgroundColor),
                ),
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: AppColors.orangeColor,
                  shape: badges.BadgeShape.circle,
                ),
                child: SvgPicture.asset(
                  IconPath.clear,
                  height: 20,
                  width: 20,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Obx(() {
                if (c.pageState.value == PageState.LOADING) {
                  return SaralNovaShimmer.listShimmer150();
                } else if (c.pageState.value == PageState.EMPTY) {
                  return EmptyView(
                    message:
                        "No checkout orders for the ${c.customer.value?.customerName}",
                    title: "No Items at the momemnt",
                    media: IconPath.empty,
                    mediaSize: 500,
                  );
                } else if (c.pageState.value == PageState.NORMAL) {
                  return Obx(
                    () => ListView.separated(
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      padding: const EdgeInsets.only(bottom: 100),
                      itemCount: c.kitchenOrderTicketList.length,
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var customerKot = c.kitchenOrderTicketList[index];
                        return CustomerKotCard(
                          kot: customerKot,
                          onSelected: (Items items) {
                            c.toggleMenuItemSelection(items);
                          },
                          selectedMenuItemsId: c.selectedMenuItemsId,
                        );
                      },
                    ),
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
        onTap: () {
          if (c.selectedMenuItemsId.isNotEmpty) {
            c.isWholeCheckout.value = false;
          } else {
            c.isWholeCheckout.value = true;
            c.addAllServedValue();
          }
          // c.discountController.clear();
          c.openCheckoutBottomSheet();
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: AppColors.primary,
          ),
          child: Obx(
            () => Text(
              c.selectedMenuItemsId.isNotEmpty ? "Split Checkout" : "Checkout",
              style: CustomTextStyles.f16W600(
                color: AppColors.scaffoldColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomerKotCard extends StatelessWidget {
  final KitchenOrderTicket kot;
  final Function(Items items)? onSelected;
  final RxList<Items> selectedMenuItemsId;
  CustomerKotCard({
    super.key,
    required this.kot,
    this.onSelected,
    required this.selectedMenuItemsId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                kot.kotNumber != null
                    ? "KOT #${kot.kotNumber.toString()}"
                    : "KOT",
                style: CustomTextStyles.f14W600(
                  color: AppColors.blackColor,
                ),
              ),
              Text(kot.createdAt ?? "",
                  style: CustomTextStyles.f14W400(
                    color: AppColors.blackColor,
                  ).copyWith(fontStyle: FontStyle.italic)),
            ],
          ),
          const Divider(
            color: AppColors.fillColor,
          ),
          if (kot.items != null && kot.items!.isNotEmpty)
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: kot.items!.length,
              itemBuilder: (context, index) {
                var item = kot.items![index];

                return Obx(
                  () {
                    var isSelected = selectedMenuItemsId.contains(item);

                    return GestureDetector(
                      onTap: () {
                        if (onSelected != null) {
                          if (item.isCancelled != true && item.isPaid != true) {
                            // onSelected!(item.id!);
                            onSelected!(item);
                          }
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: isSelected
                                  ? AppColors.orangeColor
                                  : AppColors.borderColor),
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.fillFadedColor,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SkyNetworkImage(
                                  imageUrl: item.menuImg ?? "",
                                  height: 60,
                                  width: 60,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Flexible(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.menuTitle ?? "",
                                    style: CustomTextStyles.f18W400(),
                                  ),
                                  if (item.price != null)
                                    Text(
                                      "Rs. ${item.price}", //TODO need price
                                      style: CustomTextStyles.f14W400(),
                                    ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                            text: 'Qty: ',
                                            style: CustomTextStyles.f12W300(),
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: ' ${item.quantity}',
                                                style:
                                                    CustomTextStyles.f14W400(),
                                              )
                                            ]),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          if (item.isPaid == true)
                                            Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                  color: AppColors.greenColor,
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              child: Text(
                                                "Paid",
                                                style: CustomTextStyles.f10W400(
                                                    color: AppColors
                                                        .splashBackgroundColor),
                                              ),
                                            ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          if (item.isCancelled == true)
                                            Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                  color: AppColors.errorColor,
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              child: Text(
                                                "Cancelled",
                                                style: CustomTextStyles.f10W400(
                                                    color: AppColors
                                                        .splashBackgroundColor),
                                              ),
                                            ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          if (item.isServed == true)
                                            Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                  color: AppColors.bookingColor,
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              child: Text(
                                                "Served",
                                                style: CustomTextStyles.f10W400(
                                                    color: AppColors
                                                        .splashBackgroundColor),
                                              ),
                                            ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            )
        ],
      ),
    );
  }
}
