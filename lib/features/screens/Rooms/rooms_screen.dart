import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Rooms/rooms_controller.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/features/screens/Rooms/add_room_screen.dart';

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
      ),
      body: SingleChildScrollView(
        child: Obx(
          () {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  c.roomTypes.isNotEmpty
                      ? Obx(
                          () => SizedBox(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: c.roomTypes.length,
                              itemBuilder: (context, index) {
                                var room = c.roomTypes[index];

                                return Slidable(
                                  key: ValueKey(index),

                                  // The end action pane is the one at the right or the bottom side.
                                  endActionPane: ActionPane(
                                    motion: ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        // An action can be bigger than the others.
                                        onPressed: (value) {
                                          Get.toNamed(AddRoomScreen.routeName,
                                              arguments: {
                                                "update": room,
                                                "index": index,
                                              });
                                        },
                                        backgroundColor: Colors.green,
                                        foregroundColor: Colors.white,
                                        icon: Icons.edit,

                                        // label: 'Edit',
                                      ),
                                      SlidableAction(
                                        onPressed: (value) {
                                          c.roomTypes.removeAt(index);
                                        },
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete,
                                        // label: 'Delete',
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.only(bottom: 10),
                                    decoration: const BoxDecoration(
                                        color: AppColors.whiteColor),
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      room,
                                      style: CustomTextStyles.f16W500(
                                          color: AppColors.blackColor),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : const Card(
                          child: ListTile(
                            title: Text("You can add rooms types"),
                            trailing: Icon(Icons.keyboard_arrow_right_outlined),
                          ),
                        )
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        tooltip: 'Increment',
        onPressed: () {
          if (c.roomTypes.length < 3) {
            //open bottom sheet
            c.openBottomSheet();
          } else {
            Get.toNamed(AddRoomScreen.routeName);
          }
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}
