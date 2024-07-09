import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saralnova/core/controllers/More/amenities/amenities_controller.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/core/utils/constants/image_path.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/core/utils/helpers/image_helper.dart';
import 'package:saralnova/core/utils/helpers/validators.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_text_field.dart';

import '../../../widgets/common_widgets/sky_elevated_button.dart';

class AddAmenityScreen extends StatelessWidget {
  final c = Get.find<AmenityController>();
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
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(100),
                //   child: Obx(() {
                //     final file = c.pickedFile.value;
                //     if (file != null) {
                //       return Image.file(
                //         file,
                //         height: 100,
                //         width: 100,
                //         fit: BoxFit.cover,
                //       );
                //     } else {
                //       return const SkyNetworkImage(
                //         imageUrl: "",
                //         height: 100,
                //         width: 100,
                //       );
                //     }
                //   }),
                // ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Obx(
                    () => c.pickedFile.value == null
                        ? Image.asset(
                            ImagePath.placeHolder,
                            fit: BoxFit.cover,
                            height: 100,
                            width: 100,
                          )
                        : Image.file(
                            c.pickedFile.value!,
                            fit: BoxFit.cover,
                            height: 100,
                            width: 100,
                          ),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 10,
                  child: InkResponse(
                    onTap: () {
                      ImageHelper.pickImage(
                          imageSource: ImageSource.gallery,
                          onPickImage: (imageFile) {
                            c.pickImage(imageFile);
                          });
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
                    onPressed: c.updateAmenityType,
                    title: "Update Amenity ",
                  )
          ],
        ),
      ),
    );
  }
}
