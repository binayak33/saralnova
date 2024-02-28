import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Rooms/add_room_controller.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/core/utils/constants/enums.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/core/utils/helpers/validators.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_text_field.dart';

class AddRoomScreen extends StatelessWidget {
  static const String routeName = "/add-room";
  final c = Get.find<AddRoomController>();
  AddRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(
          color: AppColors.scaffoldColor, //change your color here
        ),
        centerTitle: true,
        title: Text(
          c.pageState.value == PageState.ADD
              ? "Add Room Type"
              : "Update Room Type",
          style: CustomTextStyles.f16W600(color: AppColors.scaffoldColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: c.formKey,
          child: Column(
            children: [
              ContainerTextField(
                hint: "Deluxe Room",
                icon: IconPath.arrowLeftCircle,
                text: "Title ",
                controller: c.roomTypeController,
                textInputAction: TextInputAction.done,
                validator: (value) => Validator.validateEmpty(value!),
                textInputType: TextInputType.name,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: InkResponse(
        radius: 20,
        onTap: c.pageState.value == PageState.ADD ? c.onSave : c.onUpdate,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: AppColors.primary,
          ),
          child: Text(
            c.pageState.value == PageState.ADD ? "Save" : "Update",
            style: CustomTextStyles.f16W600(
              color: AppColors.scaffoldColor,
            ),
          ),
        ),
      ),
    );
  }
}
