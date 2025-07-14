import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/features/professional_signup/pages/professional_otp_verify_with_email_page.dart';
import 'package:flutter_application_copcup/src/features/professional_signup/pages/professional_otp_with_phone_page.dart';
import 'package:flutter_application_copcup/src/features/professional_signup/pages/professional_select_sign_up_method.dart';
import 'package:flutter_application_copcup/src/features/professional_signup/pages/professional_sign_up_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_event/pages/all_events_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_event/pages/event_detail_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_event_catagory/pages/update_category_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_food_catagory/pages/update_food_catagory.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_food_item/pages/edit_food_item_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_food_item/pages/food_item_detail_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_seller/pages/edit_responsible_account.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_profile/pages/responsible_choose_language.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_profile/pages/responsible_update_account.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_search_page/page/responsible_search_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/seller_bank_account/pages/create_bank_account_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/seller_bank_account/pages/salary_card.dart';
import 'package:flutter_application_copcup/src/features/responsible/seller_bank_account/pages/withdraw_payement_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/stripe_screen/page/create_stripe_account.dart';
import 'package:flutter_application_copcup/src/features/seller/auth/pages/seller_forgot_password/pages/forgot_password_page.dart';
import 'package:flutter_application_copcup/src/features/seller/auth/pages/seller_forgot_password/pages/otp_with_email_page.dart';
import 'package:flutter_application_copcup/src/features/seller/auth/pages/seller_forgot_password/pages/reset_password_page.dart';
import 'package:flutter_application_copcup/src/features/seller/coupons/pages/seller_coupan_page.dart';
import 'package:flutter_application_copcup/src/features/seller/coupons/pages/seller_create_coupan_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/delivery_charges/pages/all_delivery_charges_page.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_order/model/order_model.dart';
import 'package:flutter_application_copcup/src/features/seller/setting/pages/delivery_charges_page.dart';
import 'package:flutter_application_copcup/src/features/seller/setting/pages/seller_change_password_page.dart';
import 'package:flutter_application_copcup/src/features/seller/setting/pages/seller_choose_language_page.dart';
import 'package:flutter_application_copcup/src/features/user/auth/responsible_pins/responsible_create_pin.dart';
import 'package:flutter_application_copcup/src/features/user/auth/responsible_pins/responsible_log_in_pin.dart';
import 'package:flutter_application_copcup/src/features/user/auth/sign_up/pages/otp_verify_with_phone.dart';
import 'package:flutter_application_copcup/src/features/user/chat/pages/inbox_page.dart';
import 'package:flutter_application_copcup/src/features/user/chat/pages/user_chat_page.dart';
import 'package:flutter_application_copcup/src/features/user/events/all_food_list_page.dart';
import 'package:flutter_application_copcup/src/features/user/events/pages/all_events_page.dart';
import 'package:flutter_application_copcup/src/features/user/events/pages/specific_catagory_food_items.dart';
import 'package:flutter_application_copcup/src/features/user/events/pages/specific_event_detail_page.dart';
import 'package:flutter_application_copcup/src/features/user/home/pages/google_map.dart';
import 'package:flutter_application_copcup/src/features/user/profile/pages/otp_verify_delete_user.dart';
import 'package:flutter_application_copcup/src/features/user/profile/pages/responsible_notification_page.dart';
import 'package:flutter_application_copcup/src/features/user/profile/pages/user_choose_language_page.dart';
import 'package:flutter_application_copcup/src/features/user/profile/pages/user_contact_us_page.dart';
import 'package:flutter_application_copcup/src/features/user/profile/widgets/notification_widget.dart';
import 'package:flutter_application_copcup/src/features/user/qr_scan/user_qr_scan_page.dart';
import 'package:flutter_application_copcup/src/models/event_category_model.dart';
import 'package:flutter_application_copcup/src/features/get_started/pages/get_started_page.dart';
import 'package:flutter_application_copcup/src/features/get_started/pages/splash.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_food_catagory/pages/all_food_catagories_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_food_catagory/pages/food_catagory_detail_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_auth/pages/responsible_change_password_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_auth/pages/responsible_otp_email_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_auth/pages/responsible_otp_phone.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_event_catagory/pages/add_event_catagory.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_order/pages/responsible_all_order_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_payment_methid/pages/add_payment_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_payment_methid/pages/card_data_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_payment_methid/pages/card_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_payment_methid/pages/change_payment_method_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_payment_methid/pages/payemt_cards_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_auth/pages/responsible_create_new_pin_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_auth/pages/responsible_sign_in_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_auth/pages/responsible_sign_up_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/pages/responsible_home_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_event/pages/add_event_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_seller/pages/add_seller_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_seller/pages/edit_seller_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_event/pages/manage_events_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_seller/pages/responsible_manage_account_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_profile/pages/responsible_profile_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_profile/pages/responsible_sales_report_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_transfer_money/pages/select_sim_card_servic_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_transfer_money/pages/top_up_amount_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_transfer_money/pages/top_up_sim_card_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_transfer_money/pages/transfer_bank_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_transfer_money/pages/transfer_money_verified_number_page.dart';

