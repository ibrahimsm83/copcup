// import 'package:flutter/material.dart';
// import 'dart:developer';

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
// import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
// import 'package:flutter_application_copcup/src/core/api_end_points.dart';
// import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/provider/bottom_nav_bar_provider.dart';
// import 'package:flutter_application_copcup/src/features/user/calender/widgets/dashed_divider.dart';
// import 'package:flutter_application_copcup/src/features/user/cart/controller/cart_controller.dart';
// import 'package:flutter_application_copcup/src/routes/go_router.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';
// package:flutter_application_copcup/gen_l10n/app_localizations.dart
// class MyCartWidget extends StatefulWidget {
//   final List<Map<String, dynamic>> cartItems;
//   const MyCartWidget({super.key, required this.cartItems});

//   @override
//   State<MyCartWidget> createState() => _MyCartWidgetState();
// }

// class _MyCartWidgetState extends State<MyCartWidget> {
//   @override
//   ValueNotifier<double> subTotal = ValueNotifier(0);

//   void updateSubTotal(CartController provider) {
//     double total = 0;
//     for (var cartItem in provider.cartItemList) {
//       total += cartItem.quantity * cartItem.foodItem.price!;
//     }
//     subTotal.value = total;
//   }

//   Widget build(BuildContext context) {
//     final btmprovider = Provider.of<NavigationProvider>(context);
//     return Scaffold(body: Consumer<CartController>(
//       builder: (context, provider, child) {
//         if (provider.cartItemList.isEmpty)
//           return Center(
//             child: Text("No Item in Cart"),
//           );

//         updateSubTotal(provider);

//         return SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               SizedBox(
//                 height: 20,
//               ),
//               Text(
//                 AppLocalizations.of(context)!.myCart,
//                 style: textTheme(context).headlineSmall?.copyWith(
//                       fontSize: 21,
//                       color: colorScheme(context).onSurface,
//                       fontWeight: FontWeight.w600,
//                     ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 itemCount: provider.cartItemList.length,
//                 itemBuilder: (context, index) {
//                   final food = provider.cartItemList[index].foodItem;
//                   final ValueNotifier<int> quantity =
//                       ValueNotifier<int>(provider.cartItemList[index].quantity);

//                   final ValueNotifier<double> price = ValueNotifier<double>(
//                       provider.cartItemList[index].quantity * food.price!);

