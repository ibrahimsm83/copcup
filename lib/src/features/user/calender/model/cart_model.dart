import 'package:flutter/material.dart';

class CartItem {
  final String title;
  final String subtitle;
  final String imageUrl;
  final String price;
  final String itemCode;
  final ValueNotifier<int> quantity;  

  CartItem({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.price,
    required this.itemCode,
    required this.quantity,
  });
}