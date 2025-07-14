import 'dart:convert';
import 'dart:developer';

import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/core/api_end_points.dart';
import 'package:flutter_application_copcup/src/core/api_helper.dart';
import 'package:flutter_application_copcup/src/features/seller/seller_order/model/order_model.dart';
import 'package:flutter_application_copcup/src/models/event_model.dart';
import 'package:flutter_application_copcup/src/models/most_popular_events_model.dart';
import 'package:flutter_application_copcup/src/models/near_by_event_response.dart';
import 'package:flutter_application_copcup/src/models/recent_search_model.dart';

class SearchEventRepository {
  ApiHelper _apiHelper = ApiHelper();

  Future<List<RecentSearch>> getRecentSearches() async {
    final token = StaticData.accessToken;
    if (token == null || token.isEmpty) {
      throw Exception('Authorization token is missing or expired');
    }

    try {
      final response = await _apiHelper.getRequest(
        endpoint: ApiEndpoints.getRecentSearches,
        authToken: token,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);

        if (responseBody.containsKey('data') && responseBody['data'] is List) {
          final List<dynamic> recentSearches = responseBody['data'];
          return recentSearches.map((e) => RecentSearch.fromJson(e)).toList();
        } else {
          throw Exception('The "data" field is missing or invalid');
        }
      } else {
        throw Exception('Failed to fetch recent searches: ${response.body}');
      }
    } catch (e) {
      log('Error fetching recent searches: $e');
      rethrow;
    }
  }

  Future<List<RecentSearch>> getAllRecentSearches() async {
    final token = StaticData.accessToken;
    if (token == null || token.isEmpty) {
      throw Exception('Authorization token is missing or expired');
    }

    try {
      final response = await _apiHelper.getRequest(
        endpoint: ApiEndpoints.getAllRecentSearches,
        authToken: token,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);

        if (responseBody.containsKey('data') && responseBody['data'] is List) {
          final List<dynamic> recentSearches = responseBody['data'];
          return recentSearches.map((e) => RecentSearch.fromJson(e)).toList();
        } else {
          throw Exception('The "data" field is missing or invalid');
        }
      } else {
        throw Exception('Failed to fetch recent searches: ${response.body}');
      }
    } catch (e) {
      log('Error fetching recent searches: $e');
      rethrow;
    }
  }

  Future<List<EventModel>> searchEvents({
    String? eventName,
    String? address,
    List<String>? days,
  }) async {
    final token = StaticData.accessToken;
    if (token == null || token.isEmpty) {
      throw Exception('Authorization token is missing or expired');
    }

    String queryParams = '';
    if (eventName != null && eventName.isNotEmpty) {
      queryParams += 'event_name=$eventName&';
    }
    if (address != null && address.isNotEmpty) {
      queryParams += 'address=$address&';
    }
    if (days != null && days.isNotEmpty) {
      queryParams += 'days=${days.join(',')}&';
    }

    final endpoint = '${ApiEndpoints.searchEvent}?$queryParams';

    try {
      final response = await _apiHelper.getRequest(
        endpoint: endpoint,
        authToken: token,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);

        if (responseBody.containsKey('data') && responseBody['data'] is Map) {
          final nestedData = responseBody['data'];
          log('Response Body $responseBody');
          if (nestedData.containsKey('data') && nestedData['data'] is List) {
            final List<dynamic> eventsList = nestedData['data'];
            return eventsList.map((e) => EventModel.fromJson(e)).toList();
          } else {
            throw Exception('The nested "data" key is missing or invalid');
          }
        } else {
          throw Exception('The "data" field is missing in the response');
        }
      } else {
        throw Exception('Failed to search events: ${response.body}');
      }
    } catch (e) {
      log('Error searching events: $e');
      rethrow; // Let the caller handle the error
    }
  }

  Future<bool> deleteRecentSearches({required String id}) async {
    try {
      final response = await _apiHelper.deleteRequest(
        endpoint: "${ApiEndpoints.deleteRecentSearches}/$id",
      );

      if (response.statusCode == 200) {
        log('Response{$response}');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('Error delete recent searches: $e');
      return true;
    }
  }

  Future<OrderModel> getLatestOrder() async {
    final token = StaticData.accessToken;
    if (token == null || token.isEmpty) {
      throw Exception('Authorization token is missing or expired');
    }

    try {
      final response = await _apiHelper.getRequest(
        endpoint: ApiEndpoints.getlatestOrders,
        authToken: token,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);

        if (responseBody.containsKey('order') &&
            responseBody['order'] is Map<String, dynamic>) {
          return OrderModel.fromJson(responseBody['order']);
        } else {
          throw Exception('The "order" field is missing or invalid');
        }
      } else {
        throw Exception('Failed to fetch the latest order: ${response.body}');
      }
    } catch (e) {
      log('Error fetching the latest order: $e');
      rethrow;
    }
  }

  Future<List<PopularEvent>> getMostPopularEvents() async {
    try {
      final response = await _apiHelper.getRequest(
        endpoint: ApiEndpoints.getMostPopularEvent,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);

        if (responseBody.containsKey('data') && responseBody['data'] is List) {
          final List<dynamic> data = responseBody['data'];
          return data.map((e) => PopularEvent.fromJson(e)).toList();
        } else {
          throw Exception('The "data" field is missing or invalid');
        }
      } else {
        throw Exception(
            'Failed to fetch most popular events: ${response.body}');
      }
    } catch (e) {
      log('Error fetching most popular events: $e');
      rethrow;
    }
  }

  Future<List<EventModel>> getMostRecentEvents() async {
    try {
      final response = await _apiHelper.getRequest(
        endpoint: ApiEndpoints.getMostRecentEvents,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);

        if (responseBody.containsKey('data') && responseBody['data'] is List) {
          final List<dynamic> data = responseBody['data'];
          return data.map((e) => EventModel.fromJson(e)).toList();
        } else {
          throw Exception('The "data" field is missing or invalid');
        }
      } else {
        throw Exception('Failed to fetch most recent events: ${response.body}');
      }
    } catch (e) {
      log('Error fetching most recent events: $e');
      rethrow;
    }
  }

  Future<List<Event>> getNearbyEvents() async {
    final token = StaticData.accessToken;
    if (token == null || token.isEmpty) {
      throw Exception('Authorization token is missing or expired');
    }
    try {
      final response = await _apiHelper.getRequest(
        authToken: token,
        endpoint: '${ApiEndpoints.events}${ApiEndpoints.nearbyEvents}',
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);

        if (responseBody.containsKey('events') &&
            responseBody['events'] is List) {
          final List<dynamic> data = responseBody['events'];

          return data.map((json) => Event.fromJson(json)).toList();
        } else {
          throw Exception('The "data" field is missing or invalid');
        }
      } else {
        throw Exception('Failed to fetch most nearby events: ${response.body}');
      }
    } catch (e) {
      log('Error fetching most recent events: $e');
      rethrow;
    }
  }
}