//                   print(price);
//                   return Dismissible(
//                     key: UniqueKey(),
//                     direction: DismissDirection.endToStart,
//                     background: Container(
//                       alignment: Alignment.centerRight,
//                       color: Colors.white,
//                       padding: const EdgeInsets.symmetric(horizontal: 20),
//                       child: Container(
//                         height: 109,
//                         width: 90,
//                         decoration: BoxDecoration(
//                           color: colorScheme(context).error,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Icon(
//                           Icons.delete_outline,
//                           color: colorScheme(context).surface,
//                         ),
//                       ),
//                     ),
//                     onDismissed: (direction) async {
//                       // log('the crd is remove ${provider.cart!.cartItems[index].id}');
//                       await provider.removeFromCart(
//                           productId: provider.cartItemList[index].id,
//                           context: context,
//                           index: index);
//                     },
//                     child: Container(
//                       margin: const EdgeInsets.only(bottom: 10),
//                       padding: const EdgeInsets.all(15),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(12),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.3),
//                             spreadRadius: 2,
//                             blurRadius: 5,
//                             offset: Offset(0, 3),
//                           ),
//                         ],
//                       ),
//                       child: Row(
//                         children: [
//                           CircleAvatar(
//                             radius: 25,
//                             backgroundImage: CachedNetworkImageProvider(
//                               "${ApiEndpoints.baseImageUrl}${food.image}" ??
//                                   'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwRPWpO-12m19irKlg8znjldmcZs5PO97B6A&s',
//                             ),
//                             child: CachedNetworkImage(
//                               imageUrl:
//                                   "${ApiEndpoints.baseImageUrl}${food.image}" ??
//                                       'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwRPWpO-12m19irKlg8znjldmcZs5PO97B6A&s',
//                               imageBuilder: (context, imageProvider) =>
//                                   CircleAvatar(
//                                 radius: 50,
//                                 backgroundImage: imageProvider,
//                               ),
//                               placeholder: (context, url) =>
//                                   CircularProgressIndicator(),
//                               errorWidget: (context, url, error) =>
//                                   Icon(Icons.error),
//                             ),
//                           ),
//                           const SizedBox(width: 7),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   food.name.toString()!,
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .titleSmall
//                                       ?.copyWith(
//                                           color: Theme.of(context)
//                                               .colorScheme
//                                               .onSurface,
//                                           fontWeight: FontWeight.w700),
//                                 ),
//                                 Text(
//                                   food.description!,
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .bodySmall
//                                       ?.copyWith(
//                                           color: Theme.of(context)
//                                               .colorScheme
//                                               .onSurface
//                                               .withOpacity(0.4),
//                                           fontWeight: FontWeight.w400),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Column(
//                             children: [
//                               ValueListenableBuilder(
//                                 valueListenable: price,
//                                 builder: (context, value, _) {
//                                   return Text(
//                                     price.value.toStringAsFixed(2),
//                                     style: Theme.of(context)
//                                         .textTheme
//                                         .titleSmall
//                                         ?.copyWith(
//                                             color: Theme.of(context)
//                                                 .colorScheme
//                                                 .primary,
//                                             fontWeight: FontWeight.w700),
//                                   );
//                                 },
//                                 // child: ,
//                               ),
//                               Text(
//                                 'Item: ${food.id}',
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .bodySmall
//                                     ?.copyWith(
//                                         color: Theme.of(context)
//                                             .colorScheme
//                                             .onSurface
//                                             .withOpacity(0.4),
//                                         fontWeight: FontWeight.w400),
//                               ),
//                               const SizedBox(height: 5),
//                               ValueListenableBuilder<int>(
//                                 valueListenable: quantity,
//                                 builder: (context, value, _) {
//                                   return Row(children: [
//                                     GestureDetector(
//                                       onTap: () {
//                                         if (quantity.value > 1) {
//                                           quantity.value -= 1;
//                                           price.value =
//                                               quantity.value * food.price!;
//                                         }

//                                         var index = widget.cartItems.indexWhere(
//                                             (item) =>
//                                                 item['foodId'] == food.id);
//                                         if (index != -1) {
//                                           widget.cartItems[index]['quantity'] =
//                                               quantity.value;
//                                         } else {
//                                           widget.cartItems.add({
//                                             'foodId': food.id,
//                                             'quantity': quantity.value
//                                           });
//                                         }

//                                         // updateSubTotal(provider);
//                                       },
//                                       child: Container(
//                                         height: 26,
//                                         width: 28,
//                                         decoration: BoxDecoration(
//                                           color: Colors.grey.withOpacity(0.3),
//                                           borderRadius:
//                                               BorderRadius.circular(9),
//                                         ),
//                                         child: Center(
//                                           child: Icon(
//                                             Icons.remove,
//                                             color: Colors.red,
//                                             size: 15,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(width: 5),
//                                     Text(
//                                       value.toString().padLeft(1, '0'),
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.w600),
//                                     ),
//                                     SizedBox(width: 5),
//                                     GestureDetector(
//                                       onTap: () {
//                                         quantity.value += 1;

//                                         price.value =
//                                             quantity.value * food.price!;
//                                         // updateSubTotal(provider);

