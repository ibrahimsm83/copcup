import 'package:flutter/material.dart';

import 'package:flutter_application_copcup/src/features/user/calender/model/cart_model.dart';

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;

  const CartItemCard({required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(cartItem.imageUrl),
          ),
          const SizedBox(width: 7),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  cartItem.subtitle,
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
                cartItem.price,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                'Item: ${cartItem.itemCode}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.4),
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 5),
              ValueListenableBuilder<int>(
                valueListenable: cartItem.quantity,
                builder: (context, value, _) {
                  return Row(children: [
                    GestureDetector(
                      onTap: () {
                        if (cartItem.quantity.value > 1) {
                          cartItem.quantity.value -= 1;
                        }
                      },
                      child: Container(
                        height: 26,
                        width: 28,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.remove,
                            color: Colors.red,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      value.toString().padLeft(1, '0'),
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        cartItem.quantity.value += 1;
                      },
                      child: Container(
                        height: 26,
                        width: 28,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                  ]);
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
