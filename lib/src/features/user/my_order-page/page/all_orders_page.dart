import 'package:flutter/material.dart';

import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/features/user/my_order-page/widget/user_all_order_page.dart';
import 'package:flutter_application_copcup/src/features/user/my_order-page/widget/user_cancle_order.dart';
import 'package:flutter_application_copcup/src/features/user/my_order-page/widget/user_complete_order.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
class AllOrdersPage extends StatefulWidget {
  const AllOrdersPage({super.key});

  @override
  State<AllOrdersPage> createState() => _AllOrdersPageState();
}

class _AllOrdersPageState extends State<AllOrdersPage>
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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.myOrder,
        isLeadingIcon: false,
        // onLeadingPressed: () {
        //   // context.pop();
        // },
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
                    color: colorScheme(context).primary,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  tabs: [
                    Tab(text: AppLocalizations.of(context)!.allOrders),
                    Tab(text: AppLocalizations.of(context)!.completed),
                    Tab(text: AppLocalizations.of(context)!.cancel_button),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  UserAllOrderPage(),
                  UserCompleteOrder(),
                  UserCancleOrder(),
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