import 'package:flutter_application_copcup/src/features/responsible/add_seller/pages/seller_create_pin_page.dart';
import 'package:flutter_application_copcup/src/features/seller/auth/pages/seller_sigin/pages/seller_signin_page.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_bottom_nav_bar/pages/seller_bottom_bar.dart';
import 'package:flutter_application_copcup/src/features/seller/home/pages/seller_category_page.dart';
import 'package:flutter_application_copcup/src/features/seller/home/pages/seller_home_page.dart';
import 'package:flutter_application_copcup/src/features/seller/home/pages/seller_qr_page.dart';
import 'package:flutter_application_copcup/src/features/seller/home/pages/seller_stock_page.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_order/pages/seller_all_order_page.dart';
import 'package:flutter_application_copcup/src/features/seller/contact_us/pages/seller_contact_us_page.dart';
import 'package:flutter_application_copcup/src/features/seller/setting/pages/seller_faqs_page.dart';
import 'package:flutter_application_copcup/src/features/seller/setting/pages/seller_maximum_order_page.dart';
import 'package:flutter_application_copcup/src/features/seller/setting/pages/seller_notification_page.dart';
import 'package:flutter_application_copcup/src/features/seller/setting/pages/seller_profile_page.dart';
import 'package:flutter_application_copcup/src/features/seller/setting/pages/seller_setting_page.dart';
import 'package:flutter_application_copcup/src/features/seller/setting/pages/seller_term_and_condition_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_transfer_money/pages/money_transfer_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_transfer_money/pages/select_card_page.dart';
import 'package:flutter_application_copcup/src/features/user/auth/forgot_password/pages/forgot_password_page.dart';
import 'package:flutter_application_copcup/src/features/user/auth/forgot_password/pages/reset_password_page.dart';
import 'package:flutter_application_copcup/src/features/user/auth/sign_up/pages/otp_verify_with_email_page.dart';
import 'package:flutter_application_copcup/src/features/user/auth/forgot_password/pages/otp_with_email_page.dart';
import 'package:flutter_application_copcup/src/features/get_started/pages/sig_in_method_selection_page.dart';
import 'package:flutter_application_copcup/src/features/user/auth/sig_in/pages/sign_in_page.dart';
import 'package:flutter_application_copcup/src/features/user/auth/sign_up/pages/select_sign_up_method.dart';
import 'package:flutter_application_copcup/src/features/user/auth/sign_up/pages/sign_up_page.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/user_bottom_nav_bar.dart';
import 'package:flutter_application_copcup/src/features/user/calender/pages/add_new_card.dart';
import 'package:flutter_application_copcup/src/features/user/my_order-page/page/all_orders_page.dart';
import 'package:flutter_application_copcup/src/features/user/payment/pages/check_out_page.dart';
import 'package:flutter_application_copcup/src/features/user/cart/pages/my_cart_page.dart';
import 'package:flutter_application_copcup/src/features/user/calender/pages/my_order_page.dart';
import 'package:flutter_application_copcup/src/features/user/calender/pages/payement_method_page.dart';
import 'package:flutter_application_copcup/src/features/user/calender/pages/product_detail_page.dart';
import 'package:flutter_application_copcup/src/features/user/calender/pages/track_order.dart';
import 'package:flutter_application_copcup/src/features/user/home/pages/all_catagories_page.dart';
import 'package:flutter_application_copcup/src/features/user/home/pages/favourite_event_page.dart';
import 'package:flutter_application_copcup/src/features/user/search_events/pages/search_page.dart';
import 'package:flutter_application_copcup/src/features/user/profile/pages/contact_us_page.dart';
import 'package:flutter_application_copcup/src/features/user/profile/pages/edit_profile_page.dart';
import 'package:flutter_application_copcup/src/features/user/profile/pages/notification_page.dart';
import 'package:flutter_application_copcup/src/features/user/profile/pages/profile_page.dart';
import 'package:flutter_application_copcup/src/features/user/profile/pages/terms_condition_page.dart';
import 'package:flutter_application_copcup/src/features/user/transaction/pages/transaction_page.dart';
import 'package:flutter_application_copcup/src/features/user/search/pages/find_events_page.dart';
import 'package:flutter_application_copcup/src/models/event_model.dart';
import 'package:flutter_application_copcup/src/models/food_catagory_model.dart';
import 'package:flutter_application_copcup/src/models/food_item_model.dart';
import 'package:flutter_application_copcup/src/models/user_model.dart';
import 'package:flutter_application_copcup/src/routes/route_transition.dart';
import 'package:go_router/go_router.dart';
import '../features/responsible/responsible_auth/pages/reponsible_forgot_password_page.dart';
import '../features/responsible/add_food_catagory/pages/add_food_catagory_page.dart';
import '../features/responsible/responsible_bottom_nav_bar/pages/responsible_bottom_bar.dart';
import '../features/responsible/add_event_catagory/pages/all_event_catagories.dart';
import '../features/responsible/responsible_home/pages/responsible_chat_page.dart';
import '../features/responsible/add_food_item/pages/create_food_item_page.dart';
import '../features/responsible/add_event_catagory/pages/event_catagory_detail_page.dart';
import '../features/responsible/responsible_home/pages/responsible_stock.dart';
import '../features/responsible/responsible_profile/pages/responsible_change_password_page.dart';
import '../features/responsible/responsible_profile/email_change/pages/otp_verify_email.dart';
import '../features/responsible/responsible_home/pages/responsible_support_request_page.dart';
import '../features/responsible/responsible_profile/email_change/pages/email_enter_page.dart';
import '../features/user/profile/pages/change_password_page.dart';
import 'error_route.dart';

class MyAppRouter {
  static final router = GoRouter(
    initialLocation: '/${AppRoute.splashScreen}',
    routes: [
      GoRoute(
        name: AppRoute.splashScreen,
        path: '/${AppRoute.splashScreen}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: SplashScreen(),
        ),
      ),

      GoRoute(
        name: AppRoute.signInPage,
        path: '/${AppRoute.signInPage}',
        builder: (context, state) {
          var data = state.extra as Map<String, dynamic>;
          return SignInPage();
        },
      ),

      GoRoute(
        name: AppRoute.getStartedPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: const GetStartedPage()),
        path: '/${AppRoute.getStartedPage}',
      ),
      GoRoute(
        name: AppRoute.selectSignUpMethod,
        path: '/${AppRoute.selectSignUpMethod}',
        builder: (context, state) {
          var data = state.extra as Map<String, dynamic>;

          return SelectSignUpMethod(
            password: data['password'] as String,
            user: data['user'] as UserProfile,
          );
        },
      ),
      GoRoute(
        name: AppRoute.professionalSigInMethodSelectionPage,
        path: '/${AppRoute.professionalSigInMethodSelectionPage}',
        builder: (context, state) {
          var data = state.extra as Map<String, dynamic>;

          return ProfessionalSelectSignUpMethod(
            password: data['password'] as String,
            professional: data['professional'] as UserProfile,
          );
        },
      ),
      GoRoute(
        name: AppRoute.productDetailPage,
        path: '/${AppRoute.productDetailPage}',
        pageBuilder: (context, state) {
          final Map<String, dynamic> args = state.extra as Map<String, dynamic>;
          return buildPageWithFadeTransition(
            context: context,
            state: state,
            child: FoodDetailPage(
              foodModel: args['foodModel'],
            ),
          );
        },
      ),

