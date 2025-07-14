import 'package:flutter_application_copcup/src/models/specific_event_details.dart';

class FoodItem {
  final int id;
  final String name;
  final int price;
  final bool isAlcoholic;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final String image;

  FoodItem({
    required this.id,
    required this.name,
    required this.price,
    required this.isAlcoholic,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.image,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      isAlcoholic: json['is_alcoholic'] == 1,
      description: json['description'],
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'is_alcoholic': isAlcoholic ? 1 : 0,
      'description': description,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'image': image,
    };
  }
}

class FoodResponse {
  final bool success;
  final FoodCategory foodCategory;
  final List<FoodItem> foodItems;

  FoodResponse({
    required this.success,
    required this.foodCategory,
    required this.foodItems,
  });

  factory FoodResponse.fromJson(Map<String, dynamic> json) {
    return FoodResponse(
      success: json['success'],
      foodCategory: FoodCategory.fromJson(json['food_category']),
      foodItems: (json['food_items'] as List)
          .map((item) => FoodItem.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'food_category': foodCategory.toJson(),
      'food_items': foodItems.map((item) => item.toJson()).toList(),
    };
  }
}
