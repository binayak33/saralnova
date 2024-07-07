import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saralnova/core/utils/constants/colors.dart';

class CustomTheme {
  static ThemeData basicTheme() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: AppColors.scaffoldColor,
      ),
    );
    return ThemeData.light().copyWith(
      scaffoldBackgroundColor: AppColors.scaffoldColor,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: AppColors.primary,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed),
      textTheme: getBasicTextTheme(),
      primaryColor: AppColors.primary,
      hintColor: AppColors.hintTextColor,
      cardColor: AppColors.cardColor,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        surface: AppColors.cardVariantColor,
        onSurface: AppColors.textColor,
        secondary: AppColors.secondaryColor,
        outline: AppColors.borderColor,
        outlineVariant: AppColors.secondaryTextColor,
        error: AppColors.errorColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.scaffoldColor,
        foregroundColor: AppColors.textColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(
          color: AppColors.textColor,
          fontFamily: "Plus Jakarta Sans",
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
          color: AppColors.textColor,
        ),
      ),
    );
  }

  static TextTheme getBasicTextTheme() {
    return ThemeData.light().textTheme.copyWith().apply(
          fontFamily: "Plus Jakarta Sans",
          bodyColor: AppColors.textColor,
        );
  }
}
