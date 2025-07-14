import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/utils/custom_snack_bar.dart';
import 'package:flutter_application_copcup/src/features/user/chat/model/chat_room_model.dart';
import 'package:flutter_application_copcup/src/features/user/chat/model/messge_model.dart';
import 'package:flutter_application_copcup/src/features/user/chat/repository/chat_repository.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ChatController with ChangeNotifier {
  final ChatRepository _chatRepository = ChatRepository();

  //! Create Chat Room
  // ChatRoomsModel? _chatRooms;
  // ChatRoomsModel? get chatRooms => _chatRooms;
  // bool _isChatRoomLoading = false;
  // bool get isChatRoomLoading => _isChatRoomLoading;

  Future<void> createChatRoom(
      {required List<int> members,
      required String type,
      required BuildContext context,
      required String name,
      required Function(ChatRoomModel message) onSuccess}) async {
    context.loaderOverlay.show();
    notifyListeners();
    final result = await _chatRepository.createChatRoom(
      members: members,
      type: type,
    );
    result.fold(
        (failure) => showSnackbar(
            message: '-----------------------------failure',
            isError: true), (success) {
      log('----------------------success ${success.id}');

      onSuccess(success);
    });
    context.loaderOverlay.hide();
    notifyListeners();
  }

  Stream<List<SingleChatRoomModel>> chatRoomStream() async* {
    while (true) {
      await Future.delayed(Duration(
          seconds: 2)); // poll every 2s (or use Firebase/WS for real-time)
      final result = await _chatRepository.getChatRooms();

      yield* result.fold(
        (failure) async* {
          log('Chat stream failed: $failure');
          yield [];
        },
        (allChatRoomsData) async* {
          List<SingleChatRoomModel> chatRooms = allChatRoomsData.data;
          chatRooms.sort((a, b) => (b.lastMessageTime ?? DateTime(0))
              .compareTo(a.lastMessageTime ?? DateTime(0)));
          yield chatRooms;
        },
      );
    }
  }

  //! Get List of Chat Room
  ChatRoomsModel? _chatRooms;
  ChatRoomsModel? get chatRooms => _chatRooms;
  bool _isChatRoomLoading = false;
  bool get isChatRoomLoading => _isChatRoomLoading;

  // Future<void> getChatRooms({required BuildContext context}) async {
  //   _isChatRoomLoading = true;
  //   notifyListeners();

  //   final result = await _chatRepository.getChatRooms();

  //   log('--------------API response received--------------');

  //   result.fold(
  //     (failure) {
  //       showSnackbar(message: 'No Chats', isError: false);
  //       log('Failure: $failure');
  //     },
  //     (allChatRoomsData) {
  //       showSnackbar(message: 'Chat data retrieved successfully');
  //       _chatRooms = allChatRoomsData;
  //       log('Chat Rooms Data: $_chatRooms');
  //     },
  //   );

  //   _isChatRoomLoading = false;
  //   notifyListeners();
  // }

  // Receiver
  ChatMemberModel? receiver;
  void updateReceiver({required ChatMemberModel newReceiver}) {
    receiver = newReceiver;
    notifyListeners();
  }

  //! Send Message
  Future<SingleMessageModel?> sendMessage({
    required BuildContext context,
    required int chatRoomID,
    required String message,
  }) async {
    context.loaderOverlay.show();
    notifyListeners();
    final result = await _chatRepository.sendMessage(
        chatRoomID: chatRoomID, message: message);
    result.fold(
      (failure) => showSnackbar(message: failure, isError: true),
      (success) => getAllMessages(chatRoomID: chatRoomID, context: context),
    );

    context.loaderOverlay.hide();
    notifyListeners();
  }

  //! Get All Messages
  MessagesModel? _messagesData;
  MessagesModel? get messagesData => _messagesData;
  bool _isMessagesLoading = false;
  bool get isMessagesLoading => _isMessagesLoading;
  Future<void> getAllMessages({
    required BuildContext context,
    required int chatRoomID,
  }) async {
    _isMessagesLoading = true;
    notifyListeners();
    final result = await _chatRepository.getAllMessages(chatRoomID: chatRoomID);
    result.fold(
      (failure) => showSnackbar(message: failure, isError: true),
      (allMessages) {
        _messagesData = allMessages;
      },
    );

    _isMessagesLoading = false;
    notifyListeners();
  }

  //! Delte A Messages
  Future<void> deleteMessage({
    required BuildContext context,
    required int messageId,
    required String type,
  }) async {
    context.loaderOverlay.show();
    notifyListeners();
    final result =
        await _chatRepository.deleteMessage(messageId: messageId, type: type);
    result.fold((failure) => showSnackbar(message: failure, isError: true),
        (success) => showSnackbar(message: success));

    context.loaderOverlay.hide();
    notifyListeners();
  }
}
