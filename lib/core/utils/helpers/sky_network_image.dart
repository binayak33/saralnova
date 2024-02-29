import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:saralnova/core/utils/constants/image_path.dart';
import 'package:saralnova/features/widgets/shimmers/image_shimmer.dart';

class SkyNetworkImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit boxFit;
  final double? height;
  final double? width;
  final String errorImage;
  final Widget? placeHolder;
  const SkyNetworkImage({
    super.key,
    required this.imageUrl,
    this.boxFit = BoxFit.cover,
    this.height,
    this.width,
    this.errorImage = ImagePath.placeHolder,
    this.placeHolder,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: boxFit,
      cacheKey: imageUrl,
      height: height,
      width: width,
      placeholder: (context, url) => placeHolder ?? const ImageShimmer(),
      errorWidget: (context, url, error) => Image.asset(
        errorImage,
        fit: boxFit,
      ),
    );
  }
}
