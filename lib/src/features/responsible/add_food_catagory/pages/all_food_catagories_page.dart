import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_container.dart';

import 'package:flutter_application_copcup/src/features/responsible/add_food_catagory/controller/add_food_catagory_controller.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/provider/responsible_bottom_bar.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/widget/responsible_bottom-bar_widget.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/pages/responsible_home_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/pages/responsible_stock.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_profile/pages/responsible_profile_page.dart';
import 'package:flutter_application_copcup/src/features/user/chat/pages/inbox_page.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
import '../../add_food_item/controller/food_item_controller.dart';

class AllFoodCatagoriesPage extends StatefulWidget {
  const AllFoodCatagoriesPage({super.key});

  @override
  State<AllFoodCatagoriesPage> createState() => _AllFoodCatagoriesPageState();
}

class _AllFoodCatagoriesPageState extends State<AllFoodCatagoriesPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getFoodCategory();
    });
    super.initState();
  }

  getFoodCategory() async {
    final provider =
        Provider.of<FoodCatagoryController>(context, listen: false);
    await provider.getResponsibleFoodCategoryListData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: ResponsibleBottomBarWidget(),
        body: Consumer<ResponsibleHomeProvider>(
            builder: (context, value, child) => page[value.currentIndex]));
  }

  List<Widget> page = [
    ResponsibleHomePage(),
    Consumer<ResponsibleHomeProvider>(
        builder: (context, value, child) => value.resAllCategoryBool
            ? ResponsibleAllFoodCategoryWidget()
            : ResponsibleStock()),
    InboxPage(),
    ResponsibleProfilePage(),
  ];
}

class ResponsibleAllFoodCategoryWidget extends StatelessWidget {
  const ResponsibleAllFoodCategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<ResponsibleHomeProvider>(context);
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
                AppLocalizations.of(context)!.allCategoriesTitle,
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
            child: Consumer<FoodCatagoryController>(
              builder: (context, provider, child) {
                if (provider.isFoodCategoryLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (provider.responsiblefoodCategoryList.isEmpty) {
                  return Center(
                    child:
                        Text(AppLocalizations.of(context)!.na_noCategoryFound),
                  );
                }

                return GridView.builder(
                  itemCount: provider.responsiblefoodCategoryList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, childAspectRatio: 0.8),
                  itemBuilder: (context, index) {
                    final category =
                        provider.responsiblefoodCategoryList[index];
                    final isSelected =
                        provider.selectedCategory == category.categoryName;
                    if (provider.responsiblefoodCategoryList.isEmpty) {
                      return Center(
                        child: Text(
                            AppLocalizations.of(context)!.na_noCategoryFound),
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomContainer(
                          height: 73,
                          onTap: () async {
                            final foodItemProvider =
                                Provider.of<FoodItemController>(context,
                                    listen: false);
                            provider.selectCategory(category.categoryName!);
                            foodItemProvider
                                .filterResponsibleFoodItemList(category.id!);
                            context.pop();
                            // final result = await context.pushNamed(
                            //   AppRoute.foodCatagoryDetailPage,
                            //   extra: category,
                            // );
                            // print(result);
                            // if (result == true) {
                            //   await provider.getFoodCategoryList();
                            // }
                          },
                          width: 79,
                          borderRadius: 10,
                          borderWidth: 2,
                          borderColor: isSelected
                              ? colorScheme(context).secondary
                              : AppColor.categoryColor,
                          color:
                              provider.selectedCategory == category.categoryName
                                  ? colorScheme(context).secondary
                                  : AppColor.categoryColor,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: "${category.image}",
                              width: double.infinity,
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  color: Colors.grey[300],
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        SizedBox(
                          width: 80,
                          child: Center(
                            child: Text(
                              category.categoryName!,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: textTheme(context).bodyLarge?.copyWith(
                                  letterSpacing: 0.2,
                                  fontWeight: FontWeight.w500,
                                  color: colorScheme(context).onSurface),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                );
              },
            ),
          ),
          CustomButton(
            height: 55,
            iconColor: colorScheme(context).secondary,
            backgroundColor: colorScheme(context).secondary,
            text: AppLocalizations.of(context)!.na_addCategory,
            onPressed: () {
              navProvider.updateResponsibleBool(true);
              context.pushNamed(AppRoute.addFoodCatagoryPage);
            },
          ),
          SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }
}
