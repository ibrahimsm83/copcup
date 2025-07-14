import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/core/api_end_points.dart';
import 'package:flutter_application_copcup/src/core/api_helper.dart';
import 'package:flutter_application_copcup/src/models/food_catagory_food_item.dart';
import 'package:flutter_application_copcup/src/models/food_catagory_model.dart';

class FoodCatagoryRepository {
  ApiHelper _apiHelper = ApiHelper();

  Future<List<FoodCatagoryModel>> getAllFoodCatagory() async {
    try {
      final token = StaticData.accessToken;
      if (token == null || token.isEmpty) {
        throw Exception('Authorization token is missing or expired');
      }

      final response = await _apiHelper.getRequest(
        endpoint: ApiEndpoints.allFoodCategory,
        authToken: token,
      );
      log('----------food catgory ====================== ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // log('----------food catgory i check if there is event id in the resoisen ${response.body}');

        final responseBody = jsonDecode(response.body);
        final List data = responseBody['data'];

        return data.map((e) => FoodCatagoryModel.fromJson(e)).toList();
      } else {
        log('Failed to get food categories: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      log('Error fetching food categories: $e');
      return [];
    }
  }

  Future<List<FoodCatagoryModel>> getResponsibleAllFoodCatagory() async {
    try {
      final token = StaticData.accessToken;
      if (token == null || token.isEmpty) {
        throw Exception('Authorization token is missing or expired');
      }

      final response = await _apiHelper.getRequest(
        endpoint: ApiEndpoints.professionalFoodcategory,
        authToken: token,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        final List data = responseBody['data'];

        return data.map((e) => FoodCatagoryModel.fromJson(e)).toList();
      } else {
        log('Failed to get food categories: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      log('Error fetching food categories: $e');
      return [];
    }
  }

  Future<FoodResponse> getFoodCatagoryFoodItems(int id) async {
    try {
      final token = StaticData.accessToken;
      if (token == null || token.isEmpty) {
        throw Exception('Authorization token is missing or expired');
      }

      final response = await _apiHelper.getRequest(
        endpoint: '${ApiEndpoints.foodCatgory}/$id/${ApiEndpoints.foodItem}',
        authToken: token,
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        log('Response Body: $responseBody');

        return FoodResponse.fromJson(responseBody);
      } else {
        log('Failed to get food items: ${response.statusCode}');
        throw Exception('Failed to fetch  food items');
      }
    } catch (e) {
      log('Error fetching food item : $e');
      rethrow;
    }
  }

  Future<bool> addFoodCatagory(
      {required String name, required File image, required int eventid}) async {
    try {
      final token = StaticData.accessToken;
      if (token == null || token.isEmpty) {
        throw Exception('Authorization token is missing or expired');
      }

      final data = {'category_name': name, 'event_id': eventid.toString()};
      final response = await _apiHelper.postFileRequest(
        authToken: token,
        data: data,
        endpoint: ApiEndpoints.createFoodCatagory,
        file: image,
        key: 'image',
      );

      final responseBody = await response.stream.bytesToString();
      log('Response Status Code: ${response.statusCode}');
      log('Response Body: $responseBody');

      return response.statusCode == 201;
    } catch (e) {
      log('Error adding category: $e');
      return false;
    }
  }

  Future<bool> updateFoodCategory({
    required String name,
    required File image,
    required int id,
    // required int eventid,
  }) async {
    try {
      final token = StaticData.accessToken;
      if (token == null || token.isEmpty) {
        throw Exception('Authorization token is missing or expired');
      }
      final data = {
        'category_name': name,
        '_method': 'put',
        // 'event_id': eventid.toString()
      };
      final response = await _apiHelper.postFileRequest(
        authToken: StaticData.accessToken,
        data: data,
        endpoint: "${ApiEndpoints.updateFoodCategory}/$id",
        file: image,
        key: 'image',
      );

      final responseBody = await response.stream.bytesToString();
      log('Response Status Code: ${response.statusCode}');
      log('Response Body: $responseBody');

      if (response.statusCode == 200) {
        return true;
      } else {
        log('Failed to update catagory. Status Code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      log('Error updating catagory: $e');
      return false;
    }
  }

  Future<bool> deleteFoodCatagory({required String id}) async {
    try {
      final response = await _apiHelper.deleteRequest(
        endpoint: "${ApiEndpoints.deleteFoodCategory}/$id",
      );

      if (response.statusCode == 200) {
        // final responseBody = jsonDecode(response.body);
        // String message = responseBody['message'];

        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('Error fetching Events: $e');
      return true;
    }
  }
}
