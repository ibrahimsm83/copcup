// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';

import 'package:flutter_application_copcup/src/features/responsible/add_event/controller/event_controller.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_food_catagory/controller/add_food_catagory_controller.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_food_catagory/provider/food_catagory_provider.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_food_item/controller/food_item_controller.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/provider/bottom_nav_bar_provider.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/widget/bottom_bar_widget.dart';

import 'package:flutter_application_copcup/src/features/user/cart/controller/cart_controller.dart';

import 'package:flutter_application_copcup/src/features/user/events/widget/specific_event_detail.dart';
import 'package:flutter_application_copcup/src/features/user/home/pages/user_home_page.dart';
import 'package:flutter_application_copcup/src/features/user/my_order-page/page/all_orders_page.dart';
import 'package:flutter_application_copcup/src/features/user/profile/pages/profile_page.dart';
import 'package:flutter_application_copcup/src/features/user/qr_scan/user_qr_scan_page.dart';
import 'package:flutter_application_copcup/src/features/user/search/pages/find_events_page.dart';

import 'package:provider/provider.dart';

class SpecificEventDetailPage extends StatefulWidget {
  final int id;
  const SpecificEventDetailPage({super.key, required this.id});

  @override
  State<SpecificEventDetailPage> createState() =>
      _SpecificEventDetailPageState();
}

class _SpecificEventDetailPageState extends State<SpecificEventDetailPage> {
  bool isAddressExpanded = false;
  int selectedCategoryIndex = -1;
  String selectedCategoryname = '';
  int selectedCategoryId = -1;
  var totalPrice;
  @override
  void initState() {
    super.initState();

    log('-----class get id --${widget.id}');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getSpecifcEventFoodCatagory();
      getFoodCategiry();
      getAllFoods();
      log('selected id is thsi ${selectedCategoryId}');
    });
  }

  getSpecifcEventFoodCatagory() async {
    final provider = Provider.of<EventController>(context, listen: false);
    final cartController = Provider.of<CartController>(context, listen: false);

    await provider.getEventAndFoodCategories(widget.id);

    await cartController.getAllCarts(context: context);
    log('Length ------------${provider.eventDetails}');
  }

  getAllFoods() async {
    final provider = Provider.of<FoodItemController>(context, listen: false);
    final foodProvider =
        Provider.of<FoodItemController>(context, listen: false);
    await provider.getFoodItemList(widget.id);

    if (provider.foodItemList != null) {
      log('-id\\\\\\\\\\\\\\\\\\\\${selectedCategoryId}}');
      provider.changeListWithIndexes();
    }
  }

  final List<Widget> _pages = [
    FindEventsPage(),
    UserQrScanPage(),
    AllOrdersPage(),
    ProfilePage(),
  ];
  getFoodCategiry() async {
    final provider =
        Provider.of<FoodCatagoryController>(context, listen: false);

    await provider.getFoodCategoryList(widget.id);
    if (provider.foodCategoryList != null) {
      selectedCategoryIndex = 0;
      // selectedCategoryId = await provider.foodCategoryList.first.id!;
      // selectedCategoryname =
      //     await provider.foodCategoryList.first.categoryName!;

      setState(() {});
    }
  }

  final FoodCategoryProvider foodCategoryProvider = FoodCategoryProvider();
  @override
  final ValueNotifier<int> quantity = ValueNotifier<int>(0);
  Widget build(BuildContext context) {
    final provider = Provider.of<EventController>(context, listen: false);
    log('Length ------------${provider.eventDetails}');
    final size = MediaQuery.of(context).size;

    final cartController = Provider.of<CartController>(context, listen: false);
    final navigationProvider =
        Provider.of<NavigationProvider>(context, listen: false);
    List<Widget> _pages = [
      Consumer<NavigationProvider>(
          builder: (context, value, child) =>
              value.eventBool ? SpecificEventDetailWidget() : UserHomePage()),
      FindEventsPage(),
      UserQrScanPage(),
      AllOrdersPage(),
      ProfilePage(),
    ];
    return Consumer<NavigationProvider>(
        builder: (context, value, child) => Scaffold(
            bottomNavigationBar: Consumer<NavigationProvider>(
              builder: (context, navigationProvider, child) =>
                  BottomBarWidget(),
            ),
            body: _pages[value.currentIndex]));
  }
}

class FoodCategoryIcon extends StatelessWidget {
  final String label;
  final String imageurl;

  const FoodCategoryIcon({required this.label, required this.imageurl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 73,
          width: 79,
          decoration: BoxDecoration(
            border: Border.all(
              color: colorScheme(context).onSurface.withOpacity(0.3),
            ),
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            imageurl,
            height: 20,
            width: 20,
          ),
        ),
        SizedBox(height: 5),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}
