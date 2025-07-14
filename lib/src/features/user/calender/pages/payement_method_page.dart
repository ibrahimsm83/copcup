import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/provider/bottom_nav_bar_provider.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/widget/bottom_bar_widget.dart';
import 'package:flutter_application_copcup/src/features/user/calender/provider/radio_provider.dart';
import 'package:flutter_application_copcup/src/features/user/calender/widgets/payment_method_widget.dart';
import 'package:flutter_application_copcup/src/features/user/home/pages/user_home_page.dart';
import 'package:flutter_application_copcup/src/features/user/my_order-page/page/all_orders_page.dart';
import 'package:flutter_application_copcup/src/features/user/profile/pages/profile_page.dart';
import 'package:flutter_application_copcup/src/features/user/qr_scan/user_qr_scan_page.dart';
import 'package:flutter_application_copcup/src/features/user/search/pages/find_events_page.dart';

import 'package:provider/provider.dart';

class PayementMethod extends StatefulWidget {
  final String totalPrice;
  const PayementMethod({super.key, required this.totalPrice});

  @override
  State<PayementMethod> createState() => _PayementMethodState();
}

class _PayementMethodState extends State<PayementMethod> {
  List<Widget> get pages => [
        Consumer<NavigationProvider>(
            builder: (context, value, child) => value.paymentMethodBool
                ? PaymentMethodWidget(totalPrice: widget.totalPrice)
                : UserHomePage()),
        FindEventsPage(),
        UserQrScanPage(),
        AllOrdersPage(),
        ProfilePage(),
      ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final paymentProvider = Provider.of<PaymentMethodProvider>(context);

    return Scaffold(
      bottomNavigationBar: BottomBarWidget(),
      body: Consumer<NavigationProvider>(
          builder: (context, value, child) => pages[value.currentIndex]),
    );
  }
}
