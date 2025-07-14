import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_shimer.dart';
import 'package:flutter_application_copcup/src/core/api_end_points.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_event/controller/event_controller.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/provider/bottom_nav_bar_provider.dart';
import 'package:flutter_application_copcup/src/features/user/search/widgets/event_card.dart';
import 'package:flutter_application_copcup/src/features/user/search/widgets/section_header.dart';
import 'package:flutter_application_copcup/src/features/user/search_events/controller/search_event_controller.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FindEventsPage extends StatefulWidget {
  @override
  _FindEventsPageState createState() => _FindEventsPageState();
}

class _FindEventsPageState extends State<FindEventsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SearchEventController>(context, listen: false)
          .fetchNearbyEvents();
      Provider.of<SearchEventController>(context, listen: false)
          .fetchMostPopularEvents();
      Provider.of<SearchEventController>(context, listen: false)
          .gettheLatestOrder();
      Provider.of<SearchEventController>(context, listen: false)
          .fetchMostRecentEvents();
    });
  }

  final EventController eventController = EventController();
  final ValueNotifier<int> selectedKg = ValueNotifier<int>(1);
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final searchEventController = Provider.of<SearchEventController>(context);
    final navigationProvider = Provider.of<NavigationProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.findEventsTitle,
isLeadingIcon: false,
        // onLeadingPressed: () {},
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Consumer<EventController>(
              builder: (context, eventcontroller, child) {
            return Column(
              children: [
                _buildSearchBar(context),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SectionHeader(
                      title: AppLocalizations.of(context)!.all_events,
                    ),
                    TextButton(
                      onPressed: () {
                        navigationProvider.updateEventBool(true);
                        navigationProvider.setCurrentIndex(0);
                        log('---------------');
                        context.pushNamed(AppRoute.allEventsPages, extra: {
                          "title":
                              "${AppLocalizations.of(context)!.all_events}",
                          "events": eventcontroller.eventList
                        });
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.seeAllButton,
                            style: textTheme(context).labelMedium?.copyWith(
                                color: colorScheme(context).primary,
                                fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(width: 5),
                          const Icon(Icons.arrow_forward_ios, size: 15),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                eventcontroller.isEventLoading
                    ? const Center(child: CustomShimmer())
                    : eventcontroller.eventList == null ||
                            eventcontroller.eventList.isEmpty
                        ? Center(
                            child: Text(AppLocalizations.of(context)!
                                .na_noEventAvailable))
                        : SizedBox(
                            height: size.height * 0.3,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: eventcontroller.eventList.length,
                              itemBuilder: (context, index) {
                                final events = eventcontroller.eventList[index];
                                return EventCardContainer(
                                  imageUrl: events.image,
                                  eventName: events.eventName,
                                  address: events.address,
                                  onTap: () async {
                                    eventcontroller
                                        .selectEvent(events.eventName);
                                    navigationProvider.setCurrentIndex(0);
                                    navigationProvider.updateEventBool(true);
                                    final result = await context.pushNamed(
                                      AppRoute.specificEventDetailPage,
                                      extra: events.id,
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                SizedBox(height: 20),
                SectionHeader(
                  title: AppLocalizations.of(context)!.mostPopularSectionTitle,
                ),
                SizedBox(height: 10),
                searchEventController.isLoading
                    ? const Center(child: CustomShimmer())
                    : searchEventController.popularEvents == null ||
                            searchEventController.popularEvents.isEmpty
                        ? Center(
                            child: Text(AppLocalizations.of(context)!
                                .na_noPopularEvents))
                        : SizedBox(
                            height: size.height * 0.3,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  searchEventController.popularEvents.length,
                              itemBuilder: (context, index) {
                                final event =
                                    searchEventController.popularEvents[index];
                                return EventCardContainer(
                                  imageUrl: event.imageUrl,
                                  eventName: event.eventName,
                                  address: event.address,
                                  onTap: () async {
                                    navigationProvider.setCurrentIndex(0);
                                    eventcontroller
                                        .selectEvent(event.eventName);
                                    navigationProvider.updateEventBool(true);
                                    final result = await context.pushNamed(
                                      AppRoute.specificEventDetailPage,
                                      extra: event.id,
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                SizedBox(height: 20),
                SectionHeader(
                  title: AppLocalizations.of(context)!.na_mostRecentEvents,
                ),
                SizedBox(height: 10),
                searchEventController.isLoading
                    ? const Center(child: CustomShimmer())
                    : searchEventController.recentEvents == null ||
                            searchEventController.recentEvents.isEmpty
                        ? Center(
                            child: Text(AppLocalizations.of(context)!
                                .na_noRecentEvents))
                        : SizedBox(
                            height: size.height * 0.3,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  searchEventController.recentEvents.length,
                              itemBuilder: (context, index) {
                                final event =
                                    searchEventController.recentEvents[index];
                                return EventCardContainer(
                                  imageUrl: event.image,
                                  eventName: event.eventName,
                                  address: event.address,
                                  onTap: () async {
                                    eventcontroller
                                        .selectEvent(event.eventName);
                                    navigationProvider.setCurrentIndex(0);

                                    navigationProvider.updateEventBool(true);
                                    final result = await context.pushNamed(
                                      AppRoute.specificEventDetailPage,
                                      extra: event.id,
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                SizedBox(height: 20),
                SectionHeader(
                  title: AppLocalizations.of(context)!.lastOrdersSectionTitle,
                ),
                SizedBox(height: 10),
                searchEventController.isLatestOrderloading
                    ? const Center(child: CustomShimmer())
                    : searchEventController.latestOrder == null ||
                            searchEventController
                                .latestOrder!.orderItems.isEmpty
                        ? Center(
                            child: Text(AppLocalizations.of(context)!
                                .na_noLatestOrdersAvailable))
                        : SizedBox(
                            height: size.height * 0.27,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: searchEventController
                                  .latestOrder!.orderItems.length,
                              itemBuilder: (context, index) {
                                final latestOrderItem = searchEventController
                                    .latestOrder!.orderItems[index];
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Card(
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Container(
                                      width: 170,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            ),
                                            child: Image.network(
                                              '${ApiEndpoints.baseImageUrl}${latestOrderItem.foodItem!.image!}',
                                              height: 137,
                                              width: 177,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  latestOrderItem
                                                      .foodItem!.name!,
                                                  style: textTheme(context)
                                                      .bodyLarge
                                                      ?.copyWith(
                                                        color: colorScheme(
                                                                context)
                                                            .onSurface
                                                            .withOpacity(0.9),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                SizedBox(height: 4),
                                                Text(
                                                  latestOrderItem
                                                      .foodItem!.price
                                                      .toString(),
                                                  style: textTheme(context)
                                                      .labelSmall
                                                      ?.copyWith(
                                                        fontSize: 10,
                                                        color: colorScheme(
                                                                context)
                                                            .onSurface
                                                            .withOpacity(0.4),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Align(
                                          //   alignment: Alignment.bottomRight,
                                          //   child: Padding(
                                          //     padding: const EdgeInsets.only(
                                          //         right: 8.0, bottom: 8.0),
                                          //     child: CircleAvatar(
                                          //       radius: 12,
                                          //       backgroundColor:
                                          //           Theme.of(context)
                                          //               .colorScheme
                                          //               .primary,
                                          //       child: Icon(
                                          //         Icons.arrow_forward,
                                          //         color: Colors.white,
                                          //         size: 14,
                                          //       ),
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final searchEventController = Provider.of<SearchEventController>(context);
    final navProvider = Provider.of<NavigationProvider>(context);

    return Card(
      elevation: 2,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: colorScheme(context).surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              AppIcons.searchBLackIcon,
              height: 15,
              width: 15,
              color: colorScheme(context).onSurface,
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                onTap: () {
                  navProvider.updateEventBool(true);
                  navProvider.setCurrentIndex(0);
                  context.pushNamed(AppRoute.searchPage);
                },
                readOnly: true,
                controller: searchController,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.searchBarHint,
                  hintStyle: textTheme(context).titleSmall?.copyWith(
                        color: colorScheme(context).onSurface.withOpacity(0.3),
                        fontWeight: FontWeight.w700,
                      ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
