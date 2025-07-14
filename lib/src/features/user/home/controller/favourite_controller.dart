import 'package:flutter/material.dart';

import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/models/event_model.dart';
import 'package:flutter_application_copcup/src/features/user/home/repository/favourite_repository.dart';

class FavouriteController with ChangeNotifier {
  FavouritesRepository favouritesRepository = FavouritesRepository();

  bool _isFavoritesLoading = false;
  bool get isFavoritesLoading => _isFavoritesLoading;

  //! Get All Favorite Events
  List<EventModel> _favoriteEvents = [];
  List<EventModel> get favoriteEvents => _favoriteEvents;

  Future<void> getFavoritesList() async {
    _isFavoritesLoading = true;
    notifyListeners();
    _favoriteEvents = await favouritesRepository.getAllFavorites();
    _isFavoritesLoading = false;
    notifyListeners();
    print(_favoriteEvents);
  }

  //! Add Event to Favorites
  Future<void> addFavorite(
      {required BuildContext context, required EventModel event}) async {
    final token = StaticData.accessToken;
    if (token == null || token.isEmpty) {
      showSnackbar(
          message: "Authorization token is missing or expired", isError: true);
      return;
    }

    // context.loaderOverlay.show();

    final bool result =
        await favouritesRepository.addFavorite(id: event.id.toString());

    if (result) {
      _favoriteEvents.add(event);
      // context.loaderOverlay.hide();
      // showSnackbar(message: "Event added to favorites successfully");
      notifyListeners();
      getFavoritesList();
    } else {
      // context.loaderOverlay.hide();
      // showSnackbar(message: "Something went wrong", isError: true);
    }
  }

  //! Remove Event from Favorites
  Future<void> removeFavorite(
      {required BuildContext context, required String id}) async {
    // context.loaderOverlay.show();
    favoriteEvents.removeWhere((event) => event.id.toString() == id);
    notifyListeners();
    final bool result = await favouritesRepository.removeFavorite(id: id);

    if (result) {
      // context.loaderOverlay.hide();
      _favoriteEvents.removeWhere((event) => event.id == id);
      // showSnackbar(message: "Event removed from favorites successfully");
      notifyListeners();
      // getFavoritesList();
    } else {
      // context.loaderOverlay.hide();
      // showSnackbar(message: "Something went wrong", isError: true);
    }
  }

  bool isFavorite(String eventId) {
    for (var event in _favoriteEvents) {
      if (event.id == eventId) {
        return true;
      }
    }
    return false;
  }
}
