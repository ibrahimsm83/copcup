import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_food_item/repository/food_item_repository.dart';
import 'package:flutter_application_copcup/src/models/food_catagory_model.dart';
import 'package:flutter_application_copcup/src/models/food_item_model.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';

class FoodItemController with ChangeNotifier {
  final FoodItemRepository _foodItemRepository = FoodItemRepository();

  bool _isFoodItemLoading = false;
  bool get isFoodItemLoading => _isFoodItemLoading;

  //! Get All Food Items

  List<FoodItemModel> _foodItemList = [];
  List<FoodItemModel> get foodItemList => _foodItemList;
  List<FoodItemModel> _foodItemListFiltered = [];
  List<FoodItemModel> get foodItemListFiltered => _foodItemListFiltered;
  List<FoodItemModel> _sellerFoodItemList = [];
  List<FoodItemModel> get sellerFoodItemList => _sellerFoodItemList;

  List<FoodItemModel> _filterSellerFoodItemList = [];
  List<FoodItemModel> get filterSellerFoodItemList => _filterSellerFoodItemList;

  int _sellerFoodCatgoerySelectedIndex = -1;
  int get sellerFoodCatgoerySelectedIndex => _sellerFoodCatgoerySelectedIndex;

  int _sellerCopyFoodId = -1;
  int get sellerCopyFoodId => _sellerCopyFoodId;
  void sellerCategoryIdCopy(index) {
    _sellerCopyFoodId = index;
    log('the food categoory id is this ${_sellerCopyFoodId}');
    notifyListeners();
  }

  void sellerFoodIndexsChange(index) {
    _sellerFoodCatgoerySelectedIndex = index;
    log('the food categoory id is this ${_sellerFoodCatgoerySelectedIndex}');
    notifyListeners();
  }

  void sellerChangeFoodWithCategory() {
    if (_sellerFoodCatgoerySelectedIndex == -1) {
      _filterSellerFoodItemList = sellerFoodItemList;
      notifyListeners();
    } else {
      _filterSellerFoodItemList = sellerFoodItemList
          .where((food) => food.foodCategoryId == _sellerCopyFoodId)
          .toList();
      notifyListeners();
    }
  }

  Future<void> getSellerFoodItemList(int id) async {
    _isFoodItemLoading = true;
    notifyListeners();
    var foodItemSellerList = await _foodItemRepository.getAllFoodItem();

    _sellerFoodItemList =
        foodItemSellerList.where((category) => category.eventId == id).toList();

    _isFoodItemLoading = false;
    log('--------show me the all food length ${_sellerFoodItemList.length}');
    notifyListeners();
    print(_sellerFoodItemList);
  }

  Future<void> getFoodItemList(int eventId) async {
    _isFoodItemLoading = true;
    notifyListeners();

    // Fetch all food items
    List<FoodItemModel> allFoodItems =
        await _foodItemRepository.getAllFoodItem();

    log('BEFORE FILTER: ${allFoodItems.length}');

    // Filter items based on eventId
    _foodItemList =
        allFoodItems.where((item) => item.eventId == eventId).toList();

    _isFoodItemLoading = false;
    log('AFTER  Filtered food items count: ${_foodItemList.length}');
    notifyListeners();
  }

  List<FoodItemModel> _foodItemResponsibleList = [];
  List<FoodItemModel> get foodItemResponsibleList => _foodItemResponsibleList;
  List<FoodItemModel> _foodItemResponsibleListFiltered = [];
  List<FoodItemModel> get foodItemResponsibleListFiltered =>
      _foodItemResponsibleListFiltered;
  Future<void> getResponsibleFoodItemList() async {
    log('222222222222222222222-------');
    _isFoodItemLoading = true;
    notifyListeners();
    _foodItemResponsibleList =
        await _foodItemRepository.responsibleGetAllFoodItem();
    _isFoodItemLoading = false;
    log('--------show me the all food length ${_foodItemResponsibleList.length}');
    notifyListeners();
    print(_foodItemResponsibleList);
  }

  Future<void> filterResponsibleFoodItemList(int id) async {
    _isFoodItemLoading = true;
    notifyListeners();
    _foodItemResponsibleListFiltered =
        _foodItemResponsibleList.where((e) => e.foodCategoryId == id).toList();
    _isFoodItemLoading = false;
    log('--------show me the all food length ${_foodItemResponsibleListFiltered.length}');
    notifyListeners();
    print(_foodItemResponsibleListFiltered);
  }

  Future<void> filterFoodItemList(int id) async {
    _isFoodItemLoading = true;
    notifyListeners();
    _foodItemListFiltered =
        _foodItemList.where((e) => e.foodCategoryId == id).toList();
    _isFoodItemLoading = false;
    log('--------show me the all food length ${_foodItemListFiltered.length}');
    notifyListeners();
    print(_foodItemListFiltered);
  }

  //! Selected Item
  String? _selectedItem;
  String? get selectedItem => _selectedItem;

  void selectItem(String item) {
    _selectedItem = item;
    notifyListeners();
  }

