// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
// import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
// import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
// import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
// import 'package:flutter_application_copcup/src/common/widgets/custom_textfield.dart';
// import 'package:flutter_application_copcup/src/features/user/chat/controller/chat_controller.dart';
// import 'package:flutter_application_copcup/src/features/user/chat/model/messge_model.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';

// class UserChatPage extends StatefulWidget {
//   final int chatRoomID;

//   const UserChatPage({super.key, required this.chatRoomID});

//   @override
//   State<UserChatPage> createState() => _UserChatPageState();
// }

// class _UserChatPageState extends State<UserChatPage> {
//   final TextEditingController _controller = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     log('id ----------- ${widget.chatRoomID}');
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       final provider = Provider.of<ChatController>(context, listen: false);
//       await provider.getAllMessages(
//           context: context, chatRoomID: widget.chatRoomID);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<ChatController>(context, listen: false);

//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       bottomNavigationBar: Container(
//         padding:
//             EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//         child: Card(
//           elevation: 2,
//           child: CustomTextFormField(
//             fillColor: Colors.transparent,
//             controller: _controller,
//             hint: "Enter message...",
//             suffixIcon: IconButton(
//               icon: Icon(
//                 Icons.send,
//                 color: colorScheme(context).secondary,
//               ),
//               onPressed: () {
//                 if (_controller.text.isNotEmpty) {
//                   final message = _controller.text.trim();

//                   log('----------------${widget.chatRoomID}');
//                   provider
//                       .sendMessage(
//                         context: context,
//                         chatRoomID: widget.chatRoomID,
//                         message: message,
//                       )
//                       .then(
//                         (value) => _controller.clear(),
//                       );
//                 }
//               },
//             ),
//           ),
//         ),
//       ),
//       appBar: CustomAppBar(
//         title: "{provider.receiver!.name}",
//         onLeadingPressed: () {
//           context.pop();
//           log('message');
//         },
//       ),
//       body: Consumer<ChatController>(
//         builder: (context, provider, child) {
//           if (provider.isMessagesLoading) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           final messages = provider.messagesData;

//           if (messages == null) {
//             return Center(
//               child: Text("No Message"),
//             );
//           }

//           if (messages.data!.isEmpty) {
//             return Center(
//               child: Text("No Message"),
//             );
//           }
//           return ListView.separated(
//             reverse: true,
//             padding: EdgeInsets.symmetric(horizontal: 15),
//             itemCount: messages.data!.length,
//             separatorBuilder: (context, index) => SizedBox(height: 10),
//             itemBuilder: (context, index) {
//               final message = messages.data![index];
//               return message.userId == StaticData.userId
//                   ? Slidable(
//                       endActionPane: ActionPane(
//                         motion: ScrollMotion(),
//                         children: [
//                           SlidableAction(
//                             autoClose: true,
//                             onPressed: (context) {
//                               deleteDialog(
//                                   provider: provider, message: message);
//                             },
//                             backgroundColor: Colors.red,
//                             foregroundColor: Colors.white,
//                             icon: Icons.delete_outline,
//                             // label: 'Delete',
//                           ),
//                         ],
//                       ),
//                       child: Align(
//                         alignment: Alignment.centerRight,
//                         child: ConstrainedBox(
//                           constraints: BoxConstraints(
//                             maxWidth: MediaQuery.of(context).size.width * 0.6,
//                           ),
//                           child: Container(
//                             padding: EdgeInsets.all(12),
//                             decoration: BoxDecoration(
//                               color: colorScheme(context).secondary,
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(12)),
//                             ),
//                             child: Text(
//                               message.message!,
//                               softWrap: true,
//                               style: textTheme(context).bodyLarge?.copyWith(
//                                     color: colorScheme(context)
//                                         .surface, // Text color
//                                   ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     )
//                   : Slidable(
//                       startActionPane: ActionPane(
//                         motion: ScrollMotion(),
//                         children: [
//                           SlidableAction(
//                             autoClose: true,
//                             onPressed: (context) {
//                               deleteDialog(
//                                   provider: provider, message: message);
//                             },
//                             backgroundColor: Colors.red,
//                             foregroundColor: Colors.white,
//                             icon: Icons.delete_outline,
//                             // label: 'Delete',
//                           ),
//                         ],
//                       ),
//                       child: Align(
//                         alignment: Alignment.centerLeft,
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Container(
//                               decoration: BoxDecoration(
//                                   color: colorScheme(context).secondary,
//                                   borderRadius: BorderRadius.circular(30)),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(4.0),
//                                 child: SizedBox(
//                                     height: 25,
//                                     width: 25,
//                                     child: Image.asset(AppImages.userImage)),
//                               ),
//                             ),
//                             SizedBox(width: 6),
//                             ConstrainedBox(
//                               constraints: BoxConstraints(
//                                 maxWidth:
//                                     MediaQuery.of(context).size.width * 0.6,
//                               ),
//                               child: Container(
//                                 padding: EdgeInsets.all(12),
//                                 decoration: BoxDecoration(
//                                   color: Colors.black,
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(12)),
//                                 ),
//                                 child: Text(
//                                   message.message!,
//                                   softWrap: true,
//                                   style: textTheme(context).bodyLarge?.copyWith(
//                                         color: colorScheme(context)
//                                             .surface, // Text color
//                                       ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//             },
//           );
//         },
//       ),
//     );
//   }

