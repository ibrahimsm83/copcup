import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_food_catagory/controller/add_food_catagory_controller.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_food_item/controller/food_item_controller.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/provider/bottom_nav_bar_provider.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/widget/bottom_bar_widget.dart';
import 'package:flutter_application_copcup/src/features/user/home/pages/user_home_page.dart';
import 'package:flutter_application_copcup/src/features/user/my_order-page/page/all_orders_page.dart';
import 'package:flutter_application_copcup/src/features/user/profile/pages/profile_page.dart';
import 'package:flutter_application_copcup/src/features/user/qr_scan/user_qr_scan_page.dart';
import 'package:flutter_application_copcup/src/features/user/search/pages/find_events_page.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class AllFoodListPage extends StatefulWidget {
  const AllFoodListPage({super.key});

  @override
  State<AllFoodListPage> createState() => _AllFoodListPageState();
}

class _AllFoodListPageState extends State<AllFoodListPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FoodItemController>(context);
    return Scaffold(
        bottomNavigationBar: BottomBarWidget(),
        body: Consumer<NavigationProvider>(
            builder: (context, value, child) => _pages[value.currentIndex]));
  }

  List<Widget> _pages = [
    Consumer<NavigationProvider>(
      builder: (context, value, child) => value.eventBool == false
          ? UserHomePage()
          : Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.pop();
                        },
                        child: Icon(
                          Icons.arrow_back,
                        ),
                      ),
                      Text(
                        'Food List',
                        style: textTheme(context).headlineSmall?.copyWith(
                              fontSize: 21,
                              color: colorScheme(context).onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Consumer2<FoodCatagoryController, FoodItemController>(
                  builder: (context, provider, food, child) {
                    return GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 3.0,
                        mainAxisSpacing: 1,
                        childAspectRatio: 1,
                      ),
                      itemCount: provider.foodCategoryList.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        print(provider.foodCategoryList);

                        final category = provider.foodCategoryList[index];
                        final isSelected =
                            provider.selectedCategory == category.categoryName;

                        return GestureDetector(
                          onTap: () {
                            food.changeColorIndexOfFood(
                                index, category.categoryName!);
                            food.changeFoodCategoryIndexFunction(category.id);

                            food.changeListWithIndexes();
                            context.pop();
                          },
                          child: Column(
                            children: [
                              Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: food.changeindex == index
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context).colorScheme.surface,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 1.5,
                                    color: food.changeindex == index
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withOpacity(0.5),
                                  ),
                                ),
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: "${category.image}",
                                    height: double.infinity,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        color: Colors.grey[300],
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                category.categoryName!,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: food.changeindex == index
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
    ),
    FindEventsPage(),
    UserQrScanPage(),
    AllOrdersPage(),
    ProfilePage(),
  ];
}
