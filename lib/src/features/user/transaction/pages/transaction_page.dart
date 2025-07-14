import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/widget/bottom_bar_widget.dart';
import 'package:flutter_application_copcup/src/features/user/home/pages/user_home_page.dart';
import 'package:flutter_application_copcup/src/features/user/my_order-page/page/all_orders_page.dart';
import 'package:flutter_application_copcup/src/features/user/profile/pages/profile_page.dart';
import 'package:flutter_application_copcup/src/features/user/qr_scan/user_qr_scan_page.dart';
import 'package:flutter_application_copcup/src/features/user/search/pages/find_events_page.dart';
import 'package:flutter_application_copcup/src/features/user/transaction/controller/transcation_controller.dart';
import 'package:flutter_application_copcup/src/features/user/transaction/widget/transaction-widget.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../bottom_nav_bar/provider/bottom_nav_bar_provider.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUserTranscation();
    });

    super.initState();
  }

  getUserTranscation() async {
    final provider = Provider.of<TranscationController>(context, listen: false);
    await provider.getUserTransactions();
  }

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
            value.trackBoolean ? TransactionWidget() : ProfilePage()),
  ];
}

class TransactionCard extends StatelessWidget {
  final String name;
  final String amount;
  final String date;
  final String imageUrl;

  const TransactionCard({
    required this.name,
    required this.amount,
    required this.date,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    String formatDate(String date) {
      try {
        final parsedDate = DateTime.parse(date);
        return DateFormat('MMMM d, yyyy').format(parsedDate);
      } catch (e) {
        return date;
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: colorScheme(context).onSurface.withOpacity(0.2))),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(imageUrl),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: textTheme(context).bodySmall?.copyWith(
                      color: colorScheme(context).onSurface,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Text(
                  amount,
                  style: textTheme(context).titleSmall?.copyWith(
                      color: colorScheme(context).primary,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 19),
            child: Text(
              formatDate(date),
              style: textTheme(context).bodySmall?.copyWith(
                  color: colorScheme(context).onSurface.withOpacity(0.5),
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
