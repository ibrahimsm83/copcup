import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/core/api_end_points.dart';
import 'package:flutter_application_copcup/src/core/api_helper.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationController extends ChangeNotifier {
  String _location = 'Fetching location...';
  String get location => _location;

  final ApiHelper _apiHelper = ApiHelper(); // Initialize the ApiHelper

  // This function retrieves the current location and posts it to the server
  Future<void> getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _location = 'Location services are disabled';
        notifyListeners();
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _location = 'Location permission denied by the user';
          notifyListeners();
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        _location = "${placemark.locality ?? ''}, ${placemark.country ?? ''}";

        // Send the location to the server after fetching the current location
        await _setUserLocation(position.latitude, position.longitude);
      } else {
        _location = 'Unknown location';
      }
    } catch (e) {
      _location = 'Unknown location';
    }

    notifyListeners();
  }

  // Function to post the user's location to the server
  Future<void> _setUserLocation(double latitude, double longitude) async {
    final token = StaticData.accessToken;
    if (token == null || token.isEmpty) {
      throw Exception('Authorization token is missing or expired');
    }
    final data = {
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
    };

    try {
      final response = await _apiHelper.postRequest(
        endpoint: ApiEndpoints.setUserLocation,
        data: data,
        authToken: token,
      );

      // Check for a successful response
      if (response.statusCode == 200) {
        // Handle success if needed, you can update the UI or show a message
        print('Location updated successfully: ${response.body}');
      } else {
        // Handle error from the server
        print('Failed to update location: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending location to server: $e');
    }
  }
}
