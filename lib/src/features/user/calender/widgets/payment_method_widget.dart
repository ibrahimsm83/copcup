import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/provider/bottom_nav_bar_provider.dart';
import 'package:flutter_application_copcup/src/features/user/calender/provider/radio_provider.dart';
import 'package:flutter_application_copcup/src/features/user/payment/controller/payment_controller.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../provider/payement_option.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
class PaymentMethodWidget extends StatelessWidget {
  final String totalPrice;
  const PaymentMethodWidget({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final paymentProvider = Provider.of<PaymentMethodProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              AppLocalizations.of(context)!.selectPaymentMethod,
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
          // PaymentOption(
          //   image: AppImages.masterCardImage,
          //   title: 'Master Card 4434',
          //   value: 'Master Card 4434',
          // ),
          // PaymentOption(
          //   image: AppImages.payPalImage,
          //   title: 'Paypal',
          //   value: 'Paypal',
          // ),
          GestureDetector(
            onTap: () async {
              // await makePayment(
              //     'pi_3RSysDFyJfopOE7t0y7ZLKnZ_secret_14bJ51Ny49hvm6ehNyPCyBOAB');
            },
            child: PaymentOption(
              image: AppImages.googleImage,
              title: 'Stripe',
              value: 'GooglePay',
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Radio<String>(
                value: 'ReceiveBill',
                groupValue:
                    paymentProvider.receiveBillByEmail ? 'ReceiveBill' : '',
                onChanged: (value) {
                  paymentProvider.toggleReceiveBillByEmail(true);
                },
                activeColor: Colors.purple,
              ),
              Text(
                AppLocalizations.of(context)!.receiveBillByEmail,
                style: textTheme(context).titleMedium?.copyWith(
                    color: colorScheme(context).onSurface,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(
            height: 60,
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.total,
                  style: textTheme(context).titleMedium?.copyWith(
                      color: colorScheme(context).onSurface,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  totalPrice,
                  style: textTheme(context).titleMedium?.copyWith(
                      color: colorScheme(context).onSurface,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Consumer<PaymentController>(
            builder: (context, provider, child) => CustomButton(
              iconColor: colorScheme(context).primary,
              arrowCircleColor: colorScheme(context).surface,
              text: AppLocalizations.of(context)!.payNow,
              backgroundColor: colorScheme(context).primary,
              onPressed: () {
                String sessionId =
                    "success?session_id=cs_test_a1B5nGn6pHqELFYt6qul1YioH544dOhRSzRw9JvfHOFscnrWzA6qUqaDDg";
                // provider.paymentSuccess(
                //   context: context,
                //   sessionId: sessionId,
                //   onSuccess: () {
                //     successDialog(context);
                //   },
                // );
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
              width: double.infinity,
              height: size.height * 0.08,
              child: ElevatedButton(
                onPressed: () {
                  context.pushNamed(AppRoute.addNewCardPage);
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
                    const SizedBox(
                      width: 30,
                    ),
                    Text(AppLocalizations.of(context)!.addNewCard,
                        style: textTheme(context).titleSmall?.copyWith(
                            color: colorScheme(context).primary,
                            fontWeight: FontWeight.w600)),
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: colorScheme(context).primary,
                      child: Icon(
                        Icons.arrow_forward,
                        color: colorScheme(context).surface,
                        size: 24.0,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  // Future<void> makePayment(String clientSecret) async {
  //   try {
  //     await Stripe.instance.initPaymentSheet(
  //       paymentSheetParameters: SetupPaymentSheetParameters(
  //         paymentIntentClientSecret: clientSecret,
  //         merchantDisplayName: 'Your Business Name',
  //       ),
  //     );

  //     await Stripe.instance.presentPaymentSheet();

  //     print('✅ Payment successful');
  //   } catch (e) {
  //     if (e is StripeException) {
  //       print('⚠️ Stripe error: ${e.error.localizedMessage}');
  //     } else {
  //       print('❌ Payment error: $e');
  //     }
  //   }
  // }
}
