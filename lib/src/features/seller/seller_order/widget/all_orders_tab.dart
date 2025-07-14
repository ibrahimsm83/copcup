import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/common/utils/price_format.dart';
import 'package:flutter_application_copcup/src/common/utils/shared_preference_helper.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_container.dart';
import 'package:flutter_application_copcup/src/core/api_end_points.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_order/provider/seller_order_provider.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_order/widget/seller_order_dialog.dart';
import 'package:flutter_application_copcup/src/features/user/profile/provider/user_data_provider.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
class AllOrdersTab extends StatefulWidget {
  final bool isUser;
  final int? userID;
  const AllOrdersTab({super.key, this.isUser = true, this.userID = null});

  @override
  State<AllOrdersTab> createState() => _AllOrdersTabState();
}

class _AllOrdersTabState extends State<AllOrdersTab> {
  late final userId;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      log('-------------}');
      final provider = Provider.of<SellerOrderProvider>(context, listen: false);
      if (widget.isUser) {
        await provider.getUserAllOrders(context: context);

        log('data user -------------${provider.allUserOrders.length}');
        log('user value ----------------${widget.isUser}');
      }
//      final userData = await Provider.of<UserDataProvider>(context, listen: false)
//           .getUsersData();

      userId = await SharedPrefHelper.getInt(userIdText);

      log('data id -------------${userId}');

