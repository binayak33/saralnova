import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Feature/facility/facility_controller.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/features/widgets/app_widgets/hotel_feature_widget.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/features/widgets/common_widgets/empty_view.dart';
import 'package:saralnova/features/widgets/common_widgets/error_view.dart';

class FacilityScreen extends StatelessWidget {
  static const String routeName = "/facility";
  final c = Get.find<FacilityController>();
  FacilityScreen({super.key});

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
          "Add Facilities",
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
                  return EmptyView(
                    message: "Empty!!",
                    title: "Empty",
                    media: IconPath.empty,
                    mediaSize: 500,
                  );
                } else if (c.pageState.value == PageState.NORMAL) {
                  return ListView.builder(
                    itemCount: c.facilitiesList.length,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var facility = c.facilitiesList[index];
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
                                  // c.updateIndex.value = facility.id;
                                  c.facility.value = facility;
                                  c.crudState.value = CRUDSTATE.UPDATE;
                                  c.facilityTitleController.text =
                                      facility.title.toString();
                                  c.facilityPriceController.text =
                                      facility.price.toString();
                                  c.openFacilityBottomSheet();
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
                                  c.deleteFacility(facility.id!);
                                },
                                backgroundColor: AppColors.errorColor,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: HotelFeatureWidget(
                            title: facility.title,
                            subtitle: int.parse(facility.price.toString()),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return ErrorView(
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
      floatingActionButton: InkResponse(
        radius: 20,
        onTap: () {
          // c.crudState.value = CRUDSTATE.ADD;
          // c.openFacilityBottomSheet();

          c.facilityPriceController.clear();
          c.facilityTitleController.clear();
          c.openFacilityBottomSheet();
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
