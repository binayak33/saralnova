import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Home/home_controller.dart';
import 'package:saralnova/core/controllers/Splash/core_controller.dart';

class HomeScreen extends StatelessWidget {
  final c = Get.put(HomeController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Get.find<CoreController>().logOut();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GridView.builder(
          itemCount: c.dashboardList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 30,
            mainAxisSpacing: 30,
          ),
          itemBuilder: (context, index) {
            var data = c.dashboardList[index];
            return HomePageBox(
                title: data.text, icon: data.icon, color: data.color);
          },
        ),
      ),
    );
  }
}

class HomePageBox extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final Color? color;
  const HomePageBox({super.key, this.title, this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 41, 41, 41).withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "$title",
              style: TextStyle(
                fontSize: 13,
              ),
            ),
            SizedBox(width: 5),
            Container(
              child: Icon(
                icon ??
                    Icons
                        .error, // Default to an error icon if no icon is provided
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
