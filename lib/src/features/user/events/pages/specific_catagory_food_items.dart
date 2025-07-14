// ignore_for_file: override_on_non_overriding_member
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/widgets/app_bar/app_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_buton.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_food_catagory/controller/add_food_catagory_controller.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpecificCatagoryFoodItems extends StatefulWidget {
  final int id;
  const SpecificCatagoryFoodItems({super.key, required this.id});

  @override
  State<SpecificCatagoryFoodItems> createState() =>
      _SpecificCatagoryFoodItemsState();
}

class _SpecificCatagoryFoodItemsState extends State<SpecificCatagoryFoodItems> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getSpecifcFoodCatagoryFoodItem();
    });
    super.initState();
  }

  getSpecifcFoodCatagoryFoodItem() async {
    final provider =
        Provider.of<FoodCatagoryController>(context, listen: false);

    await provider.getFoodCategoryFoodItems(widget.id);

    log('Length ------------${provider.foodResponseList}');
  }

  TextEditingController searchController = TextEditingController();
  Future<bool> checkAgeVerificationStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('ageVerificationShown') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ResponsibleAppBar(
          title: 'ALL Food Items',
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Food Items',
              style: textTheme(context).labelLarge?.copyWith(
                    letterSpacing: 0.2,
                    fontSize: 16,
                    color: colorScheme(context).onSurface,
                  ),
            ),
            SizedBox(height: 25),
            Consumer<FoodCatagoryController>(
                builder: (context, provider, child) {
              if (provider.isFoodCategoryFoodItemLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              print("Inside consumer--------${provider.foodResponseList}");

              if (provider.foodResponseList == null) {
                return Center(child: Text("No Food Catagory found"));
              }

              final foodItem = provider.foodResponseList!.foodItems;
              print('event----$foodItem');

              return Container(
                height: 230,
                width: double.infinity,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: foodItem.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    final foodlist =
                        provider.foodResponseList!.foodItems[index];

                    Duration difference =
                        foodlist.endTime.difference(foodlist.startTime);

                    int hours = difference.inHours;
                    int minutes = difference.inMinutes % 60;

                    String formattedDifference =
                        "$hours hour${hours != 1 ? 's' : ''} $minutes minute${minutes != 1 ? 's' : ''}";
                    return SpecificCatgoryFoodItemCard(
                      ontap: () {
                        context.pushNamed(
                          AppRoute.productDetailPage,
                          extra: {
                            'id': foodlist.id,
                            'title': foodlist.name,
                            'imageUrl': foodlist.image,
                            'duration': formattedDifference,
                            'rating': 0.0,
                            'price': foodlist.price.toDouble(),
                          },
                        );
                      },
                      title: foodlist.name,
                      imageUrl: foodlist.image,
                      duration: formattedDifference,
                      rating: 0,
                      price: foodlist.price.toDouble(),
                    );
                  },
                ),
              );
            }),
            SizedBox(height: 20),
            Center(
              child: Text(
                'You must have to be older than 18yo and abusing alcohol is dangerous for the health',
                style: textTheme(context).labelSmall?.copyWith(
                      fontSize: 7,
                      color: colorScheme(context).error,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            SizedBox(height: 30),
            CustomButton(
                iconColor: colorScheme(context).primary,
                arrowCircleColor: colorScheme(context).surface,
                text: 'Go to Cart',
                backgroundColor: colorScheme(context).primary,
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  bool? isDialogShown = prefs.getBool('ageVerificationShown');

                  if (isDialogShown == null || !isDialogShown) {
                    showGeneralDialog(
                      context: context,
                      barrierDismissible: true,
                      barrierLabel: MaterialLocalizations.of(context)
                          .modalBarrierDismissLabel,
                      barrierColor: Colors.black45,
                      transitionDuration: const Duration(milliseconds: 200),
                      pageBuilder: (BuildContext buildContext,
                          Animation animation, Animation secondaryAnimation) {
                        return Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                            ),
                            width: MediaQuery.of(context).size.width * 0.86,
                            height: MediaQuery.of(context).size.height * 0.3,
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                      ),
                                    ),
                                    child: Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Icon(
                                          Icons.close,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    'Age Verification',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Center(
                                  child: Text(
                                    'Please confirm your age',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        prefs.setBool(
                                            'ageVerificationShown', true);
                                        Navigator.of(context).pop();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ),
                                      child: Text(
                                        'I am under 18',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        prefs.setBool(
                                            'ageVerificationShown', true);
                                        Navigator.of(context).pop();
                                        context.pushNamed(AppRoute.myCartPage);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary),
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                        ),
                                      ),
                                      child: Text(
                                        'I am 18 or older',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .surface,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    context.pushNamed(AppRoute.myCartPage);
                  }
                }),
            SizedBox(height: 20),
          ]),
        ));
  }
}

class SpecificCatgoryFoodItemCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String duration;
  final double rating;
  final double price;
  final VoidCallback ontap;

  const SpecificCatgoryFoodItemCard({
    required this.ontap,
    required this.title,
    required this.imageUrl,
    required this.duration,
    required this.rating,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int> quantity = ValueNotifier<int>(0);
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: ontap,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              width: 197,
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Column(children: [
                SizedBox(height: 55),
                Text(
                  title,
                  style: textTheme(context).bodyLarge?.copyWith(
                      color: colorScheme(context).onSurface,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      duration,
                      style: textTheme(context).labelSmall?.copyWith(
                          color:
                              colorScheme(context).onSurface.withOpacity(0.3),
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.star, color: Colors.amber, size: 10),
                    Text(
                      rating.toString(),
                      style: textTheme(context).labelSmall?.copyWith(
                          color:
                              colorScheme(context).onSurface.withOpacity(0.3),
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: '\$14'.split(" ").isNotEmpty
                              ? '\$14'.split(" ")[0] + " "
                              : "\$14",
                          style: textTheme(context).titleSmall!.copyWith(
                                color: colorScheme(context).onSurface,
                                fontWeight: FontWeight.w700,
                              ),
                          children: <TextSpan>[
                            TextSpan(
                              text: '.99',
                              style: textTheme(context).labelMedium!.copyWith(
                                    color: colorScheme(context)
                                        .onSurface
                                        .withOpacity(0.3),
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 26,
                        width: 28,
                        decoration: BoxDecoration(
                          color: colorScheme(context).primary.withOpacity(0.3),
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
                      ValueListenableBuilder<int>(
                        valueListenable: quantity,
                        builder: (context, value, _) {
                          return Text(
                            value
                                .toString()
                                .padLeft(1, '0'), // Ensures "03" format
                            style: textTheme(context).bodyLarge?.copyWith(
                                  color: colorScheme(context).onSurface,
                                  fontWeight: FontWeight.w500,
                                ),
                          );
                        },
                      ),
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
                    ]),
              ]),
            ),
          ),
        ),
        Positioned(
          top: 0,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 35,
            backgroundImage: NetworkImage(imageUrl),
          ),
        ),
      ],
    );
  }
}
