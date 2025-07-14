import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/features/user/user_map_screen/map_repository.dart';
import 'package:flutter_application_copcup/src/models/event_category_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class CategoryProvider extends ChangeNotifier {
  EventCategoryModel? _selectedCategory;

  EventCategoryModel? get selectedCategory => _selectedCategory;

  void selectCategory(EventCategoryModel category) {
    _selectedCategory = category;
    notifyListeners();
  }

  String? _selectedAddress;
  String? get selectedAddress => _selectedAddress;
  void setSelectedAddress(String address) {
    _selectedAddress = address;

    log('Selected address: $_selectedAddress');
    notifyListeners();
  }

  Future<void> fetchAndSendLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // Check location services
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return;

      // Check permission
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return;
      }

      if (permission == LocationPermission.deniedForever) return;

      final Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      await MapRepository.getCurrentLocation(
        latitude: position.latitude.toString(),
        longitude: position.longitude.toString(),
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final Placemark place = placemarks.first;
        final String address =
            '${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}';

        _selectedAddress = address;
      }

      notifyListeners();
    } catch (e) {
      log('-----------e${e}');
    }
  }
}
