import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/models/event_category_model.dart';
import 'package:flutter_application_copcup/src/features/responsible/add_event_catagory/repository/event_category_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';

class EventCategoryController with ChangeNotifier {
  EventCategoryRepository _eventCategoryRepository = EventCategoryRepository();

  bool _isEventCategoryLoading = false;
  bool get isEventCategoryLoading => _isEventCategoryLoading;

  //! Get All Event Category
  List<EventCategoryModel> _eventCategoryList = [];
  List<EventCategoryModel> get eventCategoryList => _eventCategoryList;

  Future<void> getCategoryList() async {
    _isEventCategoryLoading = true;
    notifyListeners();
    _eventCategoryList = await _eventCategoryRepository.getAllEventCategory();
    _isEventCategoryLoading = false;
    notifyListeners();
    print(_eventCategoryList);
  }

  Future<void> getUserCategoryList() async {
    _isEventCategoryLoading = true;
    notifyListeners();
    _eventCategoryList = await _eventCategoryRepository.getUsersEventCategory();
    _isEventCategoryLoading = false;
    notifyListeners();
    print(_eventCategoryList);
  }

  //! Selected Category
  String? _selectedCategory;
  String? get selectedCategory => _selectedCategory;
  int? _selectedCategoryId;
  int? get selectedCategoryId => _selectedCategoryId;

  void selectCategory(String category, int id) {
    _selectedCategory = category;
    _selectedCategoryId = id;
    notifyListeners();
  }

  //! Add Event Category

  Future<void> addEventCategory(
      {required BuildContext context,
      required String name,
      required File image}) async {
    context.loaderOverlay.show();

    final bool result = await _eventCategoryRepository.addEventCategory(
        name: name, image: image);
    if (result) {
      context.loaderOverlay.hide();
      showSnackbar(message: "category added successfully");
      notifyListeners();
      context.pop(true);
      getCategoryList();
    } else {
      context.loaderOverlay.hide();
      showSnackbar(message: "somthing went wrong", isError: true);
    }
  }

  //! Update Event Category
  Future<void> updateEventCategory(
      {required BuildContext context,
      required String name,
      required File image,
      required int id}) async {
    context.loaderOverlay.show();

    final bool result = await _eventCategoryRepository
        .updateEventCategory(
          name: name,
          image: image,
          id: id,
        )
        .whenComplete(getCategoryList);
    if (result) {
      context.loaderOverlay.hide();
      showSnackbar(message: "category updated successfully");
      notifyListeners();
    } else {
      context.loaderOverlay.hide();
      showSnackbar(message: "somthing went wrong", isError: true);
    }
  }

  //! Delete Event Category

  Future<void> deleteEventCategory(
      {required BuildContext context, required String id}) async {
    context.loaderOverlay.show();

    final bool result =
        await _eventCategoryRepository.deleteEventCategory(id: id);
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
