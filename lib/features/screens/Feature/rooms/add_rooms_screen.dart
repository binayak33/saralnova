import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Feature/room/rooms_controller.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/core/utils/constants/enums.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
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
        actions: [
          IconButton(
              onPressed: () {
                print("room Type id-----${c.roomType.value?.id}");
                print(c.roomType.value?.title);

                // -------------------------

                print(c.roomTypeController.text);
                print(c.roomTitleController.text);
                print(c.roomStatusController.text);
                print(c.rateController.text);
              },
              icon: Icon(Icons.add))
        ],
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
                  hint: "Select a type",
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
                  height: 30,
                ),
                Text(
                  "Amenities",
                  style: CustomTextStyles.f22W600(),
                ),
                Wrap(
                  alignment: WrapAlignment.start,
                  runSpacing: 6,
                  spacing: 6,
                  children: List.generate(
                    // c.features.length,
                    10,
                    (index) => ActionChip(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(6),
                        ),
                        side: BorderSide(color: AppColors.borderColor),
                      ),
                      labelPadding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      label: Text(
                        // "${c.features[index].value}",
                        "random",
                        style: CustomTextStyles.f16W500(
                          color: AppColors.blackColor,
                        ),
                      ),
                      backgroundColor: AppColors.borderColor,
                    ),
                  ),
                ),
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
