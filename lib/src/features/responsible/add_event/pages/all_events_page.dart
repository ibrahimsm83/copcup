import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_event/widgets/all_events_tab.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_event/widgets/enrolled_events_tab.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/provider/responsible_bottom_bar.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/widget/responsible_bottom-bar_widget.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/pages/responsible_home_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/pages/responsible_stock.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_profile/pages/responsible_profile_page.dart';
import 'package:flutter_application_copcup/src/features/user/chat/pages/inbox_page.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class AllEventPage extends StatefulWidget {
  const AllEventPage({super.key});

  @override
  State<AllEventPage> createState() => _AllEventPageState();
}

class _AllEventPageState extends State<AllEventPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        bottomNavigationBar: ResponsibleBottomBarWidget(),
        // appBar: CustomAppBar(
        //   title: AppLocalizations.of(context)!.manage_events,
        //   onLeadingPressed: () {
        //     context.pop();
        //   },
        // ),
        body: Consumer<ResponsibleHomeProvider>(
          builder: (context, value, child) => page[value.currentIndex],
        ),
      ),
    );
  }

  List<Widget> page = [
    ResponsibleHomePage(),
    ResponsibleStock(),
    InboxPage(),
    Consumer<ResponsibleHomeProvider>(
        builder: (context, value, child) => value.resAllEvents
            ? ResponsibleAllEventsWidge()
            : ResponsibleProfilePage()),
  ];
}

class ResponsibleAllEventsWidge extends StatelessWidget {
  const ResponsibleAllEventsWidge({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: Icon(Icons.arrow_back)),
              Text(
                AppLocalizations.of(context)!.manage_events,
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
        ),
        TabBar(
          tabs: [
            Tab(text: AppLocalizations.of(context)!.all_events),
            Tab(text: AppLocalizations.of(context)!.na_enrolled),
          ],
        ),
        Expanded(
          child: const TabBarView(
            children: [
              AllEventsTab(),
              EnrolledEventsTab(),
            ],
          ),
        ),
      ],
    );
  }
}