      GoRoute(
        name: AppRoute.chooseLanguagePage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: UserChooseLanguagePage()),
        path: '/${AppRoute.chooseLanguagePage}',
      ),
      GoRoute(
        name: AppRoute.sellerChooseLanguagePage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: SellerChooseLanguagePage()),
        path: '/${AppRoute.sellerChooseLanguagePage}',
      ),
      GoRoute(
        name: AppRoute.responsibleChooseLanguagePage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context,
            state: state,
            child: ResponsibleChooseLanguagePage()),
        path: '/${AppRoute.responsibleChooseLanguagePage}',
      ),
      GoRoute(
        name: AppRoute.sigInMethodSelectionPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: SigInMethodSelectionPage()),
        path: '/${AppRoute.sigInMethodSelectionPage}',
      ),
      GoRoute(
        name: AppRoute.signUpPage,
        builder: (context, state) {
          var data = state.extra as Map<String, dynamic>;

          return SignUpPage(
            role: data['role'] as String,
          );
        },
        path: '/${AppRoute.signUpPage}',
      ),
      GoRoute(
        name: AppRoute.ProfessionalSignUpPage,
        builder: (context, state) {
          var data = state.extra as Map<String, dynamic>;

          return ProfessionalSignUpPage(
            role: data['role'] as String,
          );
        },
        path: '/${AppRoute.ProfessionalSignUpPage}',
      ),
      GoRoute(
        name: AppRoute.forgotPasswordPage,
        builder: (context, state) {
          var data = state.extra as Map<String, dynamic>;

          return ForgotPasswordPage(
            email: data['email'] as String,
            role: data['role'] as String,
          );
        },
        path: '/${AppRoute.forgotPasswordPage}',
      ),
      GoRoute(
        name: AppRoute.resetPasswordPage,
        builder: (context, state) {
          var data = state.extra as Map<String, dynamic>;

          return ResetPasswordPage(
            role: data['role'] as String,
            email: data['email'] as String,
            token: data['token'] as String,
          );
        },
        path: '/${AppRoute.resetPasswordPage}',
      ),
      GoRoute(
        name: AppRoute.otpVerificationEmailPage,
        path: '/${AppRoute.otpVerificationEmailPage}',
        builder: (context, state) {
          var data = state.extra as Map<String, dynamic>;
          return OtpVerifyWithEmailPage(
            email: data['email'] as String,
            userProfile: data['userProfile'] as UserProfile,
            password: data['password'] as String,
          );
        },
      ),
      GoRoute(
        name: AppRoute.otpVerificationPhonePage,
        path: '/${AppRoute.otpVerificationPhonePage}',
        builder: (context, state) {
          var data = state.extra as Map<String, dynamic>;
          return OtpVerifyWithPhonePage(
            email: data['email'] as String,
            userProfile: data['userProfile'] as UserProfile,
            password: data['password'] as String,
          );
        },
      ),
      GoRoute(
        name: AppRoute.ProfessionalOtpWithEmailPage,
        path: '/${AppRoute.ProfessionalOtpWithEmailPage}',
        builder: (context, state) {
          var data = state.extra as Map<String, dynamic>;
          return ProfessionalOtpVerifyWithEmailPage(
            email: data['email'] as String,
            userProfile: data['userProfile'] as UserProfile,
            password: data['password'] as String,
          );
        },
      ),
      GoRoute(
        name: AppRoute.otpWithEmailPage,
        path: '/${AppRoute.otpWithEmailPage}',
        builder: (context, state) {
          var data = state.extra as Map<String, dynamic>;

          return OtpWithEmailPage(
            role: data['role'] as String,
            email: data['email'] as String,
          );
        },
      ),

      GoRoute(
        name: AppRoute.changePasswordPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: ChangePasswordPage()),
        path: '/${AppRoute.changePasswordPage}',
      ),
      GoRoute(
        name: AppRoute.allCatagoriesPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: AllCategoriesPage()),
        path: '/${AppRoute.allCatagoriesPage}',
      ),
      GoRoute(
        name: AppRoute.userBottomNavBar,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: UserBottomNavBar()),
        path: '/${AppRoute.userBottomNavBar}',
      ),

      GoRoute(
        name: AppRoute.sellerSignIn,
        builder: (context, state) {
          var data = state.extra as Map<String, dynamic>;
          return SellerSigninPage(
            role: data['role'] as String,
          );
        },
        path: '/${AppRoute.sellerSignIn}',
      ),
      GoRoute(
        name: AppRoute.sellerCreatePin,
        path: '/${AppRoute.sellerCreatePin}',
        builder: (context, state) {
          var data = state.extra as Map<String, dynamic>;
          return SellerCreatePinPage(
            email: data['email'] as String,
          );
        },
      ),

      GoRoute(
        name: AppRoute.sellerHomePage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: SellerHomePage()),
        path: '/${AppRoute.sellerHomePage}',
      ),
      GoRoute(
        name: AppRoute.searchEventsPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: FindEventsPage()),
        path: '/${AppRoute.searchEventsPage}',
      ),
      GoRoute(
        name: AppRoute.notificationsPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: NotificationPage()),
        path: '/${AppRoute.notificationsPage}',
      ),
      GoRoute(
        name: AppRoute.responsibleNotificationPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context,
            state: state,
            child: ResponsibleNotificationPage()),
        path: '/${AppRoute.responsibleNotificationPage}',
      ),
      GoRoute(
        name: AppRoute.termsConditionPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: TermsConditionPage()),
        path: '/${AppRoute.termsConditionPage}',
      ),
      GoRoute(
        name: AppRoute.contactUsPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: ContactUsPage()),
        path: '/${AppRoute.contactUsPage}',
      ),
      GoRoute(
        name: AppRoute.editProfilePage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: EditProfilePage()),
        path: '/${AppRoute.editProfilePage}',
      ),
      GoRoute(
        name: AppRoute.sellerQrPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: SellerQrPage()),
        path: '/${AppRoute.sellerQrPage}',
      ),
      GoRoute(
        name: AppRoute.sellerStockPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: SellerStockPage()),
        path: '/${AppRoute.sellerStockPage}',
      ),
      GoRoute(
        name: AppRoute.sellerCategoryPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: SellerCategoryPage()),
        path: '/${AppRoute.sellerCategoryPage}',
      ),
      GoRoute(
        name: AppRoute.sellerOrderPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: SellerAllOrderPage()),
        path: '/${AppRoute.sellerOrderPage}',
      ),
      GoRoute(
        name: AppRoute.transactionPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: TransactionPage()),
        path: '/${AppRoute.transactionPage}',
      ),
      //
      GoRoute(
        name: AppRoute.myCartPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: MyCartPage()),
        path: '/${AppRoute.myCartPage}',
      ),
      GoRoute(
        name: AppRoute.checkOutPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: CheckOutPage()),
        path: '/${AppRoute.checkOutPage}',
      ),
      GoRoute(
        name: AppRoute.payementMethodPage,
        pageBuilder: (context, state) {
          var data = state.extra as Map<String, dynamic>;
          return buildPageWithFadeTransition(
              context: context,
              state: state,
              child: PayementMethod(
                totalPrice: data['totalprice'],
              ));
        },
        path: '/${AppRoute.payementMethodPage}',
      ),
      GoRoute(
        name: AppRoute.addNewCardPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: AddNewCard()),
        path: '/${AppRoute.addNewCardPage}',
      ),
      GoRoute(
        name: AppRoute.trackOrderPage,
        builder: (context, state) {
          var data = state.extra as Map<String, dynamic>;
          return TrackOrder(
            orderList: data['orderList'] as OrderModel,
            oderStatus: data['orderStatus'] as String,
          );
        },

//         pageBuilder: (context, state) => buildPageWithFadeTransition(
//             context: context, state: state, child: TrackOrder(

// oderStatus: ,

//             )),
        path: '/${AppRoute.trackOrderPage}',
      ),
      GoRoute(
        name: AppRoute.myOrderPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: MyOrderPage()),
        path: '/${AppRoute.myOrderPage}',
      ),
      GoRoute(
        name: AppRoute.allOrderPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: AllOrdersPage()),
        path: '/${AppRoute.allOrderPage}',
      ),
      GoRoute(
        name: AppRoute.favouriteEventPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: FavoritesEventsPage()),
        path: '/${AppRoute.favouriteEventPage}',
      ),
      GoRoute(
        name: AppRoute.sellerBottomBar,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: SellerBottomBar()),
        path: '/${AppRoute.sellerBottomBar}',
      ),
      GoRoute(
        name: AppRoute.sellerSettingPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: SellerSettingPage()),
        path: '/${AppRoute.sellerSettingPage}',
      ),
      GoRoute(
        name: AppRoute.sellerProfilePage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: SellerProfilePage()),
        path: '/${AppRoute.sellerProfilePage}',
      ),
      GoRoute(
        name: AppRoute.sellerNotificationPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: SellerNotificationPage()),
        path: '/${AppRoute.sellerNotificationPage}',
      ),
      GoRoute(
        name: AppRoute.sellerContactUsPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: SellerContactUsPage()),
        path: '/${AppRoute.sellerContactUsPage}',
      ),
      GoRoute(
        name: AppRoute.sellerTermAndConditionPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context,
            state: state,
            child: SellerTermAndConditionPage()),
        path: '/${AppRoute.sellerTermAndConditionPage}',
      ),
      GoRoute(
        name: AppRoute.sellerFAQSPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: SellerFAQSPage()),
        path: '/${AppRoute.sellerFAQSPage}',
      ),
      GoRoute(
        name: AppRoute.sellerMaximumOrderPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: SellerMaximumOrderPage()),
        path: '/${AppRoute.sellerMaximumOrderPage}',
      ),
      GoRoute(
        name: AppRoute.searchPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: SearchPage()),
        path: '/${AppRoute.searchPage}',
      ),
      GoRoute(
        name: AppRoute.changePaymentMethodPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: ChangePaymentMethodPage()),
        path: '/${AppRoute.changePaymentMethodPage}',
      ),
      GoRoute(
        name: AppRoute.addPaymentPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: AddPaymentPage()),
        path: '/${AppRoute.addPaymentPage}',
      ),
      GoRoute(
        name: AppRoute.payemtCardsPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: PayemtCardsPage()),
        path: '/${AppRoute.payemtCardsPage}',
      ),
      GoRoute(
        name: AppRoute.cardDataPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: CardDataPage()),
        path: '/${AppRoute.cardDataPage}',
      ),
      GoRoute(
        name: AppRoute.cardPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: CardPage()),
        path: '/${AppRoute.cardPage}',
      ),
      GoRoute(
        name: AppRoute.moneyTransferPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: MoneyTransferPage()),
        path: '/${AppRoute.moneyTransferPage}',
      ),
      GoRoute(
        name: AppRoute.selectCardPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: SelectCardPage()),
        path: '/${AppRoute.selectCardPage}',
      ),
      GoRoute(
        name: AppRoute.responsibleHomePage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: ResponsibleHomePage()),
        path: '/${AppRoute.responsibleHomePage}',
      ),
      GoRoute(
        name: AppRoute.responsibleStock,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: ResponsibleStock()),
        path: '/${AppRoute.responsibleStock}',
      ),
      GoRoute(
        name: AppRoute.responsibleBottomBar,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: ResponsibleBottomBar()),
        path: '/${AppRoute.responsibleBottomBar}',
      ),
      GoRoute(
        name: AppRoute.allEventCatagories,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: AllEventCatagories()),
        path: '/${AppRoute.allEventCatagories}',
      ),
      GoRoute(
        path: '/${AppRoute.eventCatagoryDetailPage}',
        name: AppRoute.eventCatagoryDetailPage,
        builder: (context, state) {
          final category = state.extra as EventCategoryModel;
          return EventCatagoryDetailPage(category: category);
        },
      ),

      GoRoute(
        name: AppRoute.createFoodItemPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: CreateFoodItemPage()),
        path: '/${AppRoute.createFoodItemPage}',
      ),
      GoRoute(
        name: AppRoute.addEventCatagoryPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
            context: context, state: state, child: AddEventCatagoryPage()),
        path: '/${AppRoute.addEventCatagoryPage}',
      ),
      GoRoute(
        name: AppRoute.responsibleSupportRequestPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: ResponsibleSupportRequestPage(),
        ),
        path: '/${AppRoute.responsibleSupportRequestPage}',
      ),
      GoRoute(
        name: AppRoute.responsibleChatPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: ResponsibleChatPage(),
        ),
        path: '/${AppRoute.responsibleChatPage}',
      ),
      GoRoute(
        name: AppRoute.responsiblesignInPage,
        builder: (context, state) {
          return ResponsibleSignInPage();
        },
        path: '/${AppRoute.responsiblesignInPage}',
      ),
      GoRoute(
        name: AppRoute.responsiblesignUpPage,
        builder: (context, state) {
          return ResponsibleSignUpPage();
        },
        path: '/${AppRoute.responsiblesignUpPage}',
      ),
      GoRoute(
        name: AppRoute.otpDeleteUserProfile,
        builder: (context, state) {
          return OTPVerifyDeleteUserPage();
        },
        path: '/${AppRoute.otpDeleteUserProfile}',
      ),
      GoRoute(
        name: AppRoute.responsibleOtpCreateNewPin,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: ResponsibleCreateNewPinPage(
            email: state.extra as String,
          ),
        ),
        path: '/${AppRoute.responsibleOtpCreateNewPin}',
      ),
      GoRoute(
        name: AppRoute.responsibleManageAccount,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: ResponsibleManageAccountPage(),
        ),
        path: '/${AppRoute.responsibleManageAccount}',
      ),
      GoRoute(
        name: AppRoute.responsibleSalesReport,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: ResponsibleSalesReportPage(),
        ),
        path: '/${AppRoute.responsibleSalesReport}',
      ),
      GoRoute(
        name: AppRoute.responsibleProfilePage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: ResponsibleProfilePage(),
        ),
        path: '/${AppRoute.responsibleProfilePage}',
      ),
      GoRoute(
        name: AppRoute.addSellerAccount,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: AddSellerPage(),
        ),
        path: '/${AppRoute.addSellerAccount}',
      ),
      GoRoute(
        name: AppRoute.responsibleManageEventsPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: ManageEventsPage(event: state.extra as EventModel),
        ),
        path: '/${AppRoute.responsibleManageEventsPage}',
      ),
      GoRoute(
          name: AppRoute.editSellerPage,
          path: '/${AppRoute.editSellerPage}',
          pageBuilder: (context, state) {
            var data = state.extra as Map<String, dynamic>;

            return buildPageWithFadeTransition(
              context: context,
              state: state,
              child: EditSellerPage(
                userProfessionalModel: data['userProfessionalModel'],
              ),
            );
          }),
      GoRoute(
        name: AppRoute.responsibleOrderPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: ResponsibleAllOrderPage(),
        ),
        path: '/${AppRoute.responsibleOrderPage}',
      ),
      GoRoute(
        name: AppRoute.addEventsPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: AddEventPage(),
        ),
        path: '/${AppRoute.addEventsPage}',
      ),
      GoRoute(
        name: AppRoute.selectBankTransfer,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: SelectBankTransfer(),
        ),
        path: '/${AppRoute.selectBankTransfer}',
      ),

      GoRoute(
        name: AppRoute.topUpSimCardPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: TopUpSimCardPage(),
        ),
        path: '/${AppRoute.topUpSimCardPage}',
      ),

      GoRoute(
        name: AppRoute.topUpAmountPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: TopUpAmountPage(),
        ),
        path: '/${AppRoute.topUpAmountPage}',
      ),
      GoRoute(
        name: AppRoute.selectSimCardServicPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: SelectSimCardServicPage(),
        ),
        path: '/${AppRoute.selectSimCardServicPage}',
      ),

      GoRoute(
        name: AppRoute.transferMoneyVerifiedNumberPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: TransferMoneyVerifiedNumberPage(),
        ),
        path: '/${AppRoute.transferMoneyVerifiedNumberPage}',
      ),
      GoRoute(
        name: AppRoute.userProfilePage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: ProfilePage(),
        ),
        path: '/${AppRoute.userProfilePage}',
      ),
      //
      GoRoute(
        name: AppRoute.responsibleChangePasswordPage,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          final email = data['email'] as String;
          final token = data['token'] as String;
          return ResponsibleChangePasswordPage(
            email: email,
            token: token,
          );
        },
        path: '/${AppRoute.responsibleChangePasswordPage}',
      ),
      GoRoute(
        name: AppRoute.responsibleotpVerificationEmailPage,
        builder: (context, state) {
          return ResponsibleOtpEmailPage(
            email: state.extra as String,
          );
        },
        path: '/${AppRoute.responsibleotpVerificationEmailPage}',
      ),
      GoRoute(
        name: AppRoute.responsiblOtpWithPhone,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: ResponsibleOtpPhone(),
        ),
        path: '/${AppRoute.responsiblOtpWithPhone}',
      ),
      GoRoute(
        name: AppRoute.responsibleforgotPasswordPage,
        builder: (context, state) {
          return ReponsibleForgotPasswordPage();
        },
        path: '/${AppRoute.responsibleforgotPasswordPage}',
      ),
      GoRoute(
        name: AppRoute.responsibleUpdateCategoryPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: ResponsibleUpdateCategoryPage(
              category: state.extra as EventCategoryModel),
        ),
        path: '/${AppRoute.responsibleUpdateCategoryPage}',
      ),
      GoRoute(
        name: AppRoute.addFoodCatagoryPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: AddFoodCatagoryPage(),
        ),
        path: '/${AppRoute.addFoodCatagoryPage}',
      ),
      GoRoute(
        name: AppRoute.allFoodCatagoriesPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: AllFoodCatagoriesPage(),
        ),
        path: '/${AppRoute.allFoodCatagoriesPage}',
      ),
      GoRoute(
        name: AppRoute.inbox,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: InboxPage(),
        ),
        path: '/${AppRoute.inbox}',
      ),
      GoRoute(
        name: AppRoute.allCoupon,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: SellerCoupanPage(),
        ),
        path: '/${AppRoute.allCoupon}',
      ),
      GoRoute(
        name: AppRoute.createCoupon,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: SellerCreateCoupanPage(),
        ),
        path: '/${AppRoute.createCoupon}',
      ),
      GoRoute(
        name: AppRoute.foodCatagoryDetailPage,
        builder: (context, state) {
          final foodcategory = state.extra as FoodCatagoryModel;
          return FoodCatagoryDetailPage(foodcategory: foodcategory);
        },
        path: '/${AppRoute.foodCatagoryDetailPage}',
      ),
      GoRoute(
        name: AppRoute.updateFoodCatagoryPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: UpdateFoodCatagoryPage(
              foodcatagory: state.extra as FoodCatagoryModel),
        ),
        path: '/${AppRoute.updateFoodCatagoryPage}',
      ),
      GoRoute(
        name: AppRoute.editFoodItemPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: EditFoodItemPage(foodItem: state.extra as FoodItemModel),
        ),
        path: '/${AppRoute.editFoodItemPage}',
      ),
      GoRoute(
        name: AppRoute.foodItemDetailPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: FoodItemDetailPage(fooditem: state.extra as FoodItemModel),
        ),
        path: '/${AppRoute.foodItemDetailPage}',
      ),
      GoRoute(
        name: AppRoute.allEventsPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: AllEventPage(),
        ),
        path: '/${AppRoute.allEventsPage}',
      ),
      GoRoute(
        name: AppRoute.eventsDetailPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: EventDetailsPage(
            eventModel: state.extra as EventModel,
          ),
        ),
        path: '/${AppRoute.eventsDetailPage}',
      ),
      GoRoute(
        name: AppRoute.createSellerBankAccount,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: CreateSellerBankAccount(),
        ),
        path: '/${AppRoute.createSellerBankAccount}',
      ),
      GoRoute(
        name: AppRoute.createDeliveryCharges,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: DeliveryChargesPage(),
        ),
        path: '/${AppRoute.createDeliveryCharges}',
      ),
      GoRoute(
        name: AppRoute.allDeliveryCharges,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: AllDeliveryChargesPage(),
        ),
        path: '/${AppRoute.allDeliveryCharges}',
      ),
      GoRoute(
        name: AppRoute.userContactUsPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: UserContactUsPage(),
        ),
        path: '/${AppRoute.userContactUsPage}',
      ),
      GoRoute(
        name: AppRoute.sellerForgotPassword,
        builder: (context, state) {
          var data = state.extra as Map<String, dynamic>;

          return SellerForgotPasswordPage(
            email: data['email'] as String,
            role: data['role'] as String,
          );
        },
        path: '/${AppRoute.sellerForgotPassword}',
      ),
      GoRoute(
        name: AppRoute.sellerSendOtpWithEmail,
        builder: (context, state) {
          var data = state.extra as Map<String, dynamic>;

          return SellerOtpWithEmailPage(
            role: data['role'] as String,
            email: data['email'] as String,
          );
        },
        path: '/${AppRoute.sellerSendOtpWithEmail}',
      ),
      GoRoute(
        name: AppRoute.sellerResetPassword,
        builder: (context, state) {
          var data = state.extra as Map<String, dynamic>;

          return SellerResetPasswordPage(
            role: data['role'] as String,
            email: data['email'] as String,
            token: data['token'] as String,
          );
        },
        path: '/${AppRoute.sellerResetPassword}',
      ),

      GoRoute(
        name: AppRoute.userChat,
        pageBuilder: (context, state) {
          var data = state.extra as Map<String, dynamic>;
          return buildPageWithFadeTransition(
            context: context,
            state: state,
            child: UserChatPage(
              chatRoomID: data['id'],
              reciverName: data['reciverName'],
            ),
          );
        },
        path: '/${AppRoute.userChat}',
      ),

      GoRoute(
        name: AppRoute.googleMapPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: GoogleMapPage(),
        ),
        path: '/${AppRoute.googleMapPage}',
      ),
      GoRoute(
        name: AppRoute.allEventsPages,
        builder: (context, state) {
          var data = state.extra as Map<String, dynamic>;
          return AllEventsDisplayPage(
            title: data['title'] as String,
            events: data["events"] as List<EventModel>,
          );
        },
        path: '/${AppRoute.allEventsPages}',
      ),
      GoRoute(
        name: AppRoute.sellerChangePasswordPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: SellerChangePasswordPage(),
        ),
        path: '/${AppRoute.sellerChangePasswordPage}',
      ),
      GoRoute(
        name: AppRoute.responsibleChangePassword,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: ResponsibleChangePassword(),
        ),
        path: '/${AppRoute.responsibleChangePassword}',
      ),
      GoRoute(
        name: AppRoute.editResponsibleProfile,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: ResponsibleEditProfilePage(),
        ),
        path: '/${AppRoute.editResponsibleProfile}',
      ),
      GoRoute(
        name: AppRoute.changeEmailPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: EmailChangePage(),
        ),
        path: '/${AppRoute.changeEmailPage}',
      ),
      GoRoute(
        name: AppRoute.changeEmailOtpVerifyPage,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: EmailChangeVerifyOtpPage(),
        ),
        path: '/${AppRoute.changeEmailOtpVerifyPage}',
      ),
      GoRoute(
        name: AppRoute.responsibleUpdateAccount,
        pageBuilder: (context, state) => buildPageWithFadeTransition(
          context: context,
          state: state,
          child: ResponsibleUpdateAccountPage(),
        ),
        path: '/${AppRoute.responsibleUpdateAccount}',
      ),
      GoRoute(
          name: AppRoute.professionalOtpWithPhonePage,
          path: '/${AppRoute.professionalOtpWithPhonePage}',
          builder: (context, state) {
            var data = state.extra as Map<String, dynamic>;
            return ProfessionalOtpVerifyWithPhonePage(
              email: data['email'] as String,
              userProfile: data['userProfile'] as UserProfile,
              password: data['password'] as String,
            );
          }),
      GoRoute(
        name: AppRoute.specificEventDetailPage,
        path: '/${AppRoute.specificEventDetailPage}',
        pageBuilder: (context, state) {
          return buildPageWithFadeTransition(
              context: context,
              state: state,
              child: SpecificEventDetailPage(id: state.extra as int));
        },
      ),

      GoRoute(
        name: AppRoute.specificFoodCatagoryFoodItems,
        path: '/${AppRoute.specificFoodCatagoryFoodItems}',
        pageBuilder: (context, state) {
          return buildPageWithFadeTransition(
            context: context,
            state: state,
            child: SpecificCatagoryFoodItems(id: state.extra as int),
          );
        },
      ),
      GoRoute(
        name: AppRoute.salaryCard,
        path: '/${AppRoute.salaryCard}',
        pageBuilder: (context, state) {
          return buildPageWithFadeTransition(
            context: context,
            state: state,
            child: SalaryCard(),
          );
        },
      ),
      GoRoute(
        name: AppRoute.allFoodListPage,
        path: '/${AppRoute.allFoodListPage}',
        pageBuilder: (context, state) {
          return buildPageWithFadeTransition(
            context: context,
            state: state,
            child: AllFoodListPage(),
          );
        },
      ),
      GoRoute(
        name: AppRoute.withDrawPayement,
        path: '/${AppRoute.withDrawPayement}',
        pageBuilder: (context, state) {
          return buildPageWithFadeTransition(
            context: context,
            state: state,
            child: WithdrawPayementPage(amount: state.extra as int),
          );
        },
      ),

      GoRoute(
        name: AppRoute.userQrScanPage,
        path: '/${AppRoute.userQrScanPage}',
        pageBuilder: (context, state) {
          return buildPageWithFadeTransition(
            context: context,
            state: state,
            child: UserQrScanPage(),
          );
        },
      ),
      GoRoute(
        name: AppRoute.responsibleSearchScreens,
        path: '/${AppRoute.responsibleSearchScreens}',
        pageBuilder: (context, state) {
          return buildPageWithFadeTransition(
            context: context,
            state: state,
            child: ResponsibleSearchScreens(),
          );
        },
      ),
      GoRoute(
        name: AppRoute.responsibleCreatePin,
        path: '/${AppRoute.responsibleCreatePin}',
        pageBuilder: (context, state) {
          return buildPageWithFadeTransition(
            context: context,
            state: state,
            child: ResponsibleCreatePin(),
          );
        },
      ),
      GoRoute(
        name: AppRoute.responsibleLogInPin,
        path: '/${AppRoute.responsibleLogInPin}',
        pageBuilder: (context, state) {
          return buildPageWithFadeTransition(
            context: context,
            state: state,
            child: ResponsibleLogInPin(),
          );
        },
      ),
      GoRoute(
        name: AppRoute.createStripeAccount,
        path: '/${AppRoute.createStripeAccount}',
        pageBuilder: (context, state) {
          return buildPageWithFadeTransition(
            context: context,
            state: state,
            child: CreateStripeAccount(),
          );
        },
      ),
      GoRoute(
        name: AppRoute.responsibleNotification,
        path: '/${AppRoute.responsibleNotification}',
        pageBuilder: (context, state) {
          return buildPageWithFadeTransition(
            context: context,
            state: state,
            child: ResponsibleNotification(),
          );
        },
      )
    ],
    errorPageBuilder: (context, state) {
      return const MaterialPage(child: ErrorPage());
    },
  );

  static void clearAndNavigate(BuildContext context, String name) {
    while (context.canPop()) {
      context.pop();
    }
    context.pushReplacementNamed(name);
  }
}

