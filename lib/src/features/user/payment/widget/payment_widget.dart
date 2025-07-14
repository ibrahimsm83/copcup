import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/main.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/common/utils/price_format.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/core/api_end_points.dart';
import 'package:flutter_application_copcup/src/features/seller/coupons/controller/coupon_controller.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/provider/bottom_nav_bar_provider.dart';
import 'package:flutter_application_copcup/src/features/user/calender/widgets/dashed_divider.dart';
import 'package:flutter_application_copcup/src/features/user/cart/controller/cart_controller.dart';
import 'package:flutter_application_copcup/src/features/user/payment/controller/payment_controller.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';

import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
class PaymentWidget extends StatefulWidget {
  const PaymentWidget({super.key});

  @override
  State<PaymentWidget> createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _couponController = TextEditingController();
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  double subTotal = 0;
  double price = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<CartController>(
      builder: (context, provider, child) {
        if (provider.cartItemList.isEmpty)
          return Center(
            child: Text(AppLocalizations.of(context)!.na_noItemInCart),
          );

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    AppLocalizations.of(context)!.checkOut,
                    style: textTheme(context).headlineSmall?.copyWith(
                          fontSize: 21,
                          color: colorScheme(context).onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                Stack(children: [
                  ClipRRect(
                    child: CachedNetworkImage(
                      imageUrl:
                          "${ApiEndpoints.baseImageUrl}${provider.cartItemList.first.foodItem.event!.image}",
                      errorWidget: (context, url, error) => Container(
                        color: colorScheme(context).surface,
                      ),
                      placeholder: (context, url) => Shimmer.fromColors(
                          child: Container(
                            height: 120,
                            width: double.infinity,
                          ),
                          baseColor: colorScheme(context).surface,
                          highlightColor: Colors.white),
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 20,
                    child: Center(
                        child: Stack(children: [
                      const SizedBox(width: 12),
                    ])),
                  ),
                  // Positioned(
                  //   top: 40,
                  //   left: 110,
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text(
                  //           provider
                  //               .cartItemList.first.foodItem.event!.eventName,
                  //           // : 'Cultural Event',
                  //           style: textTheme(context)
                  //               .headlineMedium
                  //               ?.copyWith(
                  //                   color: colorScheme(context).surface,
                  //                   fontWeight: FontWeight.w600)),
                  //     ],
                  //   ),
                  // ),
                ]),
                const SizedBox(height: 16),
                Text(provider.cartItemList.first.foodItem.event!.eventName,
                    // AppLocalizations.of(context)!.information,
                    style: textTheme(context).bodyLarge?.copyWith(
                        color: colorScheme(context).onSurface,
                        fontWeight: FontWeight.w600,
                        fontSize: 20)),
                const SizedBox(height: 4),
                Text(provider.cartItemList.first.foodItem.event!.address,
                    style: textTheme(context).labelSmall?.copyWith(
                        color: colorScheme(context).onSurface,
                        fontSize: 12,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 20),

                // !
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: provider.cartItemList.length,
                  itemBuilder: (context, index) {
                    final food = provider.cartItemList[index].foodItem;
                    final ValueNotifier<int> quantity = ValueNotifier<int>(
                        provider.cartItemList[index].quantity);
                    price = quantity.value * food.price!;

                    subTotal += price;
                    print(price);
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
                            color: colorScheme(context).error,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.delete_outline,
                            color: colorScheme(context).surface,
                          ),
                        ),
                      ),
                      onDismissed: (direction) {
                        provider.removeFromCart(
                            productId: provider.cartItemList[index].id,
                            context: context,
                            index: index);
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
                              backgroundImage: NetworkImage(
                                  '${ApiEndpoints.baseImageUrl}${food.image}'),
                            ),
                            const SizedBox(width: 7),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    food.name!,
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
                                    food.description!,
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
                                Text(
                                  //price.toStringAsFixed(2),

                                  priceFormated(price) + ' €',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  '${AppLocalizations.of(context)!.na_itemId}: ${food.id}',
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
                                Text(
                                  '${AppLocalizations.of(context)!.na_sellerHomeQuantity}: ${quantity.value}',
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
                          ],
                        ),
                      ),
                    );
                  },
                ),