//   void deleteDialog({
//     required ChatController provider,
//     required SingleMessageModel message,
//   }) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text("Delete Confirmation"),
//         content: Text("Do you really want to delete this message?"),
//         actions: [
//           TextButton(
//             style: TextButton.styleFrom(
//               backgroundColor: Colors.white,
//               foregroundColor: Colors.green,
//               shape: RoundedRectangleBorder(
//                 side: BorderSide(color: Colors.green),
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(10),
//                 ),
//               ),
//             ),
//             onPressed: () {
//               provider
//                   .deleteMessage(
//                     context: context,
//                     messageId: message.id!,
//                     type: "for_me",
//                   )
//                   .then(
//                     (value) => Navigator.pop(context),
//                   );
//             },
//             child: Text("delete for me"),
//           ),
//           TextButton(
//             style: TextButton.styleFrom(
//               backgroundColor: Colors.white,
//               foregroundColor: Colors.red,
//               shape: RoundedRectangleBorder(
//                 side: BorderSide(color: Colors.red),
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(10),
//                 ),
//               ),
//             ),
//             onPressed: () {
//               provider
//                   .deleteMessage(
//                     context: context,
//                     messageId: message.id!,
//                     type: "for_everyone",
//                   )
//                   .then(
//                     (value) => Navigator.pop(context),
//                   );
//             },
//             child: Text("delete for everyone"),
//           ),
//         ],
//       ),
//     );
//   }
// }
////!---------------stream work correctly
// import 'dart:async';
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
// import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
// import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
// import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
// import 'package:flutter_application_copcup/src/common/widgets/custom_textfield.dart';
// import 'package:flutter_application_copcup/src/features/user/chat/controller/chat_controller.dart';
// import 'package:flutter_application_copcup/src/features/user/chat/model/messge_model.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';

// class UserChatPage extends StatefulWidget {
//   final int chatRoomID;

//   const UserChatPage({super.key, required this.chatRoomID});

//   @override
//   State<UserChatPage> createState() => _UserChatPageState();
// }

// class _UserChatPageState extends State<UserChatPage> {
//   final TextEditingController _controller = TextEditingController();
//   final StreamController<List<SingleMessageModel>> _messageController =
//       StreamController<List<SingleMessageModel>>.broadcast();
//   List<SingleMessageModel> _messages = [];
//   Timer? _pollingTimer;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final provider = Provider.of<ChatController>(context, listen: false);
//       _startPolling();
//     });
//   }

//   void _startPolling() {
//     final provider = Provider.of<ChatController>(context, listen: false);
//     _fetchMessages(provider);

//     _pollingTimer = Timer.periodic(Duration(seconds: 3), (timer) {
//       _fetchMessages(provider);
//     });
//   }

//   Future<void> _fetchMessages(ChatController provider) async {
//     try {
//       await provider.getAllMessages(
//           context: context, chatRoomID: widget.chatRoomID);
//       if (provider.messagesData?.data != null) {
//         _messages = provider.messagesData!.data!;
//         _messageController.add(_messages);
//       }
//     } catch (e) {
//       log('Error fetching messages: $e');
//     }
//   }

//   Future<void> _sendMessage(ChatController provider) async {
//     if (_controller.text.isNotEmpty) {
//       final messageText = _controller.text.trim();
//       _controller.clear();

//       log('Sending Message to Chat Room ID: ${widget.chatRoomID}');

//       final sentMessage = await provider.sendMessage(
//         context: context,
//         chatRoomID: widget.chatRoomID,
//         message: messageText,
//       );

//       if (sentMessage != null) {
//         _messages.insert(0, sentMessage); // Add the sent message to the list
//         _messageController.add(_messages); // Notify stream
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _pollingTimer?.cancel();
//     _messageController.close();
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<ChatController>(context, listen: false);

