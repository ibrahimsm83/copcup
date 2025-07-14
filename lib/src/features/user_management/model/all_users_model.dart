class AllUsersModel {
  final String name;
  final String? surName;
  final String email;
  final int id;
  final String? userCreatedAt;
  final String? image;
  final List<String> roles;
  final List<String> rolesCreated;

  AllUsersModel({
    required this.name,
    this.surName,
    required this.email,
    required this.id,
    this.userCreatedAt,
    this.image,
    required this.roles,
    required this.rolesCreated,
  });

  factory AllUsersModel.fromJson(Map<String, dynamic> json) {
    return AllUsersModel(
      name: json['name'] as String,
      surName: json['sur_name'] as String?,
      email: json['email'] as String,
      id: json['id'] as int,
      userCreatedAt: json['user_created_at'] as String?,
      image: json['image'] as String?,
      roles: List<String>.from(json['roles']),
      rolesCreated: List<String>.from(json['roles_created']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'sur_name': surName,
      'email': email,
      'id': id,
      'user_created_at': userCreatedAt,
      'image': image,
      'roles': roles,
      'roles_created': rolesCreated,
    };
  }
}
