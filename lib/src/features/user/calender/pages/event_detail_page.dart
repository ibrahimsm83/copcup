// // ignore_for_file: unused_element

// import 'package:flutter/material.dart';
// import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
// import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
// import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
// import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
// import 'package:flutter_application_copcup/src/features/responsible/add_food_catagory/controller/add_food_catagory_controller.dart';
// import 'package:flutter_application_copcup/src/features/responsible/add_food_item/controller/food_item_controller.dart';
// import 'package:flutter_application_copcup/src/features/user/calender/widgets/food_catagory.dart';
// import 'package:flutter_application_copcup/src/features/user/calender/widgets/food_item_card.dart';

// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// package:flutter_application_copcup/gen_l10n/app_localizations.dart
// import '../../../../routes/go_router.dart';

// class EventDetailPage extends StatefulWidget {
//   @override
//   State<EventDetailPage> createState() => _EventDetailPageState();
// }

// class _EventDetailPageState extends State<EventDetailPage> {
//   Future<bool> checkAgeVerificationStatus() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getBool('ageVerificationShown') ?? false;
//   }

//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       getFoodCategory();
//       getFoodItems();
//     });
//     super.initState();
//   }

//   getFoodCategory() async {
//     final provider =
//         Provider.of<FoodCatagoryController>(context, listen: false);
//     await provider.getFoodCategoryList();
//     print(provider.foodCategoryList);
//   }

//   //! Food Items
//   getFoodItems() async {
//     final provider = Provider.of<FoodItemController>(context, listen: false);
//     await provider.getFoodItemList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     void navigateBasedOnAgeVerification() async {
//       bool isAgeVerified = await checkAgeVerificationStatus();
//       Future.delayed(
//         const Duration(seconds: 4),
//         () {
//           if (isAgeVerified) {
//             context.pushNamed(AppRoute.myCartPage);
//           } else {
//             context.pushNamed(AppRoute.myCartPage);
//           }
//         },
//       );
//     }

