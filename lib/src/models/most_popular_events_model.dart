import 'dart:convert';

class PopularEvent {
  final int id;
  final String eventName;
  final String address;
  final String description;
  final List<String>? days;
  final String imageUrl;
  final int favoritesCount;

  PopularEvent({
    required this.id,
    required this.eventName,
    required this.address,
    required this.description,
    required this.imageUrl,
    required this.favoritesCount,
    this.days,
  });

  factory PopularEvent.fromJson(Map<String, dynamic> json) {
    return PopularEvent(
      id: json['id'],
      eventName: json['event_name'],
      address: json['address'],
      description: json['description'],
      imageUrl: json['image'],
      favoritesCount: json['favorites_count'],
      days: json['days'] is List
          ? List<String>.from(json['days']) // Handles a proper list
          : (json['days'] is String
              ? List<String>.from(
                  jsonDecode(json['days'])) // Handles a JSON string
              : []), // Fallback for unexpected cases
    );
  }
}
