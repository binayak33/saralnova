import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Feature/table/table_controller.dart';
import 'package:saralnova/core/utils/constants/enums.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/core/utils/helpers/validators.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_elevated_button.dart';
import 'package:saralnova/features/widgets/common_widgets/sky_text_field.dart';

class AddTablesScreen extends StatelessWidget {
  static const String routeName = "/add-tables";
  final c = Get.find<TableController>();
  AddTablesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            c.crudState.value == CRUDSTATE.ADD ? "Add Table" : "Update Table"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(
            16,
          ),
          child: Form(
            key: c.tableKey,
            child: Column(
              children: [
                SkyTextField(
                  hint: "Name",
                  controller: c.nameController,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.name,
                  validator: (value) => Validator.validateEmpty(value!),
                ),

                const SizedBox(
                  height: 10,
                ),
                SkyTextField(
                  hint: "Capacity",
                  controller: c.capcityController,
                  textInputAction: TextInputAction.done,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  textInputType: TextInputType.name,
                  validator: (value) => Validator.validateEmpty(value!),
                ),
                const SizedBox(
                  height: 10,
                ),

                SkyTextField(
                  hint: "Status",
                  controller: c.statusController,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                  suffixIconPath: IconPath.down,
                  onTap: () {
                    c.showStatus();
                  },
                  readOnly: true,
                ),
                // const Spacer(),
                const SizedBox(
                  height: 10,
                ),
                SkyTextField(
                  hint: "Select space",
                  controller: c.spaceController,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                  suffixIconPath: IconPath.down,
                  onTap: () {
                    c.openSpaceTypeBottomSheet();
                  },
                  readOnly: true,
                ),
                // const Spacer(),
                const SizedBox(
                  height: 50,
                ),
                SkyElevatedButton(
                  onPressed: c.crudState.value == CRUDSTATE.ADD
                      ? c.storeTable
                      : c.updateTable,
                  title:
                      c.crudState.value == CRUDSTATE.ADD ? "Submit" : "Update",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
