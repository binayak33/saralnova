// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';

// class CustomLoadingDialog extends StatelessWidget {
//   final double? width;
//   final bool backgroundColor;
//   final bool radius;

//   const CustomLoadingDialog(
//       {this.width, this.backgroundColor = true, this.radius = true});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             width: width ?? 120,
//             decoration: BoxDecoration(
//               color: backgroundColor ? Colors.white : null,
//               borderRadius: radius ? BorderRadius.circular(8) : null,
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Lottie.asset(
//                   height: 60,
//                   width: 60,
//                   'assets/animations/saralnova-loading.json',

//                   // 'assets/animations/saralnova-splash-animation.json',
//                   // frameRate: FrameRate.max,
//                   // frameRate: FrameRate(1000),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// void showLoadingDialog(BuildContext context, {Widget? loadingWidget}) {
//   showDialog(
//     barrierDismissible: false,
//     context: context,
//     builder: (BuildContext context) =>
//         loadingWidget ?? const CustomLoadingDialog(),
//   );
// }

// void hideLoadingDialog(BuildContext context, {Widget? loadingWidget}) {
//   Navigator.of(context).pop(loadingWidget ?? const CustomLoadingDialog());
// }

// -------------loader

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

import '../../../core/utils/constants/icon_path.dart';

// class LogoLoading {
//   SimpleFontelicoProgressDialog loading = SimpleFontelicoProgressDialog(
//     context: Get.context!,
//     barrierDimisable: false,
//   );

//   void show({String message = "Please Wait..."}) {
//     loading.show(
//         height: 112,
//         width: 112,
//         radius: 8,
//         type: SimpleFontelicoProgressDialogType.custom,
//         message: message,
//         textStyle: CustomTextStyles.f12W600(color: AppColors.primary),
//         loadingIndicator:
//             Lottie.asset(IconPath.loadingJson, height: 56, width: 56));
//   }

//   void hide() {
//     loading.hide();
//   }
// }

class LogoLoading {
  static SimpleFontelicoProgressDialog loading = SimpleFontelicoProgressDialog(
    context: Get.context!,
    barrierDimisable: false,
  );

  void show({String message = "Loading..."}) {
    loading.show(
        radius: 10,
        message: message,
        // indicatorColor: AppColors.backGroundColor,
        type: SimpleFontelicoProgressDialogType.custom,
        backgroundColor: AppColors.scaffoldColor,
        // indicatorColor: AppColors.primary,
        loadingIndicator:
            Lottie.asset(IconPath.loadingJson, height: 56, width: 56));
  }

  void hide() {
    loading.hide();
  }
}
