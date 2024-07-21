import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saralnova/core/controllers/Dashboard/dashboard_panel_controller.dart';
import 'package:saralnova/core/controllers/pos/place_order_pos_controller.dart';
import 'package:saralnova/core/model/feature_model/restaurant_model/menu_model.dart';
import 'package:saralnova/core/utils/constants/colors.dart';
import 'package:saralnova/core/utils/constants/custom_text_style.dart';
import 'package:saralnova/core/utils/constants/icon_path.dart';
import 'package:saralnova/core/utils/enums/enums.dart';
import 'package:saralnova/core/utils/helpers/sky_network_image.dart';
import 'package:saralnova/features/screens/Dashboard/pos/make_order_pos_screen.dart';
import 'package:saralnova/features/widgets/common_widgets/empty_view.dart';
import 'package:saralnova/features/widgets/common_widgets/error_view.dart';
import 'package:saralnova/features/widgets/shimmers/list_shimmer.dart';

class PlaceOrderScreenPOS extends StatelessWidget {
  static const String routeName = "/place-order-screen-pos";
  final c = Get.find<PlaceOrderPosController>();
  final dpc = Get.find<DashPanelController>();
  PlaceOrderScreenPOS({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkResponse(
          radius: 10,
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            Get.back();
            dpc.onUpdatePage(3);
          },
          child: const Icon(
            Icons.arrow_back,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(0),
            child: AnimSearchBar(
              // textFieldColor: AppColors.fillColor,
              textFieldIconColor: Colors.white,
              rtl: true,
              prefixIcon: const Icon(
                Icons.search,
                size: 15,
                color: AppColors.splashBackgroundColor,
              ),

              boxShadow: false,
              helpText: "Search....",
              suffixIcon: const Icon(
                Icons.search,
                size: 15,
                color: AppColors.blackColor,
              ),
              searchIconColor: AppColors.textColor,
              color: AppColors.fillColor,
              width: 300,
              textController: c.searchMenuController,
              onSuffixTap: () {},
              onSubmitted: (String) {},
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: 110,
              child: Obx(() {
                if (c.categories.isEmpty) {
                  return SaralNovaShimmer.categoryShimmerPOS();
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          c.selectedCategory.value = null;
                          c.getMenuItems();
                        },
                        child: Obx(() => Container(
                              height: 92,
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: c.selectedCategory.value == null
                                      ? AppColors.orangeColor
                                      : AppColors.borderColor,
                                ),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: const SkyNetworkImage(
                                      imageUrl: "",
                                      height: 60,
                                      width: 60,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  const Text("All")
                                ],
                              ),
                            )),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ListView.separated(
                          padding: const EdgeInsets.only(bottom: 20),
                          itemCount: c.categories.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 10,
                            );
                          },
                          itemBuilder: (context, index) {
                            var category = c.categories[index];
                            return GestureDetector(
                              onTap: () {
                                c.selectCategory(category.id);

                                c.getMenuItems(categoryId: category.id);
                              },
                              child: Obx(() => Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: c.selectedCategory.value ==
                                                category.id.toString()
                                            ? AppColors.orangeColor
                                            : AppColors.borderColor,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: SkyNetworkImage(
                                            imageUrl: category.image ?? "",
                                            height: 60,
                                            width: 60,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(category.title ?? "")
                                      ],
                                    ),
                                  )),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              }),
            ),

            //lower part, show products
            const SizedBox(
              height: 10,
            ),

            Obx(() {
              if (c.pageState.value == PageState.LOADING) {
                return Expanded(child: SaralNovaShimmer.menuGridShimmer());
              } else if (c.pageState.value == PageState.EMPTY) {
                return EmptyView(
                  message: "No data available",
                  title: "No Data",
                  media: IconPath.nodata,
                );
              } else if (c.pageState.value == PageState.NORMAL) {
                return Expanded(
                  child: Obx(
                    () => GridView.builder(
                      key: const PageStorageKey("products"),
                      padding: const EdgeInsets.only(bottom: 100),
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: c.menuList.length,
                      itemBuilder: (context, index) {
                        var menu = c.menuList[index];

                        return GestureDetector(
                            onTap: () {
                              c.onSelectMenu(menu);
                            },
                            child: Obx(
                              () => MenuBox(
                                menu: menu,
                                color: c.selectedMenuList
                                        .any((item) => item.id == menu.id)
                                    ? AppColors.orangeColor
                                    : AppColors.borderColor,
                              ),
                            ));
                      },
                    ),
                  ),
                );
              } else {
                return const ErrorView(
                  errorTitle: "Something went wrong!!",
                  errorMessage: "Something went wrong",
                  imagePath: IconPath.somethingWentWrong,
                );
              }
            })
          ],
        ),
      ),
      floatingActionButton: Obx(() {
        if (c.selectedMenuList.isNotEmpty) {
          return Stack(
            children: [
              FloatingActionButton.extended(
                shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.brown),
                    borderRadius: BorderRadius.circular(30)),
                label: const Text("Place order"),
                onPressed: () {
                  Get.toNamed(MakeOrderPosScreen.routeName);
                },
              ),
              Positioned(
                right: 0,
                top: 0,
                child: badges.Badge(
                  showBadge: Get.find<PlaceOrderPosController>()
                      .selectedMenuList
                      .isNotEmpty,
                  position: badges.BadgePosition.topEnd(top: -8, end: -5),
                  badgeContent: Text(
                    c.selectedMenuList.length > 9
                        ? "9+"
                        : "${c.selectedMenuList.length}",
                    style: CustomTextStyles.f13W400(
                      color: AppColors.splashBackgroundColor,
                    ),
                  ),
                  badgeStyle: const badges.BadgeStyle(
                    badgeColor: AppColors.orangeColor,
                    shape: badges.BadgeShape.circle,
                  ),
                ),
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      }),
    );
  }
}

class MenuBox extends StatelessWidget {
  MenuBox({
    super.key,
    required this.menu,
    this.color,
  });

  final Menu menu;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            // color: AppColors.borderColor,
            color: color ?? AppColors.borderColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SkyNetworkImage(
              imageUrl: menu.imageUrl ?? "",
              height: 100,
              width: 100,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            menu.title ?? "",
            style: CustomTextStyles.f14W400(color: AppColors.blackColor),
          ),
          const SizedBox(
            height: 4,
          ),
          if (menu.price != null)
            Text(
              "Rs. ${menu.price.toString()}",
              style: CustomTextStyles.f14W400(color: AppColors.blackColor),
            )
        ],
      ),
    );
  }
}
