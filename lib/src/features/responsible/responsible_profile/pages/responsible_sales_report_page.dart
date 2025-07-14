import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/app_bar/app_bar.dart';
import 'package:flutter_application_copcup/src/features/responsible/professional_qr/professional_qr_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/provider/responsible_bottom_bar.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/widget/responsible_bottom-bar_widget.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/pages/responsible_home_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/pages/responsible_stock.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_profile/pages/responsible_profile_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_profile/widgets/bar_chart_file.dart';
import 'package:flutter_application_copcup/src/features/user/chat/pages/inbox_page.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart'; 
import 'package:provider/provider.dart';

class ResponsibleSalesReportPage extends StatefulWidget {
  const ResponsibleSalesReportPage({super.key});

  @override
  State<ResponsibleSalesReportPage> createState() =>
      _ResponsibleSalesReportPageState();
}

class _ResponsibleSalesReportPageState
    extends State<ResponsibleSalesReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: ResponsibleBottomBarWidget(),
        // appBar: ResponsibleAppBar(
        //   title: AppLocalizations.of(context)!.sales_report,
        //   onLeadingPressed: () {
        //     context.pop();
        //   },
        // ),
        body: Consumer<ResponsibleHomeProvider>(
          builder: (context, value, child) => page[value.currentIndex],
        ));
  }

  List<Widget> page = [
    ResponsibleHomePage(),
    ResponsibleStock(),
    ProfessionalQrScanPage(),
    Consumer<ResponsibleHomeProvider>(
        builder: (context, value, child) => value.resSalesReport
            ? ResponsibleSaleReportWidget()
            : ResponsibleProfilePage()),
  ];
}

class ResponsibleSaleReportWidget extends StatelessWidget {
  ResponsibleSaleReportWidget({super.key});
  final ValueNotifier<String> _selectedValue =
      ValueNotifier<String>('This month');

  final ValueNotifier<String> selectedValueNotifier =
      ValueNotifier<String>('This Week');

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
                AppLocalizations.of(context)!.sales_report,
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
          Text(AppLocalizations.of(context)!.na_totalAmount,
              style: textTheme(context).titleSmall?.copyWith(
                  color: colorScheme(context).onSurface.withOpacity(0.4),
                  fontWeight: FontWeight.w500)),
          SizedBox(
            height: 10,
          ),
          Text(
            '\$2500.00',
            style: textTheme(context).headlineLarge?.copyWith(
                fontSize: 30,
                color: colorScheme(context).onSurface,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme(context).primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            ),
            child: Text(AppLocalizations.of(context)!.na_withdraw,
                style: textTheme(context).bodyLarge?.copyWith(
                    color: colorScheme(context).surface,
                    fontWeight: FontWeight.w500)),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context)!.na_itemsSold,
                        style: textTheme(context).headlineMedium?.copyWith(
                            color: colorScheme(context).onSurface,
                            fontWeight: FontWeight.w700)),
                    Container(
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:
                              colorScheme(context).onSurface.withOpacity(0.4),
                        ),
                      ),
                      child: ValueListenableBuilder<String>(
                        valueListenable: _selectedValue,
                        builder: (context, value, child) {
                          return Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              underline: SizedBox.shrink(),
                              value: value,
                              items: <String>[
                                'This month',
                                'Last month',
                                'This year',
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: textTheme(context)
                                        .labelSmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: colorScheme(context)
                                                .onSurface
                                                .withOpacity(0.6)),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  _selectedValue.value = newValue;
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularProgressIndicator(
                              value: 0.4,
                              strokeWidth: 10,
                              color: Colors.blue,
                              backgroundColor: Colors.grey.shade300,
                            ),
                            SizedBox(
                              height: 80,
                              width: 80,
                              child: CircularProgressIndicator(
                                value: 0.6,
                                strokeWidth: 10,
                                color: Colors.green,
                                backgroundColor: Colors.grey.shade300,
                              ),
                            ),
                            SizedBox(
                              height: 60,
                              width: 60,
                              child: CircularProgressIndicator(
                                value: 1.0,
                                strokeWidth: 10,
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                  radius: 5,
                                  backgroundColor:
                                      colorScheme(context).secondary),
                              SizedBox(width: 8),
                              Text(
                                AppLocalizations.of(context)!.na_byCategory,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                            ],
                          ),
                          Text(
                            '10K',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: colorScheme(context).secondary,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              CircleAvatar(
                                  radius: 5, backgroundColor: Colors.green),
                              SizedBox(width: 8),
                              Text(
                                AppLocalizations.of(context)!.na_mostSoldItem,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                            ],
                          ),
                          Text(
                            '4K',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ]),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.na_sellersActivity,
                            style: textTheme(context).headlineMedium?.copyWith(
                                color: colorScheme(context).onSurface,
                                fontWeight: FontWeight.w700),
                          ),
                          Container(
                            height: 40,
                            width: 110,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(0.4),
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: ValueListenableBuilder<String>(
                              valueListenable: selectedValueNotifier,
                              builder: (context, selectedValue, _) {
                                return Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: DropdownButton<String>(
                                    value: selectedValue,
                                    isExpanded: true,
                                    underline: SizedBox.shrink(),
                                    icon: Icon(Icons.arrow_drop_down),
                                    items: <String>[
                                      'This Week',
                                      'This Day',
                                      'Last Month',
                                      'This Year',
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: textTheme(context)
                                              .labelSmall
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color: colorScheme(context)
                                                      .onSurface
                                                      .withOpacity(0.6)),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      selectedValueNotifier.value = newValue!;
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: BarChartSample1(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(AppLocalizations.of(context)!.na_topProducts,
                              style: textTheme(context)
                                  .headlineMedium
                                  ?.copyWith(
                                      color: colorScheme(context).onSurface,
                                      fontWeight: FontWeight.w700)),
                        ],
                      ),
                      SizedBox(height: 10),
                      ProductProgress(
                          index: '01',
                          title: 'Burgers',
                          percentage: 45,
                          color: Colors.blue),
                      ProductProgress(
                          index: '02',
                          title: 'Alcohol',
                          percentage: 29,
                          color: Colors.green),
                      ProductProgress(
                          index: '03',
                          title: 'Schizo',
                          percentage: 18,
                          color: Colors.purple),
                      ProductProgress(
                          index: '04',
                          title: 'Smartwatch',
                          percentage: 25,
                          color: Colors.orange),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]));
  }
}

class ProductProgress extends StatelessWidget {
  final String index;
  final String title;
  final int percentage;
  final Color color;

  ProductProgress({
    required this.index,
    required this.title,
    required this.percentage,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Text(index,
              style: textTheme(context).bodyLarge?.copyWith(
                  color: colorScheme(context).onSurface,
                  fontWeight: FontWeight.w700)),
          SizedBox(width: 10),
          Expanded(
            flex: 3,
            child: Text(title,
                style: textTheme(context).bodyLarge?.copyWith(
                    color: colorScheme(context).onSurface,
                    fontWeight: FontWeight.w400)),
          ),
          Expanded(
            flex: 5,
            child: LinearProgressIndicator(
              value: percentage / 100,
              color: color,
              backgroundColor: Colors.grey.shade300,
            ),
          ),
          SizedBox(width: 10),
          Container(
            height: 30,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue),
            ),
            child: Center(
              child: Text('$percentage%',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14, color: color)),
            ),
          ),
        ],
      ),
    );
  }
}
