import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saralnova/core/model/feature_model/booking_model/booking_model.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/core/utils/helpers/date_helper.dart';
import 'package:saralnova/features/widgets/common_widgets/custom_alert_dialog.dart';

class BookingTile extends StatelessWidget {
  final Booking booking;
  final int index;

  const BookingTile({
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
