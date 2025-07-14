import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_event/controller/event_controller.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/provider/bottom_nav_bar_provider.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/widget/bottom_bar_widget.dart';
import 'package:flutter_application_copcup/src/features/user/events/widget/all_event_widget.dart';
import 'package:flutter_application_copcup/src/features/user/home/pages/user_home_page.dart';
import 'package:flutter_application_copcup/src/features/user/home/provider/catagory_provider.dart';
import 'package:flutter_application_copcup/src/features/user/my_order-page/page/all_orders_page.dart';
import 'package:flutter_application_copcup/src/features/user/profile/pages/profile_page.dart';
import 'package:flutter_application_copcup/src/features/user/qr_scan/user_qr_scan_page.dart';
import 'package:flutter_application_copcup/src/features/user/search/pages/find_events_page.dart';
import 'package:flutter_application_copcup/src/models/event_model.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AllEventsDisplayPage extends StatefulWidget {
  final String title;
  final List<EventModel> events;
  const AllEventsDisplayPage(
      {super.key, required this.title, required this.events});

  @override
  State<AllEventsDisplayPage> createState() => _AllEventPageState();
}

class _AllEventPageState extends State<AllEventsDisplayPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // getEvents();
    });

    super.initState();
  }

  List<Widget> get _pages => [
        Consumer<NavigationProvider>(
            builder: (context, value, child) => value.allEventBool == false
                ? UserHomePage()
                : AllEventWidget(title: widget.title, events: widget.events)),
        FindEventsPage(),
        UserQrScanPage(),
        AllOrdersPage(),
        ProfilePage(),
      ];
  getEvents() async {
    final provider = Provider.of<EventController>(context, listen: false);
    await provider.getUserEventList();
    print(provider.eventList);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final providerEvent = Provider.of<EventController>(context);
    return Scaffold(
      bottomNavigationBar: BottomBarWidget(),
      body:
          //  RefreshIndicator(
          //   onRefresh: () async {
          //     await getEvents();
          //   },
          //   child:
          Consumer<NavigationProvider>(
              builder: (context, value, child) => _pages[value.currentIndex]),
      // ),
    );
  }
}
