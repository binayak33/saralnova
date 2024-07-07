import 'package:flutter/material.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';

class SaralNovaApppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const SaralNovaApppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      iconTheme: const IconThemeData(
        color: AppColors.scaffoldColor, //change your color here
      ),
      centerTitle: true,
      title: Text(
        title,
        style: CustomTextStyles.f16W600(color: AppColors.scaffoldColor),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
