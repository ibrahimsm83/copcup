class EventDetails {
  final String eventName;
  final String location;
  final DateTime eventTime;
  final DateTime eventDate;
  final String address;
  final String description;
  final List<FoodItem> foodList;
  final List<FoodItem> dishesList;
  final List<DrinkItem> drinkList;

  EventDetails({
    required this.eventName,
    required this.location,
    required this.eventTime,
    required this.eventDate,
    required this.address,
    required this.description,
    required this.foodList,
    required this.dishesList,
    required this.drinkList,
  });
}

class FoodItem {
  final String title;
  final String imageUrl;
  final String duration;
  final double rating;
  final double price;

  FoodItem({
    required this.title,
    required this.imageUrl,
    required this.duration,
    required this.rating,
    required this.price,
  });

  Object? toJson() {
    return null;
  }
}

class DrinkItem {
  final String title;
  final String imageUrl;
  final String duration;
  final double rating;
  final double price;

  DrinkItem({
    required this.title,
    required this.imageUrl,
    required this.duration,
    required this.rating,
    required this.price,
  });
}
