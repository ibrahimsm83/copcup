import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/provider/bottom_nav_bar_provider.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/widget/bottom_bar_widget.dart';
import 'package:flutter_application_copcup/src/features/user/cart/controller/cart_controller.dart';
import 'package:flutter_application_copcup/src/features/user/home/pages/user_home_page.dart';
import 'package:flutter_application_copcup/src/features/user/my_order-page/page/all_orders_page.dart';
import 'package:flutter_application_copcup/src/features/user/payment/widget/payment_widget.dart';
import 'package:flutter_application_copcup/src/features/user/profile/pages/profile_page.dart';
import 'package:flutter_application_copcup/src/features/user/qr_scan/user_qr_scan_page.dart';
import 'package:flutter_application_copcup/src/features/user/search/pages/find_events_page.dart';

import 'package:provider/provider.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({super.key});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _couponController = TextEditingController();

  @override
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getAllCart();
    });
  }

  getAllCart() async {
    final provider = Provider.of<CartController>(context, listen: false);
    await provider.getAllCarts(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomBarWidget(),
        body: Consumer<NavigationProvider>(
            builder: (context, value, child) => pages[value.currentIndex]));
  }

  List<Widget> pages = [
    Consumer<NavigationProvider>(
        builder: (context, value, child) =>
            value.checkoutBool == true ? PaymentWidget() : UserHomePage()),
    FindEventsPage(),
    UserQrScanPage(),
    AllOrdersPage(),
    ProfilePage(),
  ];
  void _validateCoupon() {
    if (_formKey.currentState?.validate() ?? false) {
      print("Coupon Applied: ${_couponController.text}");
    } else {
      print("Coupon validation failed");
    }
  }
}
