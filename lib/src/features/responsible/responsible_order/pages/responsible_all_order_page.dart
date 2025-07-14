// import 'package:flutter/material.dart';
// import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
// import 'package:flutter_application_copcup/src/features/seller/seller_order/widget/all_orders_tab.dart';
// import 'package:go_router/go_router.dart';
// import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
// class ResponsibleAllOrderPage extends StatefulWidget {
//   const ResponsibleAllOrderPage({super.key});

//   @override
//   State<ResponsibleAllOrderPage> createState() =>
//       _ResponsibleAllOrderPageState();
// }

// class _ResponsibleAllOrderPageState extends State<ResponsibleAllOrderPage> {
//   @override
//   Widget build(BuildContext context) {
//     // ignore: unused_local_variable
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: AppLocalizations.of(context)!.order_list,
//         onLeadingPressed: () {
//           context.pop();
//         },
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(13.0),
//         child: Column(
//           children: [
//             const SizedBox(height: 16),
//             Expanded(
//               child: AllOrdersTab(isUser: true),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/provider/responsible_bottom_bar.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/widget/responsible_bottom-bar_widget.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/pages/responsible_home_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/pages/responsible_stock.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_order/widget/responsible_all_order.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_order/widget/responsible_cancle_order.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_order/widget/responsible_complete_order.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_profile/pages/responsible_profile_page.dart';
import 'package:flutter_application_copcup/src/features/user/chat/pages/inbox_page.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';


class ResponsibleAllOrderPage extends StatelessWidget {
  ResponsibleAllOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: ResponsibleBottomBarWidget(),
      body: Consumer<ResponsibleHomeProvider>(
        builder: (context, value, child) => page[value.currentIndex],
      ),
    );
  }

  List<Widget> page = [
    ResponsibleHomePage(),
    ResponsibleStock(),
    InboxPage(),
    Consumer<ResponsibleHomeProvider>(
        builder: (context, value, child) => value.resAllOrders
            ? ResponsibleAllOrderWidgetScreen()
            : ResponsibleProfilePage()),
  ];
}

class ResponsibleAllOrderWidgetScreen extends StatefulWidget {
  const ResponsibleAllOrderWidgetScreen({super.key});

  @override
  State<ResponsibleAllOrderWidgetScreen> createState() =>
      _ResponsibleAllOrderWidgetScreenState();
}

class _ResponsibleAllOrderWidgetScreenState
    extends State<ResponsibleAllOrderWidgetScreen>
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

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: Icon(Icons.arrow_back)),
              Text(
                AppLocalizations.of(context)!.myOrder,
                style: textTheme(context).headlineSmall?.copyWith(
                      fontSize: 21,
                      color: colorScheme(context).onSurface,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SizedBox(
                width: 20,
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
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
                ResponsibleAllOrder(),
                ResponsibleCompleteOrder(),
                ResponsibleCancleOrder(),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
