import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart';
import 'package:flutter_application_copcup/firebase_options.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/utils/shared_preference_helper.dart';
import 'package:flutter_application_copcup/src/core/notification_services.dart';
import 'package:flutter_application_copcup/src/features/app_localiztion/provider/app_language_provider.dart';
import 'package:flutter_application_copcup/src/features/get_started/pages/choose_language_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_event_catagory/controller/event_category_controller.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_event/controller/event_controller.dart';
import 'package:flutter_application_copcup/src/features/get_started/provider/color_provider.dart';
import 'package:flutter_application_copcup/src/features/get_started/provider/language_provider.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_food_catagory/controller/add_food_catagory_controller.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_food_item/controller/food_item_controller.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_food_catagory/provider/food_catagory_provider.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_seller/seller_auth_controller/seller_auth_controller.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_auth/controller/responsible_auth_controller.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/provider/refund_provider.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_payment_methid/provider/payment_provider.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_order/provider/responsible_order_provider.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/provider/responsible_bottom_bar.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_search_page/controller/responsible_search_controller.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_transfer_money/resposible_transfer_provider/reposible_transfer_provider.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_transfer_money/widget/bank_select_provider.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_transfer_money/widget/sim_selction_provider.dart';
import 'package:flutter_application_copcup/src/features/responsible/seller_bank_account/controller/seller_bank_controller.dart';
import 'package:flutter_application_copcup/src/features/seller/auth/seller_provider.dart';
import 'package:flutter_application_copcup/src/features/seller/contact_us/controller/contact_us_controller.dart';
import 'package:flutter_application_copcup/src/features/seller/coupons/controller/coupon_controller.dart';
import 'package:flutter_application_copcup/src/features/responsible/delivery_charges/controller/delivery_charges_controller.dart';
import 'package:flutter_application_copcup/src/features/seller/home/provider/seller_home_provider.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_order/provider/seller_order_provider.dart';
import 'package:flutter_application_copcup/src/features/seller/setting/provider/seller_setting_provider.dart';
import 'package:flutter_application_copcup/src/features/user/auth/provider/country_picker_provider.dart';
import 'package:flutter_application_copcup/src/features/user/auth/provider/forgot_password_provider.dart';
import 'package:flutter_application_copcup/src/features/user/auth/provider/password_visibility_provider.dart';
import 'package:flutter_application_copcup/src/features/user/auth/controller/auth_controller.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/provider/bottom_nav_bar_provider.dart';
import 'package:flutter_application_copcup/src/features/user/calender/provider/cart_provider.dart';
import 'package:flutter_application_copcup/src/features/user/calender/provider/radio_provider.dart';
import 'package:flutter_application_copcup/src/features/user/cart/controller/cart_controller.dart';
import 'package:flutter_application_copcup/src/features/user/chat/controller/chat_controller.dart';
import 'package:flutter_application_copcup/src/features/user/home/controller/favourite_controller.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_copcup/src/features/user/home/controller/location_controller.dart';
import 'package:flutter_application_copcup/src/features/user/home/provider/catagory_provider.dart';
import 'package:flutter_application_copcup/src/features/user/home/provider/favourite_provider.dart';
import 'package:flutter_application_copcup/src/features/user/profile/provider/user_data_provider.dart';
import 'package:flutter_application_copcup/src/features/user/payment/controller/payment_controller.dart';
import 'package:flutter_application_copcup/src/features/user/search_events/controller/search_event_controller.dart';
import 'package:flutter_application_copcup/src/features/user/transaction/controller/transcation_controller.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:flutter_application_copcup/src/theme/app_theme.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
import 'package:app_links/app_links.dart';


/*
///User Account
 gouzoupouzou@gmail.com
 Saim@123
 */



// final AppLinks _appLinks = AppLinks();

// void initAppLinks(BuildContext context) {
//   _appLinks.uriLinkStream.listen((Uri? uri) {
//     if (uri != null) {
//       print("Deep Link: $uri");
//       if (uri.scheme == 'copcup' &&
//           uri.host == 'payout' &&
//           uri.path == '/Create-Stripe-Account') {
//         final status = uri.queryParameters['status'];
//         if (status == 'success') {
//           context.goNamed('responsible-bottom-bar');
//         } else {
//           context.goNamed('Create-Stripe-Account');
//         }
//       }
//     }
//   });
// }

final AppLinks _appLinks = AppLinks();