//     return Scaffold(
//       appBar: CustomAppBar(
//         title: AppLocalizations.of(context)!.orderHistory,
//       ),
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 10),
//             Text(
//               AppLocalizations.of(context)!.foodList,
//               style: textTheme(context).headlineLarge?.copyWith(
//                     color: colorScheme(context).onSurface,
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//             ),
//             SizedBox(height: 10),
//             Consumer<FoodCatagoryController>(
//               builder: (context, provider, child) {
//                 if (provider.isFoodCategoryLoading) {
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 } else if (provider.foodCategoryList.isEmpty) {
//                   return Center(child: Text("No category available"));
//                 }

//                 return LayoutBuilder(
//                   builder: (context, constraints) {
//                     double availableWidth = constraints.maxWidth;
//                     double itemWidth = 90;
//                     int itemsThatFit = (availableWidth / itemWidth).floor();

//                     // State to track whether "More" is clicked
//                     final isExpanded =
//                         context.watch<FoodCatagoryController>().isExpanded;
//                     final showMore =
//                         provider.foodCategoryList.length > itemsThatFit;

//                     // Adjust number of visible items based on state
//                     int visibleItems = isExpanded
//                         ? provider.foodCategoryList.length
//                         : showMore
//                             ? itemsThatFit - 0
//                             : itemsThatFit;

//                     return Column(
//                       children: [
//                         Wrap(
//                           spacing: 8.0,
//                           children: [
//                             ...List.generate(
//                               visibleItems.clamp(
//                                   0, provider.foodCategoryList.length),
//                               (index) {
//                                 final category =
//                                     provider.foodCategoryList[index];
//                                 return FoodCategoryIcon(
//                                   ontap: () async {
//                                     // final result = await context.pushNamed(
//                                     //   AppRoute.specificFoodCatagoryFoodItems,
//                                     // );
//                                     // print(result);
//                                     // if (result == true) {
//                                     //   await provider.getFoodCategoryFoodItems(
//                                     //       provider.foodCategoryList.first.id
//                                     //           .toString());
//                                     // }
//                                   },
//                                   label: category.categoryName!,
//                                   imageurl: category.image!,
//                                 );
//                               },
//                             ),
//                             if (showMore && !isExpanded)
//                               GestureDetector(
//                                 onTap: () {
//                                   provider.toggleExpanded();
//                                 },
//                                 child: Column(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     Container(
//                                       height: 75,
//                                       width: 75,
//                                       decoration: BoxDecoration(
//                                         border: Border.all(
//                                           color: colorScheme(context)
//                                               .onSurface
//                                               .withOpacity(0.3),
//                                         ),
//                                         shape: BoxShape.circle,
//                                       ),
//                                       child: ClipRRect(
//                                         borderRadius:
//                                             BorderRadius.circular(100),
//                                         child: Image.asset(
//                                           AppImages.moreImage,
//                                         ),
//                                       ),
//                                     ),
//                                     Text("More"),
//                                   ],
//                                 ),
//                               ),
//                           ],
//                         ),
//                         if (isExpanded)
//                           GestureDetector(
//                             onTap: () {
//                               provider.toggleExpanded();
//                             },
//                             child: Padding(
//                               padding: const EdgeInsets.only(top: 8.0),
//                               child: Text(
//                                 "Show Less",
//                                 style: TextStyle(
//                                   color: Theme.of(context).colorScheme.primary,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),
//                       ],
//                     );
//                   },
//                 );
//               },
//             ),
//             SizedBox(height: 10),
//             Consumer<FoodCatagoryController>(
//               builder: (context, foodCategoryProvider, child) {
//                 return ListView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: foodCategoryProvider.foodCategoryList.length,
//                     itemBuilder: (context, index) {
//                       final foodCategory =
//                           foodCategoryProvider.foodCategoryList[index];
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             foodCategory.categoryName!,
//                             style: textTheme(context).headlineLarge?.copyWith(
//                                   color: colorScheme(context).onSurface,
//                                   fontSize: 24,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                           ),
//                           Consumer<FoodItemController>(
//                             builder: (context, provider, child) => Container(
//                               height: 230,
//                               width: double.infinity,
//                               child: ListView.builder(
//                                 shrinkWrap: true,
//                                 scrollDirection: Axis.horizontal,
//                                 itemCount: provider.foodItemList
//                                     .where(
//                                       (food) =>
//                                           food.foodCategoryId ==
//                                           foodCategory.id,
//                                     )
//                                     .length,
//                                 itemBuilder: (context, index) {
//                                   if (provider.isFoodItemLoading) {
//                                     return Center(
//                                       child: CircularProgressIndicator(),
//                                     );
//                                   } else if (provider.foodItemList.isEmpty) {
//                                     return Center(
//                                         child: Text("no food available"));
//                                   }
//                                   final foodList = provider.foodItemList
//                                       .where(
//                                         (food) =>
//                                             food.foodCategoryId ==
//                                             foodCategory.id,
//                                       )
//                                       .toList();
//                                   final food = foodList[index];
//                                   Duration difference =
//                                       food.endTime!.difference(food.startTime!);

//                                   int hours = difference.inHours;
//                                   int minutes = difference.inMinutes % 60;

//                                   String formattedDifference =
//                                       "$hours hour${hours != 1 ? 's' : ''} $minutes minute${minutes != 1 ? 's' : ''}";

//                                   return FoodItemCard(
//                                     addCardOnTap: () {},
//                                     ontap: () {
//                                       context.pushNamed(
//                                         AppRoute.productDetailPage,
//                                         extra: {
//                                           'id': food.id,
//                                           'title': food.name,
//                                           'imageUrl': food.image!,
//                                           'duration': formattedDifference,
//                                           'rating': 0.0,
//                                           'price': food.price,
//                                         },
//                                       );
//                                     },
//                                     title: food.name!,
//                                     imageUrl: food.image!,
//                                     duration: formattedDifference,
//                                     rating: 0,
//                                     price: food.price!,
//                                   );
//                                 },
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     });
//               },
//               // child: ,
//             ),
//             SizedBox(height: 20),
//             Center(
//               child: Text(
//                 'You must have to be older than 18yo and abusing alcohol is dangerous for the health',
//                 style: textTheme(context).labelSmall?.copyWith(
//                       fontSize: 7,
//                       color: colorScheme(context).error,
//                       fontWeight: FontWeight.w700,
//                     ),
//               ),
//             ),
//             SizedBox(height: 30),
//             CustomButton(
//                 iconColor: colorScheme(context).primary,
//                 arrowCircleColor: colorScheme(context).surface,
//                 text: 'Go to Cart',
//                 backgroundColor: colorScheme(context).primary,
//                 onPressed: () async {
//                   SharedPreferences prefs =
//                       await SharedPreferences.getInstance();
//                   bool? isDialogShown = prefs.getBool('ageVerificationShown');

