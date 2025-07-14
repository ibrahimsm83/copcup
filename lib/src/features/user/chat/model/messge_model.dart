class MessagesModel {
  final int? currentPage;
  final List<SingleMessageModel>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<MessageLinkModel>? links;
  final String? nextPageUrl;
  final String? path;
  final int? perPage;
  final String? prevPageUrl;
  final int? to;
  final int? total;

  MessagesModel({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory MessagesModel.fromJson(Map<String, dynamic> json) {
    return MessagesModel(
      currentPage: json['current_page'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => SingleMessageModel.fromJson(item))
          .toList(),
      firstPageUrl: json['first_page_url'] as String?,
      from: json['from'] as int?,
      lastPage: json['last_page'] as int?,
      lastPageUrl: json['last_page_url'] as String?,
      links: (json['links'] as List<dynamic>?)
          ?.map((item) => MessageLinkModel.fromJson(item))
          .toList(),
      nextPageUrl: json['next_page_url'] as String?,
      path: json['path'] as String?,
      perPage: json['per_page'] as int?,
      prevPageUrl: json['prev_page_url'] as String?,
      to: json['to'] as int?,
      total: json['total'] as int?,
    );
  }
}

class SingleMessageModel {
  final int? id;
  final int? chatRoomId;
  final int? userId;
  final String? message;
  final String? status;
  final String? deletedFor;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SingleMessageModel({
    this.id,
    this.chatRoomId,
    this.userId,
    this.message,
    this.status,
    this.deletedFor,
    this.createdAt,
    this.updatedAt,
  });

  factory SingleMessageModel.fromJson(Map<String, dynamic> json) {
    return SingleMessageModel(
      id: json['id'] as int?,
      chatRoomId: json['chat_room_id'] as int?,
      userId: json['user_id'] as int?,
      message: json['message'] as String?,
      status: json['status'] as String?,
      deletedFor: json['deleted_for'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }
}

class MessageLinkModel {
  final String? url;
  final String? label;
  final bool? active;

  MessageLinkModel({
    this.url,
    this.label,
    this.active,
  });

  factory MessageLinkModel.fromJson(Map<String, dynamic> json) {
    return MessageLinkModel(
      url: json['url'] as String?,
      label: json['label'] as String?,
      active: json['active'] as bool?,
    );
  }
}
