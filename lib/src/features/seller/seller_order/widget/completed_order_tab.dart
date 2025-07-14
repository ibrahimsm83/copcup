import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/utils/price_format.dart';
import 'package:flutter_application_copcup/src/common/utils/shared_preference_helper.dart';
import 'package:flutter_application_copcup/src/core/api_end_points.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_order/provider/seller_order_provider.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
class CompletedOrderTab extends StatefulWidget {
  final bool isUser;
  const CompletedOrderTab({super.key, this.isUser = true});

  @override
  State<CompletedOrderTab> createState() => _CompletedOrderTabState();
}

class _CompletedOrderTabState extends State<CompletedOrderTab> {
  late final userId;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<SellerOrderProvider>(context, listen: false);
      log('-------------${widget.isUser}');
      userId = await SharedPrefHelper.getInt(userIdText);

      log('data id -------------${userId}');
      if (provider.allUserOrders.isEmpty && widget.isUser) {
        provider.getUserAllOrders(context: context);
      }
      if (provider.allOrders.isEmpty && !widget.isUser) {
        provider.getAllOrders(context: context);
      }
    });
  }

  Future<void> getAllOrders() async {
    final provider = Provider.of<SellerOrderProvider>(context, listen: false);
    await provider.getAllOrders(context: context);
  }

  Future<void> getUserAllOrders() async {
    final provider = Provider.of<SellerOrderProvider>(context, listen: false);
    await provider.getUserAllOrders(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return widget.isUser ? getUserAllOrders() : getAllOrders();
      },
      child: Consumer<SellerOrderProvider>(
        builder: (context, provider, child) {
          if (widget.isUser
              ? provider.isAllUserOrdersLoading
              : provider.isAllOrdersLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final data = widget.isUser
              ? provider.allUserOrders
              : provider.allOrders
                  .where(
                    (order) => order.status == "completed",
                  )
                  .toList();

          if (data.isEmpty) {
            return Center(
              child: Text(AppLocalizations.of(context)!.na_noCompletedOrder),
            );
          }
          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final order = data[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
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
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  order.orderItems.first.foodItem!.name!,
                                  style: textTheme(context)
                                      .titleSmall
                                      ?.copyWith(
                                          color: colorScheme(context).onSurface,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          letterSpacing: 0.0),
                                ),
                                Text(
                                  DateFormat("dd MMM, hh:mm a")
                                      .format(order.createdAt),

                                  // '29 Nov, 01:20 pm ',
                                  style: textTheme(context)
                                      .labelSmall
                                      ?.copyWith(
                                          fontSize: 9,
                                          color: colorScheme(context).onSurface,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.0),
                                ),
                              ],
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    priceFormated(double.parse(order.amount!)) +
                                        ' €',
                                    style: textTheme(context)
                                        .titleMedium
                                        ?.copyWith(
                                          color: colorScheme(context).error,
                                        ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 10,
                                        width: 10,
                                        child: Icon(
                                          Icons.check,
                                          size: 7,
                                          color: AppColor.lightOrange,
                                        ),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: AppColor.lightOrange)),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        '${AppLocalizations.of(context)!.na_orderDelivered}',
                                        style: textTheme(context)
                                            .bodySmall
                                            ?.copyWith(
                                              color: AppColor.lightOrange,
                                              fontWeight: FontWeight.w300,
                                            ),
                                      ),
                                    ],
                                  ),
                                ]),
                            Row(
                              children: [
                                Text(
                                  '${order.orderItems.first.quantity} ${AppLocalizations.of(context)!.sellerHomeItems}',
                                  style: textTheme(context).bodySmall?.copyWith(
                                      color: colorScheme(context).onSurface,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       SizedBox(),
                            //       // CustomContainer(
                            //       //   onTap: () {
                            //       //     showModalBottomSheet(
                            //       //       context: context,
                            //       //       isScrollControlled: true,
                            //       //       shape: const RoundedRectangleBorder(
                            //       //         borderRadius: BorderRadius.vertical(
                            //       //             top: Radius.circular(16)),
                            //       //       ),
                            //       //       builder: (context) =>
                            //       //           ReviewBottomSheet(),
                            //       //     );
                            //       //   },
                            //       //   height: 26,
                            //       //   width: 110,
                            //       //   color: colorScheme(context)
                            //       //       .onSurface
                            //       //       .withOpacity(0.1),
                            //       //   borderRadius: 100,
                            //       //   child: Row(
                            //       //     mainAxisAlignment:
                            //       //         MainAxisAlignment.spaceEvenly,
                            //       //     children: [
                            //       //       Text(
                            //       //         'Write a review',
                            //       //         style: textTheme(context)
                            //       //             .bodySmall
                            //       //             ?.copyWith(
                            //       //                 color: colorScheme(context)
                            //       //                     .onSurface
                            //       //                     .withOpacity(0.6),
                            //       //                 fontWeight: FontWeight.w500,
                            //       //                 fontSize: 11),
                            //       //       ),
                            //       //       Icon(
                            //       //         Icons.keyboard_arrow_down,
                            //       //         color: colorScheme(context)
                            //       //             .onSurface
                            //       //             .withOpacity(0.3),
                            //       //       )
                            //       //     ],
                            //       //   ),
                            //       // ),
                            //       // CustomContainer(
                            //       //   color: colorScheme(context).surface,
                            //       //   borderRadius: 100,
                            //       //   height: 23,
                            //       //   padding:
                            //       //       EdgeInsets.symmetric(horizontal: 5),
                            //       //   borderColor: colorScheme(context).secondary,
                            //       //   child: Center(
                            //       //     child: Text(
                            //       //       'Order Again',
                            //       //       style: textTheme(context)
                            //       //           .bodySmall
                            //       //           ?.copyWith(
                            //       //               fontSize: 8,
                            //       //               color: colorScheme(context)
                            //       //                   .secondary),
                            //       //     ),
                            //       //   ),
                            //       // ),
                            //       Consumer2<ChatController, AuthController>(
                            //         builder: (context, chatProvider, userdata,
                            //             child) {
                            //           return InkWell(
                            //             onTap: () async {
                            //               // print(provider
                            //               //     .allUserOrders.first.sellerId);

                            //               log("id ${userId}");
                            //               chatProvider.createChatRoom(
                            //                   name: order.sellerName,
                            //                   members: [
                            //                     userId,
                            //                     widget.isUser
                            //                         ? provider
                            //                             .allUserOrders[index]
                            //                             .sellerId
                            //                         : provider
                            //                             .allOrders[index].id
                            //                   ],
                            //                   type: "private",
                            //                   context: context);
                            //               // chatProvider.updateReceiver(newReceiver: );
                            //             },
                            //             child: Column(
                            //               children: [
                            //                 Image.asset(
                            //                   AppImages.messageImage,
                            //                   height: 30,
                            //                   width: 30,
                            //                 ),
                            //                 Text(
                            //                   'Message',
                            //                   style: TextStyle(
                            //                       fontSize: 5,
                            //                       color: colorScheme(context)
                            //                           .primary),
                            //                 )
                            //               ],
                            //             ),
                            //           );
                            //         },
                            //       )
                            //     ]),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
