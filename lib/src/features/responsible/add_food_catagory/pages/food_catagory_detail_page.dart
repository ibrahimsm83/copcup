import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';

import 'package:flutter_application_copcup/src/features/responsible/add_food_catagory/controller/add_food_catagory_controller.dart';
import 'package:flutter_application_copcup/src/models/food_catagory_model.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';

import '../../../../common/widgets/custom_app_bar.dart';
import '../../../../common/widgets/custom_buton.dart';

class FoodCatagoryDetailPage extends StatelessWidget {
  final FoodCatagoryModel foodcategory;

  const FoodCatagoryDetailPage({super.key, required this.foodcategory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Manage Category',
        onLeadingPressed: () {
          Navigator.pop(context);
        },
        action: IconButton(
          onPressed: () {
            context.pushNamed(AppRoute.updateFoodCatagoryPage,
                extra: foodcategory);
          },
          icon: Icon(Icons.edit),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: colorScheme(context).secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.network(
                foodcategory.image!,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text(
                foodcategory.categoryName!,
                style: textTheme(context).titleLarge,
              ),
            ),
            // Text(
            //   'We prioritize your privacy and are committed to protecting your personal information. Our app collects data in accordance with our Privacy Policy, which details how we gather, use, and safeguard your information. By using the app, you consent to our data practices, including the use of cookies and tracking technologies to enhance your user experience.',
            //   style: textTheme(context).titleSmall?.copyWith(
            //       fontSize: 14,
            //       color: colorScheme(context).onSurface.withOpacity(0.3)),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Text(
                //   '\$25.00',
                //   style: textTheme(context).bodyMedium?.copyWith(
                //         color: colorScheme(context).primary,
                //         fontSize: 16,
                //         fontWeight: FontWeight.w700,
                //       ),
                // ),
                // Spacer(),
                if (foodcategory.createdAt != null)
                  Text(
                    DateFormat('dd-MMM-YYYY hh:mm a')
                        .format(foodcategory.createdAt!),
                    style: textTheme(context).bodyMedium?.copyWith(
                          color:
                              colorScheme(context).onSurface.withOpacity(0.2),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
              ],
            ),
            SizedBox(
              height: 60,
            ),
            Consumer<FoodCatagoryController>(
              builder: (context, provider, child) => CustomButton(
                height: 55,
                iconColor: colorScheme(context).secondary,
                backgroundColor: colorScheme(context).secondary,
                text: 'Delete Category',
                onPressed: () => provider.deleteFoodCatagory(
                  context: context,
                  id: foodcategory.id!.toString(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
