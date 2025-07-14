import 'dart:convert';

class EventModel {
  final int id;
  final String image;
  final String eventName;
  final String address;
  final String latitude;
  final String longitude;
  final int? eventCategoryId;
  final List<String>? days;
  final String description;
  final String? createdAt;
  final String? updatedAt;
  final DateTime? startDate;
  final DateTime? endDate;
  final int responsibleId;
  final Pivot pivot;
  // Constructor
  EventModel({
    required this.responsibleId,
    required this.endDate,
    required this.startDate,
    required this.latitude,
    required this.longitude,
    required this.id,
    required this.image,
    required this.eventName,
    required this.eventCategoryId,
    required this.address,
    required this.days,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      latitude: json['latitude'] ?? '', // Provide a default empty string
      longitude: json['longitude'] ?? '',
      responsibleId: json['responsible_id'] ?? 0,
      id: int.parse(json['id'].toString()),
      image: json['image'] ?? '', // Default to empty string if null
      eventName: json['event_name'] ?? '',
      eventCategoryId: json['event_category_id'] != null
          ? int.tryParse(json['event_category_id'].toString())
          : null,
      address: json['address'] ?? '',
      days: json['days'] is String
          ? List<String>.from(jsonDecode(json['days']))
          : List<String>.from(json['days'] ?? []),
      description: json['description'] ?? '',
      createdAt: json['created_at'] as String?, // Nullable String
      updatedAt: json['updated_at'] as String?, // Nullable String
      startDate: json['start_date'] != null
          ? DateTime.tryParse(json['start_date'] as String)
          : null,
      endDate: json['end_date'] != null
          ? DateTime.tryParse(json['end_date'] as String)
          : null,
      pivot: json['pivot'] != null
          ? Pivot.fromJson(json['pivot'])
          : Pivot(userId: 0, eventId: 0),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'end_date': endDate,
      'start_date': startDate,
      'id': id,
      'image': image,
      'event_name': eventName,
      'event_category_id': eventCategoryId,
      'address': address,
      'days': jsonEncode(days),
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'pivot': pivot.toJson(),
    };
  }
}

class Pivot {
  final int userId;
  final int eventId;

  Pivot({
    required this.userId,
    required this.eventId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      userId: json['user_id'],
      eventId: json['event_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'event_id': eventId,
    };
  }
}
