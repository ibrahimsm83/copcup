import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/features/seller/home/pages/seller_home_page.dart';
import 'package:flutter_application_copcup/src/features/seller/home/pages/seller_stock_page.dart';
import 'package:flutter_application_copcup/src/features/seller/home/provider/seller_home_provider.dart';
import 'package:flutter_application_copcup/src/features/seller/qr/seller_qr_scanner.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_bottom_nav_bar/widget/bottom_bar_widget.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_order/pages/seller_all_order_page.dart';
import 'package:flutter_application_copcup/src/features/seller/setting/pages/seller_setting_page.dart';
import 'package:flutter_application_copcup/src/features/seller/setting/widget/notification_card.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart'; 
import 'package:provider/provider.dart';

class SellerNotificationPage extends StatelessWidget {
  SellerNotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SellerBottomBarWidget(),
      body: Consumer<SellerHomeProvider>(
          builder: (context, value, child) => pages[value.currentIndex]),
    );
  }

  List<Widget> pages = [
    SellerHomePage(),
    SellerStockPage(),
    SellerQrScanPage(),
    SellerAllOrderPage(),
    Consumer<SellerHomeProvider>(
        builder: (context, value, child) => value.sellerNatificationBool
            ? SellerNotificationWidget()
            : SellerSettingPage()),
  ];
}

class SellerNotificationWidget extends StatelessWidget {
  const SellerNotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: Icon(Icons.arrow_back)),
              Text(
                AppLocalizations.of(context)!.notificationTitle,
                style: textTheme(context).headlineSmall?.copyWith(
                      fontSize: 21,
                      color: colorScheme(context).onSurface,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SizedBox(
                width: 20,
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppLocalizations.of(context)!.todayLabel,
              style: textTheme(context)
                  .titleMedium
                  ?.copyWith(color: colorScheme(context).onSurface),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          NotificationCard(
              iconImage: AppIcons.sellerDiscount,
              title: '30% Special Discount',
              subTitle: 'Special Discount valid today'),
          SizedBox(
            height: 15,
          ),
          NotificationCard(
              iconImage: AppIcons.lockIcon,
              title: 'Password Updated',
              subTitle: 'Your password Updated successfuly'),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              AppLocalizations.of(context)!.yesterdayLabel,
              style: textTheme(context)
                  .titleMedium
                  ?.copyWith(color: colorScheme(context).onSurface),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          NotificationCard(
              imageSize: 25,
              iconImage: AppIcons.sellerSetup,
              title: 'Account Setup Successfully',
              subTitle: 'Account has been set'),
          SizedBox(
            height: 10,
          ),
          NotificationCard(
              imageSize: 25,
              iconImage: AppIcons.sellerNotificationProfile,
              title: 'Debit Card Added Successfully',
              subTitle: 'Card has been added successfully'),
        ],
      ),
    );
  }
}
