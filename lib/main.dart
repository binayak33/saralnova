import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'core/controllers/Splash/core_controller.dart';
import 'core/utils/config/pages.dart';
import 'core/utils/config/theme.dart';
import 'features/screens/Splash/splash_screen.dart';

void main() async {
    await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Get.put(CoreController());
  runApp(const SNStayApp());
}
//TODO: network check if connection is or not

class SNStayApp extends StatelessWidget {
  const SNStayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.basicTheme(),
      getPages: pages,
      initialRoute: SplashScreen.routeName,
    );
  }
}
