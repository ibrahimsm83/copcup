import 'dart:convert';
import 'dart:developer';
import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/core/api_end_points.dart';
import 'package:flutter_application_copcup/src/core/api_helper.dart';
import 'package:flutter_application_copcup/src/models/event_model.dart';

class FavouritesRepository {
  ApiHelper _apiHelper = ApiHelper();

  Future<List<EventModel>> getAllFavorites() async {
    try {
      final token = StaticData.accessToken;
      if (token == null || token.isEmpty) {
        throw Exception('Authorization token is missing or expired');
      }

      final response = await _apiHelper.getRequest(
        endpoint: "${ApiEndpoints.user}${ApiEndpoints.favourite}",
        authToken: token,
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final List data = responseBody['data'];
        log('fave event =${data}');
        return data.map((e) => EventModel.fromJson(e)).toList();
      } else {
        log("${ApiEndpoints.user}");
        log("${ApiEndpoints.user}${ApiEndpoints.favourite}");
        log('Failed to get favorites: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      log('Error fetching favorites: $e');
      return [];
    }
  }

  Future<bool> addFavorite({required String id}) async {
    try {
      final token = StaticData.accessToken;
      if (token == null || token.isEmpty) {
        throw Exception('Authorization token is missing or expired');
      }
      log("Adding favorite to endpoint: ${ApiEndpoints.events}/$id");

      final response = await _apiHelper.postRequest(
        authToken: token,
        endpoint: "${ApiEndpoints.events}$id${ApiEndpoints.favorite}",
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        log('Failed to add to favorites: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      log('Error adding to favorites: $e');
      return false;
    }
  }

  Future<bool> removeFavorite({required String id}) async {
    try {
      final token = StaticData.accessToken;
      if (token == null || token.isEmpty) {
        throw Exception('Authorization token is missing or expired');
      }

      final response = await _apiHelper.deleteRequest(
        authToken: token,
        endpoint: "${ApiEndpoints.events}$id${ApiEndpoints.favorite}",
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        log('Failed to remove from favorites: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      log('Error removing from favorites: $e');
      return false;
    }
  }
}
