class NearbyEventsResponse {
  final String message;
  final List<Event> events;

  NearbyEventsResponse({
    required this.message,
    required this.events,
  });

  factory NearbyEventsResponse.fromJson(Map<String, dynamic> json) {
    return NearbyEventsResponse(
      message: json['message'] ?? '',
      events: (json['events'] as List<dynamic>?)
              ?.map((e) => Event.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'events': events.map((e) => e.toJson()).toList(),
    };
  }
}

class Event {
  final int id;
  final String image;
  final String eventName;
  final int eventCategoryId;
  final String address;
  final String latitude;
  final String longitude;
  final List<String> days;
  final String description;
  final String createdAt;
  final String updatedAt;
  final double distance;

  Event({
    required this.id,
    required this.image,
    required this.eventName,
    required this.eventCategoryId,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.days,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.distance,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] ?? 0, // Default to 0 if 'id' is null
      image:
          json['image'] ?? '', // Default to an empty string if 'image' is null
      eventName: json['event_name'] ?? '', // Default to an empty string
      eventCategoryId: json['event_category_id'] ?? 0, // Default to 0 if null
      address: json['address'] ??
          '', // Default to an empty string if 'address' is null
      latitude: json['latitude'] ?? '', // Default to empty string if null
      longitude: json['longitude'] ?? '', // Default to empty string if null
      days: List<String>.from(
          json['days'] ?? []), // Default to an empty list if 'days' is null
      description: json['description'] ?? '', // Default to empty string if null
      createdAt: json['created_at'] ?? '', // Default to empty string if null
      updatedAt: json['updated_at'] ?? '', // Default to empty string if null
      distance: (json['distance'] as num?)?.toDouble() ??
          0.0, // Default to 0.0 if 'distance' is null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'event_name': eventName,
      'event_category_id': eventCategoryId,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'days': days,
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'distance': distance,
    };
  }
}
