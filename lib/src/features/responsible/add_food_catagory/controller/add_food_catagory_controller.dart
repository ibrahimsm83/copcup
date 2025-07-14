import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';

import 'package:flutter_application_copcup/src/features/responsible/add_food_catagory/repository/add_food_catagory_repository.dart';
import 'package:flutter_application_copcup/src/models/food_catagory_food_item.dart';
import 'package:flutter_application_copcup/src/models/food_catagory_model.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';

class FoodCatagoryController with ChangeNotifier {
  FoodCatagoryRepository _foodCategoryRepository = FoodCatagoryRepository();
  bool isExpanded = false;

  void toggleExpanded() {
    isExpanded = !isExpanded;
    notifyListeners();
  }

  bool _isFoodCategoryLoading = false;
  bool get isFoodCategoryLoading => _isFoodCategoryLoading;

  //! Get All Food Category
  List<FoodCatagoryModel> _foodCategoryList = [];
  List<FoodCatagoryModel> get foodCategoryList => _foodCategoryList;

  Future<void> responsibleGetFoodItem() async {
    _isFoodCategoryLoading = true;
    notifyListeners();
    _foodCategoryList = await _foodCategoryRepository.getAllFoodCatagory();
    _isFoodCategoryLoading = false;
    notifyListeners();
    print(_foodCategoryList);
  }

  Future<void> getFoodCategoryList(int currentEventId) async {
    _isFoodCategoryLoading = true;
    notifyListeners();

    final allCategories = await _foodCategoryRepository.getAllFoodCatagory();

    // Filter based on the current event ID
    _foodCategoryList = allCategories
        .where((category) => category.eventId == currentEventId)
        .toList();
    log('-----length of food list is --====-----===----${_foodCategoryList.length}');
    _isFoodCategoryLoading = false;
    notifyListeners();

    print(_foodCategoryList);
  }

  List<FoodCatagoryModel> _responsiblefoodCategoryList = [];
  List<FoodCatagoryModel> get responsiblefoodCategoryList =>
      _responsiblefoodCategoryList;
  Future<void> getResponsibleFoodCategoryListData() async {
    _isFoodCategoryLoading = true;
    notifyListeners();
    _responsiblefoodCategoryList =
        await _foodCategoryRepository.getResponsibleAllFoodCatagory();
    _isFoodCategoryLoading = false;
    notifyListeners();
    print(_foodCategoryList);
  }

  bool _isFoodCategoryFoodItemLoading = false;
  bool get isFoodCategoryFoodItemLoading => _isFoodCategoryFoodItemLoading;
  FoodResponse? _foodResponseList;
  FoodResponse? get foodResponseList => _foodResponseList;

  Future<void> getFoodCategoryFoodItems(int id) async {
    _isFoodCategoryFoodItemLoading = true;
    notifyListeners();

    try {
      _foodResponseList =
          await _foodCategoryRepository.getFoodCatagoryFoodItems(id);
      print('food  items ----------$_foodResponseList');
      notifyListeners();
    } catch (e) {
      print("Error fetching food items or food categories: $e");
      _foodResponseList = null;
    } finally {
      _isFoodCategoryFoodItemLoading = false;
      notifyListeners();
    }
  }

  //! Selected Category
  String? _selectedCategory;
  String? get selectedCategory => _selectedCategory;

  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  //! Add food Category

  Future<void> addFoodCatagory({
    required BuildContext context,
    required String name,
    required File image,
    required int eventid,
  }) async {
    final token = StaticData.accessToken;
    if (token == null || token.isEmpty) {
      showSnackbar(
          message: "Authorization token is missing or expired", isError: true);
      return;
    }
    context.loaderOverlay.show();

    final bool result = await _foodCategoryRepository.addFoodCatagory(
      name: name,
      image: image,
      eventid: eventid,
    );
    if (result) {
      context.loaderOverlay.hide();
      showSnackbar(message: "category added successfully");
      notifyListeners();
      getResponsibleFoodCategoryListData();
      context.pop(true);
    } else {
      context.loaderOverlay.hide();
      showSnackbar(message: "somthing went wrong", isError: true);
    }
  }

  //! Update Food Category
  Future<void> updateFoodCatagory({
    required BuildContext context,
    required String name,
    required File image,
    required int id,
    // required int eventid,
  }) async {
    context.loaderOverlay.show();

    final bool result = await _foodCategoryRepository
        .updateFoodCategory(
          name: name,
          image: image,
          id: id,
          // eventid: eventid,
        )
        .whenComplete(responsibleGetFoodItem);
    if (result) {
      context.loaderOverlay.hide();
      showSnackbar(message: "category updated successfully");
      notifyListeners();
    } else {
      context.loaderOverlay.hide();
      showSnackbar(message: "somthing went wrong", isError: true);
    }
  }

  //! Delete Food Category

  Future<void> deleteFoodCatagory(
      {required BuildContext context, required String id}) async {
    context.loaderOverlay.show();

    final bool result =
        await _foodCategoryRepository.deleteFoodCatagory(id: id);
    if (result) {
      context.loaderOverlay.hide();
      showSnackbar(message: "category deleted successfully");
      notifyListeners();
      context.pop(true);
    } else {
      context.loaderOverlay.hide();
      showSnackbar(message: "somthing went wrong", isError: true);
    }
  }
}
