import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';

class SkyTextField extends StatelessWidget {
  final Function(String)? onValueChange;
  final String hint;
  final String? prefixIconPath;
  final Widget? prefixIcon;
  final String? suffixIconPath;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final Color? border;
  final bool? readOnly;
  final bool? showError;
  final bool? autofocus;
  final Function()? onTap;
  final Function(String)? onSubmitted;
  final TextCapitalization textCapitalization;
  final Color? fillColor;
  final bool showLable;
  final bool obscureText;
  final FocusNode? focusNode;
  final double borderRadius;

  const SkyTextField({
    Key? key,
    required this.hint,
    this.prefixIconPath,
    this.suffixIconPath,
    this.onValueChange,
    this.controller,
    this.validator,
    required this.textInputAction,
    required this.textInputType,
    this.border,
    this.readOnly = false,
    this.showError = true,
    this.textCapitalization = TextCapitalization.sentences,
    this.onTap,
    this.onSubmitted,
    this.autofocus = false,
    this.showLable = false,
    this.fillColor,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.focusNode,
    this.borderRadius = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          hint,
          style: CustomTextStyles.f16W500(color: AppColors.textColor),
        ),
        const SizedBox(
          height: 12,
        ),
        TextFormField(
          onTapOutside: (event) {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          focusNode: focusNode,
          obscureText: obscureText,
          autofocus: autofocus!,
          textCapitalization: textCapitalization,
          onFieldSubmitted: onSubmitted,
          onTap: (onTap != null) ? onTap! : null,
          readOnly: (readOnly == null) ? false : readOnly!,
          keyboardType: textInputType,
          textInputAction: textInputAction,
          maxLines: 1,
          validator: (validator != null) ? validator : null,
          controller: (controller != null) ? controller : null,
          // onChanged: (text) {
          //   if (onValueChange != null) {
          //     onValueChange!(text);
          //   }
          // },
          onChanged: onValueChange,
          decoration: InputDecoration(
            label: showLable
                ? Text(
                    hint,
                    style: CustomTextStyles.f16W400(color: theme.hintColor),
                  )
                : null,
            fillColor: fillColor ?? Colors.transparent,
            filled: true,
            prefixIcon: (prefixIconPath != null)
                ? SvgPicture.asset(
                    prefixIconPath!,
                    fit: BoxFit.scaleDown,
                    colorFilter:
                        ColorFilter.mode(theme.primaryColor, BlendMode.srcIn),
                  )
                : prefixIcon,
            suffixIcon: (suffixIconPath != null)
                ? SvgPicture.asset(suffixIconPath!, fit: BoxFit.scaleDown)
                : suffixIcon,
            contentPadding: const EdgeInsets.all(10),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              borderSide: BorderSide(
                  width: 1,
                  color:
                      (border == null) ? theme.colorScheme.outline : border!),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              borderSide: BorderSide(
                  width: 1,
                  color: (border == null) ? theme.colorScheme.error : border!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              borderSide: BorderSide(
                  width: 1,
                  color:
                      (border == null) ? theme.colorScheme.primary : border!),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              borderSide: BorderSide(width: 1, color: theme.colorScheme.error),
            ),
            errorStyle: (showError!)
                ? const TextStyle(fontSize: 12)
                : const TextStyle(fontSize: 0),
            hintText: hint,
            hintStyle: CustomTextStyles.f16W400(color: theme.hintColor),
          ),
          style: CustomTextStyles.f16W400(),
        ),
      ],
    );
  }
}
