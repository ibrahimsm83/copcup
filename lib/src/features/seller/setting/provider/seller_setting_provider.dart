import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SellerSettingProvider with ChangeNotifier {
  File? _imageFile;
  File? get imageFile => _imageFile;

  Future<void> pickImageFromGallery() async {
    try {
      final ImagePicker _picker = ImagePicker();
      if (imageIndex == 0) {
        final XFile? image =
            await _picker.pickImage(source: ImageSource.camera);
        if (image != null) {
          _imageFile = File(image.path);
          log('image Path: ${_imageFile}');
          // return File(image.path);
        } else {
          // return null; // No image selected
        }
      } else {
        final XFile? image =
            await _picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          _imageFile = File(image.path);
          log('image Path: ${_imageFile}');
          // return File(image.path);
        } else {
          // return null; // No image selected
        }
      }
      notifyListeners();
    } catch (e) {
      log('image picker error: $e');
    }
  }

  int _imageIndex = 0;
  int get imageIndex => _imageIndex;
  void selectImageIndex(index) {
    _imageIndex = index;
  }

//________________________seller Profile
  File? _profilePmageFile;
  File? get profilePmageFile => _profilePmageFile;

  Future<void> pickImageFromGalleryProfile() async {
    try {
      final ImagePicker _picker = ImagePicker();
      if (_profileImageIndex == 0) {
        final XFile? image =
            await _picker.pickImage(source: ImageSource.camera);
        if (image != null) {
          _profilePmageFile = File(image.path);
          log('image Path: ${_profilePmageFile}');
          // return File(image.path);
        } else {
          // return null; // No image selected
        }
      } else {
        final XFile? image =
            await _picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          _profilePmageFile = File(image.path);
          log('image Path: ${_profilePmageFile}');
          // return File(image.path);
        } else {
          // return null; // No image selected
        }
      }
      notifyListeners();
    } catch (e) {
      log('image picker error: $e');
    }
  }

  int _profileImageIndex = 0;
  int get profileImageIndex => _profileImageIndex;
  void selectProfileImageIndex(index) {
    _profileImageIndex = index;
  }

  bool _settingSwitch = true;
  bool get settingSwitch => _settingSwitch;
  void settingSwitchToggle() {
    _settingSwitch = !_settingSwitch;
    notifyListeners();
  }
}
