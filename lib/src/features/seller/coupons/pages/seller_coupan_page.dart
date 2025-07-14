import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/provider/responsible_bottom_bar.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/widget/responsible_bottom-bar_widget.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/pages/responsible_home_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/pages/responsible_stock.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_order/pages/responsible_all_order_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_profile/pages/responsible_profile_page.dart';
import 'package:flutter_application_copcup/src/features/seller/coupons/controller/coupon_controller.dart';
import 'package:flutter_application_copcup/src/features/user/chat/pages/inbox_page.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
class SellerCoupanPage extends StatefulWidget {
  const SellerCoupanPage({super.key});

  @override
  State<SellerCoupanPage> createState() => _SellerCoupanPageState();
}

class _SellerCoupanPageState extends State<SellerCoupanPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<CouponController>(context, listen: false);
      provider.getAllCouponsOfSeller(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ResponsibleBottomBarWidget(),
      body: Consumer<ResponsibleHomeProvider>(
          builder: (context, value, child) => pages[value.currentIndex]),
    );
  }

  List<Widget> pages = [
    ResponsibleHomePage(),
    ResponsibleStock(),
    InboxPage(),
    Consumer<ResponsibleHomeProvider>(
        builder: (context, value, child) => value.resCoupon
            ? SellerAllCouponWidget()
            : ResponsibleProfilePage()),
  ];
}

class SellerAllCouponWidget extends StatefulWidget {
  const SellerAllCouponWidget({super.key});

  @override
  State<SellerAllCouponWidget> createState() => _SellerAllCouponWidgetState();
}

class _SellerAllCouponWidgetState extends State<SellerAllCouponWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ResponsibleHomeProvider>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
                  AppLocalizations.of(context)!.all_coupons,
                  style: textTheme(context).headlineSmall?.copyWith(
                        fontSize: 21,
                        color: colorScheme(context).onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                GestureDetector(
                    onTap: () {
                      provider.updateResponsibleBool(true);
                      context.pushNamed(AppRoute.createCoupon);
                    },
                    child: Icon(Icons.add_circle_outline))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Consumer<CouponController>(
              builder: (context, provider, child) {
                var m = MediaQuery.of(context).size;
                if (provider.isCouponLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final data = provider.couponsList;

                if (data.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.only(top: m.height * 0.4),
                    child: Center(
                      child:
                          Text(AppLocalizations.of(context)!.no_coupon_found),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: data.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final coupon = data[index];
                    return Container(
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 2,
                            spreadRadius: 1),
                      ]),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey.shade500,
                          child: Text(coupon.id.toString()),
                        ),
                        title: Text(
                          coupon.code,
                          style: textTheme(context)
                              .titleSmall!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Valid from:",
                                  style: textTheme(context)
                                      .labelMedium!
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  DateFormat("yyyy-MM-dd")
                                      .format(coupon.validFrom),
                                  style: textTheme(context)
                                      .labelMedium!
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Valid until:",
                                  style: textTheme(context)
                                      .labelMedium!
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  DateFormat("yyyy-MM-dd")
                                      .format(coupon.validUntil),
                                  style: textTheme(context)
                                      .labelMedium!
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                              ],
                            )
                          ],
                        ),
                        trailing: Column(
                          children: [
                            Text(
                              "${coupon.discountAmount.toStringAsFixed(1)} €",
                              style: textTheme(context).titleMedium,
                            ),
                            Text(
                              "${coupon.discountPercentage.toStringAsFixed(0)}%",
                              style: textTheme(context).labelMedium,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
