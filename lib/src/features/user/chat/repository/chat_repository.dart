import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/core/api_end_points.dart';
import 'package:flutter_application_copcup/src/core/api_helper.dart';
import 'package:flutter_application_copcup/src/features/user/chat/model/chat_room_model.dart';
import 'package:flutter_application_copcup/src/features/user/chat/model/messge_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';

import '../../../../routes/go_router.dart';

class ChatRepository {
  final ApiHelper _apiHelper = ApiHelper();

  //! Create Chat Room
// Future<Either<String, ChatRoomModel>> createChatRoom({
//   required String type,
//   required List<int> members,
// }) async {
//   print("token is ${StaticData.accessToken}");
//   try {
//     final data = {
//       "type": type,
//       "members": members,
//     };
//     log('data is ${data}');
//     final response = await _apiHelper.postRequest(
//       endpoint: "${ApiEndpoints.createChatRoom}",
//       data: data,
//       authToken: StaticData.accessToken,
//     );

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       final responseBody = jsonDecode(response.body);
//       final chatRoomData = responseBody['chat_room'];
//       log('create chat Room response: ${responseBody['status']}');
//       final chatRoomModel = ChatRoomModel.fromMap(chatRoomData);

//       return Right(chatRoomModel);
//     } else {
//       log("repository response is ${response.body}");
//       return Left("${response.statusCode}: Something went wrong");
//     }
//   } catch (e) {
//     log('Error create chat room: $e');
//     return Left('Error create chat room: $e');
//   }
// }

  Future<Either<String, ChatRoomModel>> createChatRoom({
    required String type,
    required List<int> members,
  }) async {
    print("token is ${StaticData.accessToken}");
    try {
      final data = {
        "type": type,
        "members": members,
      };
      log('-----------data is ${data}');
      final response = await _apiHelper.postRequest(
        endpoint: "${ApiEndpoints.createChatRoom}",
        data: data,
        authToken: StaticData.accessToken,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        log('create chat Room response: ${responseBody['status']}');

        final chatRoomData = responseBody['data'];
        final chatRoomModel = ChatRoomModel.fromMap(responseBody['chat_room']);

        log('--------chat model data is ${chatRoomModel.toMap()}');
        return Right(chatRoomModel);
      } else {
        log("repository response is ${response.body}");
        return Left("${response.statusCode}: Something went wrong");
      }
    } catch (e) {
      log('Error create chat room: $e');
      return Left('Error create chat room: $e');
    }
  }

  //! Get List of Chat Room
  // Future<Either<String, ChatRoomsModel>> getChatRooms() async {
  //   print("token is ${StaticData.accessToken}");
  //   try {
  //     final response = await _apiHelper.getRequest(
  //       endpoint: "${ApiEndpoints.listChatRooms}",
  //       authToken: StaticData.accessToken,
  //     );
  //     log("repository statis code is ${response.statusCode}");
  //     log("repository response is ${response.body}");
  //     final responseBody = jsonDecode(response.body);
  //     log("repository response is ${response.body}");

  //     // if (responseBody.containsKey('data') && responseBody['data'] != null) {
  //     //   final data = responseBody['data'];
  //     //   return Right(ChatRoomsModel.fromJson(data));
  //     // } else {
  //     //   return Left("Invalid response: 'data' key is missing or null");
  //     // }
  //     if (response.statusCode == 200 ||
  //         response.statusCode == 201 && responseBody['data'] != null) {
  //       log("repository response is ${response.body}");

  //       final data = responseBody['data'];

  //       return Right(ChatRoomsModel.fromJson(data));
  //     } else {
  //       log("repository response is ${response.body}");
  //       return Left("${response.statusCode}: Something went wrong");
  //     }
  //   } catch (e) {
  //     log('Error Fetching chat room: $e');
  //     return Left('Error Fetching chat room: $e');
  //   }
  // }

  // Future<Either<String, ChatRoomsModel>> getChatRooms() async {
  //   print("token is ${StaticData.accessToken}");
  //   try {
  //     final response = await _apiHelper.getRequest(
  //       endpoint: "${ApiEndpoints.listChatRooms}",
  //       authToken: StaticData.accessToken,
  //     );

