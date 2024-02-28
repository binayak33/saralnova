import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Rooms/rooms_controller.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';

class RoomsScreen extends StatelessWidget {
  static const String routeName = "/login-screen";
  final c = Get.find<RoomsController>();
  RoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text(
          "Room Types",
          style: CustomTextStyles.f20W600(color: AppColors.whiteColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
                child: ListTile(
              title: Text("Rooms Types"),
              onTap: () {
                // Get.toNamed(RoomTypesScreen.)
              },
            ))
          ],
        ),
      ),
    );
  }
}
























// -----------------------------------

// class RoomsScreen extends StatelessWidget {
//   static const String routeName = "/login-screen";
//   final c = Get.find<RoomsController>();
//   RoomsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: AppColors.primary,
//         centerTitle: true,
//         title: Text(
//           "Room Types",
//           style: CustomTextStyles.f20W600(color: AppColors.whiteColor),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Obx(
//           () {
//             return Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                   c.roomTypes.isNotEmpty
//                       ? Obx(() => ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: c.roomTypes.length,
//                           itemBuilder: (context, index) {
//                             var room = c.roomTypes[index];
//                             return Container(
//                               decoration: BoxDecoration(
//                                   color: AppColors.whiteColor,
//                                   borderRadius: BorderRadius.circular(4)),
//                               margin: const EdgeInsets.only(bottom: 10),
//                               child: Slidable(
//                                   key: ValueKey(index),
//                                   endActionPane: ActionPane(
//                                     extentRatio: 0.5,
//                                     motion: ScrollMotion(),
//                                     children: [
//                                       SlidableAction(
//                                         padding: EdgeInsets.zero,
//                                         // An action can be bigger than the others.
//                                         onPressed: (value) {
//                                           // Get.toNamed(AddRoomScreen.routeName,
//                                           //     arguments: {
//                                           //       "update": room,
//                                           //       "index": index,
//                                           //     });

//                                           //null // empty nahuda case handle garne
//                                           c.roomTypeScreenController.text =
//                                               room;
//                                           c.pageState.value = PageState.UPDATE;

//                                           c.updateIndex.value = index;

//                                           c.openBottomSheet();
//                                         },
//                                         backgroundColor: AppColors.orangeColor,
//                                         foregroundColor: Colors.white,
//                                         icon: Icons.edit,
//                                         label: 'Edit',
//                                       ),
//                                       SlidableAction(
//                                         borderRadius: const BorderRadius.only(
//                                           topRight: Radius.circular(4),
//                                           bottomRight: Radius.circular(4),
//                                         ),
//                                         padding: EdgeInsets.zero,
//                                         onPressed: (value) {
//                                           c.roomTypes.removeAt(index);
//                                         },
//                                         backgroundColor: AppColors.errorColor,
//                                         foregroundColor: Colors.white,
//                                         icon: Icons.delete,
//                                         label: 'Delete',
//                                       ),
//                                     ],
//                                   ),
//                                   child: Container(
//                                     margin: const EdgeInsets.all(10),
//                                     width: Get.width,
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(10),
//                                       child: Text(room),
//                                     ),
//                                   )),
//                             );
//                           }))
//                       : const Card(
//                           child: ListTile(
//                             title: Text("You can add rooms types"),
//                             trailing: Icon(Icons.keyboard_arrow_right_outlined),
//                           ),
//                         ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   Card(
//                     child: ListTile(
//                       title: const Text("You can add Facilties types"),
//                       trailing: const Icon(Icons.keyboard_arrow_right_outlined),
//                       onTap: () {
//                         Get.toNamed(FacilityScreen.routeName);
//                       },
//                     ),
//                   )
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: AppColors.primary,
//         tooltip: 'Increment',
//         onPressed: () {
//           c.roomTypeScreenController.clear();
//           c.openBottomSheet();
//           // if (c.roomTypes.length < 3) {
//           //   //open bottom sheet
//           //   c.openBottomSheet();
//           // } else {
//           //   Get.toNamed(AddRoomScreen.routeName);
//           // }
//         },
//         child: const Icon(Icons.add, color: Colors.white, size: 28),
//       ),
//     );
//   }
// }
