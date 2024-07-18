import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Calendar/calendar_controller.dart';
import 'package:saralnova/core/controllers/Dashboard/dashboard_panel_controller.dart';
import 'package:saralnova/core/controllers/Dashboard/main_pos_panel_controller.dart';
import 'package:saralnova/core/controllers/Home/home_controller.dart';
import 'package:saralnova/core/controllers/More/activity_log/activity_log_controller.dart';
import 'package:saralnova/core/controllers/More/amenities/amenities_controller.dart';
import 'package:saralnova/core/controllers/More/booking/booking_controller.dart';
import 'package:saralnova/core/controllers/More/facility/facility_controller.dart';
import 'package:saralnova/core/controllers/More/more_controller.dart';
import 'package:saralnova/core/controllers/More/order/order_controller.dart';
import 'package:saralnova/core/controllers/More/order/order_detail_controller.dart';
import 'package:saralnova/core/controllers/More/orders/customer_orders/customers_KOT_controller.dart';
import 'package:saralnova/core/controllers/More/restaurant/category/category_controller.dart';
import 'package:saralnova/core/controllers/More/restaurant/variants/variant_controller.dart';
import 'package:saralnova/core/controllers/More/room/rooms_controller.dart';
import 'package:saralnova/core/controllers/More/room_type/room_type_controller.dart';
import 'package:saralnova/core/controllers/More/space/space_controller.dart';
import 'package:saralnova/core/controllers/More/staff/staff_controller.dart';
import 'package:saralnova/core/controllers/More/table/table_controller.dart';
import 'package:saralnova/core/controllers/Splash/splash_controller.dart';
import 'package:saralnova/core/controllers/menu/add_menu_controller.dart';
import 'package:saralnova/core/controllers/menu/menu_controller.dart';
import 'package:saralnova/core/controllers/pos/checkout_order_pos_controller.dart';
import 'package:saralnova/core/controllers/pos/merged_table_manage_controller.dart';
import 'package:saralnova/core/controllers/pos/pending_order_pos_controller.dart';
import 'package:saralnova/core/controllers/pos/place_order_pos_controller.dart';
import 'package:saralnova/core/controllers/pos/table_pos_controller.dart';
import 'package:saralnova/features/screens/Dashboard/dashboard_panel.dart';
import 'package:saralnova/features/screens/Dashboard/main_pos_panel.dart';
import 'package:saralnova/features/screens/More/Booking/booking_screen.dart';
import 'package:saralnova/features/screens/More/Booking/create_booking_screen.dart';
import 'package:saralnova/features/screens/More/activity_log/activity_log_screen.dart';
import 'package:saralnova/features/screens/More/aminity_type/amenity_screen.dart';
import 'package:saralnova/features/screens/More/facility_type/facility_screen.dart';
import 'package:saralnova/features/screens/More/menu/menu_screen.dart';
import 'package:saralnova/features/screens/More/order/order_detail_screen.dart';
import 'package:saralnova/features/screens/More/order/order_screen.dart';
import 'package:saralnova/features/screens/More/pos/customer_order/customer_kot_checkout_screen.dart';
import 'package:saralnova/features/screens/More/pos/kot_POS_screen.dart';
import 'package:saralnova/features/screens/More/pos/make_order_pos_screen.dart';
import 'package:saralnova/features/screens/More/pos/table/merged_table_view_screen.dart';
import 'package:saralnova/features/screens/More/pos/tables_POS_screen.dart';
import 'package:saralnova/features/screens/More/restaurant/category/category_screen.dart';
import 'package:saralnova/features/screens/More/restaurant/variants/add_variant_screen.dart';
import 'package:saralnova/features/screens/More/restaurant/variants/variants_screen.dart';
import 'package:saralnova/features/screens/More/room_type/room_type_screen.dart';
import 'package:saralnova/features/screens/More/rooms/add_rooms_screen.dart';
import 'package:saralnova/features/screens/More/rooms/rooms_screen.dart';
import 'package:saralnova/features/screens/More/space/add_space_screen.dart';
import 'package:saralnova/features/screens/More/space/space_screen.dart';
import 'package:saralnova/features/screens/More/staff/staff_screen.dart';
import 'package:saralnova/features/screens/More/tables/add_tables_screen.dart';
import 'package:saralnova/features/screens/More/tables/tables_screen.dart';
import 'package:saralnova/features/screens/Splash/splash_screen.dart';

