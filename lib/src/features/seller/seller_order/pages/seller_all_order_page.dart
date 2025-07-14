import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_order/widget/all_orders_tab.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_order/widget/completed_order_tab.dart';
import 'package:flutter_application_copcup/src/features/user/calender/pages/cancelled_order_tab.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
class SellerAllOrderPage extends StatefulWidget {
  const SellerAllOrderPage({super.key});

  @override
  State<SellerAllOrderPage> createState() => _SellerAllOrderPageState();
}

class _SellerAllOrderPageState extends State<SellerAllOrderPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    List<String> itemList = [
      AppLocalizations.of(context)!.sellerHomeItems,
      AppLocalizations.of(context)!.na_sellerHomeQuantity,
      AppLocalizations.of(context)!.na_sellerHomePricePerItem,
      AppLocalizations.of(context)!.total
    ];
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.orders,
        onLeadingPressed: () {
          // context.pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: colorScheme(context).onSurface.withOpacity(0.1)),
              child: Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5, left: 3),
                child: TabBar(
                  dividerColor: Colors.transparent,
                  controller: _tabController,
                  unselectedLabelColor: colorScheme(context).onSurface,
                  labelColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                    color: colorScheme(context).secondary,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  tabs: [
                    Tab(text: AppLocalizations.of(context)!.allOrders),
                    Tab(text: AppLocalizations.of(context)!.completed),
                    Tab(text: AppLocalizations.of(context)!.cancelled),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  AllOrdersTab(
                    isUser: false,
                  ),
                  CompletedOrderTab(isUser: false),
                  CancelledOrderTab(),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
