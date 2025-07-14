import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/features/app_localiztion/provider/app_language_provider.dart';
import 'package:flutter_application_copcup/src/features/seller/home/pages/seller_home_page.dart';
import 'package:flutter_application_copcup/src/features/seller/home/pages/seller_stock_page.dart';
import 'package:flutter_application_copcup/src/features/seller/qr/seller_qr_scanner.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_bottom_nav_bar/widget/bottom_bar_widget.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_order/pages/seller_all_order_page.dart';
import 'package:flutter_application_copcup/src/features/seller/setting/pages/seller_setting_page.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../common/widgets/custom_buton.dart';
import '../../home/provider/seller_home_provider.dart';

class SellerChooseLanguagePage extends StatefulWidget {
  const SellerChooseLanguagePage({super.key});

  @override
  State<SellerChooseLanguagePage> createState() =>
      SellerChooseLanguagePageState();
}

class SellerChooseLanguagePageState extends State<SellerChooseLanguagePage> {
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
        builder: (context, value, child) => value.sellerApplanguageBool
            ? SellerApplanguageWidget()
            : SellerSettingPage()),
  ];
}

class SellerApplanguageWidget extends StatelessWidget {
  SellerApplanguageWidget({super.key});

  @override
  final List<Map<String, String>> languages = [
    {'code': 'en', 'name': 'English (US)', 'flag': AppImages.usFlag},
    {'code': 'fr', 'name': 'French (FR)', 'flag': AppImages.franceFlag},
  ];
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final appLanguageNotifier = Provider.of<AppLanguageNotifier>(context);
    return Padding(
      padding: const EdgeInsets.all(19.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: Icon(Icons.arrow_back)),
              Text(
                'App Language',
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
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: languages.length,
              itemBuilder: (context, index) {
                final language = languages[index];
                final isSelected =
                    appLanguageNotifier.locale.languageCode == language['code'];

                return GestureDetector(
                  onTap: () {
                    appLanguageNotifier.changeLanguage(
                      Locale(language['code']!),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    padding: const EdgeInsets.all(23.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected
                            ? colorScheme(context).secondary
                            : Colors.transparent,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: size.height * 0.05,
                          width: size.width * 0.11,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              image: AssetImage(language['flag']!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            language['name']!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: isSelected
                                  ? Theme.of(context).primaryColor
                                  : Colors.black,
                            ),
                          ),
                        ),
                        if (isSelected)
                          Icon(Icons.check,
                              color: colorScheme(context).secondary),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          CustomButton(
            iconColor: colorScheme(context).secondary,
            arrowCircleColor: colorScheme(context).surface,
            text: 'Select Language',
            backgroundColor: colorScheme(context).secondary,
            onPressed: () {
              if (appLanguageNotifier.locale.languageCode.isNotEmpty) {
                context.pushNamed(AppRoute.sellerBottomBar);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Please select a language'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
