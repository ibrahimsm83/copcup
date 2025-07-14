import 'package:flutter/material.dart';

import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/core/api_end_points.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_order/model/order_model.dart';

import 'package:flutter_application_copcup/src/features/seller/seller_order/provider/seller_order_provider.dart';
import 'package:flutter_application_copcup/src/features/user/calender/widgets/order_item.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:provider/provider.dart';
import '../../../../common/widgets/custom_buton.dart';

class TrackOrderWidget extends StatefulWidget {
  final String status;
  final OrderModel orderList;

  const TrackOrderWidget(
      {super.key, required this.status, required this.orderList});

  @override
  State<TrackOrderWidget> createState() => _TrackOrderWidgetState();
}

class _TrackOrderWidgetState extends State<TrackOrderWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Consumer<SellerOrderProvider>(builder: (context, provider, child) {
        if (provider.isAllUserOrdersLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                'Track Order',
                style: textTheme(context).headlineSmall?.copyWith(
                      fontSize: 21,
                      color: colorScheme(context).onSurface,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme(context).onSurface.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey, width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox.shrink(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          widget.status,
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.orderList.orderItems.length,
                    itemBuilder: (context, index) {
                      final order = widget.orderList.orderItems[index];
                      return OrderItemCard(
                          foodName: order.foodItem!.name!,
                          // orderList[index].orderItems.first.foodItem!.image!,
                          image: Uri.parse(ApiEndpoints.baseImageUrl)
                              .resolve(order.foodItem!.image.toString())
                              .toString(),
                          itemNumber: order.quantity.toString(),
                          price: order.price!,
                          subTitle: DateFormat('dd-MM-yy, hh:mm a')
                              .format(order.updatedAt));
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    iconColor: colorScheme(context).primary,
                    arrowCircleColor: colorScheme(context).surface,
                    text: 'Show QR Code',
                    backgroundColor: colorScheme(context).primary,
                    onPressed: () {
                      showGeneralDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierLabel: MaterialLocalizations.of(context)
                              .modalBarrierDismissLabel,
                          barrierColor: Colors.black45,
                          transitionDuration: const Duration(milliseconds: 200),
                          pageBuilder: (BuildContext buildContext,
                              Animation animation,
                              Animation secondaryAnimation) {
                            return Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                ),
                                width: MediaQuery.of(context).size.width * 0.95,
                                height:
                                    MediaQuery.of(context).size.height * 0.55,
                                padding: EdgeInsets.all(10),
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: 30,
                                          ),
                                          Text("Scan QR",
                                              style: textTheme(context)
                                                  .headlineSmall
                                                  ?.copyWith(
                                                      color:
                                                          colorScheme(context)
                                                              .onSurface,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                          IconButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            icon: Icon(
                                              Icons.close,
                                              color: colorScheme(context)
                                                  .onSurface,
                                              size: 25,
                                            ),
                                          ),
                                        ],
                                      ),
                                      QrImageView(
                                        data:
                                            widget.orderList.confirmationToken!,
                                        version: QrVersions.auto,
                                        size: 200.0,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text(
                                            widget.orderList.confirmationToken!,
                                            style: textTheme(context)
                                                .titleSmall
                                                ?.copyWith(
                                                    color: colorScheme(context)
                                                        .onSurface
                                                        .withOpacity(.5),
                                                    fontWeight:
                                                        FontWeight.w400)),
                                      ),
                                      Center(
                                        child: Text(
                                            'Scan QR Code for withdraw order',
                                            style: textTheme(context)
                                                .titleMedium
                                                ?.copyWith(
                                                    color: colorScheme(context)
                                                        .onSurface,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          "The QR code is personal.do not share it anyone.sharing this code may resultin unauthorizes to your order",
                                          style: textTheme(context)
                                              .labelSmall
                                              ?.copyWith(
                                                  color: colorScheme(context)
                                                      .error,
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w500))
                                    ]),
                              ),
                            );
                          });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // SizedBox(
            //   width: double.infinity,
            //   height: size.height * 0.08,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       context.pushNamed(AppRoute.myOrderPage);
            //     },
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: colorScheme(context).surface,
            //       shape: RoundedRectangleBorder(
            //         side: BorderSide(color: colorScheme(context).primary),
            //         borderRadius: BorderRadius.circular(30.0),
            //       ),
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         const SizedBox(
            //           width: 40,
            //         ),
            //         Text('Cancel Order',
            //             style: textTheme(context).titleMedium?.copyWith(
            //                 color: colorScheme(context).primary,
            //                 fontWeight: FontWeight.w600)),
            //         CircleAvatar(
            //           radius: 22,
            //           backgroundColor: colorScheme(context).primary,
            //           child: Icon(
            //             Icons.arrow_forward,
            //             color: colorScheme(context).surface,
            //             size: 24.0,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        );
      }),
    );
  }
}