//                   if (isDialogShown == null || !isDialogShown) {
//                     showGeneralDialog(
//                       context: context,
//                       barrierDismissible: true,
//                       barrierLabel: MaterialLocalizations.of(context)
//                           .modalBarrierDismissLabel,
//                       barrierColor: Colors.black45,
//                       transitionDuration: const Duration(milliseconds: 200),
//                       pageBuilder: (BuildContext buildContext,
//                           Animation animation, Animation secondaryAnimation) {
//                         return Center(
//                           child: Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(12),
//                               color: Colors.white,
//                             ),
//                             width: MediaQuery.of(context).size.width * 0.86,
//                             height: MediaQuery.of(context).size.height * 0.3,
//                             padding: EdgeInsets.all(20),
//                             child: Column(
//                               children: [
//                                 Align(
//                                   alignment: Alignment.topRight,
//                                   child: Container(
//                                     height: 20,
//                                     width: 20,
//                                     decoration: BoxDecoration(
//                                       shape: BoxShape.circle,
//                                       border: Border.all(
//                                         color: Theme.of(context)
//                                             .colorScheme
//                                             .onSurface,
//                                       ),
//                                     ),
//                                     child: Center(
//                                       child: GestureDetector(
//                                         onTap: () {
//                                           Navigator.pop(context);
//                                         },
//                                         child: Icon(
//                                           Icons.close,
//                                           color: Theme.of(context)
//                                               .colorScheme
//                                               .onSurface,
//                                           size: 15,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Center(
//                                   child: Text(
//                                     'Age Verification',
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .titleLarge
//                                         ?.copyWith(
//                                           color: Theme.of(context)
//                                               .colorScheme
//                                               .onSurface,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 10),
//                                 Center(
//                                   child: Text(
//                                     'Please confirm your age',
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .bodySmall
//                                         ?.copyWith(
//                                           color: Theme.of(context)
//                                               .colorScheme
//                                               .onSurface,
//                                           fontWeight: FontWeight.w400,
//                                         ),
//                                   ),
//                                 ),
//                                 const SizedBox(height: 20),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     ElevatedButton(
//                                       onPressed: () {
//                                         prefs.setBool(
//                                             'ageVerificationShown', true);
//                                         Navigator.of(context).pop();
//                                       },
//                                       style: ElevatedButton.styleFrom(
//                                         backgroundColor: Theme.of(context)
//                                             .colorScheme
//                                             .surface,
//                                         shape: RoundedRectangleBorder(
//                                           side: BorderSide(
//                                               color: Theme.of(context)
//                                                   .colorScheme
//                                                   .primary),
//                                           borderRadius:
//                                               BorderRadius.circular(30.0),
//                                         ),
//                                       ),
//                                       child: Text(
//                                         'I am under 18',
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .bodySmall
//                                             ?.copyWith(
//                                               color: Theme.of(context)
//                                                   .colorScheme
//                                                   .primary,
//                                               fontWeight: FontWeight.w600,
//                                             ),
//                                       ),
//                                     ),
//                                     ElevatedButton(
//                                       onPressed: () {
//                                         prefs.setBool(
//                                             'ageVerificationShown', true);
//                                         Navigator.of(context)
//                                             .pop(); // Close dialog
//                                         context.pushNamed(AppRoute.myCartPage);
//                                       },
//                                       style: ElevatedButton.styleFrom(
//                                         backgroundColor: Theme.of(context)
//                                             .colorScheme
//                                             .primary,
//                                         shape: RoundedRectangleBorder(
//                                           side: BorderSide(
//                                               color: Theme.of(context)
//                                                   .colorScheme
//                                                   .primary),
//                                           borderRadius:
//                                               BorderRadius.circular(30.0),
//                                         ),
//                                       ),
//                                       child: Text(
//                                         'I am 18 or older',
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .bodySmall
//                                             ?.copyWith(
//                                               color: Theme.of(context)
//                                                   .colorScheme
//                                                   .surface,
//                                               fontWeight: FontWeight.w600,
//                                             ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   } else {
//                     context.pushNamed(AppRoute.myCartPage);
//                   }
//                 }),
//             SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }
