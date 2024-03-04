import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Calendar/calendar_controller.dart';
import 'package:saralnova/core/controllers/Dashboard/dashboard_panel_controller.dart';
import 'package:saralnova/core/controllers/Feature/amenities/amenities_controller.dart';
import 'package:saralnova/core/controllers/Feature/facility/facility_controller.dart';
import 'package:saralnova/core/controllers/Feature/feature_controller.dart';
import 'package:saralnova/core/controllers/Feature/room/rooms_controller.dart';
import 'package:saralnova/core/controllers/Feature/room_type/room_type_controller.dart';
import 'package:saralnova/core/controllers/Feature/staff/staff_controller.dart';
import 'package:saralnova/core/controllers/Guest/guest_controller.dart';
import 'package:saralnova/core/controllers/Home/home_controller.dart';
import 'package:saralnova/core/controllers/Splash/splash_controller.dart';
import 'package:saralnova/features/screens/Dashboard/dashboard_panel.dart';
import 'package:saralnova/features/screens/Feature/aminity_type/aminities_screen.dart';
import 'package:saralnova/features/screens/Feature/facility_type/facility_screen.dart';
import 'package:saralnova/features/screens/Feature/room_type/room_type_screen.dart';
import 'package:saralnova/features/screens/Feature/rooms/add_rooms_screen.dart';
import 'package:saralnova/features/screens/Feature/rooms/rooms_screen.dart';
import 'package:saralnova/features/screens/Feature/staff/staff_screen.dart';
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
      Get.lazyPut(() => FeatureController());
    }),
  ),

  GetPage(
    name: RoomTypeScreen.routeName,
    page: () => RoomTypeScreen(),
    binding: BindingsBuilder(() {
      Get.lazyPut(() => RoomTypeController());
    }),
  ),
  GetPage(
    name: AmenitiesScreen.routeName,
    page: () => AmenitiesScreen(),
    binding: BindingsBuilder(() {
      Get.lazyPut(() => AmenityController());
    }),
  ),
  GetPage(
    name: FacilityScreen.routeName,
    page: () => FacilityScreen(),
    binding: BindingsBuilder(() {
      Get.lazyPut(() => FacilityController());
    }),
  ),

  GetPage(
    name: RoomsScreen.routeName,
    page: () => RoomsScreen(),
    binding: BindingsBuilder(() {
      Get.lazyPut(() => RoomsController());
    }),
  ),
  GetPage(
    name: AddRoomsScreen.routeName,
    page: () => AddRoomsScreen(),
    binding: BindingsBuilder(() {
      // Get.lazyPut(() => RoomsController());
    }),
  ),

  GetPage(
    name: StaffScreen.routeName,
    page: () => StaffScreen(),
    binding: BindingsBuilder(() {
      Get.lazyPut(() => StaffController());
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
