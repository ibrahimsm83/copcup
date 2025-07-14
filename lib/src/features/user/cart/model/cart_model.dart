import 'package:flutter_application_copcup/src/models/food_item_model.dart';

class CartModel {
  final int id;
  final int userId;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<CartItemModel> cartItems;

  CartModel({
    required this.id,
    required this.userId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.cartItems,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      userId: json['user_id'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      cartItems: (json['cartitems'] as List<dynamic>?)
              ?.map((item) =>
                  CartItemModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'cartitems': cartItems.map((item) => item.toJson()).toList(),
    };
  }
}

class CartItemModel {
  final int id;
  final int cartId;
  final int foodItemId;
  final String price;
  int quantity;
  final DateTime createdAt;
  final DateTime updatedAt;
  final FoodItemModel foodItem;

  CartItemModel({
    required this.id,
    required this.cartId,
    required this.foodItemId,
    required this.price,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
    required this.foodItem,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'],
      cartId: json['cart_id'],
      foodItemId: json['foodItem_id'],
      price: json['price'],
      quantity: json['quantity'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      foodItem: FoodItemModel.fromJson(json['food_item']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cart_id': cartId,
      'foodItem_id': foodItemId,
      'price': price,
      'quantity': quantity,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'food_item': foodItem.toJson(),
    };
  }
}
