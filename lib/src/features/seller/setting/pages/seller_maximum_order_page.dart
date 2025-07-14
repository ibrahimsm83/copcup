import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_textfield.dart';
import 'package:flutter_application_copcup/src/features/seller/home/pages/seller_home_page.dart';
import 'package:flutter_application_copcup/src/features/seller/home/pages/seller_stock_page.dart';
import 'package:flutter_application_copcup/src/features/seller/qr/seller_qr_scanner.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_bottom_nav_bar/widget/bottom_bar_widget.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_order/pages/seller_all_order_page.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_order/provider/seller_order_provider.dart';
import 'package:flutter_application_copcup/src/features/seller/setting/pages/seller_setting_page.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../responsible/add_seller/seller_auth_controller/seller_auth_controller.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
import '../../home/provider/seller_home_provider.dart';

class SellerMaximumOrderPage extends StatefulWidget {
  const SellerMaximumOrderPage({super.key});

  @override
  State<SellerMaximumOrderPage> createState() => _SellerMaximumOrderPageState();
}

class _SellerMaximumOrderPageState extends State<SellerMaximumOrderPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
        builder: (context, value, child) => value.sellerOrderLimitBool
            ? SellermaximumOrderLimitWidget()
            : SellerSettingPage()),
  ];
}

class SellermaximumOrderLimitWidget extends StatelessWidget {
  SellermaximumOrderLimitWidget({super.key});

  @override
  TextEditingController orderLimitController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final SellerAuthController sellerAuthController = SellerAuthController();
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Form(
        key: _formKey,
        child: Consumer<SellerAuthController>(
            builder: (context, sellerData, child) {
          log(sellerData.seller.toString());
          log('${StaticData.userId}');

          final user = sellerData.seller;
          log(user.toString());
          log(user?.image.toString() ?? '');
          if (user == null) {
            return Center(child: CircularProgressIndicator());
          }
          return Column(
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
                    AppLocalizations.of(context)!.na_maximumOrderLimit,
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
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                      AppLocalizations.of(context)!.set_up_maximum_orders_limit,
                      style: textTheme(context).labelLarge?.copyWith(
                          color: AppColor.appGreyColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          letterSpacing: 0)),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    AppLocalizations.of(context)!.orders_limit,
                    style: textTheme(context).titleSmall?.copyWith(
                        color: colorScheme(context).onSurface,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'please enter limit';
                  }
                  return null;
                },
                borderRadius: 12,
                hint: 'Enter Order limit',
                keyboardType: TextInputType.number,
                hintColor: AppColor.appGreyColor.withOpacity(.7),
                controller: orderLimitController,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                borderColor: AppColor.appGreyColor.withOpacity(.15),
                focusBorderColor: AppColor.appGreyColor.withOpacity(.15),
                fillColor: colorScheme(context).surface,
                filled: true,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 70,
              ),
              Consumer<SellerOrderProvider>(
                builder: (context, provider, child) => CustomButton(
                  text: AppLocalizations.of(context)!.save,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final String limit = orderLimitController.text.trim();

                      provider.orderLimit(
                        context: context,
                        eventId: 4,
                        orderLimit: int.parse(limit),
                      );
                    }
                  },
                  boxShadow: [
                    BoxShadow(
                        color: colorScheme(context).onSurface.withOpacity(.3),
                        offset: Offset(1, 2),
                        blurRadius: 8)
                  ],
                  backgroundColor: colorScheme(context).secondary,
                  arrowCircleColor: colorScheme(context).surface,
                  iconColor: colorScheme(context).secondary,
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
