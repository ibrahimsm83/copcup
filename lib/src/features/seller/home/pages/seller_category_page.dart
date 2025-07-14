import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_container.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_food_catagory/controller/add_food_catagory_controller.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_food_item/controller/food_item_controller.dart';
import 'package:flutter_application_copcup/src/features/seller/home/pages/seller_home_page.dart';
import 'package:flutter_application_copcup/src/features/seller/home/pages/seller_stock_page.dart';
import 'package:flutter_application_copcup/src/features/seller/home/provider/seller_home_provider.dart';
import 'package:flutter_application_copcup/src/features/seller/qr/seller_qr_scanner.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_bottom_nav_bar/widget/bottom_bar_widget.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_order/pages/seller_all_order_page.dart';
import 'package:flutter_application_copcup/src/features/seller/setting/pages/seller_setting_page.dart';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class SellerCategoryPage extends StatefulWidget {
  const SellerCategoryPage({super.key});

  @override
  State<SellerCategoryPage> createState() => _SellerCategoryPageState();
}

class _SellerCategoryPageState extends State<SellerCategoryPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getFoodCategory();
    });
    super.initState();
  }

  getFoodCategory() async {
    final provider =
        Provider.of<FoodCatagoryController>(context, listen: false);
    await provider.getFoodCategoryList(StaticData.sellerEventId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SellerBottomBarWidget(),
      body: Consumer<SellerHomeProvider>(
          builder: (context, value, child) => pages[value.currentIndex]),
    );
  }

  List<Widget> pages = [
    SellerHomePage(),
    Consumer<SellerHomeProvider>(
        builder: (context, value, child) => value.sellerAllCategoryBool
            ? SellerCategoruPageWidget()
            : SellerStockPage()),
    SellerQrScanPage(),
    SellerAllOrderPage(),
    SellerCategoruPageWidget(),
    SellerSettingPage(),
  ];
}

class SellerCategoruPageWidget extends StatefulWidget {
  const SellerCategoruPageWidget({super.key});

  @override
  State<SellerCategoruPageWidget> createState() =>
      _SellerCategoruPageWidgetState();
}

class _SellerCategoruPageWidgetState extends State<SellerCategoruPageWidget> {
  @override
  Widget build(BuildContext context) {
    var m = MediaQuery.of(context).size;
    return Column(
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
                  child: Icon(Icons.arrow_back)),
              Text(
                'All Categories',
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
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Consumer<FoodCatagoryController>(
                builder: (context, provider, child) {
              if (provider.isFoodCategoryLoading) {
                return Padding(
                  padding: EdgeInsets.only(top: m.width * 0.4),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              return GridView.builder(
                  shrinkWrap: true,
                  itemCount: provider.foodCategoryList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, childAspectRatio: 0.8),
                  itemBuilder: (context, index) {
                    final category = provider.foodCategoryList[index];
                    if (provider.foodCategoryList.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: m.height * 0.4),
                          child: Text("No Category Found"),
                        ),
                      );
                    }
                    return Consumer<FoodItemController>(
                      builder: (context, selectedIndex, child) => Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomContainer(
                                height: 73,
                                onTap: () async {
                                  provider
                                      .selectCategory(category.categoryName!);

                                  selectedIndex.sellerFoodIndexsChange(index);
                                  selectedIndex
                                      .sellerCategoryIdCopy(category.id);
                                  selectedIndex.sellerChangeFoodWithCategory();
                                  context.pop();
                                  // final result = await context.pushNamed(
                                  //   AppRoute.foodCatagoryDetailPage,
                                  //   extra: category,
                                  // );

                                  // print(result);
                                  // if (result == true) {
                                  //   await provider.getFoodCategoryList();
                                  // }
                                },
                                width: 79,
                                borderRadius: 5,
                                borderColor: selectedIndex
                                            .sellerFoodCatgoerySelectedIndex ==
                                        index
                                    ? colorScheme(context).primary
                                    : Colors.transparent,
                                borderWidth: 1.5,
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: "${category.image}",
                                  width: double.infinity,
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      color: Colors.grey[300],
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                              Text(
                                category.categoryName!,
                                style: textTheme(context).labelLarge?.copyWith(
                                    letterSpacing: 0.2,
                                    fontSize: 12,
                                    color: colorScheme(context).onSurface),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  });
            })),
      ],
    );
  }
}
