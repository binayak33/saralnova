import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Calendar/calendar_controller.dart';
import 'package:saralnova/core/controllers/Dashboard/dashboard_panel_controller.dart';
import 'package:saralnova/core/controllers/Facility/facility_controller.dart';
import 'package:saralnova/core/controllers/Guest/guest_controller.dart';
import 'package:saralnova/core/controllers/Home/home_controller.dart';
import 'package:saralnova/core/controllers/Rooms/add_room_controller.dart';
import 'package:saralnova/core/controllers/Rooms/rooms_controller.dart';
import 'package:saralnova/core/controllers/Splash/splash_controller.dart';
import 'package:saralnova/features/screens/Dashboard/dashboard_panel.dart';
import 'package:saralnova/features/screens/Facilities/facility_screen.dart';
import 'package:saralnova/features/screens/Rooms/add_room_screen.dart';
import 'package:saralnova/features/screens/Splash/splash_screen.dart';

import '../../../features/screens/Auth/login_screen.dart';
import '../../controllers/Auth/login_controller.dart';

final List<GetPage> pages = [
  GetPage(
    name: SplashScreen.routeName,
    page: () => SplashScreen(),
    binding: BindingsBuilder(
      () => Get.lazyPut(() => SplashController()),
    ),
  ),
  GetPage(
    name: LoginScreen.routeName,
    page: () => LoginScreen(),
    binding: BindingsBuilder(
      () => Get.lazyPut(() => LoginController()),
    ),
  ),
  GetPage(
    name: DashPanel.routeName,
    page: () => DashPanel(),
    binding: BindingsBuilder(() {
      Get.lazyPut(() => DashPanelController());
      Get.lazyPut(() => HomeController());
      Get.lazyPut(() => CalendarController());
      Get.lazyPut(() => GuestController());
      Get.lazyPut(() => RoomsController());
    }),
  ),

  GetPage(
    name: AddRoomScreen.routeName,
    page: () => AddRoomScreen(),
    binding: BindingsBuilder(() {
      Get.lazyPut(() => AddRoomController());
    }),
  ),
  GetPage(
    name: FacilityScreen.routeName,
    page: () => FacilityScreen(),
    binding: BindingsBuilder(() {
      Get.lazyPut(() => FacilityController());
    }),
  ),
  // GetPage(
  //   name: RoomDetailsScreen.routeName,
  //   page: () => RoomDetailsScreen(),
  //   binding: BindingsBuilder(
  //     () => Get.lazyPut(() => RoomDetailsController()),
  //   ),
  // ),
  // GetPage(
  //   name: FinanceScreen.routeName,
  //   page: () => FinanceScreen(),
  //   binding: BindingsBuilder(
  //     () => Get.lazyPut(() => FincanceController()),
  //   ),
  // ),
  // GetPage(
  //   name: ExpenseScreen.routeName,
  //   page: () => ExpenseScreen(),
  //   binding: BindingsBuilder(
  //     () => Get.lazyPut(() => ExpenseController()),
  //   ),
  // ),
  // GetPage(
  //   name: BrowserView.routeName,
  //   page: () => BrowserView(),
  //   binding: BindingsBuilder(
  //     () =>
  //         Get.lazyPut(() => BrowserController(type: BrowserType.ForgetPasswrd)),
  //   ),
  // ),
];
