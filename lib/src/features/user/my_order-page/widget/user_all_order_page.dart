import 'dart:developer';
import 'dart:isolate';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/common/utils/price_format.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_container.dart';
import 'package:flutter_application_copcup/src/core/api_end_points.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_order/provider/seller_order_provider.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/provider/bottom_nav_bar_provider.dart';
import 'package:flutter_application_copcup/src/features/user/chat/controller/chat_controller.dart';
import 'package:flutter_application_copcup/src/features/user/my_order-page/widget/recipe_dialogue.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class UserAllOrderPage extends StatefulWidget {
  final int? userID;
  const UserAllOrderPage({super.key, this.userID = null});

  @override
  State<UserAllOrderPage> createState() => _UserAllOrderPageState();
}

class _UserAllOrderPageState extends State<UserAllOrderPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<SellerOrderProvider>(context, listen: false);
      // if (provider.allUserOrders.isEmpty) {
      provider.getUserAllOrders(context: context);
      // }
    });
  }

  Future<void> getUserAllOrders() async {
    final provider = Provider.of<SellerOrderProvider>(context, listen: false);
    await provider.getUserAllOrders(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavigationProvider>(context);

    return RefreshIndicator(
      onRefresh: () {
        return getUserAllOrders();
      },
      // child: Consumer<SellerOrderProvider>(
      //   builder: (context, provider, child) {
      //     if (provider.isAllUserOrdersLoading) {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //     final data = provider.allUserOrders;

      //     if (data.isEmpty) {
      //       Center(
      //         child: Padding(
      //           padding: const EdgeInsets.all(32.0),
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               SvgPicture.asset(
      //                 AppIcons.cartIcon,
      //                 height: 140,
      //                 width: 140,
      //               ),
      //               const SizedBox(height: 24),
      //               Text('No Orders Yet',
      //                   style: textTheme(context).titleLarge?.copyWith(
      //                       color: colorScheme(context).onSurface,
      //                       fontSize: 24,
      //                       fontWeight: FontWeight.w600)),
      //               const SizedBox(height: 12),
      //               Text(
      //                   'Lorem ipsum is a placeholder text commonly used in design and publishing to fill space and give an idea of the final text.',
      //                   textAlign: TextAlign.center,
      //                   style: textTheme(context).titleSmall?.copyWith(
      //                       color:
      //                           colorScheme(context).onSurface.withOpacity(0.5),
      //                       fontWeight: FontWeight.w400)),
      //               SizedBox(
      //                 height: 90,
      //               ),
      //               CustomButton(
      //                 iconColor: colorScheme(context).primary,
      //                 arrowCircleColor: colorScheme(context).surface,
      //                 text: 'Start Ordering',
      //                 backgroundColor: colorScheme(context).primary,
      //                 onPressed: () {
      //                   context.pushNamed(AppRoute.allOrderPage);
      //                 },
      //               ),
      //             ],
      //           ),
      //         ),
      //       );
      //     }

      //     return ListView.builder(
      //         itemCount: provider.allUserOrders.length,
      //         itemBuilder: (context, index) {
      //           final order = provider.allUserOrders[index];
      //           return InkWell(
      //             onTap: () async {
      //               navProvider.updateEventBool(true);
      //               print(order.status);
      //               log('--------QrImage path  ${order.qrCodePath}');

      //               userRecipeDialogue(
      //                 qrCodeOnTap: () {
      //                   context.pop();
      //                   navProvider.getQrImage(order.confirmationToken!);
      //                   navProvider.setCurrentIndex(2);

      //                   log('--------QrImage path  ${order.qrCodePath}');
      //                 },
      //                 context: context,
      //                 trackOnTap: () {
      //                   context.pushNamed(AppRoute.trackOrderPage, extra: {
      //                     "orderList": order,
      //                     'orderStatus': order.status,
      //                   });
      //                   navProvider.setCurrentIndex(0);
      //                   log('-----------go next track page');
      //                 },
      //                 order: order,
      //               );
      //             },
      //             child: Container(
      //               margin: const EdgeInsets.only(bottom: 20),
      //               padding: const EdgeInsets.all(20),
      //               decoration: BoxDecoration(
      //                 color: Colors.white,
      //                 borderRadius: BorderRadius.circular(12),
      //                 boxShadow: [
      //                   BoxShadow(
      //                     color: Colors.grey.withOpacity(0.3),
      //                     spreadRadius: 2,
      //                     blurRadius: 5,
      //                     offset: Offset(0, 3),
      //                   ),
      //                 ],
      //               ),
      //               child: Row(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Padding(
      //                     padding: const EdgeInsets.only(top: 5),
      //                     child: ClipRRect(
      //                       borderRadius: BorderRadius.circular(8),
      //                       child: CachedNetworkImage(
      //                         imageUrl: order.orderItems.isNotEmpty
      //                             ? Uri.parse(ApiEndpoints.baseImageUrl)
      //                                 .resolve(order
      //                                     .orderItems.first.foodItem!.image
      //                                     .toString())
      //                                 .toString()
      //                             : 'https://images.slurrp.com/prod/recipe_images/transcribe/main%20course/shahi-chicken-korma.webp?impolicy=slurrp-20210601&width=1200&height=675',
      //                         width: 95,
      //                         height: 75,
      //                         fit: BoxFit.cover,
      //                         placeholder: (context, url) => Shimmer.fromColors(
      //                           baseColor: Colors.grey[300]!,
      //                           highlightColor: Colors.grey[100]!,
      //                           child: Container(
      //                             width: 95,
      //                             height: 75,
      //                             color: Colors.white,
      //                           ),
      //                         ),
      //                         errorWidget: (context, url, error) =>
      //                             Icon(Icons.error, size: 24),
      //                       ),
      //                     ),
      //                   ),
      //                   const SizedBox(width: 10),
      //                   Expanded(
      //                     child: Column(
      //                       children: [
      //                         Row(
      //                           mainAxisAlignment:
      //                               MainAxisAlignment.spaceBetween,
      //                           children: [
      //                             Text(
      //                               order.establishmentName,
      //                               style: textTheme(context)
      //                                   .bodyMedium
      //                                   ?.copyWith(
      //                                       color:
      //                                           colorScheme(context).onSurface,
      //                                       fontWeight: FontWeight.w700,
      //                                       fontSize: 18),
      //                             ),
      //                             CustomContainer(
      //                                 borderRadius: 100,
      //                                 padding: EdgeInsets.symmetric(
      //                                     horizontal: 8, vertical: 4),
      //                                 color: AppColor.greenish.withOpacity(.22),
      //                                 child: Text(order.status!,
      //                                     style: textTheme(context)
      //                                         .bodySmall
      //                                         ?.copyWith(
      //                                             color: AppColor.greenish,
      //                                             fontSize: 10))),
      //                           ],
      //                         ),
      //                         SizedBox(
      //                           height: 3,
      //                         ),
      //                         Row(
      //                           children: [
      //                             Text(
      //                               DateFormat("dd MMM,hh:mm a")
      //                                   .format(order.createdAt),
      //                               maxLines: 1,
      //                               overflow: TextOverflow.ellipsis,
      //                               style: textTheme(context)
      //                                   .labelSmall
      //                                   ?.copyWith(
      //                                       color:
      //                                           colorScheme(context).onSurface,
      //                                       fontWeight: FontWeight.w500),
      //                             ),
      //                           ],
      //                         ),
      //                         Row(
      //                             mainAxisAlignment:
      //                                 MainAxisAlignment.spaceBetween,
      //                             children: [
      //                               Column(
      //                                 children: [
      //                                   Text(
      //                                     '\€ ${order.amount}',
      //                                     style: textTheme(context)
      //                                         .titleMedium
      //                                         ?.copyWith(
      //                                             color: colorScheme(context)
      //                                                 .onSurface,
      //                                             fontWeight: FontWeight.w500),
      //                                   ),
      //                                 ],
      //                               ),
      //                               Column(
      //                                 children: [
      //                                   Text(
      //                                     'OrderID:${order.id}',
      //                                     style: textTheme(context)
      //                                         .labelSmall
      //                                         ?.copyWith(
      //                                             fontSize: 9,
      //                                             color: colorScheme(context)
      //                                                 .error,
      //                                             fontWeight: FontWeight.w600),
      //                                   ),
      //                                 ],
      //                               )
      //                             ]),
      //                         Align(
      //                           alignment: Alignment.centerRight,
      //                           child: Consumer<ChatController>(
      //                             builder: (context, value, child) {
      //                               return GestureDetector(
      //                                   onTap: () {
      //                                     log('--------user id ${StaticData.userId}\n--------------${order.sellerId}');

      //                                     // value.updateReceiver(newReceiver:order.userId );

      //                                     value.createChatRoom(
      //                                         onSuccess: (val) {
      //                                           context.pushNamed(
      //                                             AppRoute.userChat,
      //                                             extra: {
      //                                               'id': val.id,
      //                                               'reciverName':
      //                                                   '${order.sellerName}'
      //                                             },
      //                                           );
      //                                         },
      //                                         name: order.sellerName,
      //                                         members: [
      //                                           StaticData.userId,
      //                                           order.sellerId,
      //                                         ],
      //                                         type: 'private',
      //                                         context: context);
      //                                   },
      //                                   child: Padding(
      //                                     padding: const EdgeInsets.symmetric(
      //                                         horizontal: 0.0),
      //                                     child: Image.asset(
      //                                       AppImages.messageImage,
      //                                       height: 25,
      //                                     ),
      //                                   ));
      //                             },
      //                           ),
      //                         )
      //                       ],
      //                     ),
      //                   )
      //                 ],
      //               ),
      //             ),
      //           );
      //         });
      //   },
      // ),
      child: Consumer<SellerOrderProvider>(
        builder: (context, provider, child) {
          if (provider.isAllUserOrdersLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // ✅ Filter out completed orders
          // final data = provider.allUserOrders
          //     .where(
          //         (order) => (order.status ?? '').toLowerCase() != 'completed')
          //     .toList();
          final data = provider.allUserOrders.where((order) {
            final status = (order.status ?? '').toLowerCase();
            return status != 'completed' &&
                status != 'pending' &&
                status != 'declined';
          }).toList();

          if (data.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppIcons.cartIcon,
                      height: 140,
                      width: 140,
                    ),
                    const SizedBox(height: 24),
                    Text(AppLocalizations.of(context)!.noOrdersYet,
                        style: textTheme(context).titleLarge?.copyWith(
                            color: colorScheme(context).onSurface,
                            fontSize: 24,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(height: 12),
                    // Text(
                    //   'Lorem ipsum is a placeholder text commonly used in design and publishing to fill space and give an idea of the final text.',
                    //   textAlign: TextAlign.center,
                    //   style: textTheme(context).titleSmall?.copyWith(
                    //       color:
                    //           colorScheme(context).onSurface.withOpacity(0.5),
                    //       fontWeight: FontWeight.w400),
                    // ),
                    SizedBox(height: 90),
                    CustomButton(
                      iconColor: colorScheme(context).primary,
                      arrowCircleColor: colorScheme(context).surface,
                      text: AppLocalizations.of(context)!.startOrdering,
                      backgroundColor: colorScheme(context).primary,
                      onPressed: () {
                        navProvider.updateEventBool(false);
                        navProvider.setCurrentIndex(0);
                        context.pushNamed(AppRoute.userBottomNavBar);
                      },
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final order = data[index];
              return InkWell(
                onTap: () async {
                  navProvider.updateEventBool(true);
                  print(order.status);
                  log('--------QrImage path  ${order.qrCodePath}');

                  userRecipeDialogue(
                    qrCodeOnTap: () {
                      context.pop();
                      navProvider.getQrImage(order.confirmationToken!);
                      navProvider.setCurrentIndex(2);
                      log('--------QrImage path  ${order.qrCodePath}');
                    },
                    context: context,
                    trackOnTap: () {
                      context.pushNamed(AppRoute.trackOrderPage, extra: {
                        "orderList": order,
                        'orderStatus': order.status,
                      });
                      navProvider.setCurrentIndex(0);
                      log('-----------go next track page');
                    },
                    order: order,
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.all(20),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: order.orderItems.isNotEmpty
                                ? Uri.parse(ApiEndpoints.baseImageUrl)
                                    .resolve(order
                                        .orderItems.first.foodItem!.image
                                        .toString())
                                    .toString()
                                : 'https://images.slurrp.com/prod/recipe_images/transcribe/main%20course/shahi-chicken-korma.webp?impolicy=slurrp-20210601&width=1200&height=675',
                            width: 95,
                            height: 75,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: 95,
                                height: 75,
                                color: Colors.white,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error, size: 24),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  order.establishmentName,
                                  style: textTheme(context)
                                      .bodyMedium
                                      ?.copyWith(
                                          color: colorScheme(context).onSurface,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18),
                                ),
                                CustomContainer(
                                    borderRadius: 100,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    color: AppColor.greenish.withOpacity(.22),
                                    child: Text(order.status!,
                                        style: textTheme(context)
                                            .bodySmall
                                            ?.copyWith(
                                                color: AppColor.greenish,
                                                fontSize: 10))),
                              ],
                            ),
                            SizedBox(height: 3),
                            Row(
                              children: [
                                Text(
                                  DateFormat("dd MMM,hh:mm a")
                                      .format(order.createdAt),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme(context)
                                      .labelSmall
                                      ?.copyWith(
                                          color: colorScheme(context).onSurface,
                                          fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      priceFormated(
                                            double.parse(order.amount!),
                                          ) +
                                          '  €',
                                      // '${order.amount} €',
                                      style: textTheme(context)
                                          .titleMedium
                                          ?.copyWith(
                                              color: colorScheme(context)
                                                  .onSurface,
                                              fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      '${AppLocalizations.of(context)!.na_orderId}:${order.id}',
                                      style: textTheme(context)
                                          .labelSmall
                                          ?.copyWith(
                                              fontSize: 9,
                                              color: colorScheme(context).error,
                                              fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Consumer<ChatController>(
                                builder: (context, value, child) {
                                  return GestureDetector(
                                    onTap: () {
                                      log('--------user id ${StaticData.userId}\n--------------${order.sellerId}');
                                      value.createChatRoom(
                                        onSuccess: (val) {
                                          context.pushNamed(
                                            AppRoute.userChat,
                                            extra: {
                                              'id': val.id,
                                              'reciverName':
                                                  '${order.sellerName}'
                                            },
                                          );
                                        },
                                        name: order.sellerName,
                                        members: [
                                          StaticData.userId,
                                          order.sellerId
                                        ],
                                        type: 'private',
                                        context: context,
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0.0),
                                      child: Image.asset(
                                        AppImages.messageImage,
                                        height: 25,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
