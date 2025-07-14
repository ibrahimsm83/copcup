import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_order/model/order_model.dart';

import 'package:flutter_application_copcup/src/features/user/search_events/repository/search_event_repository.dart';
import 'package:flutter_application_copcup/src/models/event_model.dart';
import 'package:flutter_application_copcup/src/models/near_by_event_response.dart';
import 'package:flutter_application_copcup/src/models/recent_search_model.dart';

import '../../../../models/most_popular_events_model.dart';

class SearchEventController with ChangeNotifier {
  final SearchEventRepository searchEventRepository = SearchEventRepository();

  //! Search  Events

  bool _isEventLoading = false;
  bool get isEventLoading => _isEventLoading;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<EventModel> _eventList = [];
  List<EventModel> get eventList => _eventList;

  List<RecentSearch> _recentSearches = [];
  List<RecentSearch> get recentSearches => _recentSearches;

  Future<void> searchEvents({
    String? eventName,
    String? address,
    List<String>? days,
  }) async {
    _isEventLoading = true;
    notifyListeners();

    try {
      final events = await searchEventRepository.searchEvents(
        eventName: eventName,
        address: address,
        days: days,
      );
      _eventList = events;
    } catch (e) {
      debugPrint('Error searching events: $e');
    } finally {
      _isEventLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchRecentSearches() async {
    _isLoading = true;
    notifyListeners();

    try {
      _recentSearches = await searchEventRepository.getRecentSearches();
    } catch (e) {
      debugPrint('Error fetching recent searches: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchAllRecentSearches() async {
    _isLoading = true;
    notifyListeners();

    try {
      _recentSearches = await searchEventRepository.getAllRecentSearches();
    } catch (e) {
      debugPrint('Error fetching all recent searches: $e');
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
        await searchEventRepository.deleteRecentSearches(id: id);
    notifyListeners();
    // context.loaderOverlay.hide();

    if (result) {
      _recentSearches = await searchEventRepository.getAllRecentSearches();
      notifyListeners();
      // Optionally show success message via a snackbar
      // showSnackbar(message: "Recent Search deleted successfully");
    } else {
      // Handle error, show snackbar or any other feedback
      // showSnackbar(message: "Something went wrong", isError: true);
    }
  }

  // Future<void> getMostRecentEventList() async {
  //   _isEventLoading = true;
  //   notifyListeners();
  //   _eventList = await searchEventRepository.getMostRecentEvents();
  //   _isEventLoading = false;
  //   notifyListeners();
  //   print(_eventList);
  // }

  bool _isLatestOrderLoading = false;
  bool get isLatestOrderloading => _isLatestOrderLoading;
  OrderModel? _latestOrder;
  OrderModel? get latestOrder => _latestOrder;

  Future<void> gettheLatestOrder() async {
    _isLatestOrderLoading = true;
    notifyListeners();

    try {
      _latestOrder = await searchEventRepository.getLatestOrder();
      print(_latestOrder);
    } catch (e) {
      print('Error fetching the latest order: $e');
      _latestOrder = null;
    } finally {
      _isLatestOrderLoading = false;
      notifyListeners();
    }
  }

  List<PopularEvent> _popularEvents = [];
  List<PopularEvent> get popularEvents => _popularEvents;
  List<EventModel> _recentEvents = [];
  List<EventModel> get recentEvents => _recentEvents;

  Future<void> fetchMostPopularEvents() async {
    _isLoading = true;
    notifyListeners();

    try {
      _popularEvents = await searchEventRepository.getMostPopularEvents();
    } catch (e) {
      debugPrint('Error fetching most popular events: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMostRecentEvents() async {
    _isLoading = true;
    notifyListeners();

    try {
      _recentEvents = await searchEventRepository.getMostRecentEvents();
    } catch (e) {
      debugPrint('Error fetching most popular events: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<Event> _eventsResponse = [];
  List<Event> get eventsResponse => _eventsResponse;
  String _status = 'Fetching events...';
  String get status => _status;

  Future<void> fetchNearbyEvents() async {
    _isLoading = true;
    notifyListeners();

    try {
      log('Fetching nearby events...');
      _eventsResponse = await searchEventRepository.getNearbyEvents();
      log('Fetched ${_eventsResponse.length} events. --------');
      _status = "Nearby events fetched successfully.";
    } catch (e) {
      log('Error fetching events: $e');
      _status = "Failed to fetch nearby events: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