class AppRoute {
  static const String errorPage = 'error-page';
  static const String splashScreen = 'splash-screen';

  static const String sigInMethodSelectionPage = 'sigInMethodSelectionPage';

  //! ###################### RESPOSIBLE ##########################
  // ------------------------ AUTH ------------------------------
  static const String responsiblesignInPage = 'responsiblesignInPage';
  static const String responsiblesignUpPage = 'responsiblesignUpPage';
  static const String responsibleOtpCreateNewPin = 'responsibleOtpCreateNewPin';
  static const String responsibleforgotPasswordPage =
      'responsibleforgotPasswordPage';
  static const String otpVerificationEmailPage = 'otpVerificationEmailPage';
  static const String responsibleotpVerificationEmailPage =
      'responsibleotpVerificationEmailPage';
  static const String responsibleChangePasswordPage =
      'responsibleChangePasswordPage';

  // get Started Page
  static const String getStartedPage = 'getStartedPage';
  static const String roleSelectionPage = 'roleSelectionPage';
  static const String chooseLanguagePage = 'chooseLanguagePage';
  static const String responsibleChooseLanguagePage =
      'responsibleChooseLanguagePage';
  static const String sellerChooseLanguagePage = 'sellerChooseLanguagePage';
  //User auth section

  static const String signInPage = 'signin-page';
  static const String responsibleNotification = 'responsible-Notification';

