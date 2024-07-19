import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/More/order/order_controller.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/features/widgets/app_widgets/order_widget.dart';
import 'package:saralnova/features/widgets/common_widgets/custom_appBar.dart';
import 'package:saralnova/features/widgets/common_widgets/empty_view.dart';
import 'package:saralnova/features/widgets/common_widgets/error_view.dart';
import 'package:saralnova/features/widgets/shimmers/list_shimmer.dart';

class OrderScreen extends StatelessWidget {
  static const String routeName = "/order-screen";
  final c = Get.find<OrderController>();
  OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:const  SaralNovaApppBar(
        title: "Orders",
      ),
      body: SingleChildScrollView(
        controller: c.scrollController,
        key: const PageStorageKey("orders"),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Obx(() {
                if (c.pageState.value == PageState.LOADING) {
                  return SaralNovaShimmer.orderShimmer();
                } else if (c.pageState.value == PageState.EMPTY) {
                  return EmptyView(
                    message: "No orders available at the moment",
                    title: "No data available",
                    media: IconPath.empty,
                    mediaSize: Get.height / 2,
                  );
                } else if (c.pageState.value == PageState.NORMAL) {
                  return ListView.builder(
                    key: const Key('builder}'),
                    itemCount: c.orders.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var order = c.orders[index];

                      return OrderWidget(
                        index: index + 1,
                        order: order,
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
              }),
              Obx(
                () => c.nextPageUrl.value != null
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: CupertinoActivityIndicator(),
                        ),
                      )
                    : Container(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
