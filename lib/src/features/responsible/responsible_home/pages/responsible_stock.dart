// ignore_for_file: override_on_non_overriding_member
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_colors.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/utils/price_format.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_container.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_textfield.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_food_catagory/controller/add_food_catagory_controller.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_food_item/controller/food_item_controller.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/provider/responsible_bottom_bar.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_search_page/page/responsible_search_page.dart';
import 'package:flutter_application_copcup/src/models/food_item_model.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
class ResponsibleStock extends StatefulWidget {
  ResponsibleStock({super.key});

  @override
  State<ResponsibleStock> createState() => ResponsibleStockPageState();
}

class ResponsibleStockPageState extends State<ResponsibleStock> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getFoodCategory();
      getFoodItems();
    });
    super.initState();
  }

  Future<void> getFoodCategory() async {
    if (!mounted) return; // Check if the widget is still in the tree
    final provider =
        Provider.of<FoodCatagoryController>(context, listen: false);
    await provider.getResponsibleFoodCategoryListData();
  }

  Future<void> getFoodItems() async {
    if (!mounted) return; // Check before using context
    final provider = Provider.of<FoodItemController>(context, listen: false);
    await provider.getResponsibleFoodItemList();
  }

  Widget build(BuildContext context) {
    final fooditem = Provider.of<FoodItemController>(context, listen: false);
    final navigationProvider = Provider.of<ResponsibleHomeProvider>(context);

    bool _isSelected = false;
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.na_foods,
        onLeadingPressed: () {},
      ),
      body: Consumer<FoodCatagoryController>(
        builder: (context, foodCatagoryController, child) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (foodCatagoryController
                    .responsiblefoodCategoryList.isNotEmpty)
                  CustomContainer(
                    boxShadow: [
                      BoxShadow(
                          color:
                              colorScheme(context).onSurface.withOpacity(.10),
                          offset: Offset(0, 3),
                          blurRadius: 12)
                    ],
                    child: CustomTextFormField(
                      onTap: () {
                        navigationProvider.updateResponsibleBool(true);

                        context.pushNamed(AppRoute.responsibleSearchScreens);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => ResponsibleSearchScreens(),
                        //     ));
                      },
                      controller: searchController,
                      fillColor: colorScheme(context).surface,
                      borderRadius: 15,
                      hint: AppLocalizations.of(context)!.searchHere,
                      hintColor: AppColor.appGreyColor.withOpacity(.5),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Transform.scale(
                            scale: 0.8,
                            child: SvgPicture.asset(AppIcons.searchIcon)),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () async {
                          // final query = searchController.text.trim();
                          // fooditem.searchFood(query);
                        },
                        child: SizedBox(
                          width: 40,
                          height: 30,
                          child: Center(
                            child: CustomContainer(
                              height: 35,
                              width: 35,
                              borderRadius: 10,
                              color: colorScheme(context).secondary,
                              child: Center(
                                  child: SvgPicture.asset(
                                AppIcons.filterIcon,
                                height: 16,
                              )),
                            ),
                          ),
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 15),
                    ),
                  ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)!.na_categories,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme(context).titleSmall?.copyWith(
                            letterSpacing: 0.2,
                            fontSize: 16,
                            color: colorScheme(context).onSurface),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        navigationProvider.updateResponsibleBool(true);

                        context.pushNamed(AppRoute.allFoodCatagoriesPage);
                      },
                      child: Text(
                        "More",
                        style: textTheme(context).titleSmall!.copyWith(
                              color: colorScheme(context).primary,
                              decoration: TextDecoration.underline,
                            ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: Consumer<FoodCatagoryController>(
                    builder: (context, provider, child) {
                      int length = provider.responsiblefoodCategoryList.length;
                      if (provider.isFoodCategoryLoading) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            color: Colors.grey[300],
                          ),
                        );
                      }

                      if (provider.responsiblefoodCategoryList.isEmpty) {
                        return Center(
                            child: Text(AppLocalizations.of(context)!
                                .na_noCategoryFound));
                      }
                      return Row(
                        children: [
                          Expanded(
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: length > 3 ? 3 : length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisExtent: 100,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemBuilder: (context, index) {
                                final category =
                                    provider.responsiblefoodCategoryList[index];
                                _isSelected = provider.selectedCategory ==
                                    category.categoryName;
                                if (provider
                                    .responsiblefoodCategoryList.isEmpty) {
                                  return Center(
                                    child: Text(AppLocalizations.of(context)!
                                        .na_noCategoryFound),
                                  );
                                }

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: CustomContainer(
                                        onTap: () {
                                          provider.selectCategory(
                                              category.categoryName!);
                                          fooditem
                                              .filterResponsibleFoodItemList(
                                                  category.id!);
                                          // set
                                        },
                                        borderRadius: 12,
                                        color: AppColor.categoryColor,
                                        borderColor: _isSelected
                                            ? colorScheme(context).primary
                                            : Colors.grey,
                                        borderWidth: 2,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl: "${category.image}",
                                            width: double.infinity,
                                            fit: BoxFit.fill,
                                            placeholder: (context, url) =>
                                                Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: Container(
                                                color: Colors.grey[300],
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      category.categoryName!,
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: textTheme(context)
                                          .labelLarge
                                          ?.copyWith(
                                              letterSpacing: 0.2,
                                              fontSize: 12,
                                              color: colorScheme(context)
                                                  .onSurface),
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          if (!provider.isFoodCategoryLoading && length > 3)
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomContainer(
                                  height: 60,
                                  color: colorScheme(context)
                                      .onSurface
                                      .withOpacity(0.05),
                                  borderRadius: 12,
                                  width: 80,
                                  onTap: () {
                                    navigationProvider
                                        .updateResponsibleBool(true);

                                    context.pushNamed(
                                        AppRoute.allFoodCatagoriesPage);
                                  },
                                  child: Icon(
                                    Icons.more_horiz_outlined,
                                    size: 35,
                                  ),
                                ),
                                Text(
                                  "More",
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme(context)
                                      .labelLarge
                                      ?.copyWith(
                                          letterSpacing: 0.2,
                                          fontSize: 12,
                                          color:
                                              colorScheme(context).onSurface),
                                )
                              ],
                            )
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)!.na_foods,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme(context).titleSmall?.copyWith(
                            letterSpacing: 0.2,
                            fontSize: 16,
                            color: colorScheme(context).onSurface),
                      ),
                    ),
                    // TextButton(
                    //   onPressed: () {
                    //     context.pushNamed(AppRoute.allFoodCatagoriesPage);
                    //   },
                    //   child: Text(
                    //     "More",
                    //     style: textTheme(context).titleSmall!.copyWith(
                    //           color: colorScheme(context).primary,
                    //           decoration: TextDecoration.underline,
                    //         ),
                    //   ),
                    // ),
                  ],
                ),
                if (foodCatagoryController
                    .responsiblefoodCategoryList.isNotEmpty)
                  SizedBox(height: 10),
                if (foodCatagoryController
                    .responsiblefoodCategoryList.isNotEmpty)
                  Consumer<FoodItemController>(
                      builder: (context, foodItemController, child) {
                    final foodCategoryProvider =
                        Provider.of<FoodCatagoryController>(context,
                            listen: false);
                    if (foodItemController.isFoodItemLoading) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          color: Colors.grey[300],
                        ),
                      );
                    }
                    print(foodItemController.foodItemResponsibleList);
                    if (foodItemController.foodItemResponsibleList.isEmpty) {
                      return Center(
                          child: Text(AppLocalizations.of(context)!
                              .na_noFoodItemFound));
                    }
                    return GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: foodCategoryProvider.selectedCategory == null
                            ? foodItemController.foodItemResponsibleList.length
                            : foodItemController
                                .foodItemResponsibleListFiltered.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 165,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 10),
                        itemBuilder: (context, index) {
                          final foodItem =
                              foodCategoryProvider.selectedCategory == null
                                  ? foodItemController
                                      .foodItemResponsibleList[index]
                                  : foodItemController
                                      .foodItemResponsibleListFiltered[index];

                          return InkWell(
                            onTap: () {
                              showStockDialog(context, foodItem);
                            },
                            child: Stack(
                              children: [
                                CustomContainer(
                                  // onTap: () {

                                  // },
                                  height: 255,
                                  color: colorScheme(context).surface,
                                  boxShadow: [
                                    BoxShadow(
                                        color: colorScheme(context)
                                            .onSurface
                                            .withOpacity(.25),
                                        offset: Offset(0, 1),
                                        blurRadius: 2)
                                  ],
                                  width: 235,
                                  borderColor:
                                      AppColor.appGreyColor.withOpacity(.02),
                                  borderRadius: 24,
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(24)),
                                        child: CachedNetworkImage(
                                          imageUrl: '${foodItem.image}',
                                          width: double.infinity,
                                          height: 100,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              Shimmer.fromColors(
                                            baseColor: Colors.grey[300]!,
                                            highlightColor: Colors.grey[100]!,
                                            child: Container(
                                              color: Colors.grey[300],
                                              width: double.infinity,
                                              height: 100,
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                      CustomContainer(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    "${foodItem.name}",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: textTheme(context)
                                                        .bodyMedium
                                                        ?.copyWith(
                                                            color: colorScheme(
                                                                    context)
                                                                .onSurface,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 12),
                                                  ),
                                                ),
                                                Text(
                                                  priceFormated(foodItem.price!)
                                                          .toString() +
                                                      '  €',
                                                  // '${foodItem.price}',
                                                  style: textTheme(context)
                                                      .bodyMedium
                                                      ?.copyWith(
                                                        color:
                                                            colorScheme(context)
                                                                .primary,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  navigationProvider
                                                      .updateResponsibleBool(
                                                          true);
                                                  foodItemController.selectItem(
                                                      foodItem.name!);
                                                  final result =
                                                      await context.pushNamed(
                                                    AppRoute.foodItemDetailPage,
                                                    extra: foodItem,
                                                  );
                                                  print(result);
                                                  if (result == true) {
                                                    await foodItemController
                                                        .getFoodItemList(
                                                            foodItem.eventId!);
                                                  }
                                                },
                                                child: Container(
                                                  height: 20,
                                                  width: 20,
                                                  child: Center(
                                                      child: SvgPicture.asset(
                                                    AppIcons.editIcon,
                                                    height: 10,
                                                  )),
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color:
                                                          AppColor.kellyGreen),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Consumer<FoodItemController>(
                                                  builder: (context, provider,
                                                          child) =>
                                                      GestureDetector(
                                                        onTap: () {
                                                          provider
                                                              .deleteFoodItem(
                                                            context: context,
                                                            id: foodItem.id!
                                                                .toString(),
                                                          );
                                                        },
                                                        child: Container(
                                                          height: 20,
                                                          width: 20,
                                                          child: Center(
                                                              child: SvgPicture
                                                                  .asset(
                                                            AppIcons
                                                                .deleteIcon1,
                                                            height: 10,
                                                          )),
                                                          decoration:
                                                              BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: AppColor
                                                                      .redColor),
                                                        ),
                                                      )),
                                            ]),
                                      )
                                    ],
                                  ),
                                ),
                                !foodItem.isInStock
                                    ? Container(
                                        color: colorScheme(context)
                                            .surface
                                            .withOpacity(.6),
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: CustomContainer(
                                                color: colorScheme(context)
                                                    .secondary,
                                                borderRadius: 30,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5, vertical: 1),
                                                child: Text(
                                                  AppLocalizations.of(context)!
                                                      .na_outOfStock,
                                                  style: textTheme(context)
                                                      .bodySmall
                                                      ?.copyWith(
                                                        fontSize: 7,
                                                        color:
                                                            colorScheme(context)
                                                                .surface,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                )),
                                          ),
                                        ),
                                      )
                                    : SizedBox()
                              ],
                            ),
                          );
                        });
                  }),
                if (foodCatagoryController
                    .responsiblefoodCategoryList.isNotEmpty)
                  SizedBox(
                    height: 40,
                  ),
                if (foodCatagoryController
                    .responsiblefoodCategoryList.isNotEmpty)
                  CustomButton(
                    height: 55,
                    iconColor: colorScheme(context).secondary,
                    backgroundColor: colorScheme(context).secondary,
                    text: AppLocalizations.of(context)!.add_item,
                    onPressed: () {
                      navigationProvider.updateResponsibleBool(true);
                      context.pushNamed(AppRoute.createFoodItemPage);
                    },
                  ),
                SizedBox(
                  height: 25,
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void showStockDialog(BuildContext context, FoodItemModel fooditem) {
    final FoodItemController foodItemController = FoodItemController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final size = MediaQuery.of(context).size;
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Container(
              height: 450,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.network(
                    fooditem.image!,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 20),
                  Text(
                    fooditem.name!,
                    style: textTheme(context)
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.w600, fontSize: 24),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      AppLocalizations.of(context)!.successMessagePart1,
                      textAlign: TextAlign.center,
                      style: textTheme(context).bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: size.width * 0.6,
                    height: size.height * 0.08,
                    child: ElevatedButton(
                      onPressed: () async {
                        foodItemController
                            .outStockFoodItem(
                                context: context, id: fooditem.id.toString())
                            .then((onValue) {
                          getFoodItems();
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(AppLocalizations.of(context)!
                                .na_productOutOfStock),
                            backgroundColor: colorScheme(context).secondary,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme(context).surface,
                        shape: RoundedRectangleBorder(
                          side:
                              BorderSide(color: colorScheme(context).secondary),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 20),
                          Text(AppLocalizations.of(context)!.na_outOfStock,
                              style: textTheme(context).bodySmall?.copyWith(
                                  color: colorScheme(context).secondary,
                                  fontWeight: FontWeight.w600)),
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: colorScheme(context).secondary,
                            child: Icon(
                              Icons.arrow_forward,
                              color: colorScheme(context).surface,
                              size: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: size.width * 0.6,
                    height: size.height * 0.08,
                    child: ElevatedButton(
                      onPressed: () {
                        foodItemController
                            .inStockFoodItem(
                                context: context, id: fooditem.id.toString())
                            .then((onValue) {
                          getFoodItems();
                        });
                        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //   content:
                        //       Text("Request for stock submitted succesfully"),
                        //   backgroundColor: colorScheme(context).secondary,
                        // ));
                        // context.pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme(context).secondary,
                        shape: RoundedRectangleBorder(
                          side:
                              BorderSide(color: colorScheme(context).secondary),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 20),
                          Text(
                              AppLocalizations.of(context)!.na_bringBackToStock,
                              style: textTheme(context).bodySmall?.copyWith(
                                  color: colorScheme(context).surface,
                                  fontWeight: FontWeight.w600)),
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: colorScheme(context).surface,
                            child: Icon(
                              Icons.arrow_forward,
                              color: colorScheme(context).primary,
                              size: 15.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