  static const String signUpPage = 'signUpPage';
  static const String otpVerificationPhonePage = 'otpVerificationPhonePage';
  static const String forgotPasswordPage = 'forgotPasswordPage';
  static const String otpWithEmailPage = 'otpWithEmailPage';

  static const String resetPasswordPage = 'resetPasswordPage';
  static const String selectSignUpMethod = 'selectSignUpMethod';

  //Professional Register section
  static const String professionalSigInMethodSelectionPage =
      'professionalSigInMethodSelectionPage';
  static const String ProfessionalSignUpPage = 'ProfessionalSignUpPage';
  static const String ProfessionalOtpWithEmailPage =
      'ProfessionalOtpWithEmailPage';
  static const String professionalOtpWithPhonePage =
      'professionalOtpWithPhonePage';
  static const String responsibleUpdateAccount = 'responsibleUpdateAccount';

  /// bottom Nav bar
  static const String userBottomNavBar = 'userBottomNavBar';
  static const String userProfilePage = 'userProfilePage';

  ///home
  static const String allCatagoriesPage = 'allCatagoriesPage';

  //_______________________Seller routes
  static const String sellerGetStarted = 'sellerGetStarted';
  static const String sellerSignIn = 'sellerSignIn';
  static const String sellerCreatePin = 'sellerCreatePin';
  static const String sellerCreatePassword = 'sellerCreatePassword';
  static const String sellerHomePage = 'sellerHomePage';
  static const String sellerChangePasswordPage = 'sellerChangePasswordPage';

