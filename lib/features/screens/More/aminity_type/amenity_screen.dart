import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/core/utils/helpers/sky_network_image.dart';
import 'package:saralnova/features/widgets/app_widgets/hotel_feature_widget.dart';
import 'package:saralnova/features/widgets/common_widgets/custom_floating_action_button.dart';
import 'package:saralnova/features/widgets/common_widgets/empty_view.dart';
import 'package:saralnova/features/widgets/common_widgets/error_view.dart';
import 'package:saralnova/features/widgets/shimmers/list_shimmer.dart';

import '../../../../core/controllers/More/amenities/amenities_controller.dart';

class AmenitiesScreen extends StatelessWidget {
  static const String routeName = "/aminity-screen";
  final c = Get.find<AmenityController>();
  AmenitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(
          color: AppColors.scaffoldColor,
        ),
        centerTitle: true,
        title: Text(
          "Amenities",
          style: CustomTextStyles.f16W600(color: AppColors.scaffoldColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Obx(() {
                if (c.pageState.value == PageState.LOADING) {
                  return SaralNovaShimmer.listShimmerheigh150();
                } else if (c.pageState.value == PageState.EMPTY) {
                  return EmptyView(
                    message: "Empty!!",
                    title: "Empty",
                    media: IconPath.empty,
                    mediaSize: 500,
                  );
                } else if (c.pageState.value == PageState.NORMAL) {
                  return ListView.builder(
                    itemCount: c.amenitiesList.length,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var amenity = c.amenitiesList[index];
                      return Container(
                          decoration: BoxDecoration(
                              color: AppColors.splashBackgroundColor,
                              borderRadius: BorderRadius.circular(4)),
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Slidable(
                            key: ValueKey(index),
                            endActionPane: ActionPane(
                              extentRatio: 0.5,
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  padding: EdgeInsets.zero,
                                  onPressed: (value) {
                                    // c.updateIndex.value = amenity.id;
                                    c.amenity.value = amenity;
                                    c.crudState.value = CRUDSTATE.UPDATE;
                                    c.titleAminityController.text =
                                        amenity.title.toString();
                                    c.openAmenityBottomSheet();
                                  },
                                  backgroundColor: AppColors.orangeColor,
                                  foregroundColor: Colors.white,
                                  icon: Icons.edit,
                                  label: 'Edit',
                                ),
                                SlidableAction(
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(4),
                                    bottomRight: Radius.circular(4),
                                  ),
                                  padding: EdgeInsets.zero,
                                  onPressed: (value) {
                                    c.deleteAminity(amenity.id!);
                                  },
                                  backgroundColor: AppColors.errorColor,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: SkyNetworkImage(
                                      imageUrl: amenity.imageUrl ?? "",
                                      // imageUrl: "",
                                      height: 70,
                                      width: 70,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: HotelFeatureWidget(
                                    title: amenity.title,
                                  ),
                                ),
                              ],
                            ),
                          ));
                    },
                  );
                } else {
                  return const ErrorView(
                    errorTitle: "Something went wrong!!",
                    errorMessage: "Something went wrong",
                    imagePath: IconPath.somethingWentWrong,
                  );
                }
              })
            ],
          ),
        ),
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          c.titleAminityController.clear();
          c.pickedFile.value = null;
          c.openAmenityBottomSheet();
        },
      ),
    );
  }
}
