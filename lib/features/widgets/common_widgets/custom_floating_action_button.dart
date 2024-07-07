import 'package:flutter/material.dart';
import 'package:saralnova/core/utils/constants/colors.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final Function() onPressed;
  const CustomFloatingActionButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(),
      onPressed: onPressed,
      child: const Icon(
        Icons.add,
        color: AppColors.splashBackgroundColor,
      ),
    );
  }
}
