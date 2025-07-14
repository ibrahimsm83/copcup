class ContactUsModel {
  final String? name;
  final String? email;
  final String? message;

  ContactUsModel({
    this.name,
    this.email,
    this.message,
  });

  factory ContactUsModel.fromJson(Map<String, dynamic> json) {
    return ContactUsModel(
      name: json['name'] as String?,
      email: json['email'] as String?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'message': message,
    };
  }
}
