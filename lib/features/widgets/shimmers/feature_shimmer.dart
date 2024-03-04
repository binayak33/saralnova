import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:shimmer/shimmer.dart';

class FeatureShimmer {
  static Widget roomTypeGrid({SliverGridDelegate? gridDelegate}) {
    return Shimmer.fromColors(
        baseColor: AppColors.shimmerBase,
        highlightColor: AppColors.shimmerHighlight,
        child: ListView.separated(
            itemCount: 10,
            shrinkWrap: true,
            physics: AlwaysScrollableScrollPhysics(),
            separatorBuilder: (_, __) => const SizedBox(height: 11),
            itemBuilder: (context, index) {
              return Container(
                height: 55,
                decoration: BoxDecoration(
                    color: AppColors.borderColor,
                    borderRadius: BorderRadius.circular(4)),
              );
            }));
  }

  static Widget FacilitiesGrid() {
    return Shimmer.fromColors(
        baseColor: AppColors.shimmerBase,
        highlightColor: AppColors.shimmerHighlight,
        child: ListView.separated(
            itemCount: 10,
            shrinkWrap: true,
            physics: AlwaysScrollableScrollPhysics(),
            separatorBuilder: (_, __) => const SizedBox(height: 11),
            itemBuilder: (context, index) {
              return Container(
                height: 80,
                decoration: BoxDecoration(
                    color: AppColors.borderColor,
                    borderRadius: BorderRadius.circular(4)),
              );
            }));
  }

  static Widget AminitiesGrid() {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBase,
      highlightColor: AppColors.shimmerHighlight,
      child: ListView.separated(
        itemCount: 10,
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        separatorBuilder: (_, __) => const SizedBox(height: 11),
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.borderColor,
              ),
              color: Colors.white,
            ),
            margin: const EdgeInsets.only(bottom: 10),
            height: 70,
            child: Row(children: [
              Container(
                height: 75,
                width: 72,
                decoration: BoxDecoration(
                  color: AppColors.borderColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              SizedBox(
                width: 25,
              ),
              Container(
                height: 17,
                width: 180,
                decoration: BoxDecoration(
                  color: AppColors.borderColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ]),
          );
        },
      ),
    );
  }

  static Widget ViewRoomsGrid() {
    return Shimmer.fromColors(
        baseColor: AppColors.shimmerBase,
        highlightColor: AppColors.shimmerHighlight,
        child: ListView.separated(
            itemCount: 10,
            shrinkWrap: true,
            physics: AlwaysScrollableScrollPhysics(),
            separatorBuilder: (_, __) => const SizedBox(height: 11),
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    // color: AppColors.scaffoldColor,
                    border: Border.all(
                      color: AppColors.borderColor,
                    ),
                    borderRadius: BorderRadius.circular(4)),
                height: 70,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 17,
                        width: 100,
                        decoration: BoxDecoration(
                          color: AppColors.borderColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 270,
                        child: Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: AppColors.borderColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Container(
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: AppColors.borderColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Container(
                                  height: 10,
                                  decoration: BoxDecoration(
                                    color: AppColors.borderColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
              );
            }));
  }

  static Widget ViewStaffsGrid() {
    return Shimmer.fromColors(
        baseColor: AppColors.shimmerBase,
        highlightColor: AppColors.shimmerHighlight,
        child: ListView.separated(
            itemCount: 10,
            shrinkWrap: true,
            physics: AlwaysScrollableScrollPhysics(),
            separatorBuilder: (_, __) => const SizedBox(height: 15),
            itemBuilder: (context, index) {
              return Container(
                height: 60,
                width: 40,
                decoration: BoxDecoration(
                    color: AppColors.errorColor,
                    borderRadius: BorderRadius.circular(4)),
              );
            }));
  }
}
