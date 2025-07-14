import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_shimer.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_event/controller/event_controller.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_event_catagory/controller/event_category_controller.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/provider/bottom_nav_bar_provider.dart';
import 'package:flutter_application_copcup/src/features/user/home/controller/location_controller.dart';
import 'package:flutter_application_copcup/src/features/user/home/provider/catagory_provider.dart';
import 'package:flutter_application_copcup/src/features/user/home/widgets/custom_drawer.dart';
import 'package:flutter_application_copcup/src/features/user/home/widgets/event_card.dart';
import 'package:flutter_application_copcup/src/features/user/profile/provider/user_data_provider.dart';
import 'package:flutter_application_copcup/src/features/user/search_events/controller/search_event_controller.dart';
import 'package:flutter_application_copcup/src/features/user/user_map_screen/map_repository.dart';
import 'package:flutter_application_copcup/src/features/user/user_map_screen/user_map_screen.dart';

import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCurrentLocation();
      getEventsCategory();
      getEvents();
      log('-------static data of user id is---${StaticData.userId}');
      log('-------static data of user email is---${StaticData.email}');
      log('-------static data of user token is---${StaticData.accessToken}');

      // getEvents();
    });
  }

  getEventsCategory() async {
    final provider =
        Provider.of<EventCategoryController>(context, listen: false);
    await provider.getUserCategoryList();
  }

  getCurrentLocation() async {
    final locProvider = Provider.of<CategoryProvider>(context, listen: false);
    final provider = Provider.of<EventController>(context, listen: false);

    await locProvider.fetchAndSendLocation().then((v) {
      provider.getUserNearEventList();
    });
  }

  getEvents() async {
    final provider = Provider.of<EventController>(context, listen: false);
    final locProvider = Provider.of<CategoryProvider>(context, listen: false);

    log('---------location value print --------${locProvider}');
    if (locProvider.selectedAddress == null ||
        locProvider.selectedAddress!.isEmpty) {
      await provider.getUserEventList();
    } else {
      await provider.getUserNearEventList();
    }

    print(provider.eventList);
  }

  final SearchEventController searchEventController = SearchEventController();
  final CategoryProvider catagoryProvider = CategoryProvider();
  final LocationController locationController = LocationController();
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final locProvider = Provider.of<CategoryProvider>(context, listen: false);

    final provider = Provider.of<NavigationProvider>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme(context).primary,
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: SvgPicture.asset(
                AppIcons.menuIcon,
                height: 15,
                width: 15,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                provider.updateEventBool(true);
                provider.setCurrentIndex(4);
                context.pushNamed(AppRoute.userProfilePage);
              },
              child: Consumer<UserDataProvider>(
                  builder: (context, provider, child) {
                log(provider.user.toString());
                log('${StaticData.userId}');

                final user = provider.user;
                log(user.toString());
                log(user?.image.toString() ?? '');
                if (user == null) {
                  return Center(child: CircularProgressIndicator());
                }
                return CachedNetworkImage(
                  imageUrl: user.image ?? StaticData.defultImage,
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    backgroundImage: imageProvider,
                  ),
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: CircleAvatar(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                );

                // CircleAvatar(
                //   backgroundImage: NetworkImage(user.image ??
                //       'https://media.istockphoto.com/id/1396644902/photo/businesswoman-posing-and-smiling-during-a-meeting-in-an-office.jpg?s=612x612&w=0&k=20&c=7wzUE1CRFOccGnps-XZWOJIyDvqA3xGbL2c49PU5_m8='),
                // );
              }),
            ),
          )
        ],
      ),
      drawer: CustomDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          await getEventsCategory();
          await getEvents();
        },
        child: SingleChildScrollView(
          child: Consumer2<EventController, EventCategoryController>(
              builder: (context, eventProvider, categoryProvider, child) {
            return Column(
              children: [
                Container(
                  height: size.height * 0.15,
                  decoration: BoxDecoration(
                    color: colorScheme(context).primary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  child: Column(
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            onTap: () {
                              provider.updateEventBool(true);
                              context.pushNamed(AppRoute.searchPage);
                            },
                            readOnly: true,
                            controller: searchController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SvgPicture.asset(
                                  AppIcons.searchGreyIcon,
                                  height: 10,
                                  width: 10,
                                  color: colorScheme(context)
                                      .onSurface
                                      .withOpacity(0.3),
                                ),
                              ),
                              hintText:
                                  AppLocalizations.of(context)!.searchTitleHome,
                              hintStyle:
                                  textTheme(context).labelSmall?.copyWith(
                                        fontSize: 10,
                                        color: colorScheme(context)
                                            .onSurface
                                            .withOpacity(0.3),
                                        fontWeight: FontWeight.w400,
                                      ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8, bottom: 10, right: 10),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MapScreen(),
                                  ));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                SizedBox(width: 5),
                                Flexible(
                                  child: Consumer<CategoryProvider>(
                                    builder: (context, loc, child) => Text(
                                      loc.selectedAddress ??
                                          locationController.location,
                                      style: textTheme(context)
                                          .labelSmall
                                          ?.copyWith(
                                            fontSize: 10,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppLocalizations.of(context)!.eventsCategoriesTitle,
                          style: textTheme(context).titleMedium?.copyWith(
                              color: colorScheme(context)
                                  .onSurface
                                  .withOpacity(0.9),
                              fontWeight: FontWeight.w600)),
                      SizedBox(
                        width: 10,
                      ),
                      TextButton(
                        onPressed: () {
                          provider.updateEventBool(true);
                          context.pushNamed(AppRoute.allCatagoriesPage);
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
                      )
                    ],
                  ),
                ),
                categoryProvider.isEventCategoryLoading
                    ? const Center(child: CustomShimmer())
                    : categoryProvider.eventCategoryList == null ||
                            categoryProvider.eventCategoryList.isEmpty
                        ? Center(
                            child: Text(AppLocalizations.of(context)!
                                .na_noCategoryFound))
                        : Container(
                            height: 120,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              itemCount:
                                  // categoryProvider.eventCategoryList.length

                                  categoryProvider.eventCategoryList.length > 3
                                      ? 4
                                      : categoryProvider
                                          .eventCategoryList.length,
                              itemBuilder: (context, index) {
                                print(categoryProvider.eventCategoryList);

                                final category =
                                    categoryProvider.eventCategoryList[index];
                                final isSelected =
                                    categoryProvider.selectedCategory ==
                                        category.categoryName;

                                return index > 2
                                    ? GestureDetector(
                                        onTap: () {
                                          provider.updateEventBool(true);
                                          context.pushNamed(
                                              AppRoute.allCatagoriesPage);
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 65,
                                              width: 65,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: AppColor
                                                          .appGreyColor
                                                          .withOpacity(.1))),
                                              child: Icon(
                                                Icons.more_horiz_outlined,
                                                color: AppColor.appGreyColor
                                                    .withOpacity(.7),
                                                size: 35,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text('more')
                                          ],
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          categoryProvider.selectCategory(
                                              category.categoryName!,
                                              category.id!);
                                          eventProvider
                                              .filterEventList(category.id!);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 65,
                                                width: 65,
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .surface,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: isSelected
                                                        ? colorScheme(context)
                                                            .primary
                                                        : Colors.transparent,
                                                    width: 2.5,
                                                  ),
                                                ),
                                                child: ClipOval(
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        "${category.image}",
                                                    height: double.infinity,
                                                    width: double.infinity,
                                                    fit: BoxFit.cover,
                                                    placeholder:
                                                        (context, url) =>
                                                            Shimmer.fromColors(
                                                      baseColor:
                                                          Colors.grey[300]!,
                                                      highlightColor:
                                                          Colors.grey[100]!,
                                                      child: Container(
                                                        height: double.infinity,
                                                        width: double.infinity,
                                                        color: Colors.grey[300],
                                                      ),
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              SizedBox(
                                                width: 100,
                                                child: Center(
                                                  child: Text(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    category.categoryName!,
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight: isSelected
                                                          ? FontWeight.bold
                                                          : FontWeight.normal,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                              },
                            ),
                          ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppLocalizations.of(context)!.nearestEvents,
                          style: textTheme(context).titleMedium?.copyWith(
                              fontSize: 17,
                              color: colorScheme(context)
                                  .onSurface
                                  .withOpacity(0.9),
                              fontWeight: FontWeight.w600)),
                      TextButton(
                        onPressed: () {
                          provider.updateEventBool(true);
                          context.pushNamed(AppRoute.allEventsPages, extra: {
                            "title":
                                "${AppLocalizations.of(context)!.nearestEvents}",
                            "events": eventProvider.eventList
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
                ),
                eventProvider.isEventLoading
                    ? const Center(child: CustomShimmer())
                    : eventProvider.eventList == null ||
                            eventProvider.eventList.isEmpty
                        ? SizedBox(
                            height: 300,
                            child: Center(
                              child: Text(AppLocalizations.of(context)!
                                  .noEventsFoundMessage),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            itemCount: categoryProvider.selectedCategory == null
                                ? eventProvider.eventList.length
                                : eventProvider.eventListFiltered.length,
                            itemBuilder: (context, index) {
                              // print("event data is ${eventList[index]}");
                              final events =
                                  categoryProvider.selectedCategory == null
                                      ? eventProvider.eventList[index]
                                      : eventProvider.eventListFiltered[index];
                              print(
                                  'here is the name....:${events.eventCategoryId}');
                              return EventCard(event: events);
                            },
                          ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
