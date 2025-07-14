import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/common/utils/price_format.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_container.dart';
import 'package:flutter_application_copcup/src/features/seller/home/provider/seller_home_provider.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_order/model/order_model.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_order/provider/seller_order_provider.dart';
import 'package:flutter_application_copcup/src/models/user_professional_model.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

sellerOrderDialog({
  required BuildContext context,
  required OrderModel order,
  required UserProfessionalModel customer,
  required bool isAccepted,
}) async {
  final m = MediaQuery.of(context).size;
  List<String> itemList = [
    AppLocalizations.of(context)!.sellerHomeItems,
    AppLocalizations.of(context)!.na_sellerHomeQuantity,
    AppLocalizations.of(context)!.na_sellerHomePricePerItem,
    AppLocalizations.of(context)!.total
  ];

  return showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Consumer<SellerOrderProvider>(
          builder: (context, value, child) => CustomContainer(
            height: m.height * 0.68,
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
                            AppLocalizations.of(context)!.sellerHomeCustomer,
                            style: textTheme(context)
                                .bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w700),
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
                  Row(children: [
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      height: 45,
                      width: 43,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            customer.image!,
                            errorListener: (p0) => Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.customerName,
                          style: textTheme(context).bodyMedium?.copyWith(
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w700,
                              color: AppColor.darkGreyColor),
                        ),
                        Text(
                          '${AppLocalizations.of(context)!.sellerHomeContact}: ${order.customerContactNumber}',
                          style: textTheme(context).bodyMedium?.copyWith(
                              letterSpacing: 0.0,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: AppColor.darkGreyColor.withOpacity(.5)),
                        ),
                        Text(
                          '${AppLocalizations.of(context)!.emailHint}: ${order.customerMail}',
                          style: textTheme(context).bodyMedium?.copyWith(
                              fontSize: 10,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w400,
                              color: AppColor.darkGreyColor.withOpacity(.5)),
                        ),
                      ],
                    )
                  ]),
                  SizedBox(
                    height: 20,
                  ),

                  SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        '${AppLocalizations.of(context)!.sellerHomeItems}:',
                        style: textTheme(context).titleSmall?.copyWith(
                            color:
                                colorScheme(context).onSurface.withOpacity(.8),
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
                      child: Column(
                          children:
                              List.generate(order.orderItems.length, (index) {
                        final foodItem = order.orderItems[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: m.width / 6,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    foodItem.foodItem!.name!,
                                    textAlign: TextAlign.start,
                                    style: textTheme(context)
                                        .bodySmall
                                        ?.copyWith(
                                            color:
                                                colorScheme(context).onSurface,
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
                                      style: textTheme(context)
                                          .bodySmall
                                          ?.copyWith(
                                              color: colorScheme(context)
                                                  .onSurface,
                                              fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: m.width / 6,
                                child: Center(
                                  child: Text(
                                    priceFormated(
                                            double.parse(foodItem.price!)) +
                                        ' €',
                                    // '\€ ${order.orderItems[index].price}',
                                    style: textTheme(context)
                                        .bodySmall
                                        ?.copyWith(
                                            color:
                                                colorScheme(context).onSurface,
                                            fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: m.width / 6,
                                child: Center(
                                  child: Text(
                                    priceFormated(
                                            double.parse(foodItem.price!) *
                                                foodItem.quantity) +
                                        ' €',
                                    // ()
                                    //     .toStringAsFixed(2),
                                    style: textTheme(context)
                                        .bodySmall
                                        ?.copyWith(
                                            color:
                                                colorScheme(context).onSurface,
                                            fontWeight: FontWeight.w300),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      })),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${AppLocalizations.of(context)!.total}:',
                          style: textTheme(context)
                              .titleSmall
                              ?.copyWith(color: colorScheme(context).onSurface),
                        ),
                        Text(
                          '${priceFormated(double.parse(order.amount!))} €',
                          style: textTheme(context).titleSmall?.copyWith(
                              color: AppColor.redColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  // value.acceptOrder == true
                  //     ? CustomButton(
                  //         text: 'Finish Order',
                  //         onPressed: () {
                  //           value.finishOrderTrue(true);
                  //         },
                  //         textColor: colorScheme(context).surface,
                  //         backgroundColor: colorScheme(context).secondary,
                  //         iconColor: colorScheme(context).secondary,
                  //       )
                  //     :
                  CustomButton(
                    text: AppLocalizations.of(context)!.na_orderReady,
                    onPressed: () {
                      value.orderReady(
                        context: context,
                        orderId: order.id,
                      );
                      // value.acceptOrdertrue(true);
                    },
                    textColor: colorScheme(context).surface,
                    backgroundColor: colorScheme(context).secondary,
                    iconColor: colorScheme(context).secondary,
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  // CustomButton(
                  //   boxShadow: [BoxShadow(color: colorScheme(context).surface)],
                  //   text: 'Cancel the Order',
                  //   onPressed: () async {
                  //     Navigator.pop(context);

                  //     await value.declineOrder(
                  //       context: context,
                  //       orderId: order.id,
                  //     );

                  //     // showSnackbar(message: 'This is working soon');
                  //   },
                  //   borderColor: colorScheme(context).secondary,
                  //   textColor: colorScheme(context).secondary,
                  //   arrowCircleColor: colorScheme(context).secondary,
                  //   backgroundColor: colorScheme(context).surface,
                  //   iconColor: colorScheme(context).surface,
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

sellerRedyForPickupDialogue({
  required BuildContext context,
  required OrderModel order,
  required UserProfessionalModel customer,
  required bool isAccepted,
}) async {
  final m = MediaQuery.of(context).size;
  List<String> itemList = [
    AppLocalizations.of(context)!.sellerHomeItems,
    AppLocalizations.of(context)!.na_sellerHomeQuantity,
    AppLocalizations.of(context)!.na_sellerHomePricePerItem,
    AppLocalizations.of(context)!.total
  ];

  return showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Consumer<SellerOrderProvider>(
          builder: (context, value, child) => CustomContainer(
            height: m.height * 0.68,
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
                            AppLocalizations.of(context)!.sellerHomeCustomer,
                            style: textTheme(context)
                                .bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w700),
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
                  Row(children: [
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      height: 45,
                      width: 43,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            customer.image!,
                            errorListener: (p0) => Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.customerName,
                          style: textTheme(context).bodyMedium?.copyWith(
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w700,
                              color: AppColor.darkGreyColor),
                        ),
                        Text(
                          '${AppLocalizations.of(context)!.sellerHomeContact}: ${order.customerContactNumber}',
                          style: textTheme(context).bodyMedium?.copyWith(
                              letterSpacing: 0.0,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: AppColor.darkGreyColor.withOpacity(.5)),
                        ),
                        Text(
                          '${AppLocalizations.of(context)!.emailHint}: ${order.customerMail}',
                          style: textTheme(context).bodyMedium?.copyWith(
                              fontSize: 10,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w400,
                              color: AppColor.darkGreyColor.withOpacity(.5)),
                        ),
                      ],
                    )
                  ]),
                  SizedBox(
                    height: 20,
                  ),

                  SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        '${AppLocalizations.of(context)!.sellerHomeItems}:',
                        style: textTheme(context).titleSmall?.copyWith(
                            color:
                                colorScheme(context).onSurface.withOpacity(.8),
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
                      child: Column(
                          children:
                              List.generate(order.orderItems.length, (index) {
                        final foodItem = order.orderItems[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: m.width / 6,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    foodItem.foodItem!.name!,
                                    textAlign: TextAlign.start,
                                    style: textTheme(context)
                                        .bodySmall
                                        ?.copyWith(
                                            color:
                                                colorScheme(context).onSurface,
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
                                      style: textTheme(context)
                                          .bodySmall
                                          ?.copyWith(
                                              color: colorScheme(context)
                                                  .onSurface,
                                              fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: m.width / 6,
                                child: Center(
                                  child: Text(
                                    priceFormated(
                                            double.parse(foodItem.price!)) +
                                        ' €',
                                    // '\€ ${order.orderItems[index].price}',
                                    style: textTheme(context)
                                        .bodySmall
                                        ?.copyWith(
                                            color:
                                                colorScheme(context).onSurface,
                                            fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: m.width / 6,
                                child: Center(
                                  child: Text(
                                    priceFormated(
                                            double.parse(foodItem.price!) *
                                                foodItem.quantity) +
                                        ' €',
                                    // ()
                                    //     .toStringAsFixed(2),
                                    style: textTheme(context)
                                        .bodySmall
                                        ?.copyWith(
                                            color:
                                                colorScheme(context).onSurface,
                                            fontWeight: FontWeight.w300),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      })),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${AppLocalizations.of(context)!.total}:',
                          style: textTheme(context)
                              .titleSmall
                              ?.copyWith(color: colorScheme(context).onSurface),
                        ),
                        Text(
                          '${priceFormated(double.parse(order.amount!))} €',
                          style: textTheme(context).titleSmall?.copyWith(
                              color: AppColor.redColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  // value.acceptOrder == true
                  //     ? CustomButton(
                  //         text: 'Finish Order',
                  //         onPressed: () {
                  //           value.finishOrderTrue(true);
                  //         },
                  //         textColor: colorScheme(context).surface,
                  //         backgroundColor: colorScheme(context).secondary,
                  //         iconColor: colorScheme(context).secondary,
                  //       )
                  //     :
                  CustomButton(
                    text: AppLocalizations.of(context)!.sellerHomeAcceptOrder,
                    onPressed: () async {
                      print(
                          '-confirmaton token-------------------${order.confirmationToken}');

                      await value.confirmOrder(
                        context: context,
                        orderId: order.id,
                        token: order.confirmationToken!,
                      );
                      // value.acceptOrdertrue(true);
                    },
                    textColor: colorScheme(context).surface,
                    backgroundColor: colorScheme(context).secondary,
                    iconColor: colorScheme(context).secondary,
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  CustomButton(
                    boxShadow: [BoxShadow(color: colorScheme(context).surface)],
                    text: AppLocalizations.of(context)!.cancelOrder,
                    onPressed: () async {
                      await value
                          .declineOrder(
                            context: context,
                            orderId: order.id,
                          )
                          .then((onValue) {});

                      // showSnackbar(message: 'This is working soon');
                    },
                    borderColor: colorScheme(context).secondary,
                    textColor: colorScheme(context).secondary,
                    arrowCircleColor: colorScheme(context).secondary,
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
      );
    },
  );
}

sellerReadyForPickedupDialogue({
  required BuildContext context,
  required OrderModel order,
  required UserProfessionalModel customer,
}) async {
  final m = MediaQuery.of(context).size;
  final navigationProvider =
      Provider.of<SellerHomeProvider>(context, listen: false);
  List<String> itemList = [
    AppLocalizations.of(context)!.sellerHomeItems,
    AppLocalizations.of(context)!.na_sellerHomeQuantity,
    AppLocalizations.of(context)!.na_sellerHomePricePerItem,
    AppLocalizations.of(context)!.total
  ];

  return showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Consumer<SellerOrderProvider>(
          builder: (context, value, child) => CustomContainer(
            height: m.height * 0.68,
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
                            '${AppLocalizations.of(context)!.sellerHomeCustomer}',
                            style: textTheme(context)
                                .bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w700),
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
                  Row(children: [
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      height: 45,
                      width: 43,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            customer.image!,
                            errorListener: (p0) => Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.customerName,
                          style: textTheme(context).bodyMedium?.copyWith(
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w700,
                              color: AppColor.darkGreyColor),
                        ),
                        Text(
                          '${AppLocalizations.of(context)!.sellerHomeContact}: ${order.customerContactNumber}',
                          style: textTheme(context).bodyMedium?.copyWith(
                              letterSpacing: 0.0,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: AppColor.darkGreyColor.withOpacity(.5)),
                        ),
                        Text(
                          '${AppLocalizations.of(context)!.emailHint}: ${order.customerMail}',
                          style: textTheme(context).bodyMedium?.copyWith(
                              fontSize: 10,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w400,
                              color: AppColor.darkGreyColor.withOpacity(.5)),
                        ),
                      ],
                    )
                  ]),
                  SizedBox(
                    height: 20,
                  ),

                  SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        '${AppLocalizations.of(context)!.sellerHomeItems}:',
                        style: textTheme(context).titleSmall?.copyWith(
                            color:
                                colorScheme(context).onSurface.withOpacity(.8),
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
                      child: Column(
                          children:
                              List.generate(order.orderItems.length, (index) {
                        final foodItem = order.orderItems[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: m.width / 6,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    foodItem.foodItem!.name!,
                                    textAlign: TextAlign.start,
                                    style: textTheme(context)
                                        .bodySmall
                                        ?.copyWith(
                                            color:
                                                colorScheme(context).onSurface,
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
                                      style: textTheme(context)
                                          .bodySmall
                                          ?.copyWith(
                                              color: colorScheme(context)
                                                  .onSurface,
                                              fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: m.width / 6,
                                child: Center(
                                  child: Text(
                                    priceFormated(
                                            double.parse(foodItem.price!)) +
                                        ' €',
                                    // '\€ ${order.orderItems[index].price}',
                                    style: textTheme(context)
                                        .bodySmall
                                        ?.copyWith(
                                            color:
                                                colorScheme(context).onSurface,
                                            fontWeight: FontWeight.w300),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: m.width / 6,
                                child: Center(
                                  child: Text(
                                    priceFormated(
                                            double.parse(foodItem.price!) *
                                                foodItem.quantity) +
                                        ' €',

                                    // (double.parse(foodItem.price!) *
                                    //         foodItem.quantity)
                                    //     .toStringAsFixed(2),
                                    style: textTheme(context)
                                        .bodySmall
                                        ?.copyWith(
                                            color:
                                                colorScheme(context).onSurface,
                                            fontWeight: FontWeight.w300),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      })),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${AppLocalizations.of(context)!.total}:',
                          style: textTheme(context)
                              .titleSmall
                              ?.copyWith(color: colorScheme(context).onSurface),
                        ),
                        Text(
                          '${priceFormated(double.parse(order.amount!))} €',
                          style: textTheme(context).titleSmall?.copyWith(
                              color: AppColor.redColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  // value.acceptOrder == true
                  //     ? CustomButton(
                  //         text: 'Finish Order',
                  //         onPressed: () {
                  //           value.finishOrderTrue(true);
                  //         },
                  //         textColor: colorScheme(context).surface,
                  //         backgroundColor: colorScheme(context).secondary,
                  //         iconColor: colorScheme(context).secondary,
                  //       )
                  //     :
                  CustomButton(
                    text: AppLocalizations.of(context)!.scanQrTitle,
                    onPressed: () {
                      context.pop();
                      navigationProvider.setCurrentIndex(2);
                    },
                    textColor: colorScheme(context).surface,
                    backgroundColor: colorScheme(context).secondary,
                    iconColor: colorScheme(context).secondary,
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  // CustomButton(
                  //   boxShadow: [BoxShadow(color: colorScheme(context).surface)],
                  //   text: 'Cancel the Order',
                  //   onPressed: () async {
                  //     await value
                  //         .declineOrder(
                  //       context: context,
                  //       orderId: order.id,
                  //     )
                  //         .then((onValue) {
                  //       context.pop();
                  //     });

                  //     // showSnackbar(message: 'This is working soon');
                  //   },
                  //   borderColor: colorScheme(context).secondary,
                  //   textColor: colorScheme(context).secondary,
                  //   arrowCircleColor: colorScheme(context).secondary,
                  //   backgroundColor: colorScheme(context).surface,
                  //   iconColor: colorScheme(context).surface,
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
