import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/core/api_end_points.dart';
import 'package:flutter_application_copcup/src/core/api_helper.dart';
import 'package:flutter_application_copcup/src/models/food_catagory_model.dart';
import 'package:flutter_application_copcup/src/models/food_item_model.dart';

class FoodItemRepository {
  ApiHelper _apiHelper = ApiHelper();

  Future<List<FoodItemModel>> getAllFoodItem() async {
    try {
      final token = StaticData.accessToken;
      if (token == null || token.isEmpty) {
        throw Exception('Authorization token is missing or expired');
      }

      final response = await _apiHelper.getRequest(
        endpoint: ApiEndpoints.allFoodItem,
        authToken: token,
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        log('-----------@@@@@@@@@@------------${responseBody}');
        final List data = responseBody['data'];

        return data.map((e) => FoodItemModel.fromJson(e)).toList();
      } else {
        log('Failed to get food categories: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      log('Error fetching food categories: $e');
      return [];
    }
  }

  Future<List<FoodItemModel>> responsibleGetAllFoodItem() async {
    try {
      final token = StaticData.accessToken;
      if (token == null || token.isEmpty) {
        throw Exception('Authorization token is missing or expired');
      }

      final response = await _apiHelper.getRequest(
        endpoint: ApiEndpoints.professionalFoodItem,
        authToken: token,
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        log('-----------@@@@@@@@@@------------${responseBody}');
        final List data = responseBody['data'];

        return data.map((e) => FoodItemModel.fromJson(e)).toList();
      } else {
        log('Failed to get food categories: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      log('Error fetching food categories: $e');
      return [];
    }
  }

  Future<bool> addFoodItem({
    required String name,
    required File image,
    required int foodcategoryid,
    required int eventid,
    required double price,
    required int is_alcoholic,
    required String description,
    required int quantity,
  }) async {
    try {
      final token = StaticData.accessToken;
      if (token == null || token.isEmpty) {
        throw Exception('Authorization token is missing or expired');
      }

      final data = {
        'name': name,
        'price': price.toString(),
        'is_alcoholic': is_alcoholic.toString(),
        'description': description,
        'event_id': eventid.toString(),
        'foodcategory_id': foodcategoryid.toString(),
        'quantity': quantity.toString(),
      };

      final response = await _apiHelper.postFileRequest(
        authToken: token,
        data: data,
        endpoint: ApiEndpoints.createFoodItem,
        file: image,
        key: 'image',
      );

      final responseBody = await response.stream.bytesToString();
      log('Response Status Code: ${response.statusCode}');
      log('Response Body: $responseBody');

      return response.statusCode == 201;
    } catch (e) {
      log('Error adding food item: $e');
      return false;
    }
  }

  Future<bool> updateFoodItem({
    required int id,
    required String name,
    required File image,
    required int foodcategoryid,
    required int eventid,
    required int price,
    required int is_alcoholic,
    required String description,
    required int quantity,
  }) async {
    try {
      final token = StaticData.accessToken;
      if (token == null || token.isEmpty) {
        throw Exception('Authorization token is missing or expired');
      }

      final data = {
        'name': name,
        'price': price.toString(),
        'is_alcoholic': is_alcoholic.toString(),
        'description': description,
        'event_id': eventid.toString(),
        'foodcategory_id': foodcategoryid.toString(),
        '_method': "put",
        'quantity': quantity.toString(),
      };

      log('Request Data: $data');

      final response = await _apiHelper.postFileRequest(
        authToken: token,
        data: data,
        endpoint: "${ApiEndpoints.updateFoodItem}/$id",
        file: image,
        key: 'image',
      );

      final responseBody = await response.stream.bytesToString();
      log('Response Status Code: ${response.statusCode}');
      log('Response Body: $responseBody');

      if (response.statusCode == 201 || response.statusCode == 204) {
        log('Food item updated successfully');
        return true;
      } else {
        log('Failed to update food item: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      log('Error updating food item: $e');
      return false;
    }
  }

  Future<bool> deleteFoodItem({required String id}) async {
    try {
      final response = await _apiHelper.deleteRequest(
        endpoint: "${ApiEndpoints.deleteFoodItem}/$id",
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('Error fetching Events: $e');
      return true;
    }
  }

  Future<bool> InStockFoodItem({required String id}) async {
    try {
      final response = await _apiHelper.patchRequest(
        authToken: StaticData.accessToken,
        endpoint:
            "${ApiEndpoints.foodItemss}/$id${ApiEndpoints.InStockFoodItem}",
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('Error fetching Events: $e');
      return true;
    }
  }

  Future<bool> OutStockFoodItem({required String id}) async {
    try {
      final response = await _apiHelper.patchRequest(
        authToken: StaticData.accessToken,
        endpoint:
            "${ApiEndpoints.foodItemss}/$id${ApiEndpoints.outOfStockFoodItem}",
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('Error fetching Events: $e');
      return true;
    }
  }

  Future<Map<String, dynamic>> searchFood(String query) async {
    final token = StaticData.accessToken;
    if (token == null || token.isEmpty) {
      throw Exception('Authorization token is missing or expired');
    }

    try {
      // Define the endpoint to search food
      final response = await _apiHelper.getRequest(
        endpoint: '${ApiEndpoints.searchFoodItem}?query=$query',
        authToken: token,
      );
      final Map<String, dynamic> data = json.decode(response.body);
      log('${data}');
      if (response.statusCode == 200) {
        // Parse food categories and food items from the response
        final List<FoodCatagoryModel> foodCategories = [];
        if (data['food_categories'] != null) {
          final List<dynamic> categoryData = data['food_categories'];
          foodCategories.addAll(
            categoryData.map((e) => FoodCatagoryModel.fromJson(e)).toList(),
          );
        }

        final List<FoodItemModel> foodItems = [];
        if (data['food_items'] != null) {
          final List<dynamic> foodItemsData = data['food_items'];
          foodItems.addAll(
            foodItemsData.map((e) => FoodItemModel.fromJson(e)).toList(),
          );
        }

        log('${{
          'food_categories': foodCategories,
          'food_items': foodItems,
        }}');

        // Return both food categories and food items
        return {
          'food_categories': foodCategories,
          'food_items': foodItems,
        };
      } else {
        throw Exception('Failed to load food items');
      }
    } catch (e) {
      throw Exception('Error fetching food: $e');
    }
  }
}
