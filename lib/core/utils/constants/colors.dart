import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF5140b2);
  static const Color secondaryColor = Color(0xFF252526);
  static const Color splashBackgroundColor = Colors.white;

  // Scaffold Colors
  static const Color scaffoldColor =
      Color.fromRGBO(233, 231, 231, 1); //TODO  choose specific color from figma

  // Common Colors
  static const Color borderColor = Color(0xFFB6B6B6);
  static const Color blackColor = Colors.black;
  static const Color fillColor = Color.fromARGB(255, 219, 219, 219);
  static const Color orangeColor = Colors.orange;
  static final Color shadowColor = Colors.black.withOpacity(0.1);

  // Text Colors
  static const Color hintTextColor = Color(0xFF8F8F8F);
  static const Color textColor = Color(0xFF374151);
  static const Color errorColor = Color(0xFFDC3545);
  static const Color secondaryTextColor = Color(0xFF8F8F8F);

  // Card Colors
  static const Color cardColor = Color(0xFFF5F6F9);
  static const Color cardVariantColor = Color(0xFFE8EAED);

  //Rooms Colors
  static const Color reservedColor = Color(0xFF8F8F8F);
  static const Color bookingColor = Color.fromRGBO(68, 190, 165, 1);
  static const Color occupiedColor = Color(0xFF5140B2);
  static const Color repairingColor = Color(0xFFF94F82);

  //Shimmer Colors
  static final Color shimmerBase = Colors.grey.withOpacity(0.40);
  static const Color shimmerHighlight = Color(0xFFE1E1E1);
  static final Color shimmerBaseLight = Colors.grey.withOpacity(0.10);

  //Box Colors
  static final Color box1 = Color(0xFFF2C4DE);
  static final Color box2 = Color(0xFFFFFFE1);
  static final Color box3 = Color(0xFFA9B5D9);
  static final Color box4 = Color(0xFFC4D7D1);
  static final Color box5 = Color(0xFFF2DDD0);
  static final Color box6 = Color(0xFFD9BCF2);
  static final Color box7 = Color(0xFFFEF4FF);
  static final Color box8 = Color(0xFFDEE3FF);
}
