import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OrderItemCard extends StatelessWidget {
  final String image;
  final String foodName;
  final String subTitle;
  final String price;
  final String itemNumber;
  OrderItemCard(
      {required this.image,
      required this.foodName,
      required this.subTitle,
      required this.price,
      required this.itemNumber});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            // child: Image.network(
            //   'https://images.slurrp.com/prod/recipe_images/transcribe/main%20course/shahi-chicken-korma.webp?impolicy=slurrp-20210601&width=1200&height=675',

            //   // '${ApiEndpoints.baseImageUrl}${order.orderItems.first.foodItem!.image!}',
            //   width: 85,
            //   height: 75,
            //   fit: BoxFit.cover,
            // ),
            child: CachedNetworkImage(
              imageUrl: image,
              width: 85,
              height: 65,
              fit: BoxFit.cover,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 95,
                  height: 75,
                  color: Colors.white,
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error, size: 24),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  foodName,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  subTitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.4),
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                price,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                itemNumber,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.4),
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
