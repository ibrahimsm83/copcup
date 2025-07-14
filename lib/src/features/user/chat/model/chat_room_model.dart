// class ChatRoomsModel {
//   final int currentPage;
//   final List<SingleChatRoomModel> data;
//   final String firstPageUrl;
//   final int from;
//   final int lastPage;
//   final String lastPageUrl;
//   final List<ChatRoomLinkModel> links;
//   final String? nextPageUrl;
//   final String path;
//   final int perPage;
//   final String? prevPageUrl;
//   final int to;
//   final int total;

//   ChatRoomsModel({
//     required this.currentPage,
//     required this.data,
//     required this.firstPageUrl,
//     required this.from,
//     required this.lastPage,
//     required this.lastPageUrl,
//     required this.links,
//     required this.nextPageUrl,
//     required this.path,
//     required this.perPage,
//     required this.prevPageUrl,
//     required this.to,
//     required this.total,
//   });

//   factory ChatRoomsModel.fromJson(Map<String, dynamic> json) {
//     return ChatRoomsModel(
//       currentPage: json['current_page'] as int,
//       data: (json['data'] as List)
//           .map((e) => SingleChatRoomModel.fromJson(e))
//           .toList(),
//       firstPageUrl: json['first_page_url'] as String,
//       from: json['from'] as int,
//       lastPage: json['last_page'] as int,
//       lastPageUrl: json['last_page_url'] as String,
//       links: (json['links'] as List)
//           .map((e) => ChatRoomLinkModel.fromJson(e))
//           .toList(),
//       nextPageUrl: json['next_page_url'] as String,
//       path: json['path'] as String,
//       perPage: json['per_page'] as int,
//       prevPageUrl: json['prev_page_url'] as String? ?? null,
//       to: json['to'] as int,
//       total: json['total'] as int,
//     );
//   }
//   Map<String, dynamic> toJson() {
//     return {
//       'current_page': currentPage,
//       'data': data.map((e) => e.toJson()).toList(),
//       'first_page_url': firstPageUrl,
//       'from': from,
//       'last_page': lastPage,
//       'last_page_url': lastPageUrl ?? '',
//       'links': links.map((e) => e.toJson()).toList(),
//       'next_page_url': nextPageUrl,
//       'path': path,
//       'per_page': perPage,
//       'prev_page_url': prevPageUrl,
//       'to': to,
//       'total': total,
//     };
//   }
// }

class ChatRoomsModel {
  final int currentPage;
  final List<SingleChatRoomModel> data;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final List<ChatRoomLinkModel> links;
  final String? nextPageUrl;
  final String path;
  final int perPage;
  final String? prevPageUrl;
  final int to;
  final int total;

