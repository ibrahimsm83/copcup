import 'package:flutter_application_copcup/src/models/event_model.dart';

class FoodItemModel {
  final int? id;
  final String? name;
  final String? image;
  final int? foodCategoryId;
  final int? eventId;
  final double? price;
  final String? description;
  final DateTime? startTime;
  final DateTime? endTime;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int isAlcoholic;
  final EventModel? event;
  final int? quantity;
  final bool isInStock;

  FoodItemModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.event,
    this.quantity,
    required this.name,
    required this.image,
    required this.foodCategoryId,
    required this.eventId,
    required this.price,
    required this.description,
    this.startTime,
    this.endTime,
    required this.isAlcoholic,
    required this.isInStock,
  });

  // factory FoodItemModel.fromJson(Map<String, dynamic> json) {
  //   return FoodItemModel(
  //     id: json['id'] as int?,
  //     quantity: json['quantity'] as int?,
  //     name: json['name'] as String? ?? '',
  //     image: json['image'] as String? ??
  //         'https://upload.wikimedia.org/wikipedia/commons/6/65/No-Image-Placeholder.svg',
  //     foodCategoryId: json['foodcategory_id'] as int?,
  //     eventId: json['event_id'] as int?,
  //     price: (json['price'] ?? 0).toDouble(),
  //     description: json['description'] as String? ?? '',
  //     startTime: json['start_time'] != null
  //         ? DateTime.tryParse(json['start_time'] as String)
  //         : null,
  //     endTime: json['end_time'] != null
  //         ? DateTime.tryParse(json['end_time'] as String)
  //         : null,
  //     createdAt: json['created_at'] != null
  //         ? DateTime.tryParse(json['created_at'] as String)
  //         : null,
  //     updatedAt: json['updated_at'] != null
  //         ? DateTime.tryParse(json['updated_at'] as String)
  //         : null,
  //     isAlcoholic: json['is_alcoholic'] as int? ?? 0,
  //     event: json['event'] != null
  //         ? EventModel.fromJson(json['event'] as Map<String, dynamic>)
  //         : null,
  //     isInStock: (json['is_in_stock'] as int?) == 0 ? false : true,
  //   );
  // }
  factory FoodItemModel.fromJson(Map<String, dynamic> json) {
    return FoodItemModel(
      id: json['id'] as int?,
      quantity: json['quantity'] as int?,
      name: json['name'] as String? ?? '',
      image: json['image'] as String? ??
          'https://upload.wikimedia.org/wikipedia/commons/6/65/No-Image-Placeholder.svg',
      foodCategoryId: json['foodcategory_id'] as int?,
      eventId: json['event_id'] as int?,
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      description: json['description'] as String? ?? '',
      startTime: json['start_time'] != null
          ? DateTime.tryParse(json['start_time'] as String)
          : null,
      endTime: json['end_time'] != null
          ? DateTime.tryParse(json['end_time'] as String)
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'] as String)
          : null,
      isAlcoholic: json['is_alcoholic'] as int? ?? 0,
      event: json['event'] != null
          ? EventModel.fromJson(json['event'] as Map<String, dynamic>)
          : null,
      isInStock: (json['is_in_stock'] as int?) == 0 ? false : true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
      'name': name,
      'image': image,
      'food_category_id': foodCategoryId,
      'event_id': eventId,
      'price': price,
      'description': description,
      'start_time': startTime?.toIso8601String(),
      'end_time': endTime?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'is_alcoholic': isAlcoholic,
    };
  }
}
