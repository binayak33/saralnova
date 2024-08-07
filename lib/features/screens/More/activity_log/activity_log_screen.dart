import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/More/activity_log/activity_log_controller.dart';
import 'package:saralnova/features/widgets/common_widgets/custom_appBar.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_text_field.dart';

import '../../../../core/utils/helpers/validators.dart';

class ActivityLogScreen extends StatelessWidget {
  static const String routeName = "/activity-log-screen";
  final c = Get.find<ActivityLogController>();
  ActivityLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SaralNovaApppBar(
        title: 'Activity Log',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SkyTextField(
                hint: "Search Booking",
                // prefixIconPath: IconPath.search,
                prefixIcon: const Icon(Icons.search),
                textCapitalization: TextCapitalization.none,
                validator: (value) => Validator.validateEmpty(value!),
                controller: c.searchBookingController,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.emailAddress,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
