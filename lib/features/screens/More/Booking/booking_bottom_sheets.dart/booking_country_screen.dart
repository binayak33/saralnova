import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/More/booking/booking_controller.dart';
import 'package:saralnova/core/model/country_model.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';

class CountryBottomSheet extends StatelessWidget {
  final c = Get.put(BookingController());
  final Function(CountryModel country) onSelectCountry;

  CountryBottomSheet({
    super.key,
    required this.onSelectCountry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        children: [
          Text(
            "Select Country",
            style: CustomTextStyles.f16W600(color: AppColors.blackColor),
          ),
          const Divider(
            color: AppColors.borderColor,
            endIndent: 10,
            indent: 10,
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: c.countries.length,
              itemBuilder: (context, index) {
                var country = c.countries[index];
                print("----country---${country}");

                return ListTile(
                  onTap: () {
                    Navigator.of(context).pop();
                    onSelectCountry(country);
                  },
                  title: Text(
                    country.countryName.toString(),
                    style: CustomTextStyles.f16W400(),
                  ),
                  dense: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  tileColor: AppColors.errorColor,
                  selected: true,
                  style: ListTileStyle.drawer,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

















// Obx(() {
          //   if (c.roomTypes.isEmpty) {
          //     return const LinearProgressIndicator();
          //   } else {
          //     return Expanded(
          //       child: ListView.builder(
          //         shrinkWrap: true,
          //         physics: const ClampingScrollPhysics(),
          //         itemCount: c.roomTypes.length,
          //         itemBuilder: (context, index) {
          //           var room = c.roomTypes[index];
          //           return ListTile(
          //             onTap: () {
          //               Navigator.of(context).pop();
          //               onSelectRoomType(room);
          //             },
          //             title: Text(
          //               room.title ?? "",
          //               style: CustomTextStyles.f16W400(),
          //             ),
          //             dense: true,
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(10),
          //             ),
          //             tileColor: AppColors.errorColor,
          //             selected: true,
          //             style: ListTileStyle.drawer,
          //           );
          //         },
          //       ),
          //     );
          //   }
          // })