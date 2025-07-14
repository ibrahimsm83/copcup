class SupportMessage {
  final int id;
  final String name;
  final String email;
  final String message;
  final DateTime createdAt;
  final DateTime updatedAt;

  SupportMessage({
    required this.id,
    required this.name,
    required this.email,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create a SupportMessage from a JSON object
  factory SupportMessage.fromJson(Map<String, dynamic> json) {
    return SupportMessage(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      message: json['message'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // Method to convert a SupportMessage object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'message': message,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
