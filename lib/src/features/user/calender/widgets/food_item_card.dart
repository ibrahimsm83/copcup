import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:shimmer/shimmer.dart';

class FoodItemCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String duration;
  final double rating;
  final String price;
  final Widget? basketWidget;
  final VoidCallback ontap;
  final VoidCallback addCardOnTap;

  const FoodItemCard({
    required this.ontap,
    required this.title,
    required this.imageUrl,
    required this.duration,
    required this.rating,
    required this.price,
    required this.addCardOnTap,
    this.basketWidget,
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
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 20),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40),
                    Text(
                      title,
                      style: textTheme(context).bodyLarge?.copyWith(
                          color: colorScheme(context).onSurface,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 4),
                    Text(duration,
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                    SizedBox(height: 4),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     Icon(Icons.star, color: Colors.amber, size: 16),
                    //     Text(
                    //       rating.toString(),
                    //       style: textTheme(context).labelMedium?.copyWith(
                    //           color: colorScheme(context)
                    //               .onSurface
                    //               .withOpacity(0.3),
                    //           fontWeight: FontWeight.w600),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(height: 10),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                // text: '${price} €'.split(" ").isNotEmpty
                                //     ? '${price} €'.split(" ")[0] + " "
                                //     : "${price} €",
                                text: price,
                                style: textTheme(context).titleSmall!.copyWith(
                                      color: colorScheme(context).primary,
                                      fontWeight: FontWeight.w700,
                                    ),
                                children: <TextSpan>[
                                  // TextSpan(
                                  //   text: '.99',
                                  //   style: textTheme(context).labelMedium!.copyWith(
                                  //         color: colorScheme(context)
                                  //             .onSurface
                                  //             .withOpacity(0.3),
                                  //         fontWeight: FontWeight.w700,
                                  //       ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          basketWidget ?? SizedBox(),
                          // Container(
                          //   height: 26,
                          //   width: 28,
                          //   decoration: BoxDecoration(
                          //     color:
                          //         colorScheme(context).onSurface.withOpacity(0.3),
                          //     borderRadius: BorderRadius.circular(9),
                          //   ),
                          //   child: Center(
                          //     child: GestureDetector(
                          //       onTap: () {
                          //         if (quantity.value > 1) {
                          //           quantity.value -= 1;
                          //         }
                          //       },
                          //       child: Icon(
                          //         Icons.remove,
                          //         color: colorScheme(context).primary,
                          //         size: 15,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(width: 5),
                          // ValueListenableBuilder<int>(
                          //   valueListenable: quantity,
                          //   builder: (context, value, _) {
                          //     return Text(
                          //       value
                          //           .toString()
                          //           .padLeft(1, '0'), // Ensures "03" format
                          //       style: textTheme(context).bodyLarge?.copyWith(
                          //             color: colorScheme(context).onSurface,
                          //             fontWeight: FontWeight.w600,
                          //           ),
                          //     );
                          //   },
                          // ),
                          // SizedBox(width: 7),
                          // Container(
                          //   height: 26,
                          //   width: 28,
                          //   decoration: BoxDecoration(
                          //     color: colorScheme(context).primary,
                          //     borderRadius: BorderRadius.circular(9),
                          //   ),
                          //   child: Center(
                          //     child: GestureDetector(
                          //       onTap: () {
                          //         quantity.value += 1;
                          //       },
                          //       child: Icon(
                          //         Icons.add,
                          //         color: colorScheme(context).surface,
                          //         size: 15,
                          //       ),
                          //     ),
                          //   ),
                          // ),

                          // ValueListenableBuilder<int>(
                          //   valueListenable: quantity,
                          //   builder: (context, value, _) {
                          //     return Text(
                          //       value
                          //           .toString()
                          //           .padLeft(1, '0'), // Ensures "03" format
                          //       style: textTheme(context).bodyLarge?.copyWith(
                          //             color: colorScheme(context).onSurface,
                          //             fontWeight: FontWeight.w600,
                          //           ),
                          //     );
                          //   },
                          // ),

                          // Container(
                          //   height: 26,
                          //   width: 28,
                          //   decoration: BoxDecoration(
                          //     color: colorScheme(context).primary,
                          //     borderRadius: BorderRadius.circular(9),
                          //   ),
                          //   child: Center(
                          //     child: GestureDetector(
                          //       onTap: () {
                          //         quantity.value += 1;
                          //       },
                          //       child: Icon(
                          //         Icons.add,
                          //         color: colorScheme(context).surface,
                          //         size: 15,
                          //       ),
                          //     ),
                          //   ),
                          // )
                        ]),
                  ]),
            ),
          ),
        ),
        Positioned(
          top: 0,
          child: GestureDetector(
            onTap: ontap,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
