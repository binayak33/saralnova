import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/features/screens/Feature/Booking/create_booking_screen.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_elevated_button.dart';

class BookSuccessScreen extends StatelessWidget {
  const BookSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SvgPicture.asset(IconPath.successBook),
          SkyElevatedButton(
              onPressed: () {
                Get.offAllNamed(CreateBookingScreen.routeName);
              },
              title: "Go to Home")
        ],
      ),
    );
  }
}