//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       bottomNavigationBar: Container(
//         padding:
//             EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//         child: Card(
//           elevation: 2,
//           child: CustomTextFormField(
//             fillColor: Colors.transparent,
//             controller: _controller,
//             hint: "Enter message...",
//             suffixIcon: IconButton(
//               icon: Icon(Icons.send, color: colorScheme(context).secondary),
//               onPressed: () => _sendMessage(provider),
//             ),
//           ),
//         ),
//       ),
//       appBar: CustomAppBar(
//         title: provider.receiver?.name ?? "Chat",
//         onLeadingPressed: () {
//           context.pop();
//           log('Back to previous screen');
//         },
//       ),
//       body: StreamBuilder<List<SingleMessageModel>>(
//         stream: _messageController.stream,
//         builder: (context, snapshot) {
//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text("No Messages"));
//           }

//           final messages = snapshot.data!;

//           return ListView.separated(
//             reverse: true,
//             padding: EdgeInsets.symmetric(horizontal: 15),
//             itemCount: messages.length,
//             separatorBuilder: (context, index) => SizedBox(height: 10),
//             itemBuilder: (context, index) {
//               final message = messages[index];
//               return message.userId == StaticData.userId
//                   ? _buildMyMessage(message, provider)
//                   : _buildOtherMessage(message, provider);
//             },
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildMyMessage(SingleMessageModel message, ChatController provider) {
//     return Slidable(
//       endActionPane: ActionPane(
//         motion: ScrollMotion(),
//         children: [
//           SlidableAction(
//             autoClose: true,
//             onPressed: (context) =>
//                 deleteDialog(provider: provider, message: message),
//             backgroundColor: Colors.red,
//             foregroundColor: Colors.white,
//             icon: Icons.delete_outline,
//           ),
//         ],
//       ),
//       child: Align(
//         alignment: Alignment.centerRight,
//         child: ConstrainedBox(
//           constraints:
//               BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
//           child: Container(
//             padding: EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: colorScheme(context).secondary,
//               borderRadius: BorderRadius.all(Radius.circular(12)),
//             ),
//             child: Text(
//               message.message!,
//               softWrap: true,
//               style: textTheme(context).bodyLarge?.copyWith(
//                     color: colorScheme(context).surface,
//                   ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildOtherMessage(
//       SingleMessageModel message, ChatController provider) {
//     return Slidable(
//       startActionPane: ActionPane(
//         motion: ScrollMotion(),
//         children: [
//           SlidableAction(
//             autoClose: true,
//             onPressed: (context) =>
//                 deleteDialog(provider: provider, message: message),
//             backgroundColor: Colors.red,
//             foregroundColor: Colors.white,
//             icon: Icons.delete_outline,
//           ),
//         ],
//       ),
//       child: Align(
//         alignment: Alignment.centerLeft,
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 color: colorScheme(context).secondary,
//                 borderRadius: BorderRadius.circular(30),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: SizedBox(
//                     height: 25,
//                     width: 25,
//                     child: Image.asset(AppImages.userImage)),
//               ),
//             ),
//             SizedBox(width: 6),
//             ConstrainedBox(
//               constraints: BoxConstraints(
//                   maxWidth: MediaQuery.of(context).size.width * 0.6),
//               child: Container(
//                 padding: EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.black,
//                   borderRadius: BorderRadius.all(Radius.circular(12)),
//                 ),
//                 child: Text(
//                   message.message!,
//                   softWrap: true,
//                   style: textTheme(context).bodyLarge?.copyWith(
//                         color: colorScheme(context).surface,
//                       ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void deleteDialog(
//       {required ChatController provider, required SingleMessageModel message}) {
//     provider
//         .deleteMessage(context: context, messageId: message.id!, type: "for_me")
//         .then((_) {
//       _messages.removeWhere((msg) => msg.id == message.id);
//       _messageController.add(_messages);
//     });
//   }
// }
import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/app_images.dart';
import 'package:flutter_application_copcup/src/common/constants/global_variable.dart';
import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_app_bar.dart';
import 'package:flutter_application_copcup/src/common/widgets/custom_textfield.dart';
import 'package:flutter_application_copcup/src/features/user/chat/controller/chat_controller.dart';
import 'package:flutter_application_copcup/src/features/user/chat/model/messge_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class UserChatPage extends StatefulWidget {
  final int chatRoomID;
  final String reciverName;

  const UserChatPage(
      {super.key, required this.chatRoomID, required this.reciverName});

  @override
  State<UserChatPage> createState() => _UserChatPageState();
}

