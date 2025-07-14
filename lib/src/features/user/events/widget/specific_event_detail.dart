// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/utils/price_format.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_container.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_event/controller/event_controller.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_food_catagory/controller/add_food_catagory_controller.dart';

import 'package:flutter_application_copcup/src/features/responsible/add_food_item/controller/food_item_controller.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/provider/bottom_nav_bar_provider.dart';

import 'package:flutter_application_copcup/src/features/user/calender/widgets/food_item_card.dart';
import 'package:flutter_application_copcup/src/features/user/cart/controller/cart_controller.dart';

import 'package:flutter_application_copcup/src/models/food_item_model.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
class SpecificEventDetailWidget extends StatefulWidget {
  const SpecificEventDetailWidget({super.key});

  @override
  State<SpecificEventDetailWidget> createState() =>
      _SpecificEventDetailWidgetState();
}

class _SpecificEventDetailWidgetState extends State<SpecificEventDetailWidget> {
  bool isAddressExpanded = false;
  int selectedCategoryIndex = -1;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventController>(context, listen: false);
    log('Length ------------${provider.eventDetails}');
    final size = MediaQuery.of(context).size;

    final cartController = Provider.of<CartController>(context, listen: false);
    final navigationProvider =
        Provider.of<NavigationProvider>(context, listen: false);

