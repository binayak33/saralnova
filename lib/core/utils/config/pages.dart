import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Calendar/calendar_controller.dart';
import 'package:saralnova/core/controllers/Dashboard/dashboard_panel_controller.dart';
import 'package:saralnova/core/controllers/Feature/activity_log/activity_log_controller.dart';
import 'package:saralnova/core/controllers/Feature/amenities/amenities_controller.dart';
import 'package:saralnova/core/controllers/Feature/booking/booking_controller.dart';
import 'package:saralnova/core/controllers/Feature/facility/facility_controller.dart';
import 'package:saralnova/core/controllers/Feature/feature_controller.dart';
import 'package:saralnova/core/controllers/Feature/restaurant/category/category_controller.dart';
import 'package:saralnova/core/controllers/Feature/restaurant/variants/variant_controller.dart';
import 'package:saralnova/core/controllers/Feature/room/rooms_controller.dart';
import 'package:saralnova/core/controllers/Feature/room_type/room_type_controller.dart';
import 'package:saralnova/core/controllers/Feature/space/space_controller.dart';
import 'package:saralnova/core/controllers/Feature/staff/staff_controller.dart';
import 'package:saralnova/core/controllers/Feature/table/table_controller.dart';
import 'package:saralnova/core/controllers/Guest/guest_controller.dart';
import 'package:saralnova/core/controllers/Home/home_controller.dart';
import 'package:saralnova/core/controllers/Splash/splash_controller.dart';
import 'package:saralnova/core/controllers/menu/add_menu_controller.dart';
import 'package:saralnova/core/controllers/menu/menu_controller.dart';
import 'package:saralnova/features/screens/Dashboard/dashboard_panel.dart';
import 'package:saralnova/features/screens/Feature/Booking/booking_screen.dart';
import 'package:saralnova/features/screens/Feature/Booking/create_booking_screen.dart';
import 'package:saralnova/features/screens/Feature/activity_log/activity_log_screen.dart';
import 'package:saralnova/features/screens/Feature/aminity_type/amenity_screen.dart';
import 'package:saralnova/features/screens/Feature/facility_type/facility_screen.dart';
import 'package:saralnova/features/screens/Feature/menu/menu_screen.dart';
import 'package:saralnova/features/screens/Feature/restaurant/category/category_screen.dart';
import 'package:saralnova/features/screens/Feature/restaurant/variants/add_variant_screen.dart';
import 'package:saralnova/features/screens/Feature/restaurant/variants/variants_screen.dart';
import 'package:saralnova/features/screens/Feature/room_type/room_type_screen.dart';
import 'package:saralnova/features/screens/Feature/rooms/add_rooms_screen.dart';
import 'package:saralnova/features/screens/Feature/rooms/rooms_screen.dart';
import 'package:saralnova/features/screens/Feature/space/add_space_screen.dart';
import 'package:saralnova/features/screens/Feature/space/space_screen.dart';
import 'package:saralnova/features/screens/Feature/staff/staff_screen.dart';
import 'package:saralnova/features/screens/Feature/tables/add_tables_screen.dart';
import 'package:saralnova/features/screens/Feature/tables/tables_screen.dart';
import 'package:saralnova/features/screens/Splash/splash_screen.dart';

import '../../../features/screens/Auth/login_screen.dart';
import '../../../features/screens/Feature/menu/add_menu_screen.dart';
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

  GetPage(
    name: CreateBookingScreen.routeName,
    page: () => CreateBookingScreen(),
    binding: BindingsBuilder(() {
      // Get.lazyPut(() => BookingController());
      Get.lazyPut(() => FacilityController());
    }),
  ),
  GetPage(
    name: BookingScreen.routeName,
    page: () => BookingScreen(),
    binding: BindingsBuilder(() {
      Get.lazyPut(() => BookingController());
      // Get.lazyPut(() => FacilityController());
    }),
  ),
  GetPage(
    name: ActivityLogScreen.routeName,
    page: () => ActivityLogScreen(),
    binding: BindingsBuilder(
      () => Get.lazyPut(() => ActivityLogController()),
    ),
  ),

  GetPage(
    name: CategoryScreen.routeName,
    page: () => CategoryScreen(),
    binding: BindingsBuilder(
      () => Get.lazyPut(() => CategoryController()),
    ),
  ),

  GetPage(
    name: VariantScreen.routeName,
    page: () => VariantScreen(),
    binding: BindingsBuilder(() {
      Get.lazyPut(() => VariantController());
    }),
  ),
  GetPage(
    name: AddVariantScreen.routeName,
    page: () => AddVariantScreen(),
    // binding: BindingsBuilder(() {
    //   // Get.lazyPut(() => VariantController());
    // }),
  ),

  GetPage(
    name: SpaceScreen.routeName,
    page: () => SpaceScreen(),
    binding: BindingsBuilder(() {
      Get.lazyPut(() => SpaceController());
    }),
  ),

  GetPage(
    name: AddSpaceScreen.routeName,
    page: () => AddSpaceScreen(),
    // binding: BindingsBuilder(() {
    //   // Get.lazyPut(() => VariantController());
    // }),
  ),
  GetPage(
    name: TablesScreen.routeName,
    page: () => TablesScreen(),
    binding: BindingsBuilder(() {
      Get.lazyPut(() => TableController());
    }),
  ),

  GetPage(
    name: AddTablesScreen.routeName,
    page: () => AddTablesScreen(),
    binding: BindingsBuilder(() {
      // Get.lazyPut(() => RoomsController());
    }),
  ),
  GetPage(
    name: MenuScreen.routeName,
    page: () => MenuScreen(),
    binding: BindingsBuilder(() {
      Get.lazyPut(() => MenuRestaurantController());
    }),
  ),

   GetPage(
    name: AddMenuScreen.routeName,
    page: () => AddMenuScreen(),
    binding: BindingsBuilder(() {
      Get.lazyPut(() => AddMenuController());
    }),
  ),
];
