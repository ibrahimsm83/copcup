import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/provider/bottom_nav_bar_provider.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/widget/bottom_bar_widget.dart';

import 'package:flutter_application_copcup/src/features/user/cart/controller/cart_controller.dart';
import 'package:flutter_application_copcup/src/features/user/cart/controller/widget/my-cart_widget.dart';
import 'package:flutter_application_copcup/src/features/user/home/pages/user_home_page.dart';
import 'package:flutter_application_copcup/src/features/user/my_order-page/page/all_orders_page.dart';
import 'package:flutter_application_copcup/src/features/user/profile/pages/profile_page.dart';
import 'package:flutter_application_copcup/src/features/user/qr_scan/user_qr_scan_page.dart';
import 'package:flutter_application_copcup/src/features/user/search/pages/find_events_page.dart';

import 'package:provider/provider.dart';

class MyCartPage extends StatefulWidget {
  const MyCartPage({super.key});

  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAllCart();
    });
    super.initState();
  }

  getAllCart() async {
    final provider = Provider.of<CartController>(context, listen: false);
    await provider.getAllCarts(context: context);
    print(provider.cartItemList);
  }

  List<Map<String, dynamic>> cartItems = [];

  List<Widget> get _pages => [
        Consumer<NavigationProvider>(
            builder: (context, value, child) => value.myCartBool == false
                ? UserHomePage()
                : MyCartWidget(
                    cartItems: cartItems,
                  )),
        FindEventsPage(),
        UserQrScanPage(),
        AllOrdersPage(),
        ProfilePage(),
      ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomBarWidget(),
        body: Consumer<NavigationProvider>(
            builder: (context, value, child) => _pages[value.currentIndex]));
  }
}
