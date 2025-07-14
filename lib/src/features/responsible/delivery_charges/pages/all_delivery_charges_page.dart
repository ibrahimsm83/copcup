import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/app_bar/app_bar.dart';
import 'package:flutter_application_copcup/src/features/responsible/delivery_charges/controller/delivery_charges_controller.dart';
import 'package:flutter_application_copcup/src/features/responsible/professional_qr/professional_qr_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/provider/responsible_bottom_bar.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/widget/responsible_bottom-bar_widget.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/pages/responsible_home_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/pages/responsible_stock.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_profile/pages/responsible_profile_page.dart';
import 'package:flutter_application_copcup/src/features/user/chat/pages/inbox_page.dart';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
class AllDeliveryChargesPage extends StatefulWidget {
  const AllDeliveryChargesPage({super.key});

  @override
  State<AllDeliveryChargesPage> createState() => _AllDeliveryChargesPageState();
}

class _AllDeliveryChargesPageState extends State<AllDeliveryChargesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getDelieveryCharges(context);
    });
  }

  getDelieveryCharges(BuildContext context) async {
    final provider =
        Provider.of<DeliveryChargesController>(context, listen: false);
    await provider.getDeliveryCharges(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ResponsibleBottomBarWidget(),
      body: Consumer<ResponsibleHomeProvider>(
        builder: (context, value, child) => page[value.currentIndex],
      ),
    );
  }

  List<Widget> page = [
    ResponsibleHomePage(),
    ResponsibleStock(),
    InboxPage(),
    Consumer<ResponsibleHomeProvider>(
        builder: (context, value, child) => value.resAllDelivery
            ? ResponsibleAllDeliveryChargesWidget()
            : ResponsibleProfilePage()),
  ];
}

class ResponsibleAllDeliveryChargesWidget extends StatelessWidget {
  const ResponsibleAllDeliveryChargesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(
            height: 10,
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
                AppLocalizations.of(context)!.all_delivery_charges,
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
          Consumer<DeliveryChargesController>(
              builder: (context, provider, child) {
            if (provider.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              itemCount: provider.deliveryChargesList.length,
              itemBuilder: (context, index) {
                final deliverycharges = provider.deliveryChargesList[index];
                if (provider.deliveryChargesList.isEmpty) {
                  return Center(
                    child: Text("No Delivery Charges Found"),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        height: size.height * 0.2,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Seller Id",
                                  style: textTheme(context).bodySmall?.copyWith(
                                      color: colorScheme(context).secondary),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  deliverycharges.sellerId.toString(),
                                  style: textTheme(context).bodySmall?.copyWith(
                                      color: colorScheme(context).onSurface,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  width: 170,
                                ),
                                IconButton(
                                    onPressed: () {
                                      provider.deleteDeliveryCharges(
                                          context: context,
                                          id: deliverycharges.id.toString());
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: colorScheme(context).secondary,
                                    )),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Base Delivery Fee",
                                  style: textTheme(context).bodySmall?.copyWith(
                                      color: colorScheme(context).secondary),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  deliverycharges.baseDeliveryFee,
                                  style: textTheme(context).bodySmall?.copyWith(
                                      color: colorScheme(context).onSurface,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Delivery_per_km",
                                  style: textTheme(context).bodySmall?.copyWith(
                                      color: colorScheme(context).secondary),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  deliverycharges.deliveryPerKm,
                                  style: textTheme(context).bodySmall?.copyWith(
                                      color: colorScheme(context).onSurface,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Minimum_order_fee",
                                  style: textTheme(context).bodySmall?.copyWith(
                                      color: colorScheme(context).secondary),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  deliverycharges.minimumOrderFee,
                                  style: textTheme(context).bodySmall?.copyWith(
                                      color: colorScheme(context).onSurface,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Free_delivery_threshold",
                                  style: textTheme(context).bodySmall?.copyWith(
                                      color: colorScheme(context).secondary),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  deliverycharges.freeDeliveryThreshold,
                                  style: textTheme(context).bodySmall?.copyWith(
                                      color: colorScheme(context).onSurface,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        ],
      ),
    );
  }
}
