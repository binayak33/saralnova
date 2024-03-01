import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Calendar/calendar_controller.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/features/widgets/common_widgets/hotel_feature_widget.dart';

class CalendarScreen extends StatelessWidget {
  static const String routeName = "/calender-screen";
  final c = Get.find<CalendarController>();
  CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(
          color: AppColors.scaffoldColor,
        ),
        centerTitle: true,
        title: Text(
          "Calendar",
          style: CustomTextStyles.f16W600(color: AppColors.scaffoldColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        color: AppColors.splashBackgroundColor,
                        borderRadius: BorderRadius.circular(4)),
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Slidable(
                        key: ValueKey(index),
                        endActionPane: ActionPane(
                          extentRatio: 0.5,
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              padding: EdgeInsets.zero,
                              onPressed: (value) {},
                              backgroundColor: AppColors.orangeColor,
                              foregroundColor: Colors.white,
                              icon: Icons.edit,
                              label: 'Edit',
                            ),
                            SlidableAction(
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(4),
                                bottomRight: Radius.circular(4),
                              ),
                              padding: EdgeInsets.zero,
                              onPressed: (value) {},
                              backgroundColor: AppColors.errorColor,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                          ],
                        ),
                        child: HotelFeatureWidget(
                          title: "hahaha",
                        )),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: InkResponse(
        radius: 20,
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: AppColors.primary,
          ),
          child: Text(
            "Add",
            style: CustomTextStyles.f16W600(
              color: AppColors.scaffoldColor,
            ),
          ),
        ),
      ),
    );
  }
}
