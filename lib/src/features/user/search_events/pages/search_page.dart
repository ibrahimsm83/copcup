import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_shimer.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_event/controller/event_controller.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/provider/bottom_nav_bar_provider.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/widget/bottom_bar_widget.dart';
import 'package:flutter_application_copcup/src/features/user/home/pages/user_home_page.dart';
import 'package:flutter_application_copcup/src/features/user/my_order-page/page/all_orders_page.dart';
import 'package:flutter_application_copcup/src/features/user/profile/pages/profile_page.dart';
import 'package:flutter_application_copcup/src/features/user/qr_scan/user_qr_scan_page.dart';
import 'package:flutter_application_copcup/src/features/user/search/pages/find_events_page.dart';
import 'package:flutter_application_copcup/src/features/user/search/widgets/event_card.dart';
import 'package:flutter_application_copcup/src/features/user/search_events/controller/search_event_controller.dart';
import 'package:flutter_application_copcup/src/features/user/search_events/widget/search_widget.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
    // Fetch recent searches once the page is loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SearchEventController>(context, listen: false)
          .fetchRecentSearches();
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchEventController = Provider.of<SearchEventController>(context);
    return Scaffold(
      bottomNavigationBar: BottomBarWidget(),
      body: Consumer<NavigationProvider>(
          builder: (context, value, child) => pages[value.currentIndex]),
    );
  }

  List<Widget> pages = [
    Consumer<NavigationProvider>(
      builder: (context, value, child) =>
          value.searchBool ? SearchScreenWidget() : UserHomePage(),
    ),
    FindEventsPage(),
    UserQrScanPage(),
    AllOrdersPage(),
    ProfilePage(),
  ];
}
