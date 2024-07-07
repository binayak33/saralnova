import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/features/screens/Feature/Booking/create_booking_screen.dart';
import 'package:saralnova/features/widgets/app_widgets/boking_tile.dart';
import 'package:saralnova/features/widgets/common_widgets/custom_floating_action_button.dart';
import 'package:saralnova/features/widgets/common_widgets/empty_view.dart';
import 'package:saralnova/features/widgets/common_widgets/error_view.dart';
import 'package:saralnova/features/widgets/shimmers/list_shimmer.dart';

import '../../../../core/controllers/Feature/booking/booking_controller.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/custom_text_style.dart';
import '../../../../core/utils/enums/enums.dart';

class BookingScreen extends StatelessWidget {
  static const String routeName = "/booking-screen";
  final c = Get.find<BookingController>();
  BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppColors.scaffoldColor,
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        title: Text(
          "Booking",
          style: CustomTextStyles.f16W600(color: AppColors.scaffoldColor),
        ),
      ),
      body: SingleChildScrollView(
        controller: c.scrollController,
        key: const PageStorageKey("Bookings"),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Obx(() {
                if (c.pageState.value == PageState.LOADING) {
                  return SaralNovaShimmer.bookingShimmer();
                } else if (c.pageState.value == PageState.EMPTY) {
                  return EmptyView(
                    message: "Empty!!",
                    title: "Empty",
                    media: IconPath.empty,
                    mediaSize: Get.height / 2,
                  );
                } else if (c.pageState.value == PageState.NORMAL) {
                  return ListView.builder(
                    key: const Key('builder}'),
                    itemCount: c.bookingList.length,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var booking = c.bookingList[index];

                      return BookingTile(
                        index: index + 1,
                        booking: booking,
                      );
                    },
                  );
                } else {
                  return const ErrorView(
                    errorTitle: "Something went wrong!!",
                    errorMessage: "Something went wrong",
                    imagePath: IconPath.errorimg,
                  );
                }
              }),
              Obx(
                () => c.nextPageUrl.value != null
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          // child: CircularProgressIndicator(),
                          child: CupertinoActivityIndicator(),
                        ),
                      )
                    : Container(),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          Get.toNamed(CreateBookingScreen.routeName);
        },
      ),
    );
  }
}
