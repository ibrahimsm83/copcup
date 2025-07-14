import 'package:flutter/material.dart';

class FavoritesProvider with ChangeNotifier {
  final Set<String> _favoriteEvents = {};

  Set<String> get favoriteEvents => _favoriteEvents;

  void toggleFavorite(String eventTitle) {
    if (_favoriteEvents.contains(eventTitle)) {
      _favoriteEvents.remove(eventTitle);
    } else {
      _favoriteEvents.add(eventTitle);
    }
    notifyListeners();
  }

  bool isFavorite(String eventTitle) {
    return _favoriteEvents.contains(eventTitle);
  }
}