      if (!widget.isUser) {
        await provider.getAllOrders(context: context);
        log('data all -------------${provider.allOrders.length}');
        log('user value ----------------${widget.isUser}');
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
      // child: Consumer<SellerOrderProvider>(
      //   builder: (context, provider, child) {
      //     if (widget.isUser
      //         ? provider.isAllUserOrdersLoading
      //         : provider.isAllOrdersLoading) {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //     final data =
      //         widget.isUser ? provider.allUserOrders : provider.allOrders;

      //     print("data is $data");

      //     if (data.isEmpty) {
      //       Center(
      //         child: widget.isUser
      //             ? Padding(
      //                 padding: const EdgeInsets.all(32.0),
      //                 child: Column(
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   children: [
      //                     SvgPicture.asset(
      //                       AppIcons.cartIcon,
      //                       height: 140,
      //                       width: 140,
      //                     ),
      //                     const SizedBox(height: 24),
      //                     Text('No Orders Yet',
      //                         style: textTheme(context).titleLarge?.copyWith(
      //                             color: colorScheme(context).onSurface,
      //                             fontSize: 24,
      //                             fontWeight: FontWeight.w600)),
      //                     const SizedBox(height: 12),
      //                     Text(
      //                         'Lorem ipsum is a placeholder text commonly used in design and publishing to fill space and give an idea of the final text.',
      //                         textAlign: TextAlign.center,
      //                         style: textTheme(context).titleSmall?.copyWith(
      //                             color: colorScheme(context)
      //                                 .onSurface
      //                                 .withOpacity(0.5),
      //                             fontWeight: FontWeight.w400)),
      //                     SizedBox(
      //                       height: 90,
      //                     ),
      //                     CustomButton(
      //                       iconColor: colorScheme(context).primary,
      //                       arrowCircleColor: colorScheme(context).surface,
      //                       text: 'Start Ordering',
      //                       backgroundColor: colorScheme(context).primary,
      //                       onPressed: () {
      //                         context.pushNamed(AppRoute.allOrderPage);
      //                       },
      //                     ),
      //                   ],
      //                 ),
      //               )
      //             : Text(
      //                 "no order found",
      //                 style: TextStyle(color: Colors.black),
      //               ),
      //       );
      //     }

      //     return ListView.builder(
      //         itemCount: widget.isUser
      //             ? provider.allUserOrders.length
      //             : provider.allOrders.length,
      //         itemBuilder: (context, index) {
      //           final order = widget.isUser
      //               ? provider.allUserOrders[index]
      //               : provider.allOrders[index];
      //           return InkWell(
      //             onTap: () async {
      //               context.loaderOverlay.show();
      //               final userProvider =
      //                   Provider.of<UserDataProvider>(context, listen: false);
      //               final customer =
      //                   await userProvider.getUserById(userId: order.userId);
      //               context.loaderOverlay.hide();
      //               if (customer != null) {
      //                 print(customer);
      //                 print(order.status);
      //                 if (order.status == 'Order placed') {
      //                   log('-----------------------------------place dialoue is tap');
      //                   sellerRedyForPickupDialogue(
      //                       context: context,
      //                       order: order,
      //                       customer: customer,
      //                       isAccepted: true);
      //                 } else if (order.status == 'In Progress') {
      //                   log('-----------------------------------inprogress dialogue');

      //                   sellerOrderDialog(
      //                     context: context,
      //                     order: order,
      //                     customer: customer,
      //                     isAccepted:
      //                         order.status == 'In Progress' ? true : false,
      //                   );
      //                 } else if (order.status == 'Ready for Pickup') {
      //                   sellerReadyForPickedupDialogue(
      //                     context: context,
      //                     order: order,
      //                     customer: customer,
      //                   );
      //                   log('--------no match ');
      //                 } else if (order.status == 'completed') {
      //                   showSnackbar(
      //                       message: 'This Order is complete successfully');
      //                 } else if (order.status == 'Declined') {
      //                   showSnackbar(
      //                       message: 'This Order is Cancel successfully');
      //                 }
      //               }
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
      //                         // imageUrl:
      //                         // '${ApiEndpoints.baseImageUrl}${order.orderItems.first.foodItem!.image!}',
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
      //                               // '29 Nov,01:20',
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
      //                               ),
      //                             ]),
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
          if (widget.isUser
              ? provider.isAllUserOrdersLoading
              : provider.isAllOrdersLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final data = widget.isUser
              ? provider.allUserOrders
              : provider.allOrders.where(
                  (order) {
                    return order.status?.toLowerCase() != 'completed' &&
                        order.status?.toLowerCase() != 'declined';
                  },
                ).toList();
          // final data = provider.allUserOrders.where((order) {
          //   final status = (order.status ?? '').toLowerCase();
          //   return status != 'completed' && status != 'declined';
          // }).toList();

          print("data is $data");

          if (data.isEmpty) {
            return Center(
              child: widget.isUser
                  ? Padding(
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
                          //     'Lorem ipsum is a placeholder text commonly used in design and publishing to fill space and give an idea of the final text.',
                          //     textAlign: TextAlign.center,
                          //     style: textTheme(context).titleSmall?.copyWith(
                          //         color: colorScheme(context)
                          //             .onSurface
                          //             .withOpacity(0.5),
                          //         fontWeight: FontWeight.w400)),
                          SizedBox(
                            height: 90,
                          ),
                          CustomButton(
                            iconColor: colorScheme(context).primary,
                            arrowCircleColor: colorScheme(context).surface,
                            text: AppLocalizations.of(context)!.startOrdering,
                            backgroundColor: colorScheme(context).primary,
                            onPressed: () {
                              context.pushNamed(AppRoute.allOrderPage);
                            },
                          ),
                        ],
                      ),
                    )
                  : Text(
                      AppLocalizations.of(context)!.noOrdersYet,
                      style: TextStyle(color: Colors.black),
                    ),
            );
          }

          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final order = data[index];
                return InkWell(
                  onTap: () async {
                    context.loaderOverlay.show();
                    final userProvider =
                        Provider.of<UserDataProvider>(context, listen: false);
                    final customer =
                        await userProvider.getUserById(userId: order.userId);
                    context.loaderOverlay.hide();
                    if (customer != null) {
                      print(customer);
                      print(order.status);
                      if (order.status == 'pending') {
                        log('-----------------------------------place dialoue is tap');
                        sellerRedyForPickupDialogue(
                            context: context,
                            order: order,
                            customer: customer,
                            isAccepted: true);
                      } else if (order.status == 'in_progress') {
                        log('-----------------------------------inprogress dialogue');

                        sellerOrderDialog(
                          context: context,
                          order: order,
                          customer: customer,
                          isAccepted: true,
                        );
                      } else if (order.status == 'ready') {
                        sellerReadyForPickedupDialogue(
                          context: context,
                          order: order,
                          customer: customer,
                        );
                        log('--------no match ');
                      } else if (order.status == 'completed') {
                        showSnackbar(
                            message: 'This Order is complete successfully');
                      } else if (order.status == 'Declined') {
                        showSnackbar(
                            message: 'This Order is Cancel successfully');
                      }
                    }
                    log('''''-----------${order.confirmationToken}''' '');
                    log('''''-----------${order.status}''' '');
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
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
                              SizedBox(
                                height: 3,
                              ),
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
                                            color:
                                                colorScheme(context).onSurface,
                                            fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          '${priceFormated(double.parse(order.amount!))} €',
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
                                          'OrderID:${order.id}',
                                          style: textTheme(context)
                                              .labelSmall
                                              ?.copyWith(
                                                  fontSize: 9,
                                                  color: colorScheme(context)
                                                      .error,
                                                  fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ]),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