class _UserChatPageState extends State<UserChatPage> {
  final TextEditingController _controller = TextEditingController();
  final StreamController<List<SingleMessageModel>> _messageController =
      StreamController.broadcast();
  List<SingleMessageModel> _messages = [];
  Timer? _pollingTimer;

  @override
  void initState() {
    super.initState();
    log('Chat Room ID: ${widget.chatRoomID}');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ChatController>(context, listen: false);
      _startPolling(provider);
    });
  }

  void _startPolling(ChatController provider) {
    _fetchMessages(provider);

    _pollingTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      _fetchMessages(provider);
    });
  }

  Future<void> _fetchMessages(ChatController provider) async {
    // }
    try {
      await provider.getAllMessages(
          context: context, chatRoomID: widget.chatRoomID);
      if (provider.messagesData?.data != null) {
        _messages = provider.messagesData!.data!;
        _messageController.add(_messages);
      }
    } catch (e) {
      log('Error fetching messages: $e');
    }
  }

  Future<void> _sendMessage(ChatController provider) async {
    if (_controller.text.isNotEmpty) {
      final message = _controller.text.trim();
      _controller.clear();

      log('Sending Message in Chat Room ID: ${widget.chatRoomID}');
      final sentMessage = await provider.sendMessage(
        context: context,
        chatRoomID: widget.chatRoomID,
        message: message,
      );

      if (sentMessage != null) {
        _messages.insert(0, sentMessage); // Add new message to top
        _messageController.add(_messages);
      }
    }
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    _messageController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChatController>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Card(
          elevation: 2,
          child: CustomTextFormField(
            fillColor: Colors.transparent,
            controller: _controller,
            hint: "Enter message...",
            suffixIcon: IconButton(
              icon: Icon(
                Icons.send,
                color: colorScheme(context).secondary,
              ),
              onPressed: () => _sendMessage(provider),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: StaticData.role == 'user'
            ? colorScheme(context).primary
            : colorScheme(context).secondary,
        leading: GestureDetector(
          onTap: () {
            context.pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: colorScheme(context).surface,
          ),
        ),
        title: Text(
          widget.reciverName,
          style: textTheme(context).headlineSmall?.copyWith(
                fontSize: 21,
                color: colorScheme(context).surface,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
      body: StreamBuilder<List<SingleMessageModel>>(
        stream: _messageController.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final messages = snapshot.data!;
          if (messages.isEmpty) {
            return Center(child: Text("No Messages"));
          }

          return ListView.separated(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 15),
            itemCount: messages.length,
            separatorBuilder: (context, index) => SizedBox(height: 10),
            itemBuilder: (context, index) {
              final message = messages[index];

              return message.userId == StaticData.userId
                  ? _buildSentMessage(message, provider)
                  : _buildReceivedMessage(message, provider);
            },
          );
        },
      ),
    );
  }

  Widget _buildSentMessage(
      SingleMessageModel message, ChatController provider) {
    return Slidable(
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            autoClose: true,
            onPressed: (context) => _deleteDialog(provider, message),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete_outline,
          ),
        ],
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme(context).secondary,
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Text(
              message.message!,
              softWrap: true,
              style: textTheme(context)
                  .bodyLarge
                  ?.copyWith(color: colorScheme(context).surface),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReceivedMessage(
      SingleMessageModel message, ChatController provider) {
    return Slidable(
      startActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            autoClose: true,
            onPressed: (context) => _deleteDialog(provider, message),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete_outline,
          ),
        ],
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: colorScheme(context).secondary,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: SizedBox(
                    height: 25,
                    width: 25,
                    child: Image.asset(AppImages.userImage)),
              ),
            ),
            SizedBox(width: 6),
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.6),
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Text(
                  message.message!,
                  softWrap: true,
                  style: textTheme(context)
                      .bodyLarge
                      ?.copyWith(color: colorScheme(context).surface),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteDialog(ChatController provider, SingleMessageModel message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Confirmation"),
        content: Text("Do you really want to delete this message?"),
        actions: [
          TextButton(
            onPressed: () {
              provider
                  .deleteMessage(
                      context: context, messageId: message.id!, type: "for_me")
                  .then(
                    (value) => Navigator.pop(context),
                  );
            },
            child: Text("Delete for me"),
          ),
          TextButton(
            onPressed: () {
              provider
                  .deleteMessage(
                      context: context,
                      messageId: message.id!,
                      type: "for_everyone")
                  .then(
                    (value) => Navigator.pop(context),
                  );
            },
            child: Text("Delete for everyone"),
          ),
        ],
      ),
    );
  }
}
