import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/pos/pending_order_pos_controller.dart';
import 'package:saralnova/core/model/feature_model/pos/pending_orders_for_kot_model.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/features/widgets/common_widgets/empty_view.dart';
import 'package:saralnova/features/widgets/common_widgets/error_view.dart';
import 'package:saralnova/features/widgets/shimmers/list_shimmer.dart';

class KotScreenPOS extends StatelessWidget {
  static const String routeName = "/pending-order-screen";
  final c = Get.find<PendingOrderController>();
  KotScreenPOS({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Text("Pending Order"),
            Obx(() {
              if (c.pageState.value == PageState.LOADING) {
                return Expanded(
                    child: SaralNovaShimmer
                        .menuGridShimmer()); //TODO make shimmer according to the page
              } else if (c.pageState.value == PageState.EMPTY) {
                return EmptyView(
                  message: "No pending orders at the moment",
                  title: "No pending orders",
                  media: IconPath.nodata,
                );
              } else if (c.pageState.value == PageState.NORMAL) {
                return Expanded(
                  child: Obx(
                    () => GridView.builder(
                      key: const PageStorageKey("pending orders"),
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        // childAspectRatio: 1,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        mainAxisExtent: 250,
                      ),
                      itemCount: c.pendingOrders.length,
                      itemBuilder: (context, index) {
                        var pOrder = c.pendingOrders[index];

                        return PendingOrderBox(
                          pendingOrders: pOrder,
                          onCancel: () {},
                          onSuccess: () {},
                        );
                      },
                    ),
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
    );
  }
}

class PendingOrderBox extends StatelessWidget {
  final PendingOrders pendingOrders;
  final Function() onSuccess;
  final Function() onCancel;
  const PendingOrderBox({
    super.key,
    required this.pendingOrders,
    required this.onCancel,
    required this.onSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.borderColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "KOT #${pendingOrders.kotNumber.toString()}",
                  style: CustomTextStyles.f16W500(
                    color: AppColors.blackColor,
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      IconPath.circleCross,
                      height: 20,
                      width: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset(
                      IconPath.circleTick,
                      height: 26,
                      width: 26,
                    )
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            color: AppColors.borderColor,
            height: 10,
          ),
          Container(
            height: 200,
            padding: const EdgeInsets.all(4),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      pendingOrders.table ?? "",
                      style:
                          CustomTextStyles.f14W400(color: AppColors.blackColor),
                    ),
                    Text(
                      pendingOrders.createdAt ?? "",
                      style:
                          CustomTextStyles.f14W400(color: AppColors.blackColor)
                              .copyWith(fontStyle: FontStyle.italic),
                    )
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                if (pendingOrders.items!.isNotEmpty)
                  Flexible(
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: pendingOrders.items!.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 4,
                        );
                      },
                      itemBuilder: (context, index) {
                        var menuItem = pendingOrders.items![index];
                        return ListTile(
                          tileColor: AppColors.fillColor,
                          dense: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0, horizontal: 16.0),
                          title: Text(
                            menuItem.menuTitle ?? "",
                            style: CustomTextStyles.f14W400(
                                color: AppColors.blackColor),
                          ),
                          trailing: Text(menuItem.quantity != null
                              ? "x ${menuItem.quantity.toString()}"
                              : ""),
                        );
                      },
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
