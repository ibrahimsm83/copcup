class SellerModel {
  final String name;
  final String surname;
  final String email;
  final int eventid;
  final int id;
  final String? createdAt;
  final String? updatedAt;

  SellerModel({
    required this.name,
    required this.surname,
    required this.email,
    required this.eventid,
    required this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory SellerModel.fromJson(Map<String, dynamic> json) {
    return SellerModel(
      name: json['name'] as String,
      surname: json['surname'] as String,
      email: json['email'] as String,
      eventid: json['eventid'] as int,
      id: json['id'] as int,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'surname': surname,
      'email': email,
      'eventid': eventid,
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
