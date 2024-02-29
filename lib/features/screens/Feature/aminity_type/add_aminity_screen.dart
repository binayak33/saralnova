import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Feature/aminities/aminites_controller.dart';
import 'package:saralnova/core/utils/constants/enums.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/core/utils/helpers/sky_network_image.dart';
import 'package:saralnova/core/utils/helpers/validators.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_text_field.dart';

import '../../../widgets/common_widgets/sky_elevated_button.dart';

class AddAmenityScreen extends StatelessWidget {
  final c = Get.find<AminityController>();
  AddAmenityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Form(
        key: c.aminityKey,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: const SkyNetworkImage(
                    // imageUrl:
                    //     c.currentUser.value?.avatarUrl ??
                    //         "",
                    imageUrl: "",
                    height: 100,
                    width: 100,
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 10,
                  child: InkResponse(
                    onTap: () {
                      // ImageHelper.pickImage(
                      //     imageSource: ImageSource.camera,
                      //     onPickImage: (pickedImage) {
                      //       c.pickImage(pickedImage);
                      //     });

                      // showModalBottomSheet(
                      //   backgroundColor: AppColors.blackColor,
                      //   context: context,
                      //   shape: const RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.vertical(
                      //       top: Radius.circular(16),
                      //     ),
                      //   ),
                      //   builder: (BuildContext context) {
                      //     // return SelectImage(
                      //     //     selectImg: (ImageSource source) {
                      //     //   ImageHelper.pickImage(
                      //     //       imageSource: source,
                      //     //       onPickImage: (pickedImage) {
                      //     //         c.pickImage(pickedImage);
                      //     //       });
                      //     // });
                      //     return Text("ha");
                      //   },
                      // );
                    },
                    child: SvgPicture.asset(
                      IconPath.camera,
                      height: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SkyTextField(
              autofocus: true,
              hint: c.crudState.value == CRUDSTATE.ADD
                  ? "Add Amenity"
                  : "Update Amenity ",
              controller: c.titleAminityController,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.name,
              validator: (value) => Validator.validateEmpty(value!),
            ),
            const SizedBox(
              height: 10,
            ),
            c.crudState.value == CRUDSTATE.ADD
                ? SkyElevatedButton(
                    onPressed: c.storeAmenityType,
                    title: "Add Amenity ",
                  )
                : SkyElevatedButton(
                    // onPressed: c.updateRoomType,
                    onPressed: () {},

                    title: "Update Amenity ",
                  )
          ],
        ),
      ),
    );
  }
}
