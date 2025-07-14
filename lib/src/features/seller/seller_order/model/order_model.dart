// class OrderModel {
//   final int id;
//   final int userId;
//   final String amount;
//   final String status;
//   final String stripeSessionId;
//   final int sellerId;
//   final String qrCodePath;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final String confirmationToken;
//   final List<dynamic> orderItems;

//   OrderModel({
//     required this.id,
//     required this.userId,
//     required this.amount,
//     required this.status,
//     required this.stripeSessionId,
//     required this.sellerId,
//     required this.qrCodePath,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.confirmationToken,
//     required this.orderItems,
//   });

//   factory OrderModel.fromJson(Map<String, dynamic> json) {
//     return OrderModel(
//       id: json['id'],
//       userId: json['user_id'],
//       amount: json['amount'],
//       status: json['status'],
//       stripeSessionId: json['stripe_session_id'],
//       sellerId: json['seller_id'],
//       qrCodePath: json['qr_code_path'],
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//       confirmationToken: json['confirmation_token'],
//       orderItems: json['order_items'] ?? [],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'user_id': userId,
//       'amount': amount,
//       'status': status,
//       'stripe_session_id': stripeSessionId,
//       'seller_id': sellerId,
//       'qr_code_path': qrCodePath,
//       'created_at': createdAt.toIso8601String(),
//       'updated_at': updatedAt.toIso8601String(),
//       'confirmation_token': confirmationToken,
//       'order_items': orderItems,
//     };
//   }
// }

import 'package:flutter_application_copcup/src/models/food_item_model.dart';

class OrderModel {
  final int id;
  final int userId;
  final String? amount; // Nullable
  final String customerName; // Nullable

  final String? status; // Nullable
  final String? stripeSessionId; // Nullable
  final String? customerContactNumber; // Nullable

  final int sellerId;
  final String? qrCodePath; // Nullable
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? confirmationToken; // Nullable
  final String establishmentName; // Nullable

  final List<OrderItemModel> orderItems;
  final String sellerName;
  final String customerMail;

  OrderModel({
    required this.customerMail,
    required this.customerName,
    required this.customerContactNumber,
    required this.establishmentName,
    required this.id,
    required this.userId,
    required this.sellerName,
    this.amount,
    this.status,
    this.stripeSessionId,
    required this.sellerId,
    this.qrCodePath,
    required this.createdAt,
    required this.updatedAt,
    this.confirmationToken,
    required this.orderItems,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    var orderItemsJson = json['order_items'] as List<dynamic>?;

    List<OrderItemModel> orderItems = [];
    if (orderItemsJson != null) {
      orderItems = orderItemsJson
          .map((item) => OrderItemModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    return OrderModel(
      customerMail: json['customer_email'] ?? '',
      customerContactNumber: json['customer_number'] ?? '',
      customerName: json['customer_name'] ?? '',
      establishmentName: json['establishment'] ?? '', // Default to empty string
      sellerName: json['seller_name'] ?? '', // Default to empty string
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      amount: json['amount']?.toString(), // Ensure null safety
      status: json['status']?.toString(),
      stripeSessionId: json['stripe_session_id']?.toString(),
      sellerId: json['seller_id'] ?? 0,
      qrCodePath: json['qr_code']?.toString(),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(), // Default value if null
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(), // Default value if null
      confirmationToken: json['confirmation_token']?.toString(),
      orderItems: orderItems,
    );
  }

  // factory OrderModel.fromJson(Map<String, dynamic> json) {
  //   var orderItemsJson = json['order_items'] as List<dynamic>?;

  //   List<OrderItemModel> orderItems = [];
  //   if (orderItemsJson != null) {
  //     orderItems = orderItemsJson
  //         .map((item) => OrderItemModel.fromJson(item as Map<String, dynamic>))
  //         .toList();
  //   }
  //   return OrderModel(
  //     establishmentName: json['establishment'],
  //     sellerName: json['seller_name'],
  //     id: json['id'] ?? 0,
  //     userId: json['user_id'] ?? 0,
  //     amount: json['amount'] as String?,
  //     status: json['status'] as String?,
  //     stripeSessionId: json['stripe_session_id'] as String?,
  //     sellerId: json['seller_id'] ?? 0,
  //     qrCodePath: json['qr_code'] as String?,
  //     createdAt: DateTime.parse(json['created_at']),
  //     updatedAt: DateTime.parse(json['updated_at']),
  //     confirmationToken: json['confirmation_token'] as String?,
  //     orderItems: orderItems,
  //   );
  // }
}

class OrderItemModel {
  final int id;
  final int orderId;
  final int foodItemId;
  final int quantity;
  final String? price; // Nullable
  final DateTime createdAt;
  final DateTime updatedAt;
  final FoodItemModel? foodItem;

  OrderItemModel({
    required this.id,
    required this.orderId,
    required this.foodItemId,
    required this.quantity,
    this.price,
    required this.createdAt,
    required this.updatedAt,
    this.foodItem,
  });

  // factory OrderItemModel.fromJson(Map<String, dynamic> json) {
  //   return OrderItemModel(
  //     id: json['id'] ?? 0,
  //     orderId: json['order_id'] ?? 0,
  //     foodItemId: json['foodItem_id'] ?? 0,
  //     quantity: json['quantity'] ?? 0,
  //     price: json['price'] as String?,
  //     createdAt: DateTime.parse(json['created_at']),
  //     updatedAt: DateTime.parse(json['updated_at']),
  //     foodItem: json['food_item'] != null
  //         ? FoodItemModel.fromJson(json['food_item'])
  //         : null,
  //   );
  // }
  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'] ?? 0,
      orderId: json['order_id'] ?? 0,
      foodItemId: json['foodItem_id'] ?? 0,
      quantity: json['quantity'] ?? 0,
      price: json['price']?.toString(),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
      foodItem: json['food_item'] != null
          ? FoodItemModel.fromJson(json['food_item'])
          : null,
    );
  }
}
