import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/features/responsible/professional_qr/professional_qr_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/widget/responsible_bottom-bar_widget.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/pages/responsible_home_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/pages/responsible_stock.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_profile/pages/responsible_profile_page.dart';
import 'package:flutter_application_copcup/src/features/user/chat/pages/inbox_page.dart';

import 'package:provider/provider.dart';

import '../provider/responsible_bottom_bar.dart';

class ResponsibleBottomBar extends StatelessWidget {
  ResponsibleBottomBar({super.key});

  @override
  final List<Widget> _pages = [
    ResponsibleHomePage(),
    ResponsibleStock(),
    InboxPage(),
    ResponsibleProfilePage(),
  ];

  Widget build(BuildContext context) {
    return Consumer<ResponsibleHomeProvider>(
      builder: (context, value, child) => Scaffold(
        body: _pages[value.currentIndex],
        bottomNavigationBar: ResponsibleBottomBarWidget(),
      ),
    );
  }
}
