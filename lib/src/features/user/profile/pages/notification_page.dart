import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/widget/bottom_bar_widget.dart';
import 'package:flutter_application_copcup/src/features/user/home/pages/user_home_page.dart';
import 'package:flutter_application_copcup/src/features/user/my_order-page/page/all_orders_page.dart';
import 'package:flutter_application_copcup/src/features/user/profile/pages/profile_page.dart';
import 'package:flutter_application_copcup/src/features/user/profile/widgets/notification_widget.dart';
import 'package:flutter_application_copcup/src/features/user/qr_scan/user_qr_scan_page.dart';
import 'package:flutter_application_copcup/src/features/user/search/pages/find_events_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../bottom_nav_bar/provider/bottom_nav_bar_provider.dart';

class NotificationPage extends StatelessWidget {
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
            value.notificationBool ? NotificationWidget() : ProfilePage()),
  ];
}

class NotificationTile extends StatelessWidget {
  final String imagesvg;
  final String title;
  final String subtitle;

  const NotificationTile({
    required this.imagesvg,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: 86,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          color: colorScheme(context).surface,
          border: Border.all(
              color: colorScheme(context).onSurface.withOpacity(0.15)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: colorScheme(context).primary,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    imagesvg,
                    height: 18,
                    width: 18,
                    color: colorScheme(context).surface,
                  ),
                ],
              ),
            ),
            SizedBox(width: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme(context).titleSmall?.copyWith(
                      color: colorScheme(context).onSurface,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  subtitle,
                  style: textTheme(context).labelSmall?.copyWith(
                      color: colorScheme(context).onSurface.withOpacity(0.4),
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