                //!

                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: _couponController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(12),
                            prefixIcon: Image.asset(
                              AppImages.cuponImage,
                              height: 20,
                              width: 10,
                            ),
                            hintText: AppLocalizations.of(context)!.applyCoupon,
                            hintStyle: textTheme(context).bodyLarge?.copyWith(
                                  color: colorScheme(context)
                                      .onSurface
                                      .withOpacity(0.5),
                                  fontWeight: FontWeight.w500,
                                ),
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .na_enterCouponCode;
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Consumer<CouponController>(
                      builder: (context, provider, child) => ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            final couponCode = _couponController.text.trim();
                            // !provider.cartItemList.first.foodItem
                            provider.validateCoupon(
                              context: context,
                              couponCode: couponCode,
                              sellerID: StaticData.userId,
                            );
                          }
                        },
                        child: Text(
                          AppLocalizations.of(context)!.apply,
                          style: textTheme(context).bodyLarge?.copyWith(
                              color: colorScheme(context).surface,
                              fontWeight: FontWeight.w500),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: colorScheme(context).primary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context)!.subtotal,
                        style: textTheme(context).titleSmall?.copyWith(
                            color:
                                colorScheme(context).onSurface.withOpacity(0.3),
                            fontWeight: FontWeight.w500)),
                    Text(priceFormated(provider.subTotal) + ' €',
                        // '${provider.subTotal.toStringAsFixed(2)} €',
                        style: textTheme(context).titleSmall?.copyWith(
                            color:
                                colorScheme(context).onSurface.withOpacity(0.3),
                            fontWeight: FontWeight.w500)),
                  ],
                ),

                const SizedBox(height: 10),
                DashedDivider(),
                const SizedBox(height: 20),
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
                            fontWeight: FontWeight.w500))
                  ],
                ),
                const SizedBox(height: 10),
                DashedDivider(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context)!.total,
                        style: textTheme(context).titleSmall?.copyWith(
                            color: colorScheme(context).onSurface,
                            fontWeight: FontWeight.w500)),
                    Text(
                        priceFormated(provider.subTotal +
                                (provider.deliveryCharges == null
                                    ? 0.0
                                    : provider.deliveryCharges!)) +
                            ' €',
                        // '${provider.subTotal + (provider.deliveryCharges == null ? 0.0 : provider.deliveryCharges!)} €',
                        style: textTheme(context).titleSmall?.copyWith(
                            color: colorScheme(context).onSurface,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
                const SizedBox(height: 30),
                Consumer<PaymentController>(
                  builder: (context, paymentProvider, child) => CustomButton(
                    iconColor: colorScheme(context).primary,
                    arrowCircleColor: colorScheme(context).surface,
                    text: AppLocalizations.of(context)!.payNow,
                    backgroundColor: colorScheme(context).primary,
                    onPressed: () {
                      paymentProvider
                          .makePayment(
                        context: context,
                        orderId: provider.cart!.id,
                        coupanCode: _couponController.text,
                      )
                          .then((onValue) {
                        if (onValue) {
                          successDialog(context);
                          context.loaderOverlay.hide();
                        } else {
                          context.loaderOverlay.hide();
                          showSnackbar(
                              message: AppLocalizations.of(context)!
                                  .na_somethingWentWrong,
                              isError: true);
                          context.pop();
                        }
                        context.loaderOverlay.hide();
                        // context.pushNamed(AppRoute.payementMethodPage, extra: {
                        //   'totalprice': provider.subTotal.toString()
                        // });
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  void successDialog(context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<NavigationProvider>(context, listen: false);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              height: 450,
              width: 450,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Lottie.asset(
                      AppLottieImage.lottieCongrats,
                      height: 142,
                      width: 139,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.congratulationsText,
                    style: textTheme(context).titleLarge?.copyWith(
                        color: colorScheme(context).onSurface.withOpacity(0.8),
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      AppLocalizations.of(context)!.successMessagePart1,
                      style: textTheme(context).bodySmall?.copyWith(
                          color:
                              colorScheme(context).onSurface.withOpacity(0.8),
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.successMessagePart2,
                    style: textTheme(context).bodySmall?.copyWith(
                        color: colorScheme(context).onSurface.withOpacity(0.8),
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Consumer<PaymentController>(
                  //   builder: (context, value, child) => SizedBox(
                  //     width: size.width * 0.7,
                  //     height: size.height * 0.08,
                  //     child: ElevatedButton(
                  //       onPressed: () {
                  //         provider.updateEventBool(true);
                  //         context.goNamed(AppRoute.trackOrderPage, extra: {
                  //           'orderList': value.currentOrder,
                  //           'orderStatus': value.currentOrder?.status,
                  //         });
                  //       },
                  //       style: ElevatedButton.styleFrom(
                  //         backgroundColor: colorScheme(context).primary,
                  //         shape: RoundedRectangleBorder(
                  //           side:
                  //               BorderSide(color: colorScheme(context).primary),
                  //           borderRadius: BorderRadius.circular(30.0),
                  //         ),
                  //       ),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           SizedBox(
                  //             width: 5,
                  //           ),
                  //           Text(AppLocalizations.of(context)!.trackOrder,
                  //               style: textTheme(context).bodySmall?.copyWith(
                  //                   color: colorScheme(context).surface,
                  //                   fontWeight: FontWeight.w600)),
                  //           CircleAvatar(
                  //             radius: 15,
                  //             backgroundColor: colorScheme(context).surface,
                  //             child: Icon(
                  //               Icons.arrow_forward,
                  //               color: colorScheme(context).primary,
                  //               size: 15.0,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: size.width * 0.7,
                    height: size.height * 0.08,
                    child: ElevatedButton(
                      onPressed: () {
                        MyAppRouter.clearAndNavigate(
                            context, AppRoute.userBottomNavBar);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme(context).surface,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: colorScheme(context).primary),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 5,
                          ),
                          Text(AppLocalizations.of(context)!.goToHome,
                              style: textTheme(context).bodySmall?.copyWith(
                                  color: colorScheme(context).primary,
                                  fontWeight: FontWeight.w600)),
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: colorScheme(context).primary,
                            child: Icon(
                              Icons.arrow_forward,
                              color: colorScheme(context).surface,
                              size: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
