// ignore_for_file: use_key_in_widget_constructors
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_order/provider/seller_order_provider.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/widget/bottom_bar_widget.dart';
import 'package:flutter_application_copcup/src/features/user/my_order-page/page/all_orders_page.dart';
import 'package:flutter_application_copcup/src/features/user/calender/provider/cart_provider.dart';
import 'package:flutter_application_copcup/src/features/user/home/pages/user_home_page.dart';
import 'package:flutter_application_copcup/src/features/user/profile/pages/profile_page.dart';
import 'package:flutter_application_copcup/src/features/user/qr_scan/user_qr_scan_page.dart';
import 'package:flutter_application_copcup/src/features/user/search/pages/find_events_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/provider/bottom_nav_bar_provider.dart';

import '../profile/provider/user_data_provider.dart';

class UserBottomNavBar extends StatefulWidget {
  @override
  State<UserBottomNavBar> createState() => _UserBottomNavBarState();
}

class _UserBottomNavBarState extends State<UserBottomNavBar> {
  int? orderCount;
  final List<Widget> _pages = [
    UserHomePage(),
    FindEventsPage(),
    UserQrScanPage(),
    AllOrdersPage(),
    ProfilePage(isFromHome:false),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final sellerProvider =
          Provider.of<SellerOrderProvider>(context, listen: false);
      await sellerProvider.getUserAllOrders(context: context);
      orderCount = sellerProvider.allUserOrders.length;
      getUser();
      log('bottom-------------${sellerProvider.allUserOrders.length}');
    });
  }
  getUser() async {
    final provider = Provider.of<UserDataProvider>(context, listen: false);
    await provider.getUsersData();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItemCount = cartProvider.cartItems
        .fold<int>(0, (sum, item) => sum + item.quantity.value);

    return Consumer<NavigationProvider>(
      builder: (context, navigationProvider, child) {
        return Scaffold(
          body: _pages[navigationProvider.currentIndex],
          bottomNavigationBar: BottomBarWidget(),
        );
      },
    );
  }
}
