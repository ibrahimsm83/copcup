import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/common/utils/price_format.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_container.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_event/controller/event_controller.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_auth/controller/responsible_auth_controller.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_auth/widgets/account_alert_dialog.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/provider/responsible_bottom_bar.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/provider/refund_provider.dart';
import 'package:flutter_application_copcup/src/models/event_model.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';import 'package:shimmer/shimmer.dart';

class ResponsibleHomePage extends StatefulWidget {
  const ResponsibleHomePage({super.key});

  @override
  State<ResponsibleHomePage> createState() => _ResponsibleHomePageState();
}

class _ResponsibleHomePageState extends State<ResponsibleHomePage> {
  List<EventModel> events = [];
  int? selectedEventId;
  String? selectedEvent;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getUser();
      getEvents();
      getAllIncomeData();
    });
    super.initState();
  }

  getEvents() async {
    final provider = Provider.of<EventController>(context, listen: false);
    await provider.getProfessionalEvents();
    if (mounted) {
      setState(() {
        events = provider.professionalEventList;
        if (provider.professionalEventList.isNotEmpty) {
          log('-get first event id -----------${provider.professionalEventList.last.eventName}');
        }
      });
    }
    final renevueProvider = Provider.of<RefundProvider>(context, listen: false);
    log('---check boolean----${renevueProvider.selectedEventBool}');
    log('---check boolean----${events.length}');
    log('---check renevue----${renevueProvider.selectedEventBool}');

    if (events.isNotEmpty && renevueProvider.selectedEventBool == false) {
      log('000000000000 it get first event value${events.last.id}\n${events.first.id} ');
      await renevueProvider.getDailyRenevue(
          id: events.first.id, context: context);
      await renevueProvider.getWeeklyRenevue(
          id: events.first.id, context: context);

      renevueProvider.getWeeklyGraphRenevue(
          id: events.first.id, context: context);
    }
  }

  getAllIncomeData() {
    final renevueProvider = Provider.of<RefundProvider>(context, listen: false);
    renevueProvider.getAllInComeData();
  }

  getUser() async {
    final provider =
        Provider.of<ResponsibleAuthController>(context, listen: false);
    if (provider.userProfessionalModel == null) {
      await provider.getProfessionalDetail(
        context: context,
        onError: (error) {
          customAlertDialog(
            context: context,
            content: error,
            onPressed: () {
              getUser();
              context.pop();
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final renevueProvider = Provider.of<RefundProvider>(context, listen: false);
    final List<String> itemList = [
      AppLocalizations.of(context)!.sellerHomeItems,
      AppLocalizations.of(context)!.na_sellerHomeQuantity,
      AppLocalizations.of(context)!.na_sellerHomePricePerItem,
      AppLocalizations.of(context)!.total
    ];
    var m = MediaQuery.of(context).size;
    final navResponsibleProvider =
        Provider.of<ResponsibleHomeProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<ResponsibleAuthController>(
            builder: (context, responsibleAuthController, child) {
          final user = responsibleAuthController.userProfessionalModel;
          log("professuinal user $user");

          if (user == null) {
            return Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox(
                    height: m.height * 0.35,
                    child: Column(
                      children: [
                        Container(
                          height: m.height * 0.32,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: colorScheme(context).secondary,
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(50))),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        navResponsibleProvider
                                            .updateResponsibleBool(true);
                                        navResponsibleProvider
                                            .setCurrentIndex(3);
                                        context.pushNamed(
                                            AppRoute.responsibleNotification);
                                        // context.pushNamed(AppRoute
                                        //     .responsibleNotificationPage);
                                      },
                                      child: Container(
                                        height: 35,
                                        width: 35,
                                        child: Center(
                                            child: SvgPicture.asset(
                                                AppIcons.bellIcon)),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: colorScheme(context)
                                                    .surface,
                                                width: 2)),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    GestureDetector(
                                      onTap: () {
                                        navResponsibleProvider
                                            .setCurrentIndex(3);
                                        // context.pushNamed(
                                        //     AppRoute.responsibleProfilePage);
                                      },
                                      child: Container(
                                        height: 35,
                                        width: 35,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: ClipOval(
                                          child: CachedNetworkImage(
                                            imageUrl: user.image ??
                                                StaticData.defultImage,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    CircleAvatar(
                                              radius: 42,
                                              backgroundImage: imageProvider,
                                            ),
                                            placeholder: (context, url) =>
                                                Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: CircleAvatar(
                                                radius: 42,
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Hey ',
                                          style: textTheme(context)
                                              .titleMedium
                                              ?.copyWith(
                                                fontSize: 16,
                                                color: colorScheme(context)
                                                    .surface,
                                              ),
                                        ),
                                        TextSpan(
                                          text: '${user.name} !',
                                          style: textTheme(context)
                                              .titleMedium
                                              ?.copyWith(
                                                fontSize: 16,
                                                color: colorScheme(context)
                                                    .surface,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Text(
                                  AppLocalizations.of(context)!
                                      .explore_responsible,
                                  style: textTheme(context)
                                      .headlineLarge
                                      ?.copyWith(
                                          color: colorScheme(context).surface,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 28),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: CustomContainer(
                      boxShadow: [
                        BoxShadow(
                          color:
                              colorScheme(context).onSurface.withOpacity(.10),
                          offset: Offset(0, 3),
                          blurRadius: 12,
                        )
                      ],
                      child: Container(
                        decoration: BoxDecoration(
                          color: colorScheme(context).surface,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: DropdownButtonFormField<String>(
                          value: selectedEvent,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!
                                .switch_toggle_hint,
                            hintStyle: TextStyle(
                                color: AppColor.appGreyColor.withOpacity(.5)),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            // suffixIcon:
                            //     Icon(Icons.keyboard_arrow_down_outlined),
                            border: InputBorder.none,
                          ),
                          items: events.map((event) {
                            return DropdownMenuItem<String>(
                              value: event.eventName,
                              child: Text(event.eventName),
                            );
                          }).toList(),
                          onChanged: (value) async {
                            renevueProvider.updateSelectedBool(true);

                            setState(() {
                              selectedEvent = value;
                              selectedEventId = events
                                  .firstWhere((e) => e.eventName == value)
                                  .id;
                            });

                            log('-----------${selectedEventId}');
                            // await renevueProvider.getWeeklyRenevue(
                            //     id: selectedEventId!, context: context);
                            await renevueProvider.getWeeklyGraphRenevue(
                                id: selectedEventId!, context: context);

                            await renevueProvider.getDailyRenevue(
                                id: selectedEventId!, context: context);
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 30),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
              //   child: CustomContainer(
              //     height: 53,
              //     color: colorScheme(context).surface,
              //     borderColor: AppColor.appGreyColor.withOpacity(.2),
              //     borderRadius: 9,
              //     child: Padding(
              //       padding: EdgeInsets.symmetric(horizontal: 0.0),
              //       child: Row(
              //         children: [
              //           Padding(
              //             padding: EdgeInsets.symmetric(horizontal: 8.0),
              //             child: Text(
              //               AppLocalizations.of(context)!.switch_to_seller_mode,
              //               style: textTheme(context).bodySmall?.copyWith(
              //                   color: AppColor.appGreyColor.withOpacity(.8),
              //                   fontSize: 12,
              //                   fontWeight: FontWeight.w600),
              //             ),
              //           ),
              //           Spacer(),
              //           Consumer<SellerHomeProvider>(
              //               builder: (context, value, child) => CustomSwitch(
              //                     value: value.switchToggle,
              //                     onChanged: (p0) {
              //                       value.updateSwitchStatus();
              //                       // if (p0) {
              //                       //   context.pushReplacementNamed(
              //                       //       AppRoute.sellerBottomBar);
              //                       // } else {
              //                       //   context.pushReplacementNamed(
              //                       //       AppRoute.responsibleBottomBar);
              //                       // }
              //                     },
              //                   ))
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomContainer(
                          // height: 110,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          borderRadius: 8,
                          color: AppColor.appYellow,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0, top: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                      alignment: Alignment.topRight,
                                      child: SvgPicture.asset(
                                          AppIcons.clipCircle)),
                                ),
                                Consumer<RefundProvider>(
                                  builder: (context, value, child) {
                                    if (value.renevueModel == null ||
                                        value.renevueModel!.data.isEmpty) {
                                      return Text(
                                        '0.00 €',
                                        style: textTheme(context)
                                            .titleLarge
                                            ?.copyWith(
                                              color:
                                                  colorScheme(context).surface,
                                              fontWeight: FontWeight.w700,
                                            ),
                                      );
                                    } else {
                                      return Text(
                                        priceFormated(
                                              double.parse(value.renevueModel!
                                                  .data.first.totalRevenue),
                                            ) +
                                            ' €',
                                        // '${}',
                                        style: textTheme(context)
                                            .titleLarge
                                            ?.copyWith(
                                              color:
                                                  colorScheme(context).surface,
                                              fontWeight: FontWeight.w700,
                                            ),
                                      );
                                    }
                                  },
                                ),
                                SizedBox(height: 8),
                                Text(
                                  AppLocalizations.of(context)!.todays_revenue,
                                  style:
                                      textTheme(context).titleLarge?.copyWith(
                                            color: colorScheme(context).surface,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                          ),
                                )
                              ],
                            ),
                          )),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: CustomContainer(
                          height: 110,
                          borderRadius: 8,
                          color: AppColor.greenish,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0, top: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                      alignment: Alignment.topRight,
                                      child: SvgPicture.asset(
                                          AppIcons.clipSecondCircle)),
                                ),
                                // Consumer<RefundProvider>(
                                //   builder: (context, value, child) {
                                //     if (value.weeklygraphRenevue == null ||
                                //         value
                                //             .weeklygraphRenevue!.data.isEmpty) {
                                //       return Text(
                                //         '0',
                                //         style: textTheme(context)
                                //             .titleLarge
                                //             ?.copyWith(
                                //               color:
                                //                   colorScheme(context).surface,
                                //               fontWeight: FontWeight.w700,
                                //             ),
                                //       );
                                //     } else {
                                //       return Text(
                                //         '${value.weeklygraphRenevue!.data.last.totalRevenue}',
                                //         style: textTheme(context)
                                //             .titleLarge
                                //             ?.copyWith(
                                //               color:
                                //                   colorScheme(context).surface,
                                //               fontWeight: FontWeight.w700,
                                //             ),
                                //       );
                                //     }
                                //   },
                                // ),
                                Consumer<RefundProvider>(
                                  builder: (context, value, child) {
                                    if (value.weeklygraphRenevue == null ||
                                        value
                                            .weeklygraphRenevue!.data.isEmpty) {
                                      return Text(
                                        '0.00 €',
                                        style: textTheme(context)
                                            .titleLarge
                                            ?.copyWith(
                                              color:
                                                  colorScheme(context).surface,
                                              fontWeight: FontWeight.w700,
                                            ),
                                      );
                                    } else {
                                      // Sum of all totalRevenue values
                                      double totalSum = value
                                          .weeklygraphRenevue!.data
                                          .map((e) => e.totalRevenue ?? 0)
                                          .fold(
                                              0.0,
                                              (prev, element) =>
                                                  prev + element);

                                      return Text(
                                        // '${totalSum.toStringAsFixed(2)}', // You can format to 2 decimal places
                                        priceFormated(totalSum) + '  €',
                                        style: textTheme(context)
                                            .titleLarge
                                            ?.copyWith(
                                              color:
                                                  colorScheme(context).surface,
                                              fontWeight: FontWeight.w700,
                                            ),
                                      );
                                    }
                                  },
                                ),
                                SizedBox(height: 8),
                                Text(
                                  AppLocalizations.of(context)!
                                      .revenue_this_week,
                                  style:
                                      textTheme(context).titleLarge?.copyWith(
                                            color: colorScheme(context).surface,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                          ),
                                )
                              ],
                            ),
                          )),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.revenue_this_week,
                      style: textTheme(context).titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color:
                              colorScheme(context).onSurface.withOpacity(0.4),
                          fontSize: 14),
                    ),
                    Text(
                      AppLocalizations.of(context)!.registrations_this_week,
                      style: textTheme(context).titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color:
                              colorScheme(context).onSurface.withOpacity(0.4),
                          fontSize: 14),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Consumer<RefundProvider>(
                  builder: (context, value, child) {
                    return Row(
                      children: [
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text: priceFormated(
                                    value.allIncomeModel?.totalRevenue ?? 0.0) +
                                ' €',
                            // '${ ?? 0} €',
                            style: textTheme(context).titleLarge?.copyWith(
                                  color: colorScheme(context).onSurface,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ])),
                        SizedBox(width: 30),
                        // RichText(
                        //     text: TextSpan(children: [
                        //   TextSpan(
                        //     text: '60',
                        //     style: textTheme(context).titleLarge?.copyWith(
                        //           color: colorScheme(context).onSurface,
                        //           fontWeight: FontWeight.w700,
                        //         ),
                        //   ),
                        //   TextSpan(
                        //     text: '/75',
                        //     style: textTheme(context).titleLarge?.copyWith(
                        //           color: AppColor.appGreyColor.withOpacity(.6),
                        //           fontWeight: FontWeight.w400,
                        //           fontSize: 14,
                        //         ),
                        //   ),
                        // ])),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                height: 40,
              ),
              // Padding(
              //   padding: const EdgeInsets.all(16.0),
              //   child: SizedBox(
              //     height: 100,
              //     child: LineChart(
              //       LineChartData(
              //         gridData: FlGridData(
              //           show: true,
              //           drawVerticalLine: true,
              //           getDrawingHorizontalLine: (value) => FlLine(
              //             color: Colors.grey.withOpacity(0.2),
              //             strokeWidth: 1,
              //           ),
              //           getDrawingVerticalLine: (value) => FlLine(
              //             color: Colors.grey.withOpacity(0.2),
              //             strokeWidth: 1,
              //           ),
              //         ),
              //         titlesData: FlTitlesData(show: false),
              //         borderData: FlBorderData(show: false),
              //         lineBarsData: [
              //           LineChartBarData(
              //             spots: [
              //               FlSpot(0, 3),
              //               FlSpot(1, 1),
              //               FlSpot(2, 4),
              //               FlSpot(3, 2),
              //               FlSpot(4, 6),
              //               FlSpot(5, 4),
              //               FlSpot(6, 5),
              //             ],
              //             isCurved: true,
              //             color: Colors.blueAccent,
              //             barWidth: 3,
              //             dotData: FlDotData(
              //               show: true,
              //               checkToShowDot: (spot, barData) {
              //                 return spot == FlSpot(4, 6);
              //               },
              //             ),
              //             belowBarData: BarAreaData(
              //               show: true,
              //               color: Colors.blue.withOpacity(0.2),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              Consumer<RefundProvider>(
                builder: (context, value, child) {
                  final weeklyData = value.weeklygraphRenevue?.data ?? [];

                  // If there's no data, provide default zero values for the graph
                  List<FlSpot> spots = weeklyData.isNotEmpty
                      ? List.generate(
                          weeklyData.length,
                          (i) => FlSpot(i.toDouble(),
                              weeklyData[i].totalRevenue.toDouble()))
                      : List.generate(
                          7,
                          (i) => FlSpot(
                              i.toDouble(), 0)); // Default 7-day zero data

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: SizedBox(
                      height: 100, // Keep it small like your example
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(show: false), // Hide grid lines
                          titlesData:
                              FlTitlesData(show: false), // Hide all labels
                          borderData:
                              FlBorderData(show: false), // Remove border
                          lineBarsData: [
                            LineChartBarData(
                              spots: spots,
                              isCurved: true,
                              color: Colors.blueAccent,
                              barWidth: 2,
                              isStrokeCapRound: true,
                              belowBarData: BarAreaData(
                                show: true,
                                color: Colors.blue
                                    .withOpacity(0.2), // Light fill below line
                              ),
                              dotData: FlDotData(show: false), // Hide dots
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 20,
              )
            ],
          );
        }),
      ),
    );
  }
}
