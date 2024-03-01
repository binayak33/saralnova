import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Feature/room/rooms_controller.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
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
        title: const Text("Add Room"),
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
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Rate per night",
                  style: CustomTextStyles.f22W600(),
                ),

                // TODO
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: InkResponse(
        radius: 20,
        onTap: () {
          // c.titleRoomController.clear();
          // c.openRoomsBottomSheet();
          c.storeRoom();

          //   TODO : function call garne get. back garne  garna vanda paila clear garne
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: AppColors.primary,
          ),
          child: Text(
            "Save",
            style: CustomTextStyles.f16W600(
              color: AppColors.scaffoldColor,
            ),
          ),
        ),
      ),
    );
  }
}
