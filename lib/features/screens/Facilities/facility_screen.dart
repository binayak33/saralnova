import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Facility/facility_controller.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/core/utils/constants/enums.dart';

class FacilityScreen extends StatelessWidget {
  static const String routeName = "/facility";
  final c = Get.find<FacilityController>();
  FacilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text(
          "Facilities",
          style: CustomTextStyles.f20W600(color: AppColors.whiteColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Obx(
            () {
              return Column(
                children: [
                  c.facilites.isNotEmpty
                      ? Obx(
                          () => ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: c.facilites.length,
                            itemBuilder: (context, index) {
                              var facility = c.facilites[index];
                              return Container(
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                margin: const EdgeInsets.only(bottom: 10),
                                child: Slidable(
                                  key: ValueKey(index),
                                  endActionPane: ActionPane(
                                    extentRatio: 0.5,
                                    motion: ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        autoClose: true,
                                        key:
                                            ValueKey(facility.title.toString()),
                                        padding: EdgeInsets.zero,
                                        onPressed: (value) {
                                          c.facilityTitleController.text =
                                              facility.title.toString();
                                          c.facilityPriceController.text =
                                              facility.price.toString();
                                          c.pageState.value = PageState.UPDATE;

                                          c.updateFacilityIndex.value = index;

                                          c.openFacilityBottomSheet();
                                        },
                                        backgroundColor: AppColors.orangeColor,
                                        foregroundColor: AppColors.whiteColor,
                                        icon: Icons.edit,
                                        label: "Edit",
                                      ),
                                      SlidableAction(
                                        autoClose: true,
                                        key:
                                            ValueKey(facility.price.toString()),
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(4),
                                          bottomRight: Radius.circular(4),
                                        ),
                                        padding: EdgeInsets.zero,
                                        onPressed: (value) {
                                          c.facilites.removeAt(index);
                                        },
                                        backgroundColor: AppColors.errorColor,
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        label: 'Delete',
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    width: Get.width,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            facility.title ?? "",
                                            style: CustomTextStyles.f18W400(
                                              color: AppColors.blackColor,
                                            ),
                                          ),
                                          Text(
                                            facility.price != null
                                                ? "Rs. ${facility.price.toString()}"
                                                : "",
                                            style: CustomTextStyles.f16W400(
                                              color:
                                                  AppColors.secondaryTextColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : const Card(
                          child: ListTile(
                            title: Text("Looks like no facilites here. "),
                          ),
                        ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        tooltip: 'Increment',
        onPressed: () {
          c.facilityTitleController.clear();
          c.facilityPriceController.clear();

          c.openFacilityBottomSheet();
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}
