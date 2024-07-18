import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Home/home_controller.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/core/utils/helpers/sky_network_image.dart';
import 'package:saralnova/features/widgets/shimmers/list_shimmer.dart';

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
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Obx(() {
                if (c.pageState.value == PageState.LOADING) {
                  return SaralNovaShimmer.menuGridShimmer();
                } else {
                  return GridView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(bottom: 40),
                    physics: const AlwaysScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    children: [
                      CountWidget(
                        title: "Rooms",
                        count: c.hotelDashboard.value?.roomCount ?? 0,
                        icon: IconPath.rooms,
                      ),
                      CountWidget(
                        title: "New Bookings",
                        count: c.hotelDashboard.value?.newBookingCount ?? 0,
                        icon: IconPath.calander,
                      ),
                      CountWidget(
                        title: "Total Bookings",
                        count: c.hotelDashboard.value?.totalBookingCount ?? 0,
                        icon: IconPath.calendarTick,
                      ),
                      CountWidget(
                        title: "Available Rooms",
                        count: c.hotelDashboard.value?.availableRoomsCount ?? 0,
                        icon: IconPath.roomType,
                      ),
                      CountWidget(
                        title: "Cancelled Bookings",
                        count: c.hotelDashboard.value?.cancelledCount ?? 0,
                        icon: IconPath.cancelCalendar,
                      ),
                      CountWidget(
                        title: "Occupied Rooms",
                        count: c.hotelDashboard.value?.occupiedRooms ?? 0,
                        icon: IconPath.doorLocked,
                      ),
                      CountWidget(
                        title: "Reserved Rooms",
                        count: c.hotelDashboard.value?.reservedRooms ?? 0,
                        icon: IconPath.doorLocked,
                      ),
                      CountWidget(
                        title: "Vacant Rooms",
                        count: c.hotelDashboard.value?.vacantRooms ?? 0,
                        icon: IconPath.roomDoor,
                      ),
                    ],
                  );
                }
              }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Obx(() {
                  if (c.pageState.value == PageState.LOADING) {
                    return SaralNovaShimmer.menuGridShimmer();
                  } else {
                    return Column(
                      children: [
                        GridView(
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(bottom: 40),
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          children: [
                            CountWidget(
                              title: "Categories",
                              count:
                                  c.restaurantDashboard.value?.categoryCount ??
                                      0,
                              icon: IconPath.category,
                            ),
                            CountWidget(
                              title: "Menu",
                              count:
                                  c.restaurantDashboard.value?.menuCount ?? 0,
                              icon: IconPath.menu,
                            ),
                            CountWidget(
                              title: "Table Count",
                              count:
                                  c.restaurantDashboard.value?.tableCount ?? 0,
                              icon: IconPath.tables,
                            ),
                            CountWidget(
                              title: "Order Count",
                              count:
                                  c.restaurantDashboard.value?.orderCount ?? 0,
                              icon: IconPath.order,
                            ),
                            CountWidget(
                              title: "New Order",
                              count:
                                  c.restaurantDashboard.value?.newOrderCount ??
                                      0,
                              icon: IconPath.placeOrder,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        if (c.restaurantDashboard.value != null &&
                            c.restaurantDashboard.value!.bestSellingMenus!
                                .isNotEmpty)
                          ListView.separated(
                            padding: const EdgeInsets.only(bottom: 40),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: c.restaurantDashboard.value!
                                .bestSellingMenus!.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              var item = c.restaurantDashboard.value!
                                  .bestSellingMenus![index];
                              return ListTile(
                                contentPadding: const EdgeInsets.all(10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                tileColor: AppColors.splashBackgroundColor,
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: SkyNetworkImage(
                                    imageUrl: item.imageUrl ?? "",
                                    height: 70,
                                    width: 70,
                                  ),
                                ),
                                title: Column(
                                  children: [
                                    Text(
                                      item.title ?? "",
                                      style: CustomTextStyles.f18W500(),
                                    ),
                                    Text(
                                      item.categoryName ?? "",
                                      style: CustomTextStyles.f14W400(
                                          color: AppColors.occupiedColor),
                                    ),
                                  ],
                                ),
                                trailing: RichText(
                                  text: TextSpan(
                                      text: 'Sold: ',
                                      style: CustomTextStyles.f14W400(),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ' ${item.count.toString()}',
                                          style: CustomTextStyles.f16W600(),
                                        )
                                      ]),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 10,
                              );
                            },
                          )
                      ],
                    );
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CountWidget extends StatelessWidget {
  final String title;
  final int count;
  final String icon;
  CountWidget({
    super.key,
    required this.title,
    required this.count,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          8,
        ),
        color: AppColors.fillFadedColor,
        border: Border.all(color: AppColors.fillFadedColor),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(
            height: 10,
          ),
          Center(
            child: SvgPicture.asset(
              icon,
              height: 40,
              width: 40,
            ),
          ),
          Center(
            child: Text(
              "${count}",
              style: CustomTextStyles.f20W400(),
            ),
          ),
          Text(
            title,
            style: CustomTextStyles.f16W600(),
          ),
        ],
      ),
    );
  }
}