  ///home
  static const String favouriteEventPage = 'favouriteEventPage';
  static const String searchPage = 'searchPage';
  static const String allFoodListPage = 'All-Food-List-Page';

  static const String allEventsPages = 'allEventsPages';
  static const String userQrScanPage = 'user-Qr-Scan-Page';

  static const String specificEventDetailPage = 'specificEventDetailPage';
  // search pages
  static const String searchEventsPage = 'searchEventsPage';

  // profile

  static const String notificationsPage = 'notificationsPage';
  static const String responsibleNotificationPage =
      'responsibleNotificationPage';

  static const String termsConditionPage = 'termsConditionPage';
  static const String inbox = 'inbox';
  static const String contactUsPage = 'contactUsPage';
  static const String editProfilePage = 'editProfilePage';
  static const String transactionPage = 'transactionPage';
  static const String changePasswordPage = 'changePasswordPage';
  static const String otpDeleteUserProfile = 'otpDeleteUserProfile';
//seller

  static const String sellerQrPage = 'sellerQrPage';
  static const String sellerStockPage = 'sellerStockPage';
  static const String sellerCategoryPage = 'sellerCategoryPage';
  static const String sellerOrderPage = 'sellerOrderPage';
  // seller Account
  static const String createSellerBankAccount = 'createSellerBankAccount';
  static const String salaryCard = 'salaryCard';
  static const String withDrawPayement = 'withDrawPayement';
  static const String responsibleSearchScreens = 'ResponsibleSearchScreens';

