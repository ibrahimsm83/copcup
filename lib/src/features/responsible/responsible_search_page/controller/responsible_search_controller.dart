import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_search_page/model/responsible_recent_search.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_search_page/responsible_search_repository/search_repositery.dart';
import 'package:flutter_application_copcup/src/models/food_item_model.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ResponsibleSearchController with ChangeNotifier {
  List<FoodItemModel> _searchFoodItem = [];
  List<FoodItemModel> get searchFoodItem => _searchFoodItem;

  bool _isEventLoading = false;
  bool get isEventLoading => _isEventLoading;
  Future<void> searchResponsibleFoodItem({
    required String query,
  }) async {
    log('--------${query}');
    _isEventLoading = true;
    notifyListeners();
    try {
      final foodItems =
          await ResponsibleSearchRepositery.searchEvents(foodName: query);
      _searchFoodItem = foodItems;

      log('${_searchFoodItem.length}');
    } catch (e) {
      log('---------------${e}');
    } finally {
      _isEventLoading = false;
      notifyListeners();
    }
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<ResponsibleRecentSearch> _recentSearches = [];
  List<ResponsibleRecentSearch> get recentSearches => _recentSearches;
  Future<void> fetchRecentSearches() async {
    _isLoading = true;
    notifyListeners();

    try {
      List<ResponsibleRecentSearch> resultData =
          await ResponsibleSearchRepositery.getRecentSearches();

      _recentSearches = resultData
          .where((e) => e.foodItemName != null && e.foodItemName!.isNotEmpty)
          .toList();

      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching recent searches: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteRecentSearches({
    required BuildContext context,
    required String id,
  }) async {
    // context.loaderOverlay.show();

    final bool result =
        await ResponsibleSearchRepositery.deleteRecentSearches(id: id);
    notifyListeners();
    // context.loaderOverlay.hide();

    if (result) {
      _recentSearches = await ResponsibleSearchRepositery.getRecentSearches();
      notifyListeners();
    } else {}
  }

  Future<void> deleteAllChat({required BuildContext context}) async {
    try {
      context.loaderOverlay.show();
      notifyListeners();
      bool result = await ResponsibleSearchRepositery.clearAllSearch();
      if (result) {
        _recentSearches = [];
        notifyListeners();
      } else {
        log('--------Some thing went wrong');
      }
    } catch (e) {
      log('--------${e}');
    } finally {
      context.loaderOverlay.hide();
      notifyListeners();
    }
  }
}
