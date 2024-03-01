import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Feature/aminities/aminites_controller.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/core/utils/constants/enums.dart';
import 'package:saralnova/core/utils/helpers/sky_network_image.dart';
import 'package:saralnova/features/widgets/common_widgets/hotel_feature_widget.dart';

class AmenitiesScreen extends StatelessWidget {
  static const String routeName = "/aminity-screen";
  final c = Get.find<AminityController>();
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
          "Add Amenity",
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
                  return Center(
                    child: LinearProgressIndicator(),
                  );
                } else if (c.pageState.value == PageState.EMPTY) {
                  return Center(
                    child: Text("Empty"),
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
                              motion: ScrollMotion(),
                              children: [
                                SlidableAction(
                                  padding: EdgeInsets.zero,
                                  onPressed: (value) {
                                    c.updateIndex.value = amenity.id;
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
                  return Center(
                    child: Text("Error View"),
                  );
                }
              })
            ],
          ),
        ),
      ),
      floatingActionButton: InkResponse(
        radius: 20,
        onTap: () {
          c.titleAminityController.clear();
          c.pickedFile.value = null; // Clearing the picked file value
          c.openAmenityBottomSheet();
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: AppColors.primary,
          ),
          child: Text(
            "Create",
            style: CustomTextStyles.f16W600(
              color: AppColors.scaffoldColor,
            ),
          ),
        ),
      ),
    );
  }
}
