// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// class ErrorView extends StatelessWidget {
//   String? title, message;
//   String? media;
//   double mediaSize;
//   Widget? widget;

//   ErrorView(
//       {this.message,
//       this.title,
//       this.media,
//       this.widget,
//       this.mediaSize = 200});

//   @override
//   Widget build(BuildContext context) {
//     Widget mediaWidget = Image.asset("assets/images/somethingWentWrong.");
//     if (media != null) {
//       if (media!.contains("svg")) {
//         mediaWidget = SvgPicture.asset(
//           media!,
//           width: mediaSize,
//           height: mediaSize,
//         );
//       } else {
//         mediaWidget = Image.asset(
//           media!,
//         );
//       }
//     }
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               margin: EdgeInsets.all(16),
//               alignment: Alignment.center,
//               height: mediaSize,
//               child: mediaWidget,
//             ),
//             SizedBox(height: 8.0),
//             Text(
//               title ?? "Oops!",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
//               textAlign: TextAlign.center,
//             ),
//             Text(message ?? "Something went wrong, Please try again!",
//                 style: TextStyle(color: Colors.grey),
//                 textAlign: TextAlign.center),
//             SizedBox(height: 24.0),
//             widget ?? Container()
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';

class ErrorView extends StatelessWidget {
  final String imagePath;
  final String? errorTitle;
  final String? errorMessage;
  final double? imageHeight;
  const ErrorView({
    Key? key,
    required this.imagePath,
    this.errorMessage,
    this.imageHeight,
    this.errorTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: SvgPicture.asset(
              imagePath,
              fit: BoxFit.contain,
              height: imageHeight ?? Get.height / 2,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 32,
              right: 32,
            ),
            child: Column(
              children: [
                if (errorTitle != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      errorTitle!,
                      textAlign: TextAlign.center,
                      style:
                          CustomTextStyles.f20W600(color: AppColors.blackColor),
                    ),
                  ),
                if (errorMessage != null)
                  Text(
                    errorMessage!,
                    textAlign: TextAlign.center,
                    style:
                        CustomTextStyles.f18W400(color: AppColors.borderColor),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