    return Consumer2<EventController, FoodItemController>(
        builder: (context, provider, fooditemCtrl, child) {
      if (provider.isEventDetailLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (provider.eventDetails == null) {
        return Center(child: Text('No Events Details'));
      }

      final event = provider.eventDetails!.event;

      final foodList = provider.eventDetails!.foodCategories;
      log('--------event response ${event.toJson()}');
      log('--------food list response ${foodList}');

      return Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: event.image,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                            log('---------');
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          )),
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          SizedBox(
                            height: 45,
                            width: 55,
                            child: GestureDetector(
                              onTap: () {
                                navigationProvider.updateEventBool(true);
                                context.pushNamed(AppRoute.myCartPage);
                              },
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: AppColor.basketColor,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset(
                                        AppIcons.basketIcon,
                                      ),
                                    )),
                              ),
                            ),
                          ),
                          Consumer<CartController>(
                            builder: (context, value, child) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Container(
                                height: 16,

                                width: 16,

                                // padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: colorScheme(context).error,
                                    shape: BoxShape.circle),
                                child: Center(
                                  child: Text(
                                    '${value.cartItemList.length}',
                                    style: textTheme(context)
                                        .bodySmall
                                        ?.copyWith(
                                            color: colorScheme(context).surface,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: size.height - 300,
                    width: size.width,
                    decoration: BoxDecoration(),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                event.eventName,
                                style: textTheme(context)
                                    .headlineLarge
                                    ?.copyWith(
                                        color: colorScheme(context).onSurface,
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Icon(Icons.location_on, size: 16),
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      '${event.description}',
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      maxLines: isAddressExpanded ? null : 2,
                                      style: textTheme(context)
                                          .titleMedium
                                          ?.copyWith(
                                            color: colorScheme(context)
                                                .onSurface
                                                .withOpacity(0.5),
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isAddressExpanded = !isAddressExpanded;
                                      });
                                    },
                                    child: Text(
                                      isAddressExpanded
                                          ? AppLocalizations.of(context)!
                                              .na_seeMore
                                          : AppLocalizations.of(context)!
                                              .na_seeLess,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),

                              Text(
                                AppLocalizations.of(context)!
                                    .na_eventDescription,
                                style: textTheme(context)
                                    .headlineLarge
                                    ?.copyWith(
                                        color: colorScheme(context).onSurface,
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8),
                              Text(
                                event.description,
                                style: textTheme(context).titleSmall?.copyWith(
                                    color: colorScheme(context)
                                        .onSurface
                                        .withOpacity(0.5),
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(height: 20),
                              Text(
                                AppLocalizations.of(context)!.foodLists,
                                style: textTheme(context)
                                    .headlineLarge
                                    ?.copyWith(
                                        color: colorScheme(context).onSurface,
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              SizedBox(
                                height: 100,
                                width: double.infinity,
                                child: Consumer<FoodCatagoryController>(
                                  builder: (context, provider, child) {
                                    int length =
                                        provider.foodCategoryList.length;
                                    if (provider.isFoodCategoryLoading) {
                                      return Shimmer.fromColors(
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[100]!,
                                        child: Container(
                                          color: Colors.grey[300],
                                        ),
                                      );
                                    }

                                    if (provider.foodCategoryList.isEmpty) {
                                      return Center(
                                          child: Text("No Category Found"));
                                    }
                                    return ListView.separated(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      // physics: NeverScrollableScrollPhysics(),
                                      itemCount:
                                          provider.foodCategoryList.length > 3
                                              ? 4
                                              : provider
                                                  .foodCategoryList.length,
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                        width: 20,
                                      ),
                                      itemBuilder: (context, index) {
                                        final category =
                                            provider.foodCategoryList[index];
                                        if (provider.foodCategoryList.isEmpty) {
                                          return Center(
                                            child: Text("No Category Found"),
                                          );
                                        }

                                        return index > 2
                                            ? GestureDetector(
                                                onTap: () {
                                                  navigationProvider
                                                      .updateEventBool(true);

                                                  context.pushNamed(
                                                      AppRoute.allFoodListPage);
                                                },
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 65,
                                                      width: 65,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color: AppColor
                                                                  .appGreyColor
                                                                  .withOpacity(
                                                                      .1))),
                                                      child: Icon(
                                                        Icons
                                                            .more_horiz_outlined,
                                                        color: AppColor
                                                            .appGreyColor
                                                            .withOpacity(.7),
                                                        size: 35,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text('more')
                                                  ],
                                                ),
                                              )
                                            : Consumer<FoodItemController>(
                                                builder:
                                                    (context, foods, child) =>
                                                        GestureDetector(
                                                  onTap: () {
                                                    foods
                                                        .changeColorIndexOfFood(
                                                            index,
                                                            category
                                                                .categoryName!);
                                                    foods
                                                        .changeFoodCategoryIndexFunction(
                                                            category.id);

                                                    foods
                                                        .changeListWithIndexes();
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                          height: 65,
                                                          width: 65,
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              border: Border.all(
                                                                  color: foods
                                                                              .changeindex ==
                                                                          index
                                                                      ? colorScheme(
                                                                              context)
                                                                          .primary
                                                                      : Colors
                                                                          .transparent,
                                                                  width: foods.changeindex ==
                                                                          index
                                                                      ? 1.8
                                                                      : 0.1)),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        200),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl:
                                                                  "${category.image}",
                                                              width: double
                                                                  .infinity,
                                                              fit: BoxFit.fill,
                                                              placeholder: (context,
                                                                      url) =>
                                                                  Shimmer
                                                                      .fromColors(
                                                                baseColor:
                                                                    Colors.grey[
                                                                        300]!,
                                                                highlightColor:
                                                                    Colors.grey[
                                                                        100]!,
                                                                child:
                                                                    Container(
                                                                  color: Colors
                                                                          .grey[
                                                                      300],
                                                                ),
                                                              ),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  Icon(Icons
                                                                      .error),
                                                            ),
                                                          )),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Container(
                                                          width: 90,
                                                          child: Center(
                                                            child: Text(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              category
                                                                  .categoryName!,
                                                              style: textTheme(context).bodyMedium?.copyWith(
                                                                  color: colorScheme(
                                                                          context)
                                                                      .onSurface,
                                                                  fontWeight: foods
                                                                              .changeindex ==
                                                                          index
                                                                      ? FontWeight
                                                                          .w700
                                                                      : FontWeight
                                                                          .w400),
                                                            ),
                                                          ))
                                                    ],
                                                  ),
                                                ),
                                              );
                                        // Container(
                                        //   height: 100,
                                        //   width: 100,
                                        //   decoration: BoxDecoration(
                                        //       shape: BoxShape.circle),
                                        //   child: Column(
                                        //     crossAxisAlignment:
                                        //         CrossAxisAlignment.center,
                                        //     children: [
                                        //       Expanded(
                                        //         child: CustomContainer(
                                        //           onTap: () {
                                        //             log('--------');
                                        //             filteredFoods = fooditemCtrl
                                        //                 .foodItemList
                                        //                 .where((food) =>
                                        //                     food.foodCategoryId ==
                                        //                     category.id)
                                        //                 .toList();
                                        //             selectedCategoryname =
                                        //                 category.categoryName!;
                                        //             selectedCategoryIndex =
                                        //                 index;

                                        //             setState(() {});
                                        //           },
                                        //           borderRadius: 500,
                                        //           borderWidth: 2,
                                        //           borderColor:
                                        //               selectedCategoryIndex ==
                                        //                       index
                                        //                   ? colorScheme(context)
                                        //                       .primary
                                        //                   : null,
                                        //           color: AppColor.categoryColor,
                                        //           child: ClipRRect(
                                        //             borderRadius:
                                        //                 BorderRadius.all(
                                        //               Radius.circular(5),
                                        //             ),
                                        //             child: CachedNetworkImage(
                                        //               imageUrl:
                                        //                   "${category.image}",
                                        //               width: double.infinity,
                                        //               fit: BoxFit.fill,
                                        //               placeholder: (context,
                                        //                       url) =>
                                        //                   Shimmer.fromColors(
                                        //                 baseColor:
                                        //                     Colors.grey[300]!,
                                        //                 highlightColor:
                                        //                     Colors.grey[100]!,
                                        //                 child: Container(
                                        //                   color:
                                        //                       Colors.grey[300],
                                        //                 ),
                                        //               ),
                                        //               errorWidget: (context,
                                        //                       url, error) =>
                                        //                   Icon(Icons.error),
                                        //             ),
                                        //           ),
                                        //         ),
                                        //       ),
                                        //       Text(
                                        //         category.categoryName!,
                                        //         textAlign: TextAlign.center,
                                        //         maxLines: 1,
                                        //         overflow: TextOverflow.ellipsis,
                                        //         style: textTheme(context)
                                        //             .labelLarge
                                        //             ?.copyWith(
                                        //                 letterSpacing: 0.2,
                                        //                 fontSize: 12,
                                        //                 color:
                                        //                     colorScheme(context)
                                        //                         .onSurface),
                                        //       )
                                        //     ],
                                        //   ),
                                        // );
                                      },
                                    );
                                  },
                                ),
                              ),

                              SizedBox(height: 10),

                              Consumer<FoodItemController>(
                                builder: (context, value, child) => Text(
                                  value.selectedFoodName,
                                  style: textTheme(context)
                                      .headlineLarge
                                      ?.copyWith(
                                        color: colorScheme(context).onSurface,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // Consumer<FoodItemController>(
                              //   builder: (context, provider, child) =>
                              //       GridView.builder(
                              //     shrinkWrap: true,
                              //     physics: NeverScrollableScrollPhysics(),
                              //     gridDelegate:
                              //         SliverGridDelegateWithFixedCrossAxisCount(
                              //             crossAxisCount: 2,
                              //             childAspectRatio: 0.76),
                              //     itemCount: provider.filteredFoods.length,
                              //     itemBuilder: (context, index) {
                              //       final food = provider.filteredFoods[index];
                              //       Duration difference = food.endTime!
                              //           .difference(food.startTime!);

                              //       int hours = difference.inHours;
                              //       int minutes = difference.inMinutes % 60;

                              //       String formattedDifference =
                              //           "$hours hour${hours != 1 ? 's' : ''} $minutes minute${minutes != 1 ? 's' : ''}";
                              //       log('-----------------saimsaisaik----------------------${food.createdAt}');

                              //       return FoodItemCard(
                              //         textIncrements: quantity,
                              //         addonTap: () {
                              //           quantity.value += 1;
                              //         },
                              //         removeOnTap: () {
                              //           if (quantity.value > 1) {
                              //             quantity.value -= 1;
                              //           }
                              //         },
                              //         addCardOnTap: () {
                              //           cartController.addToCart(
                              //               context: context,
                              //               productId: food.id!,
                              //               quantity: 1);
                              //         },
                              //         ontap: () {
                              //           FoodItemModel foodItemModel =
                              //               FoodItemModel(
                              //                   isInStock: food.isInStock,
                              //                   name: food.name,
                              //                   image: food.image,
                              //                   foodCategoryId:
                              //                       food.foodCategoryId,
                              //                   eventId: food.eventId,
                              //                   price: food.price,
                              //                   description: food.description,
                              //                   isAlcoholic: food.isAlcoholic,
                              //                   createdAt: food.createdAt,
                              //                   endTime: food.endTime,
                              //                   event: food.event,
                              //                   id: food.id,
                              //                   quantity: food.quantity,
                              //                   startTime: food.startTime,
                              //                   updatedAt: food.updatedAt);
                              //           context.pushNamed(
                              //             AppRoute.productDetailPage,
                              //             extra: {
                              //               'foodModel': foodItemModel,
                              //             },
                              //           );
                              //         },
                              //         title: food.name!,
                              //         imageUrl: food.image!,
                              //         duration: formattedDifference,
                              //         rating: 0,
                              //         price: food.price!,
                              //       );
                              //     },
                              //   ),
                              // ),

                              Consumer<FoodItemController>(
                                builder: (context, provider, child) =>
                                    GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisExtent: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.32),
                                  itemCount: provider.filteredFoods.length,
                                  itemBuilder: (context, index) {
                                    final food = provider.filteredFoods[index];

                                    // Create a separate ValueNotifier for each item
                                    ValueNotifier<int> quantity =
                                        ValueNotifier<int>(1);

                                    // Duration difference = food.endTime!
                                    //     .difference(food.startTime!);
                                    // int hours = difference.inHours;
                                    // int minutes = difference.inMinutes % 60;
                                    // String formattedDifference =
                                    //     "$hours hour${hours != 1 ? 's' : ''} $minutes minute${minutes != 1 ? 's' : ''}";

                                    return ValueListenableBuilder<int>(
                                      valueListenable: quantity,
                                      builder: (context, value, child) => Stack(
                                        children: [
                                          FoodItemCard(
                                            basketWidget: GestureDetector(
                                              onTap: () async {
                                                await cartController.addToCart(
                                                  context: context,
                                                  productId: food.id!,
                                                  quantity: 1,
                                                );

                                                await cartController
                                                    .getAllCarts(
                                                        context: context);
                                              },
                                              child: Container(
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: AppColor.basketColor,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: SvgPicture.asset(
                                                      AppIcons.basketIcon,
                                                    ),
                                                  )),
                                            ),
                                            addCardOnTap: () {},
                                            ontap: () {
                                              FoodItemModel foodItemModel =
                                                  FoodItemModel(
                                                isInStock: food.isInStock,
                                                name: food.name,
                                                image: food.image,
                                                foodCategoryId:
                                                    food.foodCategoryId,
                                                eventId: food.eventId,
                                                price: food.price,
                                                description: food.description,
                                                isAlcoholic: food.isAlcoholic,
                                                createdAt: food.createdAt,
                                                endTime: food.endTime,
                                                event: food.event,
                                                id: food.id,
                                                quantity: food.quantity,
                                                startTime: food.startTime,
                                                updatedAt: food.updatedAt,
                                              );
                                              ValueNotifier<int> totalPrice =
                                                  ValueNotifier<int>(
                                                      food.price?.toInt() ?? 1);

                                              food.isInStock
                                                  ? showDialog(
                                                      context: context,
                                                      builder: (ssdasdas) =>
                                                          Center(
                                                        child: CustomContainer(
                                                          borderRadius: 20,
                                                          color: colorScheme(
                                                                  context)
                                                              .surface,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.6,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.9,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        15.0),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                CustomContainer(
                                                                  height: 120,
                                                                  borderRadius:
                                                                      20,
                                                                  width: double
                                                                      .infinity,
                                                                  color: Colors
                                                                      .amber,
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    child:
                                                                        CachedNetworkImage(
                                                                      imageUrl:
                                                                          food.image!,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      placeholder: (context,
                                                                              url) =>
                                                                          Shimmer
                                                                              .fromColors(
                                                                        baseColor:
                                                                            Colors.grey[300]!,
                                                                        highlightColor:
                                                                            Colors.grey[100]!,
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              120,
                                                                          width:
                                                                              double.infinity,
                                                                          color:
                                                                              Colors.grey[300],
                                                                        ),
                                                                      ),
                                                                      errorWidget: (context,
                                                                              url,
                                                                              error) =>
                                                                          Icon(Icons
                                                                              .error),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Text(
                                                                  food.name!,
                                                                  style: textTheme(
                                                                          context)
                                                                      .headlineSmall
                                                                      ?.copyWith(
                                                                          color: colorScheme(context)
                                                                              .onSurface,
                                                                          fontWeight:
                                                                              FontWeight.w400),
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    '${food.description!}',
                                                                    maxLines: 5,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: textTheme(
                                                                            context)
                                                                        .titleSmall
                                                                        ?.copyWith(
                                                                            color:
                                                                                colorScheme(context).onSurface,
                                                                            fontWeight: FontWeight.w400),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      AppLocalizations.of(
                                                                              context)!
                                                                          .na_sellerHomePricePerItem,
                                                                      style: textTheme(
                                                                              context)
                                                                          .titleSmall
                                                                          ?.copyWith(
                                                                              color: colorScheme(context).onSurface,
                                                                              fontWeight: FontWeight.w400),
                                                                    ),
                                                                    Text(
                                                                      priceFormated(
                                                                              food.price!) +
                                                                          ' €',
                                                                      style: textTheme(
                                                                              context)
                                                                          .bodyMedium
                                                                          ?.copyWith(
                                                                              color: colorScheme(context).onSurface,
                                                                              fontSize: 18),
                                                                    )
                                                                  ],
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          8.0),
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        AppLocalizations.of(context)!
                                                                            .na_itemCount,
                                                                        style: textTheme(context).titleSmall?.copyWith(
                                                                            color:
                                                                                colorScheme(context).onSurface,
                                                                            fontWeight: FontWeight.w400),
                                                                      ),
                                                                      Spacer(),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          if (quantity.value >
                                                                              1) {
                                                                            quantity.value -=
                                                                                1;

                                                                            setState(() {
                                                                              totalPrice.value -= food.price!.toInt();
                                                                            });
                                                                          }
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              26,
                                                                          width:
                                                                              28,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                colorScheme(context).onSurface.withOpacity(0.3),
                                                                            borderRadius:
                                                                                BorderRadius.circular(9),
                                                                          ),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Icon(
                                                                              Icons.remove,
                                                                              color: colorScheme(context).primary,
                                                                              size: 15,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      ValueListenableBuilder<
                                                                          int>(
                                                                        valueListenable:
                                                                            quantity,
                                                                        builder: (context,
                                                                            value,
                                                                            _) {
                                                                          return Text(
                                                                            value.toString().padLeft(1,
                                                                                '0'), // Ensures "03" format
                                                                            style: textTheme(context).bodyLarge?.copyWith(
                                                                                  color: colorScheme(context).onSurface,
                                                                                  fontWeight: FontWeight.w600,
                                                                                ),
                                                                          );
                                                                        },
                                                                      ),
                                                                      SizedBox(
                                                                          width:
                                                                              7),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          quantity.value +=
                                                                              1;
                                                                          setState(
                                                                              () {
                                                                            totalPrice.value +=
                                                                                food.price!.toInt();
                                                                          });
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              26,
                                                                          width:
                                                                              28,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                colorScheme(context).primary,
                                                                            borderRadius:
                                                                                BorderRadius.circular(9),
                                                                          ),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Icon(
                                                                              Icons.add,
                                                                              color: colorScheme(context).surface,
                                                                              size: 15,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    await cartController
                                                                        .addToCart(
                                                                      context:
                                                                          context,
                                                                      productId:
                                                                          food.id!,
                                                                      quantity:
                                                                          quantity
                                                                              .value,
                                                                    )
                                                                        .then(
                                                                            (onValue) {
                                                                      context
                                                                          .pop();
                                                                    });
                                                                    await cartController.getAllCarts(
                                                                        context:
                                                                            context);
                                                                  },
                                                                  child:
                                                                      CustomContainer(
                                                                    height: 50,
                                                                    width: double
                                                                        .infinity,
                                                                    color: colorScheme(
                                                                            context)
                                                                        .primary,
                                                                    borderRadius:
                                                                        100,
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        AppLocalizations.of(context)!
                                                                            .na_addToCart,
                                                                        style: textTheme(context).bodyMedium?.copyWith(
                                                                            color: colorScheme(context)
                                                                                .surface,
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : SizedBox.shrink();
                                            },
                                            title: food.name!,
                                            imageUrl: food.image!,
                                            duration: 'formattedDifference',
                                            rating: 0,
                                            price: priceFormated(food.price!) +
                                                ' €',
                                          ),
                                          food.isInStock
                                              ? SizedBox()
                                              : Container(
                                                  color: colorScheme(context)
                                                      .surface
                                                      .withOpacity(.6),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: CustomContainer(
                                                          color: colorScheme(
                                                                  context)
                                                              .secondary,
                                                          borderRadius: 30,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal: 5,
                                                                  vertical: 1),
                                                          child: Text(
                                                            'Out Of Stock',
                                                            style: textTheme(
                                                                    context)
                                                                .bodySmall
                                                                ?.copyWith(
                                                                  fontSize: 7,
                                                                  color: colorScheme(
                                                                          context)
                                                                      .surface,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),

                              SizedBox(height: 20),

                              Center(
                                child: Text(
                                  AppLocalizations.of(context)!.ageWarning,
                                  style:
                                      textTheme(context).labelSmall?.copyWith(
                                            fontSize: 7,
                                            color: colorScheme(context).error,
                                            fontWeight: FontWeight.w700,
                                          ),
                                ),
                              ),
                              SizedBox(height: 30),
                              CustomButton(
                                  iconColor: colorScheme(context).primary,
                                  arrowCircleColor:
                                      colorScheme(context).surface,
                                  text: AppLocalizations.of(context)!.goToCart,
                                  backgroundColor: colorScheme(context).primary,
                                  onPressed: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    bool? isDialogShown =
                                        prefs.getBool('ageVerificationShown');

                                    if (isDialogShown == null ||
                                        !isDialogShown) {
                                      showGeneralDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        barrierLabel:
                                            MaterialLocalizations.of(context)
                                                .modalBarrierDismissLabel,
                                        barrierColor: Colors.black45,
                                        transitionDuration:
                                            const Duration(milliseconds: 200),
                                        pageBuilder: (BuildContext buildContext,
                                            Animation animation,
                                            Animation secondaryAnimation) {
                                          return Center(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: Colors.white,
                                              ),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.86,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.3,
                                              padding: EdgeInsets.all(20),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Container(
                                                      height: 20,
                                                      width: 20,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .onSurface,
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Icon(
                                                            Icons.close,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .onSurface,
                                                            size: 15,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .ageVerification,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge
                                                          ?.copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .onSurface,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Center(
                                                    child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .ageVerificationMessage,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall
                                                          ?.copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .onSurface,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          prefs.setBool(
                                                              'ageVerificationShown',
                                                              true);
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .surface,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            side: BorderSide(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30.0),
                                                          ),
                                                        ),
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .under18Button,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall
                                                                  ?.copyWith(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .primary,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                        ),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          prefs.setBool(
                                                              'ageVerificationShown',
                                                              true);
                                                          Navigator.of(context)
                                                              .pop(); // Close dialog
                                                          context.pushNamed(
                                                              AppRoute
                                                                  .myCartPage);
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .primary,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            side: BorderSide(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30.0),
                                                          ),
                                                        ),
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .over18Button,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall
                                                                  ?.copyWith(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .surface,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    } else {
                                      navigationProvider.updateEventBool(true);

                                      context.pushNamed(AppRoute.myCartPage);
                                    }
                                  }),
                              SizedBox(height: 20),
                            ]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
