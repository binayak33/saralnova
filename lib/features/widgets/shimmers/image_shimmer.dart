import 'package:flutter/material.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:shimmer/shimmer.dart';

class ImageShimmer extends StatelessWidget {
  const ImageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBase,
      highlightColor: AppColors.shimmerHighlight,
      child: Container(
        color: AppColors.shimmerBase,
      ),
    );
  }
}
