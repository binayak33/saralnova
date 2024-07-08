import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/helpers/sky_network_image.dart';
import 'package:shimmer/shimmer.dart';

class SaralNovaShimmer {
  static Widget listShimmerheigh50() {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBase,
      highlightColor: AppColors.shimmerHighlight,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 15,
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemBuilder: (context, index) {
          return Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.splashBackgroundColor,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [],
            ),
          );
        },
      ),
    );
  }

  static Widget listShimmerheigh75() {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBase,
      highlightColor: AppColors.shimmerHighlight,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 15,
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemBuilder: (context, index) {
          return Container(
              // height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.shimmerBase,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.shimmerHighlight,
                    ),
                    height: 30,
                    width: 100,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.shimmerHighlight,
                    ),
                    height: 30,
                    width: 150,
                  ),
                ],
              ));
        },
      ),
    );
  }

  static Widget listShimmerheigh150() {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBase,
      highlightColor: AppColors.shimmerHighlight,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 15,
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.shimmerBase,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: const SkyNetworkImage(
                    imageUrl: "",
                    height: 70,
                    width: 70,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.shimmerBase,
                  ),
                  height: 30,
                  width: 200,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  static Widget bookingShimmer() {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBase,
      highlightColor: AppColors.shimmerHighlight,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 15,
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.shimmerBase,
            ),
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 20,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.shimmerHighlight,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 20,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.shimmerHighlight,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 20,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.shimmerHighlight,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 20,
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.shimmerHighlight,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 20,
                      width: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.shimmerHighlight,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 20,
                      width: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.shimmerHighlight,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 20,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.shimmerHighlight,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 20,
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.shimmerHighlight,
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  static Widget menuShimmer() {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBase,
      highlightColor: AppColors.shimmerHighlight,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 15,
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.shimmerBase,
            ),
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 20,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.shimmerHighlight,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 20,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.shimmerHighlight,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 20,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.shimmerHighlight,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 20,
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.shimmerHighlight,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 20,
                      width: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.shimmerHighlight,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 20,
                      width: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.shimmerHighlight,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: const SkyNetworkImage(
                        imageUrl: "",
                        height: 100,
                        width: 100,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 20,
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.shimmerHighlight,
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  // static Widget sellerProductsCard() {
  //   return Shimmer.fromColors(
  //     baseColor: AppColors.shimmerBase,
  //     highlightColor: AppColors.shimmerHighlight,
  //     child: SizedBox(
  //       height: Get.height,
  //       width: double.infinity,
  //       child: ListView.builder(
  //         shrinkWrap: true,
  //         physics: const AlwaysScrollableScrollPhysics(),
  //         padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8),
  //         scrollDirection: Axis.vertical,
  //         itemCount: 10,
  //         itemBuilder: (context, index) {
  //           return Container(
  //             margin: const EdgeInsets.only(bottom: 16),
  //             height: 100,
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(8),
  //               color: AppColors.shimmerBase,
  //             ),
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }

  // static Widget productGrid({SliverGridDelegate? gridDelegate}) {
  //   return Shimmer.fromColors(
  //     baseColor: AppColors.shimmerBase,
  //     highlightColor: AppColors.shimmerHighlight,
  //     child: GridView.builder(
  //       shrinkWrap: true,
  //       physics: const NeverScrollableScrollPhysics(),
  //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //         crossAxisCount: 2,
  //         childAspectRatio: 1,
  //         mainAxisSpacing: 10,
  //         crossAxisSpacing: 10,
  //       ),
  //       padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8),
  //       itemCount: 6,
  //       itemBuilder: (context, index) {
  //         return Container(
  //           width: 150,
  //           margin: const EdgeInsets.only(right: 8),
  //           decoration: BoxDecoration(
  //             color: AppColors.shimmerBase,
  //             borderRadius: BorderRadius.circular(8),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  // static Widget sellerComponent({SliverGridDelegate? gridDelegate}) {
  //   return Shimmer.fromColors(
  //     baseColor: AppColors.shimmerBase,
  //     highlightColor: AppColors.shimmerHighlight,
  //     child: GridView.builder(
  //       shrinkWrap: true,
  //       physics: const NeverScrollableScrollPhysics(),
  //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //         crossAxisCount: 2,
  //         mainAxisSpacing: 10,
  //         crossAxisSpacing: 10,
  //       ),
  //       padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8),
  //       itemCount: 4,
  //       itemBuilder: (context, index) {
  //         return Container(
  //           width: 150,
  //           margin: const EdgeInsets.only(right: 8),
  //           decoration: BoxDecoration(
  //             color: AppColors.shimmerBase,
  //             borderRadius: BorderRadius.circular(8),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  // static Widget productContainer() {
  //   return Shimmer.fromColors(
  //     baseColor: AppColors.shimmerBase,
  //     highlightColor: AppColors.shimmerHighlight,
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Container(
  //         height: 200,
  //         margin: const EdgeInsets.only(right: 8),
  //         decoration: BoxDecoration(
  //           color: AppColors.shimmerBase,
  //           borderRadius: BorderRadius.circular(8),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
