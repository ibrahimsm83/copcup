import 'dart:convert';
import 'dart:developer';

import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/core/api_end_points.dart';
import 'package:flutter_application_copcup/src/core/api_helper.dart';
import 'package:flutter_application_copcup/src/features/responsible/responsible_search_page/model/responsible_recent_search.dart';
import 'package:flutter_application_copcup/src/models/food_item_model.dart';
import 'package:flutter_application_copcup/src/models/recent_search_model.dart';

class ResponsibleSearchRepositery {
  static ApiHelper _apiHelper = ApiHelper();

  static Future<List<ResponsibleRecentSearch>> getRecentSearches() async {
    final token = StaticData.accessToken;
    if (token == null || token.isEmpty) {
      throw Exception('Authorization token is missing or expired');
    }

    try {
      final response = await _apiHelper.getRequest(
        endpoint: ApiEndpoints.professionalRecentSearch,
        authToken: token,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);

        if (responseBody.containsKey('search_history') &&
            responseBody['search_history'] is List) {
          final List<dynamic> recentSearches = responseBody['search_history'];
          return recentSearches
              .map((e) => ResponsibleRecentSearch.fromJson(e))
              .toList();
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

  static Future<List<RecentSearch>> getAllRecentSearches() async {
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

  static Future<bool> clearAllSearch() async {
    final response = await _apiHelper.deleteRequest(
        endpoint: ApiEndpoints.delteAllChatHistory);
    log('------------${response.statusCode}');
    log('------------${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      log('------------${response.body}');

      return true;
    } else {
      return false;
    }
  }

  static Future<List<FoodItemModel>> searchEvents({
    String? foodName,
    String? address,
    List<String>? days,
  }) async {
    final token = StaticData.accessToken;
    if (token == null || token.isEmpty) {
      log('Authorization token is missing or expired');
      return [];
    }

    String queryParams = '';
    if (foodName != null && foodName.isNotEmpty) {
      queryParams += 'query=$foodName';
    }

    final endpoint = '${ApiEndpoints.searchprofessionalFoodItem}?$queryParams';

    try {
      final response = await _apiHelper.getRequest(
        endpoint: endpoint,
        authToken: token,
      );

      log('Response Status Code: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseBody = json.decode(response.body);

        if (!responseBody.containsKey('food_items') ||
            responseBody['food_items'] == null) {
          log('The "food_items" field is missing or null in the response: $responseBody');
          return [];
        }

        if (responseBody['food_items'] is! List) {
          log('The "food_items" field is not a List: $responseBody');
          return [];
        }

        final List<dynamic> eventsList = responseBody['food_items'];
        log('Fetched search data: ${eventsList.length} items found.');

        return eventsList.map((e) => FoodItemModel.fromJson(e)).toList();
      } else {
        log('Failed to search events: ${response.body}');
        return [];
      }
    } catch (e) {
      log('Error searching events: $e');
      return [];
    }
  }

  static Future<bool> deleteRecentSearches({required String id}) async {
    try {
      final response = await _apiHelper.deleteRequest(
        endpoint: "${ApiEndpoints.deleteProfessionalSearch}/$id",
      );
      log('Response${response.statusCode}');
      log('Response${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
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
}
