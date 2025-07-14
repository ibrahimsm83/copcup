import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_shimer.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_event/controller/event_controller.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/provider/bottom_nav_bar_provider.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/widget/bottom_bar_widget.dart';
import 'package:flutter_application_copcup/src/features/user/search/widgets/event_card.dart';
import 'package:flutter_application_copcup/src/features/user/search_events/controller/search_event_controller.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class SearchScreenWidget extends StatefulWidget {
  const SearchScreenWidget({super.key});

  @override
  State<SearchScreenWidget> createState() => _SearchScreenWidgetState();
}

class _SearchScreenWidgetState extends State<SearchScreenWidget> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final searchEventController = Provider.of<SearchEventController>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Search bar

            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      context.goNamed(AppRoute.userBottomNavBar);
                    },
                    child: Icon(Icons.arrow_back)),
                Text(
                  '${AppLocalizations.of(context)!.searchHere}',
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
              height: 10,
            ),
            Card(
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
                        onChanged: (query) {
                          // Show recent searches while typing
                          if (query.isEmpty) {
                            searchEventController.fetchRecentSearches();
                          } else {
                            searchEventController.searchEvents(
                                eventName: query);
                          }
                        },
                        onSubmitted: (query) {
                          // Perform search when submit is pressed
                          searchEventController.searchEvents(eventName: query);
                        },
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.searchBarHint,
                          hintStyle: textTheme(context).titleSmall?.copyWith(
                              color: colorScheme(context)
                                  .onSurface
                                  .withOpacity(0.3),
                              fontWeight: FontWeight.w700),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Recent searches or event cards
            searchEventController.isLoading
                ? const Center(child: CircularProgressIndicator())
                : searchController.text.isEmpty
                    ? _buildRecentSearches(searchEventController)
                    : _buildEventCards(searchEventController),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentSearches(SearchEventController searchEventController) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.of(context)!.recentsSearch,
              style: textTheme(context).titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme(context).onSurface),
            ),
            TextButton(
              onPressed: () {
                searchEventController.fetchAllRecentSearches();
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
                  const SizedBox(width: 10),
                  const Icon(Icons.arrow_forward_ios, size: 15),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: searchEventController.recentSearches.length,
          itemBuilder: (context, index) {
            final search = searchEventController.recentSearches[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: GestureDetector(
                onTap: () {
                  searchController.text = search.eventName;
                  searchEventController.searchEvents(
                      eventName: search.eventName);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      search.eventName,
                      style: textTheme(context).titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color:
                              colorScheme(context).onSurface.withOpacity(0.6)),
                    ),
                    GestureDetector(
                      onTap: () async {
                        searchEventController.recentSearches.removeAt(index);
                        // searchEventController.
                        await searchEventController.deleteRecentSearches(
                          id: search.searchLogId.toString(),
                          context: context,
                        );
                      },
                      child: Icon(
                        Icons.close,
                        color: colorScheme(context).onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        )
      ],
    );
  }

  Widget _buildEventCards(SearchEventController searchEventController) {
    final eventController = Provider.of<EventController>(context);
    final navProvider = Provider.of<NavigationProvider>(context, listen: false);

    final size = MediaQuery.of(context).size;
    return searchEventController.isEventLoading
        ? const Center(child: CustomShimmer())
        : searchEventController.eventList.isEmpty
            ? const Center(child: Text("No Event Available"))
            : SizedBox(
                height: 240,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: searchEventController.eventList.length,
                  itemBuilder: (context, index) {
                    final event = searchEventController.eventList[index];
                    return EventCardContainer(
                      imageUrl: event.image,
                      eventName: event.eventName,
                      address: event.address,
                      onTap: () async {
                        navProvider.updateEventBool(true);
                        eventController.selectEvent(event.eventName);
                        final result = await context.pushNamed(
                          AppRoute.specificEventDetailPage,
                          extra: event.id,
                        );
                      },
                    );
                  },
                ),
              );
  }
}
