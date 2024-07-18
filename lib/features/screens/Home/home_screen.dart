import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Home/home_controller.dart';

class HomeScreen extends StatelessWidget {
  // final c = Get.put(HomeController());
  final c = Get.find<HomeController>();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: c.currentIndex.value,
      child: Scaffold(
        appBar: AppBar(
          title: const TabBar(
            padding: EdgeInsets.zero,
            tabs: [
              Tab(
                // text: "Hotel",
                child: Text("Hotel"),
              ),
              Tab(
                // text: "Restaurant",
                child: Text("Restaurant"),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(
              child: Text("Hotel"),
            ),
            Center(
              child: Text("Restaurant"),
            ),
          ],
        ),
      ),
    );
  }
}
