import 'package:flutter/material.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';

class OptionsScreen extends StatelessWidget {
  const OptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 14,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemBuilder: (context, index) {
                return OptionsListTile(
                  title: "Breakfast 200",
                );
              })
        ],
      ),
    );
  }
}

class OptionsListTile extends StatelessWidget {
  final String title;

  const OptionsListTile({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          title,
          style: CustomTextStyles.f14W400(),
        ),
        trailing: Radio(
          value: "1",
          groupValue: "1",
          onChanged: (value) {},
        ),
      ),
    );
  }
}
