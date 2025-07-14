// ignore_for_file: override_on_non_overriding_member

import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/features/seller/home/pages/seller_home_page.dart';
import 'package:flutter_application_copcup/src/features/seller/home/pages/seller_stock_page.dart';
import 'package:flutter_application_copcup/src/features/seller/home/provider/seller_home_provider.dart';
import 'package:flutter_application_copcup/src/features/seller/qr/seller_qr_scanner.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_bottom_nav_bar/widget/bottom_bar_widget.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_order/pages/seller_all_order_page.dart';
import 'package:flutter_application_copcup/src/features/seller/setting/pages/seller_setting_page.dart';

import 'package:provider/provider.dart';

class SellerBottomBar extends StatelessWidget {
  SellerBottomBar({super.key});

  @override
  final List<Widget> _pages = [
    SellerHomePage(),
    SellerStockPage(),
    SellerQrScanPage(),
    SellerAllOrderPage(),
    SellerSettingPage(),
  ];

  Widget build(BuildContext context) {
    return Consumer<SellerHomeProvider>(
      builder: (context, value, child) => Scaffold(
        body: _pages[value.currentIndex],
        bottomNavigationBar: SellerBottomBarWidget(),
      ),
    );
  }
}