  //! Add Food Item
  Future<void> addFoodItem({
    required String name,
    required File image,
    required int foodcategory_id,
    required int eventid,
    required double price,
    required int is_alcoholic,
    required String description,
    required int quantity,
  }) async {
    final token = StaticData.accessToken;
    if (token == null || token.isEmpty) {
      showSnackbar(
          message: "Authorization token is missing or expired", isError: true);
      return;
    }

    final bool result = await _foodItemRepository.addFoodItem(
      quantity: quantity,
      name: name,
      image: image,
      foodcategoryid: foodcategory_id,
      eventid: eventid,
      price: price,
      is_alcoholic: is_alcoholic,
      description: description,
    );

    if (result) {
      showSnackbar(message: "Food item added successfully");
      notifyListeners();
      getFoodItemList(eventid);
    } else {
      showSnackbar(message: "Something went wrong", isError: true);
    }
  }

  //! Update Food Item
  Future<void> updateFoodItem({
    required BuildContext context,
    required String name,
    required File image,
    required int id,
    required int foodcategoryid,
    required int eventid,
    required int price,
    required int is_alcoholic,
    required String description,
    required int quantity,
  }) async {
    context.loaderOverlay.show();

    final bool result = await _foodItemRepository
        .updateFoodItem(
          quantity: quantity,
          name: name,
          image: image,
          id: id,
          foodcategoryid: foodcategoryid,
          eventid: eventid,
          price: price,
          is_alcoholic: is_alcoholic,
          description: description,
        )
        .whenComplete(() => getFoodItemList(eventid));

    context.loaderOverlay.hide();
    if (result) {
      showSnackbar(message: "Food item updated successfully");
      notifyListeners();
      context.pop(true);
    } else {
      // showSnackbar(message: "Something went wrong", isError: true);
    }
  }

  //! Delete Food Item
  Future<void> deleteFoodItem({
    required BuildContext context,
    required String id,
  }) async {
    context.loaderOverlay.show();

    final bool result = await _foodItemRepository.deleteFoodItem(id: id);

    context.loaderOverlay.hide();
    if (result) {
      showSnackbar(message: "Food item deleted successfully");
      notifyListeners();
    } else {
      showSnackbar(message: "Something went wrong", isError: true);
    }
  }

  Future<void> inStockFoodItem({
    required BuildContext context,
    required String id,
  }) async {
    context.loaderOverlay.show();
    notifyListeners();
    try {
      final bool result = await _foodItemRepository.InStockFoodItem(id: id);

      if (result) {
        showSnackbar(message: "Food item in stock ");
        context.pop();
      } else {
        showSnackbar(message: "Something went wrong", isError: true);
      }
    } catch (e) {
      showSnackbar(message: "Something went wrong", isError: true);
    } finally {
      context.loaderOverlay.hide();
      notifyListeners();
    }
  }

  Future<void> outStockFoodItem({
    required BuildContext context,
    required String id,
  }) async {
    context.loaderOverlay.show();
    notifyListeners();
    try {
      final bool result = await _foodItemRepository.OutStockFoodItem(id: id);

      context.loaderOverlay.hide();
      if (result) {
        showSnackbar(message: "Food item out of stock ");
        context.pop();
      } else {
        showSnackbar(message: "Something went wrong", isError: true);
      }
    } catch (e) {
      showSnackbar(message: "Something went wrong", isError: true);
    } finally {
      context.loaderOverlay.hide();
      notifyListeners();
    }
  }

  List<FoodItemModel> _foodItems = [];
  List<FoodCatagoryModel> _foodCategories = [];

  List<FoodItemModel> get foodItems => _foodItems;
  List<FoodCatagoryModel> get foodCategories => _foodCategories;

  Future<void> searchFood(String query) async {
    try {
      final Map<String, dynamic> response =
          await _foodItemRepository.searchFood(query);

      _foodItems = response['food_items'] ?? [];
      _foodCategories = response['food_categories'] ?? [];

      log(' length item: ${_foodItems.length}');
      log(' length itecateg: ${_foodCategories.length}');

      notifyListeners();
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  int _changeindex = -1;
  int get changeindex => _changeindex;
  String _selectedFoodName = '';
  String get selectedFoodName => _selectedFoodName;
  void changeColorIndexOfFood(index, String foodName) {
    _changeindex = index;

    _selectedFoodName = foodName;
    notifyListeners();
  }

  int _foodCatgoerySelectedIndex = -1;
  int get foodCatgoerySelectedIndex => _foodCatgoerySelectedIndex;
  void changeFoodCategoryIndexFunction(index) {
    _foodCatgoerySelectedIndex = index;
    log('the food categoory id is this ${_foodCatgoerySelectedIndex}');
    notifyListeners();
  }

  List<FoodItemModel> _filteredFoods = [];
  List<FoodItemModel> get filteredFoods => _filteredFoods;

  void changeListWithIndexes() {
    if (_foodCatgoerySelectedIndex == -1) {
      _filteredFoods = foodItemList;
      notifyListeners();
    } else {
      _filteredFoods = foodItemList
          .where((food) => food.foodCategoryId == _foodCatgoerySelectedIndex)
          .toList();
      notifyListeners();
    }
  }
}
