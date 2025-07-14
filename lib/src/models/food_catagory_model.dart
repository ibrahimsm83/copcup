class FoodCatagoryModel {
  final int? id;
  final String? image;
  final String? categoryName;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? eventId; // Changed from String? to int?

  FoodCatagoryModel({
    this.id,
    this.image,
    this.categoryName,
    this.createdAt,
    this.updatedAt,
    this.eventId,
  });

  factory FoodCatagoryModel.fromJson(Map<String, dynamic> json) {
    return FoodCatagoryModel(
      id: json['id'] as int?,
      image: json['image'] as String?,
      categoryName:
          (json['category_name'] ?? json['name'] ?? 'no name') as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      eventId: json['event_id'] as int?, // Correctly parsed as int
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'category_name': categoryName,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'event_id': eventId,
    };
  }
}