  //     log("repository status code is ${response.statusCode}");
  //     log("repository response is ${response.body}");

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       final responseBody = jsonDecode(response.body);
  //       log("repository response is ${response.body}");

  //       if (responseBody.containsKey('chatRooms') &&
  //           responseBody['chatRooms'] != null) {
  //         final data = responseBody['chatRooms'];

  //         return Right(ChatRoomsModel.fromJson(data));
  //       } else {
  //         return Left("Invalid response: 'chatRooms' key is missing or null");
  //       }
  //     } else {
  //       return Left("${response.statusCode}: Something went wrong");
  //     }
  //   } catch (e) {
  //     log('Error Fetching chat room: $e');
  //     return Left('Error Fetching chat room: $e');
  //   }
  // }
  Future<Either<String, ChatRoomsModel>> getChatRooms() async {
    print("token is ${StaticData.accessToken}");
    try {
      final response = await _apiHelper.getRequest(
        endpoint: "${ApiEndpoints.listChatRooms}",
        authToken: StaticData.accessToken,
      );

      log("repository status code is ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);
        log("Decoded response: $responseBody");

        if (responseBody.containsKey('chatRooms') &&
            responseBody['chatRooms'] != null) {
          final data = responseBody['chatRooms'];

          try {
            final chatRoomsModel = ChatRoomsModel.fromJson(data);
            log("Parsed ChatRoomsModel: ${jsonEncode(chatRoomsModel.toJson())}");
            return Right(chatRoomsModel);
          } catch (e) {
            log("Error parsing ChatRoomsModel: $e");
            return Left("Error parsing ChatRoomsModel: $e");
          }
        } else {
          return Left("Invalid response: 'chatRooms' key is missing or null");
        }
      } else {
        return Left("${response.statusCode}: Something went wrong");
      }
    } catch (e) {
      log('Error Fetching chat room: $e');
      return Left('Error Fetching chat room: $e');
    }
  }

  //! Send Message
  Future<Either<String, String>> sendMessage({
    required int chatRoomID,
    required String message,
  }) async {
    print("token is ${StaticData.accessToken}");
    final data = {
      "message": message,
    };
    try {
      final response = await _apiHelper.postRequest(
        endpoint: "${ApiEndpoints.sendMessage}/${chatRoomID}",
        data: data,
        authToken: StaticData.accessToken,
      );
      log("repository status code  is ${response.statusCode}");
      log("repository body is ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);

        final data = responseBody['status'];

        return Right(data);
      } else {
        log("repository response is ${response.body}");
        return Left("${response.statusCode}: Something went wrong");
      }
    } catch (e) {
      log('Error Sending message: $e');
      return Left('Error Sending message: $e');
    }
  }

  //! Get All Messages
  Future<Either<String, MessagesModel>> getAllMessages(
      {required int chatRoomID}) async {
    print("token is ${StaticData.accessToken}");

    try {
      final response = await _apiHelper.getRequest(
        endpoint: "${ApiEndpoints.listMessages}/${chatRoomID}",
        // data: data,
        authToken: StaticData.accessToken,
      );
      log('----.......status code ${response.statusCode}');
      log('----.......status code ${response.body}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);

        final data = responseBody['messages'];

        return Right(MessagesModel.fromJson(data));
      } else {
        log("repository response is ${response.body}");
        return Left("${response.statusCode}: Something went wrong");
      }
    } catch (e) {
      log('Error fetching message: $e');
      return Left('Error fetching message: $e');
    }
  }

  //! Delete a Messages
  Future<Either<String, String>> deleteMessage({
    required int messageId,
    required String type,
  }) async {
    print("token is ${StaticData.accessToken}");
    final data = {"type": type};
    try {
      final response = await _apiHelper.deleteRequest(
        endpoint: "${ApiEndpoints.deleteMessage}/${messageId}",
        data: data,
        authToken: StaticData.accessToken,
      );
      log('==++++++++++++++++++++++++++++++${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = jsonDecode(response.body);

        final data = responseBody['message'];
        log('==++++++++++++++++++++++++++++++${responseBody}');

        return Right(data);
      } else {
        log("repository response is ${response.body}");
        return Left("${response.statusCode}: Something went wrong");
      }
    } catch (e) {
      log('Error deleting message: $e');
      return Left('Error deleting message: $e');
    }
  }
}
