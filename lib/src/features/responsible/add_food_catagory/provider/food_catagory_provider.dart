import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FoodCategoryProvider extends ChangeNotifier {
  File? selectedImage;
  final categoryNameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Failed to pick image: $e');
    }
  }

  String? validateCategoryName() {
    final text = categoryNameController.text.trim();
    if (text.isEmpty) {
      return 'Category name is required';
    }
    return null;
  }

  void clearFields() {
    categoryNameController.clear();
    selectedImage = null;
    notifyListeners();
  }
}
