import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/utils/price_format.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_container.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_shimer.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_food_catagory/controller/add_food_catagory_controller.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_food_item/controller/food_item_controller.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/provider/responsible_bottom_bar.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/widget/responsible_bottom-bar_widget.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/pages/responsible_home_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/pages/responsible_stock.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_profile/pages/responsible_profile_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_search_page/controller/responsible_search_controller.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/provider/bottom_nav_bar_provider.dart';
import 'package:flutter_application_copcup/src/features/user/chat/pages/inbox_page.dart';
import 'package:flutter_application_copcup/src/models/food_item_model.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart'; 
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../common/constants/app_colors.dart';

class ResponsibleSearchScreens extends StatefulWidget {
  const ResponsibleSearchScreens({super.key});

  @override
  State<ResponsibleSearchScreens> createState() =>
      _ResponsibleSearchScreensState();
}

class _ResponsibleSearchScreensState extends State<ResponsibleSearchScreens> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchRecentSearch();
    });
  }

  void fetchRecentSearch() async {
    if (!mounted) return;
    final provider =
        Provider.of<ResponsibleSearchController>(context, listen: false);
    await provider.fetchRecentSearches();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ResponsibleBottomBarWidget(),
      body: Consumer<ResponsibleHomeProvider>(
        builder: (context, value, child) => page[value.currentIndex],
      ),
    );
  }

  List<Widget> page = [
    ResponsibleHomePage(),
    Consumer<ResponsibleHomeProvider>(
        builder: (context, value, child) => value.ressearchPage
            ? ResponsibleSearchScreenWidget()
            : ResponsibleStock()),
    InboxPage(),
    ResponsibleProfilePage()
  ];
}

class ResponsibleSearchScreenWidget extends StatefulWidget {
  const ResponsibleSearchScreenWidget({super.key});

  @override
  State<ResponsibleSearchScreenWidget> createState() =>
      _ResponsibleSearchScreenWidgetState();
}

