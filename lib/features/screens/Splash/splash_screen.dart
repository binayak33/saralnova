import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:saralnova/core/controllers/Splash/splash_controller.dart';
import 'package:saralnova/core/utils/constants/colors.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = "/splash-screen";
  final c = Get.find<SplashController>();
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashBackgroundColor,
      body: Center(
        // child: SvgPicture.asset(
        //   IconPath.logo,
        //   fit: BoxFit.contain,
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Lottie.asset(
              'assets/animations/saralnova-splash-animation.json',
            )
          ],
        ),
      ),
    );
  }
}
