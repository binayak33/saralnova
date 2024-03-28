import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/model/feature_model/booking_model/booking_model.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/core/utils/helpers/date_helper.dart';
import 'package:saralnova/features/screens/Feature/Booking/create_booking_screen.dart';
import 'package:saralnova/features/widgets/common_widgets/custom_alert_dialog.dart';
import 'package:saralnova/features/widgets/common_widgets/empty_view.dart';
import 'package:saralnova/features/widgets/common_widgets/error_view.dart';

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
                  return const Center(
                    child: LinearProgressIndicator(),
                  );
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
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Create"),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        foregroundColor: AppColors.scaffoldColor,
        backgroundColor: AppColors.primary,
        onPressed: () {
          Get.toNamed(CreateBookingScreen.routeName);
        },
        // child: Text("Create")
      ),
    );
  }
}

class BookingTile extends StatelessWidget {
  final Booking booking;
  final int index;

  BookingTile({
    super.key,
    required this.booking,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        border: Border.all(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: Column(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "S.N: $index ",
                    style:
                        CustomTextStyles.f12W400(color: AppColors.blackColor),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "#${booking.id}",
                    style:
                        CustomTextStyles.f12W600(color: AppColors.blackColor),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              RichText(
                text: TextSpan(
                  text: "Guest Name:   ",
                  style: CustomTextStyles.f14W400(color: AppColors.borderColor),
                  children: [
                    TextSpan(
                        text: booking.guest?.name ?? "",
                        style: CustomTextStyles.f16W500())
                  ],
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              RichText(
                text: TextSpan(
                  text: "Check-In:   ",
                  style: CustomTextStyles.f14W400(color: AppColors.borderColor),
                  children: [
                    TextSpan(
                      text: (booking.checkout != null
                          ? DateTimeHelper.prettyDateWithDay(booking.checkin)! +
                              " 12:00:00 AM"
                          : ""),
                      style: CustomTextStyles.f11W400(),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              RichText(
                text: TextSpan(
                  text: "Check-Out:   ",
                  style: CustomTextStyles.f14W400(color: AppColors.borderColor),
                  children: [
                    TextSpan(
                      text: (booking.checkout != null
                          ? DateTimeHelper.prettyDateWithDay(
                                  booking.checkout)! +
                              " 12:00:00 AM"
                          : ""),
                      style: CustomTextStyles.f11W400(),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 4,
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Payment Status: ",
                        style: CustomTextStyles.f14W400(
                            color: AppColors.borderColor),
                        children: [
                          TextSpan(
                            text: booking.paymentStatus ?? "",
                            style: CustomTextStyles.f14W500(),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    RichText(
                      text: TextSpan(
                        text: "Total Amt : ",
                        style: CustomTextStyles.f14W400(
                            color: AppColors.borderColor),
                        children: [
                          TextSpan(
                            text: (booking.totalAmount != null
                                ? "Rs. ${booking.totalAmount.toString()}"
                                : ""),
                            style: CustomTextStyles.f14W500(),
                          )
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: "Remaining Amt: ",
                        style: CustomTextStyles.f14W400(
                            color: AppColors.borderColor),
                        children: [
                          TextSpan(
                            text: (booking.remainingAmount != null
                                ? "Rs. ${booking.remainingAmount.toString()}"
                                : ""),
                            style: CustomTextStyles.f14W500(),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    RichText(
                      text: TextSpan(
                        text: "Gest count:   ",
                        style: CustomTextStyles.f14W400(
                            color: AppColors.borderColor),
                        children: [
                          TextSpan(
                            text: (booking.guestCount != null
                                ? booking.guestCount.toString()
                                : ""),
                            style: CustomTextStyles.f14W500(),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    RichText(
                      text: TextSpan(
                        text: "Status:   ",
                        style: CustomTextStyles.f14W400(
                            color: AppColors.borderColor),
                        children: [
                          TextSpan(
                            text: booking.status ?? "",
                            style: CustomTextStyles.f14W500(),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                children: [
                  // ClipRRect(
                  //   borderRadius: BorderRadius.circular(8),
                  //   child: SkyNetworkImage(
                  //     imageUrl: "",
                  //     height: 100,
                  //     width: 100,
                  //   ),
                  // ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: AppColors.orangeColor,
                        child: IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            IconPath.edit,
                            height: 18,
                            width: 18,
                            colorFilter: const ColorFilter.mode(
                                Colors.white, BlendMode.srcIn),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      CircleAvatar(
                          radius: 15,
                          backgroundColor: AppColors.errorColor,
                          child: IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext ctx) {
                                    return CustomAlertDialog(
                                        title: "Do you really want to delete ?",
                                        message: "You cannot undo this action",
                                        // onConfirm: onConfirmDelete,
                                        onConfirm: () {},
                                        confirmText: "Yes");
                                  });
                            },
                            icon: SvgPicture.asset(
                              IconPath.delete,
                              colorFilter: const ColorFilter.mode(
                                  Colors.white, BlendMode.srcIn),
                            ),
                          )),
                    ],
                  )
                ],
              ),
            ],
          )
        ]),
      ),
    );
  }
}