class _ResponsibleSearchScreenWidgetState
    extends State<ResponsibleSearchScreenWidget> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final searchFoodController =
        Provider.of<ResponsibleSearchController>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      context.pop();
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
                ),
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
                            searchFoodController.fetchRecentSearches();
                          } else {
                            searchFoodController.searchResponsibleFoodItem(
                                query: query);
                          }
                        },
                        onSubmitted: (query) {
                          searchFoodController.searchResponsibleFoodItem(
                              query: query);
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
            searchFoodController.isEventLoading
                ? const Center(child: CircularProgressIndicator())
                : searchController.text.isEmpty
                    ? _buildRecentSearches(searchFoodController)
                    : _buildEventCards(searchFoodController),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentSearches(
      ResponsibleSearchController searchEventController) {
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
            GestureDetector(
              onTap: () async {
                await searchEventController.deleteAllChat(context: context);
              },
              child: Text(
                'Clear all',
                style: textTheme(context)
                    .bodyMedium
                    ?.copyWith(color: colorScheme(context).secondary),
              ),
            )
          ],
        ),
        SizedBox(height: 10),
        Consumer<ResponsibleSearchController>(
          builder: (context, value, child) => ListView.builder(
            shrinkWrap: true,
            // physics: NeverScrollableScrollPhysics(),
            itemCount: searchEventController.recentSearches.length,
            itemBuilder: (context, index) {
              log('-------history search length is ${searchEventController.recentSearches.length}');
              final search = searchEventController.recentSearches[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        search.foodItemName,
                        style: textTheme(context).titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colorScheme(context)
                                .onSurface
                                .withOpacity(0.6)),
                      ),
                      GestureDetector(
                        onTap: () async {
                          log('---------------search id is  thsi ${search.searchLogId}');
                          await searchEventController
                              .deleteRecentSearches(
                            id: search.searchLogId.toString(),
                            context: context,
                          )
                              .then((val) {
                            searchEventController.recentSearches
                                .removeAt(index);
                          });
                        },
                        child: Icon(
                          Icons.close,
                          color:
                              colorScheme(context).onSurface.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  Widget _buildEventCards(ResponsibleSearchController searchEventController) {
    final navProvider = Provider.of<NavigationProvider>(context, listen: false);
    final navigationProvider = Provider.of<ResponsibleHomeProvider>(context);

    final size = MediaQuery.of(context).size;
    return searchEventController.isEventLoading
        ? const Center(child: CustomShimmer())
        : searchEventController.searchFoodItem.isEmpty
            ? Center(
                child: Text(AppLocalizations.of(context)!.na_noEventAvailable))
            : Consumer<FoodItemController>(
                builder: (context, foodItemController, child) {
                final foodCategoryProvider =
                    Provider.of<FoodCatagoryController>(context, listen: false);
                if (searchEventController.isEventLoading) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      color: Colors.grey[300],
                    ),
                  );
                }

                return GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: searchEventController.searchFoodItem.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 165,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      final foodItem =
                          searchEventController.searchFoodItem[index];

                      return InkWell(
                        onTap: () {
                          showStockDialog(context, foodItem);
                        },
                        child: Stack(
                          children: [
                            CustomContainer(
                              // onTap: () {

                              // },
                              height: 255,
                              color: colorScheme(context).surface,
                              boxShadow: [
                                BoxShadow(
                                    color: colorScheme(context)
                                        .onSurface
                                        .withOpacity(.25),
                                    offset: Offset(0, 1),
                                    blurRadius: 2)
                              ],
                              width: 235,
                              borderColor:
                                  AppColor.appGreyColor.withOpacity(.02),
                              borderRadius: 24,
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(24)),
                                    child: CachedNetworkImage(
                                      imageUrl: '${foodItem.image}',
                                      width: double.infinity,
                                      height: 100,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          Shimmer.fromColors(
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[100]!,
                                        child: Container(
                                          color: Colors.grey[300],
                                          width: double.infinity,
                                          height: 100,
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                  CustomContainer(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "${foodItem.name}",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: textTheme(context)
                                                    .bodyMedium
                                                    ?.copyWith(
                                                        color:
                                                            colorScheme(context)
                                                                .onSurface,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 12),
                                              ),
                                            ),
                                            Text(
                                              priceFormated(
                                                    foodItem.price!,
                                                  ) +
                                                  '  €',
                                              style: textTheme(context)
                                                  .bodyMedium
                                                  ?.copyWith(
                                                    color: colorScheme(context)
                                                        .primary,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              navigationProvider
                                                  .updateResponsibleBool(true);
                                              foodItemController
                                                  .selectItem(foodItem.name!);

                                              final result =
                                                  await context.pushNamed(
                                                AppRoute.foodItemDetailPage,
                                                extra: foodItem,
                                              );
                                              print(result);
                                              if (result == true) {
                                                await foodItemController
                                                    .getFoodItemList(
                                                        foodItem.eventId!);
                                              }
                                            },
                                            child: Container(
                                              height: 20,
                                              width: 20,
                                              child: Center(
                                                  child: SvgPicture.asset(
                                                AppIcons.editIcon,
                                                height: 10,
                                              )),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppColor.kellyGreen),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Consumer<FoodItemController>(
                                              builder: (context, provider,
                                                      child) =>
                                                  GestureDetector(
                                                    onTap: () {
                                                      provider.deleteFoodItem(
                                                        context: context,
                                                        id: foodItem.id!
                                                            .toString(),
                                                      );
                                                    },
                                                    child: Container(
                                                      height: 20,
                                                      width: 20,
                                                      child: Center(
                                                          child:
                                                              SvgPicture.asset(
                                                        AppIcons.deleteIcon1,
                                                        height: 10,
                                                      )),
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: AppColor
                                                              .redColor),
                                                    ),
                                                  )),
                                        ]),
                                  )
                                ],
                              ),
                            ),
                            !foodItem.isInStock
                                ? Container(
                                    color: colorScheme(context)
                                        .surface
                                        .withOpacity(.6),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: CustomContainer(
                                            color:
                                                colorScheme(context).secondary,
                                            borderRadius: 30,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 1),
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .na_outOfStock,
                                              style: textTheme(context)
                                                  .bodySmall
                                                  ?.copyWith(
                                                    fontSize: 7,
                                                    color: colorScheme(context)
                                                        .surface,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                            )),
                                      ),
                                    ),
                                  )
                                : SizedBox()
                          ],
                        ),
                      );
                    });
              });
  }

  void showStockDialog(BuildContext context, FoodItemModel fooditem) {
    final FoodItemController foodItemController = FoodItemController();
    final ResponsibleSearchController responsibleSearchController =
        ResponsibleSearchController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        final size = MediaQuery.of(context).size;
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              height: 450,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(
                    fooditem.image!,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 20),
                  Text(
                    fooditem.name!,
                    style: textTheme(context)
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w600, fontSize: 24),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      AppLocalizations.of(context)!.successMessagePart1,
                      textAlign: TextAlign.center,
                      style: textTheme(context).bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: size.width * 0.6,
                    height: size.height * 0.08,
                    child: ElevatedButton(
                      onPressed: () async {
                        foodItemController
                            .outStockFoodItem(
                                context: context, id: fooditem.id.toString())
                            .then((onValue) {
                          setState(() {
                            searchController.text = searchController.text + 'j';
                          });
                          // searchFoodController.searchResponsibleFoodItem(
                          //   query: query);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(AppLocalizations.of(context)!
                                  .na_productOutOfStock),
                              backgroundColor: colorScheme(context).secondary,
                            ),
                          );
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme(context).surface,
                        shape: RoundedRectangleBorder(
                          side:
                              BorderSide(color: colorScheme(context).secondary),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 20),
                          Text(AppLocalizations.of(context)!.na_outOfStock,
                              style: textTheme(context).bodySmall?.copyWith(
                                  color: colorScheme(context).secondary,
                                  fontWeight: FontWeight.w600)),
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: colorScheme(context).secondary,
                            child: Icon(
                              Icons.arrow_forward,
                              color: colorScheme(context).surface,
                              size: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: size.width * 0.6,
                    height: size.height * 0.08,
                    child: ElevatedButton(
                      onPressed: () {
                        foodItemController.inStockFoodItem(
                            context: context, id: fooditem.id.toString());
                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //   content:
                        //       Text("Request for stock submitted succesfully"),
                        //   backgroundColor: colorScheme(context).secondary,
                        // ));
                        // context.pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme(context).secondary,
                        shape: RoundedRectangleBorder(
                          side:
                              BorderSide(color: colorScheme(context).secondary),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 20),
                          Text(
                              AppLocalizations.of(context)!.na_bringBackToStock,
                              style: textTheme(context).bodySmall?.copyWith(
                                  color: colorScheme(context).surface,
                                  fontWeight: FontWeight.w600)),
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: colorScheme(context).surface,
                            child: Icon(
                              Icons.arrow_forward,
                              color: colorScheme(context).primary,
                              size: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
