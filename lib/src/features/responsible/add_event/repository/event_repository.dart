import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/core/api_end_points.dart';
import 'package:flutter_application_copcup/src/core/api_helper.dart';
import 'package:flutter_application_copcup/src/models/event_model.dart';
import 'package:flutter_application_copcup/src/models/specific_event_details.dart';
import 'package:fpdart/fpdart.dart';

class EventRepository {
  ApiHelper _apiHelper = ApiHelper();

  Future<List<EventModel>> getAllEvents() async {
    try {
      final response = await _apiHelper.getRequest(
        endpoint: ApiEndpoints.allEvents,
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final List data = responseBody['data'];

        return data.map((e) => EventModel.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e, stc) {
      log('Error fetching Events: $e,\n$stc');
      return [];
    }
  }

  Future<List<EventModel>> getSpecificCatagoryEvents() async {
    try {
      final response = await _apiHelper.getRequest(
        endpoint: ApiEndpoints.specificCatagoryEvents,
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final List data = responseBody['data'];

        return data.map((e) => EventModel.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e, stc) {
      log('Error fetching Events: $e,\n$stc');
      return [];
    }
  }

  Future<List<EventModel>> getUserEvents() async {
    try {
      final response = await _apiHelper.getRequest(
        endpoint: ApiEndpoints.userEvents,
      );
      log('all event data ------${response.body}');
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final List data = responseBody['data'];

        return data.map((e) => EventModel.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      log('Error fetching Events: $e');
      return [];
    }
  }

  Future<List<EventModel>> getNearestEvent() async {
    try {
      final response = await _apiHelper.getRequest(
        endpoint: ApiEndpoints.userEventsNearby,
      );
      log('-----------------${response.statusCode}');
      log('-----------------${response.body}');

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        final List data = responseBody['events'];

        return data.map((e) => EventModel.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      log('Error fetching Events: $e');
      return [];
    }
  }

  Future<EventResponse> getEventDetails(int id) async {
    try {
      final token = StaticData.accessToken;

      if (token == null || token.isEmpty) {
        throw Exception('Authorization token is missing or expired');
      }

      final response = await _apiHelper.getRequest(
        endpoint: '${ApiEndpoints.events}$id/${ApiEndpoints.details}',
        authToken: token,
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        log('Response Body: $responseBody');

        return EventResponse.fromJson(responseBody);
      } else {
        log('Failed to get event details: ${response.statusCode}');
        throw Exception('Failed to fetch event details');
      }
    } catch (e) {
      log('Error fetching event details: $e');
      rethrow;
    }
  }

  Future<bool> addEvent({
    required String event_name,
    required File image,
    required String address,
    required List<String> days,
    required String description,
    required int event_category_id,
    required String start_Date,
    required String end_Date,
  }) async {
    try {
      final data = {
        'event_name': event_name,
        'event_category_id': event_category_id.toString(),
        'address': address,
        'description': description,
        'days': jsonEncode(days),
        'start_date': start_Date,
        'end_date': end_Date,
      };
      final response = await _apiHelper.postFileRequest(
        authToken: StaticData.accessToken,
        data: data,
        endpoint: ApiEndpoints.addEvent,
        file: image,
        key: 'image',
      );

      // Log response details
      final responseBody = await response.stream.bytesToString();
      log('Response Status Code: ${response.statusCode}');
      log('Response Body: $responseBody');

      if (response.statusCode == 201) {
        print(response);
        return true;
      } else {
        print(response.statusCode);
        return false;
      }
    } catch (e) {
      log('Error adding Event: $e');
      return false;
    }
  }

  Future<bool> updateEvent({
    required String event_name,
    required File image,
    required String address,
    required List<String> days,
    required String description,
    required int event_category_id,
    required int id,
    required String start_Date,
    required String end_Date,
  }) async {
    try {
      final token = StaticData.accessToken;
      if (token == null || token.isEmpty) {
        throw Exception('Authorization token is missing or expired');
      }

      final data = {
        'event_name': event_name,
        'event_category_id': event_category_id.toString(),
        'address': address,
        'description': description,
        'days': days.toString(),
        '_method': 'put',
        'start_date': start_Date,
        'end_date': end_Date,
      };
      final response = await _apiHelper.postFileRequest(
        authToken: token,
        data: data,
        endpoint: "${ApiEndpoints.updateEvent}/$id",
        file: image,
        key: 'image',
      );

      // Log response details
      final responseBody = await response.stream.bytesToString();
      log('Response Status Code: ${response.statusCode}');
      log('Response Body: $responseBody');

      if (response.statusCode == 200 || response.statusCode == 204) {
        log('event updated successfully');
        return true;
      } else {
        log('Failed to update event: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      log('Error updating event: $e');
      return false;
    }
  }

  Future<bool> deleteEvent({required String id}) async {
    try {
      final token = StaticData.accessToken;
      if (token == null || token.isEmpty) {
        throw Exception('Authorization token is missing or expired');
      }

      final response = await _apiHelper.deleteRequest(
        endpoint: "${ApiEndpoints.deleteEvent}$id",
        authToken: token,
      );

      if (response.statusCode == 200) {
        // final responseBody = jsonDecode(response.body);
        // String message = responseBody['message'];

        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('Error fetching Events: $e');
      return true;
    }
  }

  //! ############## ASSOCIATE ESTABLISHMENT WITH EVENT ##############
  Future<Either<String, String>> associateEstablishmentWithEvent({
    required int eventId,
  }) async {
    try {
      final token = StaticData.accessToken;
      if (token == null || token.isEmpty) {
        throw Exception('Authorization token is missing or expired');
      }

      final data = {
        'event_id': eventId.toString(),
      };

      final response = await _apiHelper.postRequest(
        authToken: token,
        data: data,
        endpoint: ApiEndpoints.associateEstablishmentWithEvent,
      );

      final statusCode = response.statusCode;
      final responseBody = jsonDecode(response.body);
      if (statusCode == 200 || statusCode == 201) {
        return Right("Request Sent Successfully");
      } else {
        final message = responseBody['error'];
        return Left("$statusCode: $message");
      }
    } catch (e, stackTrace) {
      log('Error associating establishment with event: $e, stackTrace: $stackTrace');
      return Left('Error associating establishment with event: $e');
    }
  }

  //! ############## ALL PROFESSIONAL EVENTS ##############
  Future<Either<String, List<EventModel>>> getProfessionalEvents() async {
    try {
      final token = StaticData.accessToken;
      if (token == null || token.isEmpty) {
        throw Exception('Authorization token is missing or expired');
      }

      final response = await _apiHelper.getRequest(
        authToken: token,
        endpoint: ApiEndpoints.professionalEvents,
      );

      final statusCode = response.statusCode;
      final responseBody = jsonDecode(response.body);
      if (statusCode == 200 || statusCode == 201) {
        final List data = responseBody['data'];
        final List<EventModel> events =
            data.map((e) => EventModel.fromJson(e)).toList();

        return Right(events);
      } else {
        final message = responseBody['message'];
        return Left("$statusCode: $message");
      }
    } catch (e, stackTrace) {
      log('Error fetching professional events: $e, stackTrace: $stackTrace');
      return Left('Error fetching professional events: $e');
    }
  }

  // Future<Either<String, List<EventModel>>>
  //     getProfessionalUnAssignEvent() async {
  //   try {
  //     final token = StaticData.accessToken;
  //     if (token == null || token.isEmpty) {
  //       throw Exception('Authorization token is missing or expired');
  //     }

  //     final response = await _apiHelper.getRequest(
  //       authToken: token,
  //       endpoint: ApiEndpoints.professionalUnAssignedEvents,
  //     );

  //     final statusCode = response.statusCode;
  //     final responseBody = jsonDecode(response.body);
  //     log('------response body   -----099999999999999999--------${responseBody}');
  //     log('------response body--------${response.statusCode}');

  //     if (statusCode == 200 || statusCode == 201) {
  //       final List data = responseBody['data'];
  //       final List<EventModel> events =
  //           data.map((e) => EventModel.fromJson(e)).toList();

  //       return Right(events);
  //     } else {
  //       final message = responseBody['message'];

  //       return Left("$statusCode: $message");
  //     }
  //   } catch (e, stackTrace) {
  //     log('Error fetching professional events: $e, stackTrace: $stackTrace');
  //     return Left('Error fetching professional events: $e');
  //   }
  // }
  Future<Either<String, List<EventModel>>>
      getProfessionalUnAssignEvent() async {
    try {
      final token = StaticData.accessToken;
      if (token == null || token.isEmpty) {
        throw Exception('Authorization token is missing or expired');
      }

      final response = await _apiHelper.getRequest(
        authToken: token,
        endpoint: ApiEndpoints.professionalUnAssignedEvents,
      );

      final statusCode = response.statusCode;
      final responseBody = jsonDecode(response.body);

      log('------response body- ha ya  unassign event kie------- $responseBody');
      log('------status code-------- $statusCode');

      if (statusCode == 200 || statusCode == 201) {
        final dynamic data = responseBody['data'];
        log("Type of responseBody['data']: ${data.runtimeType}");

        if (data is List<dynamic>) {
          final events = data
              .map((e) => EventModel.fromJson(Map<String, dynamic>.from(e)))
              .toList();
          return Right(events);
        } else if (data is Map<String, dynamic>) {
          final events = data.values
              .map((e) => EventModel.fromJson(Map<String, dynamic>.from(e)))
              .toList();
          return Right(events);
        } else {
          return Left("Unexpected data format: ${data.runtimeType}");
        }
      } else {
        final message = responseBody['message'] ?? 'Unknown error occurred';
        return Left("$statusCode: $message");
      }
    } catch (e, stackTrace) {
      log('Error fetching professional events: $e\nStackTrace: $stackTrace');
      return Left('Error fetching professional events: $e');
    }
  }
}
