class EventCategoryModel {
  final int? id;
  final String? image;
  final String? categoryName;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  EventCategoryModel({
    this.id,
    this.image,
    this.categoryName,
    this.createdAt,
    this.updatedAt,
  });

  // Factory constructor to parse JSON into an EventCategory object with null checks
  factory EventCategoryModel.fromJson(Map<String, dynamic> json) {
    return EventCategoryModel(
      id: json['id'] as int?,
      image: json['image'] as String?,
      categoryName: json['category_name'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  // Method to convert an EventCategory object into JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'category_name': categoryName,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
