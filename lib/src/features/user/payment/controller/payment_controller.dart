import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_order/model/order_model.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_order/repository/order_repository.dart';
import 'package:flutter_application_copcup/src/features/user/payment/repository/payment_repository.dart';

import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;

class PaymentController with ChangeNotifier {
  final PaymentRepository _paymentRepository = PaymentRepository();

  // //! Make Payment
  // String _url = '';
  // String get url => _url;

  // Future<bool> makePayment({
  //   required BuildContext context,
  //   required int orderId,
  //   required String coupanCode,
  // }) async {
  //   try {
  //     context.loaderOverlay.show();
  //     _url = await _paymentRepository.makePayment(
  //         orderId: orderId, coupanCode: coupanCode);
  //     bool isSucceed = await StripeSheet(
  //         context: context,
  //         height: MediaQuery.of(context).size.height,
  //         width: MediaQuery.of(context).size.width,
  //         client_secret: url,
  //         paymentIntentId:
  //         );
  //     if (isSucceed) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //     // showSnackbar(message: url);
  //   } catch (e) {
  //     showSnackbar(message: e.toString(), isError: true);
  //     print('Error making payment: $e');
  //     return false;
  //   } finally {
  //     notifyListeners();
  //     context.loaderOverlay.hide();
  //   }
  // }
  String _url = '';
  String _paymentIntentId = '';

  String get url => _url;
  String get paymentIntentId => _paymentIntentId;

  Future<bool> makePayment({
    required BuildContext context,
    required int orderId,
    required String coupanCode,
  }) async {
    try {
      context.loaderOverlay.show();

      final result = await _paymentRepository.makePayment(
        orderId: orderId,
        coupanCode: coupanCode,
      );

      _url = result['client_secret'] ?? '';
      _paymentIntentId = result['payment_intent_id'] ?? '';

      bool isSucceed = await StripeSheet(
        context: context,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        client_secret: _url,
        paymentIntentId: _paymentIntentId,
      );

      return isSucceed;
    } catch (e) {
      showSnackbar(message: e.toString(), isError: true);
      print('Error making payment: $e');
      return false;
    } finally {
      notifyListeners();
      context.loaderOverlay.hide();
    }
  }

  // //! Payment Success
  // Future<void> paymentSuccess({
  //   required BuildContext context,
  //   required String sessionId,
  //   required Function() onSuccess,
  // }) async {
  //   try {
  //     context.loaderOverlay.show();
  //     final bool result =
  //         await _paymentRepository.paymentSuccess(sessionId: sessionId);
  //     if (result) {
  //       onSuccess();
  //     }
  //     notifyListeners();
  //   } catch (e) {
  //     showSnackbar(message: e.toString(), isError: true);

  //     print('Error in payment: $e');
  //   } finally {
  //     context.loaderOverlay.hide();
  //   }
  // }

  // Future<void> StripeSheet({
  //   required BuildContext context,
  //   required double height,
  //   required double width,
  //   required String client_secret,
  // }) async {
  //   try {
  //     var gPay = stripe.PaymentSheetGooglePay(
  //       merchantCountryCode: 'PK',
  //       testEnv: true,
  //       currencyCode: 'EUR',
  //     );
  //     // final isGooglePaySupported = await Stripe.instance
  //     //     .isGooglePaySupported(IsGooglePaySupportedParams());
  //     // log('--------------------${isGooglePaySupported}');
  //     await stripe.Stripe.instance
  //         .initPaymentSheet(
  //           paymentSheetParameters: stripe.SetupPaymentSheetParameters(
  //             googlePay: stripe.PaymentSheetGooglePay(
  //               merchantCountryCode: 'PK',
  //               testEnv: true,
  //             ),
  //             merchantDisplayName: 'copcup',
  //             paymentIntentClientSecret: client_secret,
  //             style: ThemeMode.dark,
  //           ),
  //         )
  //         .then((value) {});
  //     await displayPaymentsheet(
  //       width: width,
  //       context: context,
  //       height: height,
  //       // model: model,
  //       clienttoken: client_secret,
  //     );
  //   } catch (e) {
  //     print('exception;$e');
  //   }
  // }

  Future<bool> StripeSheet({
    required BuildContext context,
    required double height,
    required double width,
    required String client_secret,
    required String paymentIntentId,
  }) async {
    try {
      // Initialize the payment sheet with Stripe
      await stripe.Stripe.instance.initPaymentSheet(
        paymentSheetParameters: stripe.SetupPaymentSheetParameters(
          googlePay: stripe.PaymentSheetGooglePay(
            merchantCountryCode: 'PK',
            testEnv: true,
            currencyCode: 'EUR',
          ),
          merchantDisplayName: 'copcup',
          paymentIntentClientSecret: client_secret,
          style: ThemeMode.dark,
        ),
      );

      // Present the payment sheet
      await stripe.Stripe.instance.presentPaymentSheet();
      await _paymentRepository.finalizeOrder(paymentIntentId);

      // If no exception is thrown, payment is successful
      return true;
    } on stripe.StripeException catch (e) {
      print('Stripe exception: $e');
      return false;
    } catch (e) {
      print('General exception: $e');
      return false;
    }
  }

  displayPaymentsheet({
    required BuildContext context,
    required double height,
    required double width,
    required String clienttoken,
  }) async {
    try {
      await stripe.Stripe.instance.presentPaymentSheet().then((value) async {
        log("value is succeed");

        // checkPaymentStatus(clienttoken);
        // stripe.PaymentIntent m= stripe.PaymentIntent.r
        await stripe.Stripe.instance.confirmPaymentSheetPayment().then((value) {
          log("Payment Successfull");
          // paymentIntent = null;
          // model.isPaid = true;
          // CheckOutController.to.placeorder(
          //   width: width,
          //   context: context,
          //   height: height,
          //   model: model,
          //   draft: draft,
          // );
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Text("Payment Successfull"),
                          ],
                        )
                      ],
                    ),
                  ));
        });
      }).onError((error, stackTrace) {
        print("Error is : ---->$error $stackTrace");
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  content: Center(
                      child: InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: Text("Cancelled"))),
                ));
      });
    } on stripe.StripeException catch (e) {
      print("Error is :----> $e");
      if (e.error.localizedMessage!.contains("Your card was declined")) {}
      if (e.error.localizedMessage!.contains("cancle")) {}
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled"),
              ));
    } catch (e) {
      print('$e');
    }
  }

  OrderModel? _currentOrder;
  OrderModel? get currentOrder => _currentOrder;
  bool _isCurrentLoading = false;
  bool get isCurrentLoading => _isCurrentLoading;
  Future<void> getCurrentOrder({
    required BuildContext context,
  }) async {
    _isCurrentLoading = true;
    notifyListeners();
    final result = await OrderRepository().getCurrentOrder();
    result.fold(
      (failure) => showSnackbar(message: 'No Orders', isError: false),
      (allUserOrders) => _currentOrder = allUserOrders,
    );
    log("all user order list: ${_currentOrder}");
    _isCurrentLoading = false;
    notifyListeners();
  }
}
