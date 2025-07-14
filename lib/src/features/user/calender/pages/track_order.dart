import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_order/model/order_model.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_order/provider/seller_order_provider.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/provider/bottom_nav_bar_provider.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/widget/bottom_bar_widget.dart';
import 'package:flutter_application_copcup/src/features/user/calender/widgets/track_order_widget.dart';
import 'package:flutter_application_copcup/src/features/user/home/pages/user_home_page.dart';
import 'package:flutter_application_copcup/src/features/user/my_order-page/page/all_orders_page.dart';
import 'package:flutter_application_copcup/src/features/user/profile/pages/profile_page.dart';
import 'package:flutter_application_copcup/src/features/user/qr_scan/user_qr_scan_page.dart';
import 'package:flutter_application_copcup/src/features/user/search/pages/find_events_page.dart';
import 'package:provider/provider.dart';

class TrackOrder extends StatefulWidget {
  final OrderModel orderList;
  final String oderStatus;
  const TrackOrder(
      {super.key, required this.oderStatus, required this.orderList});

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<SellerOrderProvider>(context, listen: false);
      if (provider.allUserOrders.isEmpty) {
        provider.getUserAllOrders(context: context);
      }
    });
  }

  Future<void> getUserOrder() async {
    final provider = Provider.of<SellerOrderProvider>(context, listen: false);
    await provider.getUserAllOrders(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBarWidget(),
      body: Consumer<NavigationProvider>(
        builder: (context, value, child) => getPages()[value.currentIndex],
      ),
    );
  }

  List<Widget> getPages() {
    return [
      Consumer<NavigationProvider>(
          builder: (context, value, child) => value.trackBoolean
              ? TrackOrderWidget(
                  status: widget.oderStatus,
                  orderList: widget.orderList,
                )
              : UserHomePage()),
      FindEventsPage(),
      UserQrScanPage(),
      AllOrdersPage(),
      ProfilePage(),
    ];
  }
}
