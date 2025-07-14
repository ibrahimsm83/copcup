import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/features/user/cart/controller/cart_controller.dart';
import 'package:flutter_application_copcup/src/models/food_item_model.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class FoodDetailPage extends StatelessWidget {
  final FoodItemModel foodModel;

  const FoodDetailPage({
    required this.foodModel,
  });

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int> quantity = ValueNotifier<int>(0);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: NetworkImage(foodModel.image!),
            //     fit: BoxFit.cover,
            //   ),
            // ),
            child: CachedNetworkImage(
              imageUrl: foodModel.image!,
              fit: BoxFit.cover,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  color: Colors.grey[300],
                  height: 200,
                  width: double.infinity,
                ),
              ),
              errorWidget: (context, url, error) => Icon(
                Icons.error_outline,
                color: Colors.red,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  foodModel.name!,
                  style: textTheme(context).headlineLarge?.copyWith(
                        color: colorScheme(context).onSurface,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.timer, color: Colors.grey, size: 18),
                    SizedBox(width: 5),
                    Text(
                      foodModel.startTime.toString(),
                      style: textTheme(context).bodyLarge?.copyWith(
                            color:
                                colorScheme(context).onSurface.withOpacity(0.6),
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    SizedBox(width: 16),
                    Icon(Icons.star, color: Colors.yellow, size: 18),
                    SizedBox(width: 5),
                    Text(
                      foodModel.eventId.toString(),
                      style: textTheme(context).bodyLarge?.copyWith(
                            color:
                                colorScheme(context).onSurface.withOpacity(0.6),
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Container(
                          height: 26,
                          width: 28,
                          decoration: BoxDecoration(
                            color:
                                colorScheme(context).onSurface.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                if (quantity.value > 1) {
                                  quantity.value -= 1;
                                }
                              },
                              child: Icon(
                                Icons.remove,
                                color: colorScheme(context).primary,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5),
                        ValueListenableBuilder<int>(
                          valueListenable: quantity,
                          builder: (context, value, _) {
                            return Text(
                              value
                                  .toString()
                                  .padLeft(1, '0'), // Ensures "03" format
                              style: textTheme(context).bodyLarge?.copyWith(
                                    color: colorScheme(context).onSurface,
                                    fontWeight: FontWeight.w600,
                                  ),
                            );
                          },
                        ),
                        SizedBox(width: 7),
                        Container(
                          height: 26,
                          width: 28,
                          decoration: BoxDecoration(
                            color: colorScheme(context).primary,
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                quantity.value += 1;
                              },
                              child: Icon(
                                Icons.add,
                                color: colorScheme(context).surface,
                                size: 15,
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NutrientInfo(label: '165 kcal', value: 'Calories'),
                    Container(
                      width: 0.7,
                      height: 50,
                      color: Colors.grey,
                    ),
                    NutrientInfo(label: '200', value: 'Proteins'),
                    Container(
                      width: 0.7,
                      height: 50,
                      color: Colors.grey,
                    ),
                    NutrientInfo(label: '10.9', value: 'Fats'),
                    Container(
                      width: 0.7,
                      height: 50,
                      color: Colors.grey,
                    ),
                    NutrientInfo(label: '20.5', value: 'Carbo'),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  'Description',
                  style: textTheme(context).headlineMedium?.copyWith(
                        fontSize: 24,
                        color: colorScheme(context).onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: 8),
                Text(
                  foodModel.description!,
                  style: textTheme(context).titleMedium?.copyWith(
                        color: colorScheme(context).onSurface.withOpacity(0.6),
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: colorScheme(context).surface,
                  border: Border.all(color: colorScheme(context).onSurface),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.shopping_cart,
                  color: colorScheme(context).onSurface,
                  size: 29,
                ),
              ),
              Consumer<CartController>(
                builder: (context, provider, child) => Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      minimumSize: Size(270, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(19),
                      ),
                    ),
                    onPressed: () {
                      if (quantity.value < 1) {
                        showSnackbar(message: "add quantity", isError: true);
                      } else {
                        provider.addToCart(
                            context: context,
                            productId: foodModel.id!,
                            quantity: quantity.value);
                      }
                    },
                    child: Text(
                      // 'Buy Now',
                      'Add to Cart',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.surface,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NutrientInfo extends StatelessWidget {
  final String label;
  final String value;

  const NutrientInfo({Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: textTheme(context).bodyLarge?.copyWith(
                color: colorScheme(context).onSurface,
                fontWeight: FontWeight.w700,
              ),
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: textTheme(context).bodyLarge?.copyWith(
                color: colorScheme(context).onSurface.withOpacity(0.6),
                fontWeight: FontWeight.w400,
              ),
        ),
      ],
    );
  }
}