//                                         var index = widget.cartItems.indexWhere(
//                                             (item) =>
//                                                 item['foodId'] == food.id);
//                                         if (index != -1) {
//                                           widget.cartItems[index]['quantity'] =
//                                               quantity.value;
//                                         } else {
//                                           widget.cartItems.add({
//                                             'foodId': food.id,
//                                             'quantity': quantity.value
//                                           });
//                                         }
//                                       },
//                                       child: Container(
//                                         height: 26,
//                                         width: 28,
//                                         decoration: BoxDecoration(
//                                           color: Colors.green,
//                                           borderRadius:
//                                               BorderRadius.circular(9),
//                                         ),
//                                         child: Center(
//                                           child: Icon(
//                                             Icons.add,
//                                             color: Colors.white,
//                                             size: 15,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ]);
//                                 },
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text('Subtotal',
//                       style: textTheme(context).titleSmall?.copyWith(
//                           color:
//                               colorScheme(context).onSurface.withOpacity(0.3),
//                           fontWeight: FontWeight.w500)),
//                   ValueListenableBuilder(
//                     valueListenable: subTotal,
//                     builder: (context, value, child) {
//                       print("subtotal listen is $value");
//                       return Text('\€ ${value.toStringAsFixed(2)}',
//                           style: textTheme(context).titleSmall?.copyWith(
//                               color: colorScheme(context)
//                                   .onSurface
//                                   .withOpacity(0.3),
//                               fontWeight: FontWeight.w500));
//                     },
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               DashedDivider(),
//               const SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text('Delivery',
//                       style: textTheme(context).titleSmall?.copyWith(
//                           color:
//                               colorScheme(context).onSurface.withOpacity(0.3),
//                           fontWeight: FontWeight.w500)),
//                   Text(
//                       '\€ ${provider.deliveryCharges == null ? 0 : provider.deliveryCharges!.toStringAsFixed(2)}',
//                       style: textTheme(context).titleSmall?.copyWith(
//                           color:
//                               colorScheme(context).onSurface.withOpacity(0.3),
//                           fontWeight: FontWeight.w500)),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               DashedDivider(),
//               const SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text('Total',
//                       style: textTheme(context).titleSmall?.copyWith(
//                           color: colorScheme(context).onSurface,
//                           fontWeight: FontWeight.w500)),
//                   Text(
//                       '\€ ${subTotal.value + (provider.deliveryCharges == null ? 0.0 : provider.deliveryCharges!)}',
//                       style: textTheme(context).titleSmall?.copyWith(
//                           color: colorScheme(context).onSurface,
//                           fontWeight: FontWeight.w500)),
//                 ],
//               ),
//               const SizedBox(height: 60),
//               CustomButton(
//                 iconColor: colorScheme(context).primary,
//                 arrowCircleColor: colorScheme(context).surface,
//                 text: AppLocalizations.of(context)!.checkOut,
//                 backgroundColor: colorScheme(context).primary,
//                 onPressed: () async {
//                   btmprovider.updateEventBool(true);
//                   print("click");
//                   if (widget.cartItems.isNotEmpty) {
//                     // for (var item in cartItems) {
//                     //   provider.addToCartMultiple(
//                     //     context: context,
//                     //     productId: item['foodId'],
//                     //     quantity: item['quantity'],
//                     //   );
//                     // }
//                     List<Future> tasks = [];

//                     // Add each API call to the list
//                     for (var item in widget.cartItems) {
//                       tasks.add(provider.addToCartMultiple(
//                         context: context,
//                         productId: item['foodId'],
//                         quantity: item['quantity'],
//                       ));
//                     }

//                     // Wait for all API calls to complete
//                     await Future.wait(tasks);

//                     // Navigate after all tasks are done
//                     log('-----selected food item ${tasks}');

//                     context.pushNamed(AppRoute.checkOutPage);
//                   } else {
//                     context.pushNamed(AppRoute.checkOutPage);
//                   }
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     ));
//   }
// }

import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/utils/price_format.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/core/api_end_points.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/provider/bottom_nav_bar_provider.dart';
import 'package:flutter_application_copcup/src/features/user/calender/widgets/dashed_divider.dart';
import 'package:flutter_application_copcup/src/features/user/cart/controller/cart_controller.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
class MyCartWidget extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  const MyCartWidget({super.key, required this.cartItems});

  @override
  State<MyCartWidget> createState() => _MyCartWidgetState();
}

class _MyCartWidgetState extends State<MyCartWidget> {
  @override
  ValueNotifier<double> subTotal = ValueNotifier(0);

