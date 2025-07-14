import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/provider/bottom_nav_bar_provider.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/widget/bottom_bar_widget.dart';
import 'package:flutter_application_copcup/src/features/user/home/pages/user_home_page.dart';
import 'package:flutter_application_copcup/src/features/user/my_order-page/page/all_orders_page.dart';
import 'package:flutter_application_copcup/src/features/user/profile/pages/profile_page.dart';
import 'package:flutter_application_copcup/src/features/user/profile/widgets/language_widget.dart';
import 'package:flutter_application_copcup/src/features/user/qr_scan/user_qr_scan_page.dart';
import 'package:flutter_application_copcup/src/features/user/search/pages/find_events_page.dart';
import 'package:flutter_application_copcup/src/features/user/transaction/widget/transaction-widget.dart';
import 'package:provider/provider.dart';

class UserChooseLanguagePage extends StatefulWidget {
  const UserChooseLanguagePage({super.key});

  @override
  State<UserChooseLanguagePage> createState() => _UserChooseLanguagePageState();
}

class _UserChooseLanguagePageState extends State<UserChooseLanguagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBarWidget(),
      body: Consumer<NavigationProvider>(
          builder: (context, value, child) => pages[value.currentIndex]),
    );
  }

  List<Widget> pages = [
    UserHomePage(),
    FindEventsPage(),
    UserQrScanPage(),
    AllOrdersPage(),
    Consumer<NavigationProvider>(
        builder: (context, value, child) =>
            value.languageBool ? LanguageWidget() : ProfilePage()),
  ];
}