void initAppLinks(BuildContext context) {
  _appLinks.uriLinkStream.listen((Uri? uri) {
    if (uri != null) {
      print("Deep Link: $uri");

      // Make sure host and path match
      if (uri.scheme == 'copcup' &&
          uri.host == 'payout' &&
          uri.pathSegments.contains('Create-Stripe-Account')) {
        final status = uri.queryParameters['status'];
        if (status == 'success') {
          print('Stripe onboarding success. Navigating to bottom bar...');
          context.goNamed('responsible-bottom-bar'); // <- route name
        } else {
          print('Stripe onboarding failed or cancelled.');
          context.goNamed('Create-Stripe-Account');
        }
      }
    }
  });
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

int generateRandomId() {
  return Random().nextInt(900000) + 100000;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51RUTsURuiu3ZhvceGn0Q5WNOzujXmgS2OVs8Ld0lUOy7iJ65vFe1hb1HC26n3V8hKH4mLrw5ZXDWqIFAcwrP9GYN00Sb5tKfSf';

  // Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  // Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();

  await SharedPrefHelper.getInitialValue();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final notificationService = NotificationService();
  await notificationService.initialize();
  await notificationService.requestPermission();
  await notificationService.enableAutoInit();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RoleProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => SellerAuthProvider()),
        ChangeNotifierProvider(create: (_) => PasswordVisibilityProvider()),
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => FoodCategoryProvider()),
        ChangeNotifierProvider(create: (_) => CheckboxProvider()),
        ChangeNotifierProvider(create: (_) => CountryPickerProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => SellerHomeProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => SellerOrderProvider()),
        ChangeNotifierProvider(create: (_) => ResponsibleTransferProvider()),
        ChangeNotifierProvider(create: (_) => PaymentMethodProvider()),
        ChangeNotifierProvider(create: (_) => SellerSettingProvider()),
        ChangeNotifierProvider(create: (_) => PaymentProvider()),
        ChangeNotifierProvider(create: (_) => ResponsibleOrderProvider()),
        ChangeNotifierProvider(create: (_) => ResponsibleHomeProvider()),
        ChangeNotifierProvider(create: (_) => RefundProvider()),
        ChangeNotifierProvider(create: (_) => BankSelectionProvider()),
        ChangeNotifierProvider(create: (_) => SimSelectionProvider()),
        ChangeNotifierProvider(create: (_) => AppLanguageNotifier()),
        ChangeNotifierProvider(create: (_) => ForgotPasswordProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => EventCategoryController()),
        ChangeNotifierProvider(create: (_) => EventController()),
        ChangeNotifierProvider(create: (_) => FoodCatagoryController()),
        ChangeNotifierProvider(create: (_) => FoodItemController()),
        ChangeNotifierProvider(create: (_) => ContactUsController()),
        ChangeNotifierProvider(create: (_) => ResponsibleAuthController()),
        ChangeNotifierProvider(create: (_) => CartController()),
        ChangeNotifierProvider(create: (_) => UserDataProvider()),
        ChangeNotifierProvider(create: (_) => SellerAuthController()),
        ChangeNotifierProvider(create: (_) => DeliveryChargesController()),
        ChangeNotifierProvider(create: (_) => PaymentController()),
        ChangeNotifierProvider(create: (_) => FavouriteController()),
        ChangeNotifierProvider(create: (_) => SellerBankAccountController()),
        ChangeNotifierProvider(create: (_) => CouponController()),
        ChangeNotifierProvider(create: (_) => ChatController()),
        ChangeNotifierProvider(create: (_) => LocationController()),
        ChangeNotifierProvider(create: (_) => SearchEventController()),
        ChangeNotifierProvider(create: (_) => TranscationController()),
        ChangeNotifierProvider(create: (_) => ResponsibleSearchController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    initAppLinks(context);
    final appLocale = Provider.of<AppLanguageNotifier>(context).locale;
    return GlobalLoaderOverlay(
      child: SafeArea(
        // child: MaterialApp.router(
        //   title: 'CopCup',
        //   debugShowCheckedModeBanner: false,
        //   scaffoldMessengerKey: scaffoldMessengerKey,
        //   theme: AppTheme.instance.lightTheme,
        //   routerDelegate: MyAppRouter.router.routerDelegate,
        //   routeInformationParser: MyAppRouter.router.routeInformationParser,
        //   routeInformationProvider: MyAppRouter.router.routeInformationProvider,
        //   locale: appLocale,
        //   supportedLocales: const [
        //     Locale('en'),
        //     Locale('fr'),
        //   ],
        //   localizationsDelegates: const [
        //     AppLocalizations.delegate,
        //     GlobalMaterialLocalizations.delegate,
        //     GlobalWidgetsLocalizations.delegate,
        //     GlobalCupertinoLocalizations.delegate,
        //   ],
        // ),
        child: MaterialApp.router(
          title: 'CopCup',
          debugShowCheckedModeBanner: false,
          scaffoldMessengerKey: scaffoldMessengerKey,
          theme: AppTheme.instance.lightTheme, // Your custom light theme
          themeMode: ThemeMode
              .light, // <--- Force light theme regardless of system setting
          routerDelegate: MyAppRouter.router.routerDelegate,
          routeInformationParser: MyAppRouter.router.routeInformationParser,
          routeInformationProvider: MyAppRouter.router.routeInformationProvider,
          locale: appLocale,
          supportedLocales: const [
            Locale('en'),
            Locale('fr'),
          ],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ),
      ),
    );
  }
}