  // calender
  static const String myCartPage = 'myCartPage';
  static const String userContactUsPage = 'userContactUsPage';
  static const String payementMethodPage = 'payementMethodPage';
  static const String addNewCardPage = 'addNewCardPage';
  static const String trackOrderPage = 'track-Order-Page';
  static const String myOrderPage = 'myOrderPage';
  static const String allOrderPage = 'allOrderPage';
  static const String checkOutPage = 'checkOutPage';
  static const String sellerProfilePage = 'sellerProfilePage';
  static const String sellerBottomBar = 'sellerBottomBar';
  static const String sellerSettingPage = 'sellerSettingPage';
  static const String sellerNotificationPage = 'sellerNotificationPage';
  static const String sellerContactUsPage = 'sellerContactUsPage';
  static const String sellerTermAndConditionPage = 'sellerTermAndConditionPage';
  static const String sellerFAQSPage = 'sellerFAQSPage';
  static const String sellerMaximumOrderPage = 'sellerMaximumOrderPage';
  static const String changePaymentMethodPage = 'changePaymentMethodPage';
  static const String addPaymentPage = 'addPaymentPage';
  static const String payemtCardsPage = 'payemtCardsPage';
  static const String cardDataPage = 'cardDataPage';
  static const String cardPage = 'cardPage';
  static const String moneyTransferPage = 'moneyTransferPage';
  static const String selectCardPage = 'selectCardPage';
  static const String productDetailPage = 'productDetailPage';
  //Responsible
  static const String editResponsibleProfile = 'editResponsibleProfile';
  static const String responsibleHomePage = 'responsible-home-page';
  static const String responsibleStock = 'responsible-stock';
  static const String responsibleBottomBar = 'responsible-bottom-bar';
  static const String responsibleChangePassword = 'responsibleChangePassword';
  //Event catagories
  static const String allEventCatagories = 'allEventCatagories';
  static const String eventCatagoryDetailPage = 'eventCatagoryDetailPage';
  static const String responsibleUpdateCategoryPage =
      'responsible-update-category_page';
  static const String addEventCatagoryPage = 'addEventCatagoryPage';
  //Food Item
  static const String createFoodItemPage = 'createFoodItemPage';
  static const String editFoodItemPage = 'editFoodItemPage';
  static const String foodItemDetailPage = 'foodItemDetailPage';
  static const String specificFoodCatagoryFoodItems =
      'specificFoodCatagoryFoodItems';
// support Request
  static const String responsibleSupportRequestPage =
      'responsible-support-request-page';
  static const String responsibleChatPage = 'responsible-chat_page';
  static const String responsibleOrderPage = 'responsibleOrderPage';
  // responsible auth section

