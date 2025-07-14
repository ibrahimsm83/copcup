class UserProfile {
  final int id;
  final String surname;
  final String name;
  final String profileImage;
  final String role;
  final String email;
  final String phonenumber;
  final String? pin;
  final String? pinExpiresAt;
  final String? createdAt;
  final String? updatedAt;
  final String? countryCode;

  UserProfile({
    required this.countryCode,
    required this.id,
    required this.surname,
    required this.name,
    required this.profileImage,
    required this.role,
    required this.email,
    required this.phonenumber,
    this.pin,
    this.pinExpiresAt,
    this.createdAt,
    this.updatedAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] ?? 0,
      surname: json['surname'] ?? '',
      countryCode: json['countryCode'] ?? '',
      name: json['name'] ?? '',
      phonenumber: json['phonenumber'] ?? '',
      email: json['email'] ?? '',
      profileImage: json['profile_image'] ??
          'https://upload.wikimedia.org/wikipedia/en/3/3c/User_default_picture.jpg',
      role: json['role'] ?? '',
      pin: json['pin'],
      pinExpiresAt: json['pin_expires_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'surname': surname,
      'name': name,
      'profile_image': profileImage,
      'role': role,
      'email': email,
      'phonenumber': phonenumber,
      'pin': pin,
      'pin_expires_at': pinExpiresAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'country_code': countryCode,
    };
  }

  static UserProfile fromMap(Map<String, dynamic> userProfile) {
    return UserProfile(
      id: userProfile['id'] ?? 0,
      surname: userProfile['surname'] ?? '',
      countryCode: userProfile['country_code'] ?? '',
      name: userProfile['name'] ?? '',
      phonenumber: userProfile['phonenumber'] ?? '',
      email: userProfile['email'] ?? '',
      profileImage: userProfile['profile_image'] ??
          'https://upload.wikimedia.org/wikipedia/en/3/3c/User_default_picture.jpg',
      role: userProfile['role'] ?? '',
      pin: userProfile['pin'],
      pinExpiresAt: userProfile['pin_expires_at'],
      createdAt: userProfile['created_at'],
      updatedAt: userProfile['updated_at'],
    );
  }
}
