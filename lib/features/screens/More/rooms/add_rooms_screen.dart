import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/More/room/rooms_controller.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/core/utils/helpers/validators.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_text_field.dart';

class AddRoomsScreen extends StatelessWidget {
  static const String routeName = "/add-rooms";
  final c = Get.find<RoomsController>();
  AddRoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            c.crudState.value == CRUDSTATE.ADD ? "Add Room" : "Update Room"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Form(
            key: c.addRoomKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Room Type",
                  style: CustomTextStyles.f16W400(),
                ),
                SkyTextField(
                  hint: "Select a type",
                  controller: c.roomTypeController,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                  readOnly: true,
                  suffixIconPath: IconPath.down,
                  onTap: () {
                    c.openRoomTypeBottomSheet();
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Room Title",
                  style: CustomTextStyles.f16W400(),
                ),
                SkyTextField(
                  hint:
                      "Room Title", //TODO room title should not have more than 12 characters because it does overflow in available rooms screen
                  controller: c.roomTitleController,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                  validator: (value) => Validator.validateEmpty(value!),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Room Status",
                  style: CustomTextStyles.f16W400(),
                ),
                SkyTextField(
                  hint: "Select status",
                  controller: c.roomStatusController,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                  suffixIconPath: IconPath.down,
                  onTap: () {
                    c.showStatus();
                  },
                  readOnly: true,
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Rate per night",
                  style: CustomTextStyles.f16W400(),
                ),
                SkyTextField(
                  hint: "Enter rate",
                  controller: c.rateController,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.number,
                  validator: (value) => Validator.validateEmpty(value!),
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Amenities",
                  style: CustomTextStyles.f22W600(),
                ),
                const SizedBox(
                  height: 10,
              ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.borderColor),
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  height: 170,
                  width: Get.width,
                  child: Obx(() {
                    if (c.amenityController.amenitiesList.isNotEmpty) {
                      return SizedBox(
                        height: 300,
                        width: Get.width,
                        child: ListView(
                          children: [
                            Wrap(
                              alignment: WrapAlignment.start,
                              runSpacing: 6,
                              spacing: 6,
                              children: List.generate(
                                c.amenityController.amenitiesList.length,
                                (index) {
                                  var amenity =
                                      c.amenityController.amenitiesList[index];
                                  return ActionChip(
                                    color: c.amenitiesDataList.contains(amenity)
                                        ? MaterialStateProperty.all<Color?>(
                                            AppColors.orangeColor)
                                        : MaterialStateProperty.all<Color?>(
                                            Colors.transparent),
                                    backgroundColor: AppColors.blackColor,
                                    avatar:
                                        c.amenitiesDataList.contains(amenity)
                                            ? const Icon(Icons.check)
                                            : const Icon(Icons.add),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: const BorderSide(
                                        color: AppColors.borderColor,
                                      ),
                                    ),
                                    label: Text(
                                      "${c.amenityController.amenitiesList[index].title}",
                                      style: CustomTextStyles.f12W600(
                                        color: AppColors.blackColor,
                                      ),
                                    ),
                                    onPressed: () {
                                      //TODO  // c.amenitiesDataList.add(amenity);

                                      if (c.amenitiesDataList
                                          .contains(amenity)) {
                                        c.amenitiesDataList.remove(amenity);
                                      } else {
                                        c.amenitiesDataList.add(amenity);
                                      }
                                    },
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: InkResponse(
        radius: 20,
        onTap: () {
          c.crudState.value == CRUDSTATE.ADD ? c.storeRoom() : c.updateRoom();
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: AppColors.primary,
          ),
          child: Text(
            c.crudState.value == CRUDSTATE.ADD ? "Save" : "Update",
            style: CustomTextStyles.f16W600(
              color: AppColors.scaffoldColor,
            ),
          ),
        ),
      ),
    );
  }
}