  static const String responsiblOtpWithPhone = 'responsiblOtpWithPhone';

  static const String responsiblechangePasswordPage = 'changePasswordPage';
  static const String changeEmailPage = 'changeEmailPage';
  static const String changeEmailOtpVerifyPage = 'changeEmailOtpVerifyPage';

  // events
  static const addEventsPage = 'addEventsPage';
  static const allEventsPage = 'allEventsPage';
  static const eventsDetailPage = 'eventsDetailPage';
  // add food catagory
  static const addFoodCatagoryPage = 'addFoodCatagoryPage';
  static const allFoodCatagoriesPage = 'allFoodCatagoriesPage';
  static const foodCatagoryDetailPage = 'foodCatagoryDetailPage';
  static const updateFoodCatagoryPage = 'updateFoodCatagoryPage';
// responsible profile section
  static const responsibleProfilePage = 'responsibleProfilePage';
  static const responsibleManageAccount = 'responsibleManageAccount';
  static const responsibleSalesReport = 'responsibleSalesReport';
  static const responsibleManageEventsPage = 'responsibleManageEventsPage';
  static const addSellerAccount = 'addSellerAccount';
  static const editSellerPage = 'editSellerPage';

  static const selectBankTransfer = 'selectBankTransfer';
  static const topUpSimCardPage = 'topUpSimCardPage';
  static const topUpAmountPage = 'topUpAmountPage';
  static const selectSimCardServicPage = 'selectSimCardServicPage';
  static const transferMoneyVerifiedNumberPage =
      'transferMoneyVerifiedNumberPage';

  static const allCoupon = 'all-coupan';
  static const createCoupon = 'create-coupan';
  static const userChat = 'user-chat';

  static const createDeliveryCharges = 'createDeliveryCharges';
  static const allDeliveryCharges = 'all-Delivery-Charges';
  static const demoPage = 'demo-page';

  //seller forgot password
  static const sellerForgotPassword = 'sellerForgotPassword';
  static const sellerSendOtpWithEmail = 'sellerSendOtpWithEmail';
  static const sellerResetPassword = 'sellerResetPassword';
  static const responsibleCreatePin = 'responsible-Create-Pin';
  static const responsibleLogInPin = 'Responsible-LogIn-Pin';
  static const createStripeAccount = 'Create-Stripe-Account';

  /// google map
  static const googleMapPage = 'googleMapPage';
}
