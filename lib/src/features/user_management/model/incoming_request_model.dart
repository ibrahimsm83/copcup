
class IncomingRequestModel {
  final int id;
  final String name;
  final String? surName;
  final String email;
  final String company;
  final String userCreatedAt;
  final String? image;

  IncomingRequestModel({
    required this.id,
    required this.name,
    this.surName,
    required this.email,
    required this.company,
    required this.userCreatedAt,
    this.image,
  });

  // Factory method to create an instance from a JSON object
  factory IncomingRequestModel.fromJson(Map<String, dynamic> json) {
    return IncomingRequestModel(
      id: json['id'],
      name: json['name'],
      surName: json['sur_name'],
      email: json['email'],
      company: json['company'],
      userCreatedAt: json['user_created_at'],
      image: json['image'],
    );
  }

  // Method to convert the instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sur_name': surName,
      'email': email,
      'company': company,
      'user_created_at': userCreatedAt,
      'image': image,
    };
  }
}
