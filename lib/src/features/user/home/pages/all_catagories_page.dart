import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_event/controller/event_controller.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_event_catagory/controller/event_category_controller.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/provider/bottom_nav_bar_provider.dart';
import 'package:flutter_application_copcup/src/features/user/bottom_nav_bar/widget/bottom_bar_widget.dart';
import 'package:flutter_application_copcup/src/features/user/home/pages/user_home_page.dart';
import 'package:flutter_application_copcup/src/features/user/home/provider/catagory_provider.dart';
import 'package:flutter_application_copcup/src/features/user/home/widgets/catagory_item.dart';
import 'package:flutter_application_copcup/src/features/user/my_order-page/page/all_orders_page.dart';
import 'package:flutter_application_copcup/src/features/user/profile/pages/profile_page.dart';
import 'package:flutter_application_copcup/src/features/user/qr_scan/user_qr_scan_page.dart';
import 'package:flutter_application_copcup/src/features/user/search/pages/find_events_page.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
class AllCategoriesPage extends StatefulWidget {
  const AllCategoriesPage({super.key});

  @override
  _AllCategoriesPageState createState() => _AllCategoriesPageState();
}

class _AllCategoriesPageState extends State<AllCategoriesPage> {
  final categoryProvider = CategoryProvider();

  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getEventsCategory();
      getEvents();
    });
    super.initState();
  }

  getEventsCategory() async {
    final provider =
        Provider.of<EventCategoryController>(context, listen: false);
    await provider.getUserCategoryList();
  }

  getEvents() async {
    final provider = Provider.of<EventController>(context, listen: false);
    await provider.getUserEventList();
    print(provider.eventList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomBarWidget(),
        body: Consumer<NavigationProvider>(
            builder: (context, value, child) => _pages[value.currentIndex]));
  }

  List<Widget> _pages = [
    Consumer<NavigationProvider>(
      builder: (context, value, child) => value.eventCategoryBool
          ? Padding(
              padding: const EdgeInsets.all(10),
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
                            context.goNamed(AppRoute.userBottomNavBar);
                          },
                          child: Icon(Icons.arrow_back)),
                      Text(
                        AppLocalizations.of(context)!.allCategoriesTitle,
                        style: textTheme(context).bodyLarge?.copyWith(
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
                  Consumer<EventCategoryController>(
                    builder: (context, provider, child) {
                      return GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: provider.eventCategoryList.length,
                        itemBuilder: (context, index) {
                          print(provider.eventCategoryList);

                          final category = provider.eventCategoryList[index];
                          final isSelected = provider.selectedCategory ==
                              category.categoryName;

                          return CategoryItem(
                            category: category,
                            isSelected: isSelected,
                            onTap: () {
                              final eventProvider =
                                  Provider.of<EventController>(context,
                                      listen: false);

                              provider.selectCategory(
                                  category.categoryName!, category.id!);
                              eventProvider.filterEventList(category.id!);
                              // context.pop();
                              context.goNamed(AppRoute.userBottomNavBar);
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            )
          : UserHomePage(),
    ),
    FindEventsPage(),
    UserQrScanPage(),
    AllOrdersPage(),
    ProfilePage(),
  ];
}