import '../../../features/screens/Auth/login_screen.dart';
import '../../../features/screens/More/menu/add_menu_screen.dart';
import '../../../features/screens/More/pos/activites_screen.dart';
import '../../../features/screens/More/pos/customer_order/customer_orders_screen.dart';
import '../../controllers/Auth/login_controller.dart';
import '../../controllers/More/orders/customer_orders/customer_order_controller.dart';
import '../../controllers/pos/activities_controller.dart';

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
      Get.lazyPut(() => MainPosPanelController());
      Get.lazyPut(() => MoreController());
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

  GetPage(
    name: ActivitiesScreen.routeName,
    page: () => ActivitiesScreen(),
    binding: BindingsBuilder(() {
      Get.lazyPut(() => ActivitiesController());
    }),
  ),

  // .......below are the orders controllers/pages/routeNames

  GetPage(
    name: OrderScreen.routeName,
    page: () => OrderScreen(),
    binding: BindingsBuilder(
      () => Get.lazyPut(() => OrderController()),
    ),
  ),

  GetPage(
    name: OrderDetailScreen.routeName,
    page: () => OrderDetailScreen(),
    binding: BindingsBuilder(() {
      Get.lazyPut(() => OrderDetailController());
    }),
  ),

  GetPage(
    name: MainPosPanel.routeName,
    page: () => MainPosPanel(),
    binding: BindingsBuilder(() {
      Get.lazyPut(() => MainPosPanelController());
      Get.lazyPut(() => PlaceOrderPosController());
      Get.lazyPut(() => PendingOrderController());
      Get.lazyPut(() => CheckoutOrderPOSController());
      Get.lazyPut(() => CustomerOrderController());
      Get.lazyPut(() => TablesPosController());
      Get.lazyPut(() => ActivitiesController());
    }),
  ),

  GetPage(
    name: MakeOrderPosScreen.routeName,
    page: () => MakeOrderPosScreen(),
    binding: BindingsBuilder(() {
      // Get.lazyPut(() => PlaceOrderPosController());
    }),
  ),

  GetPage(
    name: KotScreenPOS.routeName,
    page: () => KotScreenPOS(),
    binding: BindingsBuilder(() {
      // Get.lazyPut(() => PendingOrderController());
    }),
  ),

//working on this controller
  GetPage(
    name: CustomerOrderScreen.routeName,
    page: () => CustomerOrderScreen(),
    binding: BindingsBuilder(() {
      // Get.lazyPut(() => CustomerOrderController());
    }),
  ),
  GetPage(
    name: CustomersKotCheckoutScreen.routeName,
    page: () => CustomersKotCheckoutScreen(),
    binding: BindingsBuilder(() {
      Get.lazyPut(() => CustomersKOTCheckoutController());
    }),
  ),

  GetPage(
    name: TablesScreenPOS.routeName,
    page: () => TablesScreenPOS(),
    binding: BindingsBuilder(() {
      // Get.lazyPut(() => TablesPosController());
    }),
  ),
  // GetPage( //TODO This screen can be delete
  //   name: MergeTableScreen.routeName,
  //   page: () => MergeTableScreen(),
  //   binding: BindingsBuilder(() {
  //     // Get.lazyPut(() => ManageTableController());
  //   }),
  // ),

  GetPage(
    name: MergedTableViewScreen.routeName,
    page: () => MergedTableViewScreen(),
    binding: BindingsBuilder(() {
      Get.lazyPut(() => MergedTableManageController());
    }),
  ),
];
