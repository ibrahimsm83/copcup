import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/utils/price_format.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_container.dart';
import 'package:flutter_application_copcup/src/features/app_localiztion/provider/app_language_provider.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_order/model/order_model.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_order/provider/seller_order_provider.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/provider/bottom_nav_bar_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
void userRecipeDialogue({
  required BuildContext context,
  required OrderModel order,
  required VoidCallback trackOnTap,
  required VoidCallback qrCodeOnTap,

  // required UserProfessionalModel customer,
  // required bool isAccepted,
}) async {
  final provider = Provider.of<NavigationProvider>(context, listen: false);

  final m = MediaQuery.of(context).size;
  List<String> itemList = [
    AppLocalizations.of(context)!.sellerHomeItems,
    AppLocalizations.of(context)!.na_sellerHomeQuantity,
    AppLocalizations.of(context)!.na_sellerHomePricePerItem,
    AppLocalizations.of(context)!.total
  ];

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: Consumer<SellerOrderProvider>(
          builder: (contedasdasdasxt, value, child) => Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: CustomContainer(
              height: m.height * 0.7,
              width: m.width * 0.9,
              borderRadius: 24,
              color: colorScheme(context).surface,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${order.establishmentName}',
                              style: textTheme(context).bodyMedium?.copyWith(
                                  color: colorScheme(context).onSurface,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Image.asset(
                                AppImages.cancleImage,
                                height: 25,
                                color: colorScheme(context).onSurface,
                              ),
                            )
                          ]),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: SizedBox(
                            height: 80,
                            child: SingleChildScrollView(
                              child: Text("${AppLocalizations.of(context)!.bottomBarOrders} #${order.id} ${AppLocalizations.of(context)!.na_from} ${order.establishmentName} ${AppLocalizations.of(context)!.na_orderBeingProcessed}" +
                                  order.orderItems
                                      .map((item) =>
                                          "${item.quantity}x ${item.foodItem!.name}")
                                      .join(", ") +
                                  " ${AppLocalizations.of(context)!.na_forTotalOf}  ${priceFormated(double.parse(order.amount!))} € . ${AppLocalizations.of(context)!.role_seller} : ${order.sellerName}. ${AppLocalizations.of(context)!.na_useConfirmationToken} ${order.confirmationToken} ${AppLocalizations.of(context)!.na_verificationThankYou}"),
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          '${AppLocalizations.of(context)!.sellerHomeItems}:',
                          style: textTheme(context).titleSmall?.copyWith(
                              color: colorScheme(context)
                                  .onSurface
                                  .withOpacity(.8),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(4, (index) {
                        return SizedBox(
                          width: m.width / 6,
                          child: Center(
                            child: Text(
                              itemList[index],
                              textAlign: TextAlign.center,
                              style: textTheme(context).bodySmall?.copyWith(
                                  letterSpacing: 0.1,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.0,
                          ),
                          child: ListView.builder(
                            itemCount: order.orderItems.length,
                            itemBuilder: (context, index) {
                              final foodItem = order.orderItems[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: m.width / 6,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 10.0),
                                        child: Text(
                                          foodItem.foodItem!.name!,
                                          // order.orderItems[index].foodItem,
                                          textAlign: TextAlign.start,
                                          style: textTheme(context)
                                              .bodySmall
                                              ?.copyWith(
                                                  color: colorScheme(context)
                                                      .onSurface,
                                                  fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: m.width / 6,
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 5.0),
                                        child: Center(
                                          child: Text(
                                            foodItem.quantity.toString(),
                                            // order.orderItems[index].quantity.toString(),
                                            style: textTheme(context)
                                                .bodySmall
                                                ?.copyWith(
                                                    color: colorScheme(context)
                                                        .onSurface,
                                                    fontWeight:
                                                        FontWeight.w300),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: m.width / 6,
                                      child: Center(
                                        child: Text(
                                          priceFormated(double.parse(
                                                  foodItem.price!)) +
                                              ' €',
                                          // foodItem.price!,
                                          // '\€ ${order.orderItems[index].price}',
                                          style: textTheme(context)
                                              .bodySmall
                                              ?.copyWith(
                                                  color: colorScheme(context)
                                                      .onSurface,
                                                  fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: m.width / 6,
                                      child: Center(
                                        child: Text(
                                          priceFormated(double.parse(
                                                      foodItem.price!) *
                                                  foodItem.quantity) +
                                              ' €',
                                          // (double.parse(foodItem.price!) *
                                          //         foodItem.quantity)
                                          // .toStringAsFixed(2),

                                          style: textTheme(context)
                                              .bodySmall
                                              ?.copyWith(
                                                  color: colorScheme(context)
                                                      .onSurface,
                                                  fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          )
                          // Column(
                          //     children:
                          //         List.generate(order.orderItems.length, (index) {
                          //   final foodItem = order.orderItems[index];
                          //   return ;
                          // })),
                          ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${AppLocalizations.of(context)!.total}:',
                            style: textTheme(context).titleSmall?.copyWith(
                                color: colorScheme(context).onSurface),
                          ),
                          Text(
                            priceFormated(double.parse(order.amount!)) + ' €',
                            // '${order.amount} €',

                            style: textTheme(context).titleSmall?.copyWith(
                                color: AppColor.redColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                      height: 50,
                      arrowCircleRadius: 18,
                      boxShadow: [
                        BoxShadow(color: colorScheme(context).surface)
                      ],
                      text: AppLocalizations.of(context)!.qrTitle,
                      onPressed: qrCodeOnTap,
                      borderColor: colorScheme(context).primary,
                      textColor: colorScheme(context).surface,
                      arrowCircleColor: colorScheme(context).surface,
                      iconColor: colorScheme(context).primary,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                      height: 50,
                      arrowCircleRadius: 20,
                      boxShadow: [
                        BoxShadow(color: colorScheme(context).surface)
                      ],
                      text: AppLocalizations.of(context)!.trackOrder,
                      onPressed: trackOnTap,
                      borderColor: colorScheme(context).primary,
                      textColor: colorScheme(context).primary,
                      arrowCircleColor: colorScheme(context).primary,
                      backgroundColor: colorScheme(context).surface,
                      iconColor: colorScheme(context).surface,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
