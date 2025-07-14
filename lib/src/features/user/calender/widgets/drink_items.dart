import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';

class DrinkItems extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String duration;
  final double rating;
  final double price;
  final VoidCallback ontap;

  const DrinkItems({
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
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            onTap: ontap,
            child: Container(
              margin: EdgeInsets.only(top: 50),
              padding: EdgeInsets.symmetric(horizontal: 28, vertical: 20),
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
              child: Column(
                children: [
                  SizedBox(height: 40),
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
                      Text(duration,
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      SizedBox(width: 4),
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      Text(
                        rating.toString(),
                        style: textTheme(context).labelMedium?.copyWith(
                            color:
                                colorScheme(context).onSurface.withOpacity(0.3),
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: '\$14'.split(" ").isNotEmpty
                              ? '\$14'.split(" ")[0] + " "
                              : "\$14",
                          style: textTheme(context).titleSmall!.copyWith(
                                color: colorScheme(context).primary,
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
                      SizedBox(width: 5),
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
                            value.toString().padLeft(1, '0'),
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
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          child: CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(imageUrl),
          ),
        ),
      ],
    );
  }
}