  void updateSubTotal(CartController provider) {
    double total = 0;
    for (var cartItem in provider.cartItemList) {
      total += cartItem.quantity * cartItem.foodItem.price!;
    }
    subTotal.value = total;
  }

//!
  late ValueNotifier<double> totalCartValue;

  @override
  void initState() {
    super.initState();
    totalCartValue = ValueNotifier<double>(0.0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      calculateTotal();
    });
  }

  void calculateTotal() {
    final provider = Provider.of<CartController>(context, listen: false);
    double total = provider.cartItemList.fold(0.0, (sum, item) {
      return sum + (item.quantity * (item.foodItem.price ?? 0));
    });
    totalCartValue.value = total;
  }

  Widget build(BuildContext context) {
    final btmprovider = Provider.of<NavigationProvider>(context);
    return Scaffold(body: Consumer<CartController>(
      builder: (context, provider, child) {
        if (provider.cartItemList.isEmpty)
          return Center(
            child: Text(AppLocalizations.of(context)!.na_noItemInCart),
          );

        updateSubTotal(provider);

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                AppLocalizations.of(context)!.myCart,
                style: textTheme(context).headlineSmall?.copyWith(
                      fontSize: 21,
                      color: colorScheme(context).onSurface,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SizedBox(
                height: 20,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: provider.cartItemList.length,
                itemBuilder: (context, index) {
                  final item = provider.cartItemList[index];
                  final food = item.foodItem;
                  final ValueNotifier<int> quantity =
                      ValueNotifier<int>(item.quantity);
                  final ValueNotifier<double> price =
                      ValueNotifier<double>(item.quantity * food.price!);

                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 109,
                        width: 90,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.error,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.delete_outline,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                    ),
                    onDismissed: (direction) async {
                      await provider.removeFromCart(
                        productId: item.id,
                        context: context,
                        index: index,
                      );
                      calculateTotal(); // 👈 update total
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage: CachedNetworkImageProvider(
                              "${ApiEndpoints.baseImageUrl}${food.image}",
                            ),
                          ),
                          const SizedBox(width: 7),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  food.name ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                          fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  food.description ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface
                                              .withOpacity(0.4),
                                          fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              ValueListenableBuilder(
                                valueListenable: price,
                                builder: (context, value, _) {
                                  return Text(
                                    priceFormated(price.value) + ' €',
                                    // price.value.toStringAsFixed(2),

                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontWeight: FontWeight.w700),
                                  );
                                },
                              ),
                              Text(
                                '${AppLocalizations.of(context)!.sellerHomeItems}: ${food.id}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withOpacity(0.4),
                                        fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(height: 5),
                              ValueListenableBuilder<int>(
                                valueListenable: quantity,
                                builder: (context, value, _) {
                                  return Row(children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (quantity.value > 1) {
                                          quantity.value -= 1;
                                          price.value =
                                              quantity.value * food.price!;
                                          item.quantity = quantity.value;
                                          calculateTotal(); // 👈 update total
                                        }
                                        var index = widget.cartItems.indexWhere(
                                            (item) =>
                                                item['foodId'] == food.id);
                                        if (index != -1) {
                                          widget.cartItems[index]['quantity'] =
                                              quantity.value;
                                        } else {
                                          widget.cartItems.add({
                                            'foodId': food.id,
                                            'quantity': quantity.value
                                          });
                                        }
                                      },
                                      child: Container(
                                        height: 26,
                                        width: 28,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(9),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.remove,
                                            color: Colors.red,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      value.toString().padLeft(1, '0'),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(width: 5),
                                    GestureDetector(
                                      onTap: () {
                                        quantity.value += 1;
                                        price.value =
                                            quantity.value * food.price!;
                                        item.quantity = quantity.value;
                                        calculateTotal(); // 👈 update total

                                        var index = widget.cartItems.indexWhere(
                                            (item) =>
                                                item['foodId'] == food.id);
                                        if (index != -1) {
                                          widget.cartItems[index]['quantity'] =
                                              quantity.value;
                                        } else {
                                          widget.cartItems.add({
                                            'foodId': food.id,
                                            'quantity': quantity.value
                                          });
                                        }
                                      },
                                      child: Container(
                                        height: 26,
                                        width: 28,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(9),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]);
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.subtotal,
                      style: textTheme(context).titleSmall?.copyWith(
                          color:
                              colorScheme(context).onSurface.withOpacity(0.3),
                          fontWeight: FontWeight.w500)),
                  ValueListenableBuilder(
                    valueListenable: totalCartValue,
                    builder: (context, value, child) {
                      print("subtotal listen is $value");
                      return Text(
                          priceFormated(value) + ' €'
                          // '${value.toStringAsFixed(2)} €',
                          ,
                          style: textTheme(context).titleSmall?.copyWith(
                              color: colorScheme(context)
                                  .onSurface
                                  .withOpacity(0.3),
                              fontWeight: FontWeight.w500));
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              DashedDivider(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.delivery,
                      style: textTheme(context).titleSmall?.copyWith(
                          color:
                              colorScheme(context).onSurface.withOpacity(0.3),
                          fontWeight: FontWeight.w500)),
                  Text(
                      priceFormated(provider.deliveryCharges == null
                              ? 0
                              : provider.deliveryCharges!) +
                          ' €',
                      // '${provider.deliveryCharges == null ? 0 : provider.deliveryCharges!.toStringAsFixed(2)} €',
                      style: textTheme(context).titleSmall?.copyWith(
                          color:
                              colorScheme(context).onSurface.withOpacity(0.3),
                          fontWeight: FontWeight.w500)),
                ],
              ),
              const SizedBox(height: 10),
              DashedDivider(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.total,
                      style: textTheme(context).titleSmall?.copyWith(
                          color: colorScheme(context).onSurface,
                          fontWeight: FontWeight.w500)),
                  // Text(
                  //     '\€ ${subTotal.value + (provider.deliveryCharges == null ? 0.0 : provider.deliveryCharges!)}',
                  //     style: textTheme(context).titleSmall?.copyWith(
                  //         color: colorScheme(context).onSurface,
                  //         fontWeight: FontWeight.w500)),
                  ValueListenableBuilder<double>(
                    valueListenable: totalCartValue,
                    builder: (context, value, _) {
                      return SizedBox(
                        child: Text(
                            priceFormated(value +
                                    (provider.deliveryCharges == null
                                        ? 0.0
                                        : provider.deliveryCharges!)) +
                                ' €',
                            // '${value + (provider.deliveryCharges == null ? 0.0 : provider.deliveryCharges!)} €',
                            style: textTheme(context).titleSmall?.copyWith(
                                color: colorScheme(context).onSurface,
                                fontWeight: FontWeight.w500)),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 60),
              CustomButton(
                iconColor: colorScheme(context).primary,
                arrowCircleColor: colorScheme(context).surface,
                text: AppLocalizations.of(context)!.checkOut,
                backgroundColor: colorScheme(context).primary,
                onPressed: () async {
                  btmprovider.updateEventBool(true);
                  print("click");
                  if (widget.cartItems.isNotEmpty) {
                    // for (var item in cartItems) {
                    //   provider.addToCartMultiple(
                    //     context: context,
                    //     productId: item['foodId'],
                    //     quantity: item['quantity'],
                    //   );
                    // }
                    List<Future> tasks = [];

                    // Add each API call to the list
                    for (var item in widget.cartItems) {
                      tasks.add(provider.addToCartMultiple(
                        context: context,
                        productId: item['foodId'],
                        quantity: item['quantity'],
                      ));
                    }

                    // Wait for all API calls to complete
                    await Future.wait(tasks);

                    // Navigate after all tasks are done
                    log('-----selected food item ${tasks}');

                    context.pushNamed(AppRoute.checkOutPage);
                  } else {
                    context.pushNamed(AppRoute.checkOutPage);
                  }
                },
              ),
            ],
          ),
        );
      },
    ));
  }
}
