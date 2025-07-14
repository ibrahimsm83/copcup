import 'dart:developer';

import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/core/api_end_points.dart';
import 'package:flutter_application_copcup/src/core/api_helper.dart';

class MapRepository {
  static ApiHelper apiHelper = ApiHelper();
  static Future<bool> getCurrentLocation({
    required String longitude,
    required String latitude,
  }) async {
    final response = await apiHelper.postRequest(
        endpoint: ApiEndpoints.setUserLocation,
        data: {
          'longitude': longitude,
          'latitude': latitude,
        },
        authToken: StaticData.accessToken);

    log('Response from setUserLocation: ${response.body}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
