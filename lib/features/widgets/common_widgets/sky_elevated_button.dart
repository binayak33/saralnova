import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';

class SkyElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isDisabled;
  final String title;
  final String? suffixIconPath;
  final String? prefixIconPath;
  final double radius;
  final Color? color;
  final double height;
  final double? width;
  final TextStyle? textStyle;
  const SkyElevatedButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.suffixIconPath,
    this.prefixIconPath,
    this.radius = 4,
    this.color,
    this.isDisabled = false,
    this.height = 50,
    this.textStyle,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: color ?? theme.colorScheme.primary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius)),
          minimumSize:
              width != null ? Size(width!, height) : Size.fromHeight(height),
          maximumSize: width != null ? Size(width!, height) : null),
      onPressed: (isDisabled)
          ? null
          : () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
              onPressed!();
            },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (prefixIconPath != null)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: SvgPicture.asset(
                prefixIconPath!,
                height: 24,
                width: 24,
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
          Text(
            title,
            style: textStyle ?? CustomTextStyles.f16W400(color: Colors.white),
          ),
          if (suffixIconPath != null)
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: SvgPicture.asset(
                suffixIconPath!,
                height: 24,
                width: 24,
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
        ],
      ),
    );
  }
}

class SkyOutlineButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isDisabled;
  final String title;
  final String? suffixIconPath;
  final String? prefixIconPath;
  final double radius;
  final Color? color;
  final double height;
  final double? width;
  final TextStyle? textStyle;
  const SkyOutlineButton({
    Key? key,
    required this.onPressed,
    required this.title,
    this.suffixIconPath,
    this.prefixIconPath,
    this.radius = 4,
    this.color,
    this.isDisabled = false,
    this.height = 50,
    this.textStyle,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          // backgroundColor: color ?? theme.colorScheme.primary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius)),
          minimumSize:
              width != null ? Size(width!, height) : Size.fromHeight(height),
          maximumSize: width != null ? Size(width!, height) : null),
      onPressed: (isDisabled)
          ? null
          : () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
              onPressed!();
            },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (prefixIconPath != null)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: SvgPicture.asset(
                prefixIconPath!,
                height: 24,
                width: 24,
                colorFilter:
                    const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
              ),
            ),
          Text(
            title,
            style:
                textStyle ?? CustomTextStyles.f16W400(color: AppColors.primary),
          ),
          if (suffixIconPath != null)
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: SvgPicture.asset(
                suffixIconPath!,
                height: 24,
                width: 24,
                colorFilter:
                    const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
              ),
            ),
        ],
      ),
    );
  }
}