  ChatRoomsModel({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory ChatRoomsModel.fromJson(Map<String, dynamic> json) {
    return ChatRoomsModel(
      currentPage: json['current_page'] as int? ?? 0,
      data: (json['data'] as List?)
              ?.map((e) => SingleChatRoomModel.fromJson(e))
              .toList() ??
          [],
      firstPageUrl: json['first_page_url'] as String? ?? '',
      from: json['from'] as int? ?? 0,
      lastPage: json['last_page'] as int? ?? 0,
      lastPageUrl: json['last_page_url'] as String? ?? '',
      links: (json['links'] as List?)
              ?.map((e) => ChatRoomLinkModel.fromJson(e))
              .toList() ??
          [],
      nextPageUrl: json['next_page_url'] as String?,
      path: json['path'] as String? ?? '',
      perPage: json['per_page'] as int? ?? 0,
      prevPageUrl: json['prev_page_url'] as String?,
      to: json['to'] as int? ?? 0,
      total: json['total'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'data': data.map((e) => e.toJson()).toList(),
      'first_page_url': firstPageUrl,
      'from': from,
      'last_page': lastPage,
      'last_page_url': lastPageUrl,
      'links': links.map((e) => e.toJson()).toList(),
      'next_page_url': nextPageUrl,
      'path': path,
      'per_page': perPage,
      'prev_page_url': prevPageUrl,
      'to': to,
      'total': total,
    };
  }
}

// class SingleChatRoomModel {
//   final int id;
//   final String type;
//   final int createdBy;
//   final int archived;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final DateTime? lastMessageTime;
//   final String? lastmessage;
//   final int lastMessageSenderId;
//   final List<ChatMemberModel> members;

//   SingleChatRoomModel({
//     required this.id,
//     required this.lastMessageTime,
//     this.lastmessage,
//     required this.lastMessageSenderId,
//     required this.type,
//     required this.createdBy,
//     required this.archived,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.members,
//   });

//   factory SingleChatRoomModel.fromJson(Map<String, dynamic> json) {
//     return SingleChatRoomModel(
//       lastmessage: json['last_message'] ?? '',
//       lastMessageTime: json['last_message_time'] != null
//           ? DateTime.parse(json['last_message_time'])
//           : DateTime.now(),
//       lastMessageSenderId: json['last_message_sender_id'] as int,
//       id: json['id'] as int,
//       type: json['type'] as String,
//       createdBy: json['created_by'] as int,
//       archived: json['archived'] as int,
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//       members: (json['members'] as List)
//           .map((e) => ChatMemberModel.fromJson(e))
//           .toList(),
//     );
//   }
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'type': type,
//       'created_by': createdBy,
//       'archived': archived,
//       'created_at': createdAt.toIso8601String(),
//       'updated_at': updatedAt.toIso8601String(),
//       'last_message_time': lastMessageTime!.toIso8601String(),
//       'last_message': lastmessage,
//       'last_message_sender_id': lastMessageSenderId,
//       'members': members.map((e) => e.toJson()).toList(),
//     };
//   }
// }
class SingleChatRoomModel {
  final int id;
  final String type;
  final int createdBy;
  final int archived;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastMessageTime;
  final String? lastmessage;
  final int lastMessageSenderId;
  final List<ChatMemberModel> members;

  SingleChatRoomModel({
    required this.id,
    required this.lastMessageTime,
    this.lastmessage,
    required this.lastMessageSenderId,
    required this.type,
    required this.createdBy,
    required this.archived,
    required this.createdAt,
    required this.updatedAt,
    required this.members,
  });

  // factory SingleChatRoomModel.fromJson(Map<String, dynamic> json) {
  //   return SingleChatRoomModel(
  //     id: json['id'] as int? ?? 0,
  //     type: json['type'] as String? ?? '',
  //     createdBy: json['created_by'] as int? ?? 0,
  //     archived: json['archived'] as int? ?? 0,
  //     createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
  //     updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
  //     lastMessageTime: json['last_message_time'] != null
  //         ? DateTime.tryParse(json['last_message_time'])
  //         : null,
  //     lastmessage: json['last_message'] as String?,
  //     lastMessageSenderId: json['last_message_sender_id'] as int? ?? 0,
  //     members: (json['members'] as List?)
  //             ?.map((e) => ChatMemberModel.fromJson(e))
  //             .toList() ??
  //         [],
  //   );
  // }
  factory SingleChatRoomModel.fromJson(Map<String, dynamic> json) {
    return SingleChatRoomModel(
      lastmessage: json['last_message'] as String? ?? '',
      lastMessageTime:
          (json['last_message_time'] != null && json['last_message_time'] != '')
              ? DateTime.tryParse(json['last_message_time'])
              : null, // Handle empty string case
      lastMessageSenderId: (json['last_message_sender_id'] != null &&
              json['last_message_sender_id'] != '')
          ? int.tryParse(json['last_message_sender_id'].toString()) ?? 0
          : 0, // Convert empty string to 0
      id: json['id'] as int,
      type: json['type'] as String,
      createdBy: json['created_by'] as int,
      archived: json['archived'] as int,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      members: (json['members'] as List)
          .map((e) => ChatMemberModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'created_by': createdBy,
      'archived': archived,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'last_message_time': lastMessageTime?.toIso8601String(),
      'last_message': lastmessage,
      'last_message_sender_id': lastMessageSenderId,
      'members': members.map((e) => e.toJson()).toList(),
    };
  }
}

// class ChatMemberModel {
//   final int id;
//   final int? eventId;
//   final String name;

//   final String? surName;
//   final String email;
//   final String? emailVerifiedAt;
//   final String? contactNumber;
//   final String? image;
//   final String? pin;
//   final String? pinExpiresAt;
//   final String? stripeAccountId;
//   final String walletBalance;
//   final int isOnline;
//   final String? lastSeen;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final ChatPivotModel pivot;

//   ChatMemberModel({
//     required this.id,
//     this.eventId,
//     required this.name,
//     this.surName,
//     required this.email,
//     this.emailVerifiedAt,
//     this.contactNumber,
//     this.image,
//     this.pin,
//     this.pinExpiresAt,
//     this.stripeAccountId,
//     required this.walletBalance,
//     required this.isOnline,
//     this.lastSeen,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.pivot,
//   });

//   factory ChatMemberModel.fromJson(Map<String, dynamic> json) {
//     return ChatMemberModel(
//       id: json['id'] as int,
//       eventId: json['event_id'] as int?,
//       name: json['name'] as String,
//       surName: json['sur_name'] as String?,
//       email: json['email'] as String,
//       emailVerifiedAt: json['email_verified_at'] as String?,
//       contactNumber: json['contact_number'] as String?,
//       image: json['image'] as String?,
//       pin: json['pin'] as String?,
//       pinExpiresAt: json['pin_expires_at'] as String?,
//       stripeAccountId: json['stripe_account_id'] as String?,
//       walletBalance: json['wallet_balance'] as String,
//       isOnline: json['is_online'] as int,
//       lastSeen: json['last_seen'] as String?,
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//       pivot: ChatPivotModel.fromJson(json['pivot']),
//     );
//   }
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'event_id': eventId,
//       'name': name,
//       'sur_name': surName,
//       'email': email,
//       'email_verified_at': emailVerifiedAt,
//       'contact_number': contactNumber,
//       'image': image,
//       'pin': pin,
//       'pin_expires_at': pinExpiresAt,
//       'stripe_account_id': stripeAccountId,
//       'wallet_balance': walletBalance,
//       'is_online': isOnline,
//       'last_seen': lastSeen,
//       'created_at': createdAt.toIso8601String(),
//       'updated_at': updatedAt.toIso8601String(),
//       'pivot': pivot.toJson(),
//     };
//   }
// }

class ChatMemberModel {
  final int id;
  final int? eventId;
  final String name;
  final String? surName;
  final String email;
  final String? emailVerifiedAt;
  final String? contactNumber;
  final String? image;
  final String? pin;
  final String? pinExpiresAt;
  final String? stripeAccountId;
  final String walletBalance;
  final int isOnline;
  final String? lastSeen;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ChatPivotModel pivot;

  ChatMemberModel({
    required this.id,
    this.eventId,
    required this.name,
    this.surName,
    required this.email,
    this.emailVerifiedAt,
    this.contactNumber,
    this.image,
    this.pin,
    this.pinExpiresAt,
    this.stripeAccountId,
    required this.walletBalance,
    required this.isOnline,
    this.lastSeen,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  factory ChatMemberModel.fromJson(Map<String, dynamic> json) {
    return ChatMemberModel(
      id: json['id'] as int? ?? 0,
      eventId: json['event_id'] as int?,
      name: json['name'] as String? ?? '',
      surName: json['sur_name'] as String?,
      email: json['email'] as String? ?? '',
      emailVerifiedAt: json['email_verified_at'] as String?,
      contactNumber: json['contact_number'] as String?,
      image: json['image'] as String?,
      pin: json['pin'] as String?,
      pinExpiresAt: json['pin_expires_at'] as String?,
      stripeAccountId: json['stripe_account_id'] as String?,
      walletBalance: json['wallet_balance'] as String? ?? '0.0',
      isOnline: json['is_online'] as int? ?? 0,
      lastSeen: json['last_seen'] as String?,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      pivot: ChatPivotModel.fromJson(json['pivot'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'event_id': eventId,
      'name': name,
      'sur_name': surName,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'contact_number': contactNumber,
      'image': image,
      'pin': pin,
      'pin_expires_at': pinExpiresAt,
      'stripe_account_id': stripeAccountId,
      'wallet_balance': walletBalance,
      'is_online': isOnline,
      'last_seen': lastSeen,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'pivot': pivot.toJson(),
    };
  }
}

class ChatPivotModel {
  final int chatRoomId;
  final int userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? lastReadAt;
  final int isArchived;

  ChatPivotModel({
    required this.chatRoomId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    this.lastReadAt,
    required this.isArchived,
  });

  factory ChatPivotModel.fromJson(Map<String, dynamic> json) {
    return ChatPivotModel(
      chatRoomId: json['chat_room_id'] as int,
      userId: json['user_id'] as int,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      lastReadAt: json['last_read_at'] as String?,
      isArchived: json['is_archived'] as int,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'chat_room_id': chatRoomId,
      'user_id': userId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'last_read_at': lastReadAt,
      'is_archived': isArchived,
    };
  }
}

class ChatRoomLinkModel {
  final String? url;
  final String label;
  final bool active;

  ChatRoomLinkModel({
    this.url,
    required this.label,
    required this.active,
  });

  factory ChatRoomLinkModel.fromJson(Map<String, dynamic> json) {
    return ChatRoomLinkModel(
      url: json['url'] as String?,
      label: json['label'] as String,
      active: json['active'] as bool,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'label': label,
      'active': active,
    };
  }
}

class ChatRoomModel {
  final String type;
  final int createdBy;
  final String updatedAt;
  final String createdAt;
  final int id;
  final int archived;

  ChatRoomModel({
    required this.type,
    required this.createdBy,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
    required this.archived,
  });

  // Method to convert object to map
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'created_by': createdBy,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'id': id,
      'archived': archived
    };
  }

  // Factory constructor to create object from map
  factory ChatRoomModel.fromMap(Map<String, dynamic> map) {
    return ChatRoomModel(
      archived: map["archived"] ?? 0,
      type: map['type'] ?? '',
      createdBy: map['created_by'] ?? 0,
      updatedAt: map['updated_at'] ?? '',
      createdAt: map['created_at'] ?? '',
      id: map['id'] ?? 0,
    );
  }
}
