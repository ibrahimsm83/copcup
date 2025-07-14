class EventResponse {
  final bool success;
  final Event event;
  final List<FoodCategory> foodCategories;

  EventResponse({
    required this.success,
    required this.event,
    required this.foodCategories,
  });

  factory EventResponse.fromJson(Map<String, dynamic> json) {
    return EventResponse(
      success: json['success'],
      event: Event.fromJson(json['event']),
      foodCategories: (json['food_categories'] is List)
          ? (json['food_categories'] as List)
              .map((item) => FoodCategory.fromJson(item))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'event': event.toJson(),
      'food_categories': foodCategories.map((item) => item.toJson()).toList(),
    };
  }
}

class Event {
  final int id;
  final String eventName;
  final String address;
  final String description;
  final String image;

  Event({
    required this.id,
    required this.eventName,
    required this.address,
    required this.description,
    required this.image,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      eventName: json['event_name'],
      address: json['address'],
      description: json['description'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'event_name': eventName,
      'address': address,
      'description': description,
      'image': image,
    };
  }
}

class FoodCategory {
  final int id;
  final String name;
  final String image;

  FoodCategory({
    required this.id,
    required this.name,
    required this.image,
  });

  factory FoodCategory.fromJson(Map<String, dynamic> json) {
    return FoodCategory(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}
