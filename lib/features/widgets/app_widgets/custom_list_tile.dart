import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final Function()? onTap;
  final String iconPath;
  const CustomListTile({
    super.key,
    required this.title,
    required this.iconPath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(
        iconPath,
        height: 20,
        width: 20,
      ),
      title: Text(title),
      onTap: onTap,
    );
  }
}
