import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/utils/price_format.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/core/api_end_points.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_order/provider/seller_order_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
class UserCancleOrder extends StatefulWidget {
  const UserCancleOrder({super.key});

  @override
  State<UserCancleOrder> createState() => _UserCancleOrderState();
}

class _UserCancleOrderState extends State<UserCancleOrder> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<SellerOrderProvider>(context, listen: false);
      if (provider.allOrders.isEmpty) {
        provider.getAllOrders(context: context);
      }
    });
  }

  Future<void> getAllOrders() async {
    final provider = Provider.of<SellerOrderProvider>(context, listen: false);
    await provider.getAllOrders(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => getAllOrders(),
      child: Consumer<SellerOrderProvider>(
        builder: (context, provider, child) {
          if (provider.isAllOrdersLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final data = provider.allUserOrders
              .where(
                (order) => order.status == "declined",
              )
              .toList();

          log('------------${data.length}');
          if (data.isEmpty) {
            return Center(
              child: Text(AppLocalizations.of(context)!.na_noCancelledOrder),
            );
          }
          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final order = provider.allUserOrders[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(16),
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          // child: Image.network(
                          //   'https://images.slurrp.com/prod/recipe_images/transcribe/main%20course/shahi-chicken-korma.webp?impolicy=slurrp-20210601&width=1200&height=675',

                          //   // '${ApiEndpoints.baseImageUrl}${order.orderItems.first.foodItem!.image!}',
                          //   width: 85,
                          //   height: 75,
                          //   fit: BoxFit.cover,
                          // ),
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
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    order.orderItems.first.foodItem!.name!,
                                    style: textTheme(context)
                                        .titleSmall
                                        ?.copyWith(
                                            color:
                                                colorScheme(context).onSurface,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            letterSpacing: 0.0),
                                  ),
                                  Text(
                                    DateFormat("dd MMM,hh:mm a")
                                        .format(order.createdAt),
                                    // '29 Nov, 01:20 pm ',
                                    style: textTheme(context)
                                        .labelSmall
                                        ?.copyWith(
                                            fontSize: 9,
                                            color:
                                                colorScheme(context).onSurface,
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
                                      '${priceFormated(double.parse(order.amount!))} €',
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
                                          AppLocalizations.of(context)!
                                              .cancelOrder,
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
                                    '${order.orderItems.length} ${AppLocalizations.of(context)!.sellerHomeItems}',
                                    style: textTheme(context)
                                        .bodySmall
                                        ?.copyWith(
                                            color:
                                                colorScheme(context).onSurface,
                                            fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
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
