import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_copcup/src/common/constants/static_data.dart';
import 'package:flutter_application_copcup/src/core/api_end_points.dart';
import 'package:flutter_application_copcup/src/features/user/chat/controller/chat_controller.dart';
import 'package:flutter_application_copcup/src/features/user/chat/model/chat_room_model.dart';
import 'package:flutter_application_copcup/src/routes/go_router.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_copcup/gen_l10n/app_localizations.dart';
class InboxPage extends StatefulWidget {
  const InboxPage({super.key});

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  List<SingleChatRoomModel> filteredChatList = [];
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   final provider = Provider.of<ChatController>(context, listen: false);
    //   await provider.chatRoomStream();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.chats),
      ),
      // body: Consumer<ChatController>(
      //   builder: (context, provider, child) {
      //     if (provider.isChatRoomLoading) {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //     final data = provider.chatRooms;

      //     if (data == null) {
      //       return Center(
      //         child: Text(AppLocalizations.of(context)!.no_chat_found),
      //       );
      //     }

      //     if (data.data.isEmpty) {
      //       return Center(
      //         child: Text(AppLocalizations.of(context)!.no_chat_found),
      //       );
      //     }

      //     return SingleChildScrollView(
      //       padding: EdgeInsets.all(16),
      //       child: Column(
      //         children: [
      //           SearchBar(
      //             onChanged: (value) {
      //               setState(() {
      //                 final filter = provider.receiver!.name
      //                     .toLowerCase()
      //                     .contains(value.toLowerCase());
      //                 print(filter);
      //               });
      //             },
      //             elevation: WidgetStatePropertyAll(0),
      //             backgroundColor: WidgetStatePropertyAll(Colors.grey.shade200),
      //             shape: WidgetStatePropertyAll(
      //               RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.all(
      //                   Radius.circular(5),
      //                 ),
      //               ),
      //             ),
      //             hintText: "Search",
      //             hintStyle: WidgetStatePropertyAll(
      //               TextStyle(
      //                 color: Colors.grey.shade500,
      //               ),
      //             ),
      //             leading: Icon(
      //               Icons.search,
      //               color: Colors.grey.shade500,
      //             ),
      //           ),
      //           SizedBox(height: 12),
      //           ListView.builder(
      //             reverse: true,
      //             shrinkWrap: true,
      //             itemCount: provider.chatRooms!.data.length,
      //             itemBuilder: (context, index) {
      //               final chat = provider.chatRooms!.data[index];
      //               String formattedDate = chat.lastMessageTime != null
      //                   ? DateFormat('hh:mm a').format(chat.lastMessageTime!)
      //                   : '';

      //               ChatMemberModel receiver;
      //               if (chat.members.first.id == StaticData.userId) {
      //                 receiver = chat.members[1];
      //               } else {
      //                 receiver = chat.members[0];
      //               }

      //               return ListTile(
      //                 onTap: () {
      //                   provider.updateReceiver(newReceiver: receiver);
      //                   context.pushNamed(AppRoute.userChat, extra: {
      //                     'id': chat.id,
      //                     'reciverName': receiver.name
      //                   });

      //                   log('------chat id is ${chat.id}');
      //                 },
      //                 contentPadding: EdgeInsets.all(0),
      //                 leading: CircleAvatar(
      //                   backgroundColor: Colors.grey.shade300,
      //                   foregroundImage: receiver.image != null
      //                       ? CachedNetworkImageProvider(
      //                           '${ApiEndpoints.baseImageUrl}${receiver.image!}')
      //                       : null,
      //                   child: receiver.image == null
      //                       ? Icon(
      //                           Icons.person,
      //                           color: Colors.black,
      //                         )
      //                       : null,
      //                 ),
      //                 title: Text(
      //                   receiver.name,
      //                   style: GoogleFonts.roboto(
      //                     fontWeight: FontWeight.w700,
      //                     fontSize: 17,
      //                   ),
      //                 ),
      //                 subtitle: Text(
      //                   "${chat.lastmessage ?? ''}",
      //                   style: GoogleFonts.roboto(
      //                       fontWeight: FontWeight.w700,
      //                       fontSize: 12,
      //                       color: Colors.grey.shade500),
      //                 ),
      //                 trailing: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.end,
      //                   children: [
      //                     Text(
      //                       "${formattedDate ?? ''}",
      //                       style: GoogleFonts.roboto(
      //                         fontWeight: FontWeight.w700,
      //                         fontSize: 12,
      //                         color: Colors.grey.shade700,
      //                       ),
      //                     ),
      //                     // Container(
      //                     //   padding: EdgeInsets.all(3),
      //                     //   decoration: BoxDecoration(
      //                     //     color: colorScheme(context).primary,
      //                     //     borderRadius: BorderRadius.all(
      //                     //       Radius.circular(4),
      //                     //     ),
      //                     //   ),
      //                     //   child: Text(
      //                     //     "0",
      //                     //     style: TextStyle(
      //                     //       color: Colors.white,
      //                     //       fontWeight: FontWeight.w500,
      //                     //     ),
      //                     //   ),
      //                     // )
      //                   ],
      //                 ),
      //               );
      //             },
      //           )
      //         ],
      //       ),
      //     );
      //   },
      // ),
      body: StreamBuilder<List<SingleChatRoomModel>>(
        stream: Provider.of<ChatController>(context, listen: false)
            .chatRoomStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
                child: Text(AppLocalizations.of(context)!.no_chat_found));
          }

          // Sort by lastMessageTime in descending order (latest first)
          final chatList = snapshot.data!
            ..sort((a, b) {
              final aTime =
                  a.lastMessageTime ?? DateTime.fromMillisecondsSinceEpoch(0);
              final bTime =
                  b.lastMessageTime ?? DateTime.fromMillisecondsSinceEpoch(0);
              return bTime.compareTo(aTime); // Latest on top
            });

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                SearchBar(
                  onChanged: (value) {
                    setState(() {
                      // Update your filteredChatList here if needed
                    });
                  },
                  elevation: const WidgetStatePropertyAll(0),
                  backgroundColor: WidgetStatePropertyAll(Colors.grey.shade200),
                  shape: const WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                  hintText: "Search",
                  hintStyle: WidgetStatePropertyAll(
                    TextStyle(color: Colors.grey.shade500),
                  ),
                  leading: Icon(Icons.search, color: Colors.grey.shade500),
                ),
                const SizedBox(height: 12),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: chatList.length,
                  itemBuilder: (context, index) {
                    final chat = chatList[index];
                    final formattedDate = chat.lastMessageTime != null
                        ? DateFormat('hh:mm a').format(chat.lastMessageTime!)
                        : '';

                    final receiver = chat.members.first.id == StaticData.userId
                        ? chat.members[1]
                        : chat.members[0];

                    return ListTile(
                      onTap: () {
                        Provider.of<ChatController>(context, listen: false)
                            .updateReceiver(newReceiver: receiver);
                        context.pushNamed(AppRoute.userChat, extra: {
                          'id': chat.id,
                          'reciverName': receiver.name,
                        });
                      },
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey.shade300,
                        foregroundImage: receiver.image != null
                            ? CachedNetworkImageProvider(
                                '${ApiEndpoints.baseImageUrl}${receiver.image!}')
                            : null,
                        child: receiver.image == null
                            ? const Icon(Icons.person, color: Colors.black)
                            : null,
                      ),
                      title: Text(
                        receiver.name,
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                        ),
                      ),
                      subtitle: Text(
                        chat.lastmessage ?? '',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            formattedDate,
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
