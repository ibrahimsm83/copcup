import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:http/http.dart';

class ApiHelper {
  final Duration _timeoutDuration = const Duration(seconds: 30);

  Future<Response> postRequest({
    required String endpoint,
    dynamic data,
    String? authToken,
    Map<String, String>? h,
  }) async {
    Map<String, String> headers = h ??
        {
          'Content-Type': 'application/json',
          'Accept-Language': StaticData.appLanguage,
          if (authToken != null) 'Authorization': 'Bearer $authToken',
        };

    log('REQUEST TO : $endpoint');
    log('Headers: $headers');

    try {
      final Response response = await post(
        Uri.parse(endpoint),
        headers: headers,
        body: jsonEncode(data),
      ).timeout(_timeoutDuration);

      log('RESPONSE: ${response.statusCode} ${response.body}');
      return response;
    } catch (e, stackTrace) {
      log('Error during POST request: $e', stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<StreamedResponse> postFileRequest({
    required String endpoint,
    required String key,
    File? file,
    Uint8List? imagepath,
    List<File>? files,
    Map<String, String>? data,
    required String authToken,
  }) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $authToken',
      'Accept-Language': StaticData.appLanguage,
    };

    log('REQUEST TO: $endpoint');
    log('Headers: $headers');

    try {
      final request = MultipartRequest('POST', Uri.parse(endpoint));

      if (data != null) {
        request.fields.addEntries(data.entries);
      }
      log('Request Fields: ${request.fields}');

      if (imagepath != null) {
        final multipartFile =
            MultipartFile.fromBytes(key, imagepath, filename: 'image.jpg');
        request.files.add(multipartFile);
        log('Added single file with filename: image.jpg, size: ${imagepath.lengthInBytes}');
      }

      if (file != null) {
        request.files.add(await MultipartFile.fromPath(key, file.path));
        log('Added single file: ${file.path}');
      }

      if (files != null) {
        for (int i = 0; i < files.length; i++) {
          final file = files[i];
          request.files
              .add(await MultipartFile.fromPath('$key[$i]', file.path));
          log('Added file from list: ${file.path}');
        }
      }

      request.headers.addEntries(headers.entries);

      final response = await request.send();
      log('Response Status Code: ${response.statusCode}');

      return response;
    } catch (e, stackTrace) {
      log('Error during POST request: $e', stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<StreamedResponse> postFilesWithDataRequest({
    required String endpoint,
    required String key,
    required List<File> files,
    required Map<String, String> data,
    String? authToken,
  }) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer ${StaticData.accessToken}',
      'Content-Type': 'multipart/form-data',
      'Accept-Language': StaticData.appLanguage,
    };

    log('REQUEST TO : $endpoint');
    log('Headers: $headers');

    try {
      final request = MultipartRequest(
        'POST',
        Uri.parse(endpoint),
      );
      request.headers.addEntries(headers.entries);
      for (File file in files) {
        var filename = file.path.split("/").last;

        request.files.add(
            await MultipartFile.fromPath(key, file.path, filename: filename));
      }
      request.fields.addEntries(data.entries);
      final response = await request.send();
      return response;
    } catch (e, stackTrace) {
      log('Error during POST request: $e', stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<StreamedResponse> putFileRequest({
    required String endpoint,
    required String key,
    File? file,
    List<File>? files,
    Map<String, String>? data,
    required String authToken,
  }) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $authToken',
      'Accept-Language': StaticData.appLanguage,
    };

    log('REQUEST TO: $endpoint');
    log('Headers: $headers');

    try {
      final request = MultipartRequest('PUT', Uri.parse(endpoint));

      if (data != null) {
        request.fields.addEntries(data.entries);
      }
      log('Request Fields: ${request.fields}');

      if (file != null) {
        request.files.add(await MultipartFile.fromPath(key, file.path));
        log('Added single file: ${file.path}');
      }

      if (files != null) {
        for (int i = 0; i < files.length; i++) {
          final file = files[i];
          request.files.add(await MultipartFile.fromPath(
              '$key[$i]', file.path)); // Add each file with an indexed key
          log('Added file from list: ${file.path}');
        }
      }

      // Add headers to the request
      request.headers.addEntries(headers.entries);

      // Send the PUT request
      final response = await request.send();
      log('Response Status Code: ${response.statusCode}');

      // Return the streamed response
      return response;
    } catch (e, stackTrace) {
      log('Error during PUT request with file(s): $e', stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<Response> getRequest({
    required String endpoint,
    String? authToken,
  }) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer ${authToken ?? StaticData.accessToken}',
      'Content-Type': 'application/json',
      'Accept-Language': StaticData.appLanguage,
    };

    log('REQUEST TO : $endpoint');
    log('Headers: $headers');
    try {
      final Response response = await get(Uri.parse(endpoint), headers: headers)
          .timeout(_timeoutDuration);
      return response;
    } catch (e, stackTrace) {
      log('Error while GET request: $e', stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<Response> patchRequest({
    required String endpoint,
    dynamic data,
    String? authToken,
  }) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept-Language': StaticData.appLanguage,
      if (authToken != null) 'Authorization': 'Bearer $authToken',
    };

    log('REQUEST TO : $endpoint');
    log('Headers: $headers');
    try {
      Response response = await patch(
        Uri.parse(endpoint),
        headers: headers,
        body: jsonEncode(data),
      ).timeout(_timeoutDuration);

      log('RESPONSE: ${response.statusCode} ${response.body}');

      return response;
    } catch (e, stackTrace) {
      log('Error during PATCH request: $e', stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<Response> deleteRequest({
    required String endpoint,
    Map<String, String>? data,
    String? authToken,
  }) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer ${authToken ?? StaticData.accessToken}',
      'Content-Type': 'application/json',
      'Accept-Language': StaticData.appLanguage,
    };

    log('REQUEST TO : $endpoint');
    log('Headers: $headers');
    try {
      final Response response = await delete(
        Uri.parse(endpoint),
        headers: headers,
        body: jsonEncode(data),
      ).timeout(_timeoutDuration);
      return response;
    } catch (e, stackTrace) {
      log('Error while delete request: $e', stackTrace: stackTrace);
      rethrow;
    }
  }
}
