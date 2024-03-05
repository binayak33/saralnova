import 'package:flutter/material.dart';

class DateRoomScreen extends StatelessWidget {
  const DateRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
      color: Colors.purple,
      child: const Center(
        child: Text("Date Rooms"),
      ),
    );
  }
}
