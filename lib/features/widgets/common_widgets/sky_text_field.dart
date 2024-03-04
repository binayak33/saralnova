import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final List<TextInputFormatter>? inputFormatters;

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
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return TextFormField(
      onTapOutside: (event) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      focusNode: focusNode,
      inputFormatters: inputFormatters,
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
                style: CustomTextStyles.f16W400(color: AppColors.hintTextColor),
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
              color: (border == null) ? theme.colorScheme.outline : border!),
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
              color: (border == null) ? theme.colorScheme.primary : border!),
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
    );
  }
}

class ContainerTextField extends StatelessWidget {
  final FocusNode? focusNode;
  final String text;
  final String hint;
  final String icon;
  final bool enableDatePicker;
  final TextEditingController controller;
  final VoidCallback? onTap;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final bool? readOnly;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  const ContainerTextField({
    Key? key,
    required this.hint,
    required this.icon,
    this.focusNode,
    required this.text,
    this.enableDatePicker = false,
    required this.controller,
    this.onTap,
    this.textInputAction,
    this.textInputType,
    this.readOnly = false,
    this.validator,
    this.onChanged,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool hasFocus = focusNode?.hasFocus ?? false;

    return Focus(
      focusNode: focusNode,
      child: Builder(
        builder: (context) {
          bool hasFocus = Focus.of(context).hasFocus;

          return Container(
            padding: const EdgeInsets.only(left: 12, top: 8, bottom: 8),
            decoration: BoxDecoration(
              border: Border.all(
                color:
                    hasFocus ? AppColors.primary : AppColors.secondaryTextColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Flexible(
                  child: Container(
                    // width: 50,
                    // color: Colors.red,
                    child: SvgPicture.asset(icon),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    // color: Colors.yellow,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          text,
                          style: CustomTextStyles.f12W600(
                              color: AppColors.secondaryTextColor),
                        ),
                        //if overlaps put this sizebox
                        // const SizedBox(
                        //   height: 6,
                        // ),
                        SizedBox(
                          // color: Colors.green,
                          // height: 40,
                          child: TextFormField(
                            // style: CustomTextStyles.f16W400(),
                            style: CustomTextStyles.f14W500()
                                .copyWith(color: Colors.black),
                            onTapOutside: (event) {
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                            },
                            inputFormatters: inputFormatters,
                            focusNode: focusNode,
                            controller: controller,
                            validator: (validator != null) ? validator : null,
                            onTap: onTap,
                            onChanged: onChanged,
                            readOnly: readOnly ?? false,
                            keyboardType: textInputType,
                            textInputAction: textInputAction,
                            decoration: InputDecoration(
                                hintText: hint,
                                hintStyle: CustomTextStyles.f14W400(
                                    color: AppColors.secondaryTextColor),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}


 // contentPadding:
                            //     const EdgeInsets.symmetric(vertical: 10),
                            // contentPadding: const EdgeInsets.only(bottom: 16),
                            // contentPadding: contentPadding ??
                            //     const EdgeInsets.only(bottom: 16),