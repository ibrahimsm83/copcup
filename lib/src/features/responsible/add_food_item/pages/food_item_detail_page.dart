import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/utils/price_format.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/provider/responsible_bottom_bar.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_bottom_nav_bar/widget/responsible_bottom-bar_widget.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/pages/responsible_home_page.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_home/pages/responsible_stock.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_profile/pages/responsible_profile_page.dart';
import 'package:flutter_application_copcup/src/features/user/chat/pages/inbox_page.dart';

import 'package:flutter_application_copcup/src/models/food_item_model.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';

class FoodItemDetailPage extends StatelessWidget {
  final FoodItemModel fooditem;

  const FoodItemDetailPage({super.key, required this.fooditem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ResponsibleBottomBarWidget(),
      body: Consumer<ResponsibleHomeProvider>(
        builder: (context, value, child) => page[value.currentIndex],
      ),
    );
  }

  List<Widget> get page => [
        ResponsibleHomePage(),
        Consumer<ResponsibleHomeProvider>(
            builder: (context, value, child) => value.resFoodDetailBool
                ? ResponsibleFoodItemDetailWidget(
                    aditOntap: () {
                      context.pushNamed(AppRoute.editFoodItemPage,
                          extra: fooditem);
                    },
                    fooditem: fooditem,
                  )
                : ResponsibleStock()),
        InboxPage(),
        ResponsibleProfilePage(),
      ];
}

class ResponsibleFoodItemDetailWidget extends StatelessWidget {
  final FoodItemModel fooditem;
  final VoidCallback aditOntap;
  const ResponsibleFoodItemDetailWidget(
      {super.key, required this.fooditem, required this.aditOntap});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                AppLocalizations.of(context)!.manage_food_items,
                style: textTheme(context).headlineSmall?.copyWith(
                      fontSize: 21,
                      color: colorScheme(context).onSurface,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              IconButton(
                onPressed: aditOntap,
                icon: Icon(Icons.edit),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: colorScheme(context).secondary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.network(
              fooditem.image!,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              fooditem.name!,
              style: textTheme(context).titleLarge,
            ),
          ),
          Text(
            fooditem.description!,
            style: textTheme(context).titleSmall?.copyWith(
                fontSize: 14,
                color: colorScheme(context).onSurface.withOpacity(0.3)),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                // fooditem.price.toString(),
                priceFormated(fooditem.price!) + '  €',
                style: textTheme(context).bodyMedium?.copyWith(
                      color: colorScheme(context).primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              Spacer(),
              Text(
                'Mon to Thu: 10:15 AM',
                style: textTheme(context).bodyMedium?.copyWith(
                      color: colorScheme(context).onSurface.withOpacity(0.2),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ],
          ),
          SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }
}
