class ResponsibleModel {
  int id;
  int? userId;
  final String? managerName;
  final String? email;
  final String companyName;
  final String businessType;
  final String phoneNo;
  final String address;
  final String kbisNumber;
  final String? createdAt;
  final String? updatedAt;

  ResponsibleModel({
    required this.id,
    this.userId,
    this.managerName,
    this.email,
    required this.companyName,
    required this.businessType,
    required this.phoneNo,
    required this.address,
    required this.kbisNumber,
    this.createdAt,
    this.updatedAt,
  });

  factory ResponsibleModel.fromJson(Map<String, dynamic> json) {
    return ResponsibleModel(
      id: json['id'] ?? 0,
      userId: json['userId'],
      companyName: json['companyName'] ?? '',
      businessType: json['businessType'] ?? '',
      phoneNo: json['phoneNo'] ?? '',
      address: json['address'] ?? '',
      kbisNumber: json['kbisNumber'] ?? '',
      managerName: json['managerName'],
      email: json['email'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'companyName': companyName,
      'businessType': businessType,
      'phoneNo': phoneNo,
      'address': address,
      'kbisNumber': kbisNumber,
      'managerName': managerName,
      'email': email,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  static ResponsibleModel fromMap(Map<String, dynamic> userProfile) {
    return ResponsibleModel(
      id: userProfile['id'] ?? 0,
      userId: userProfile['userId'],
      companyName: userProfile['companyName'] ?? '',
      businessType: userProfile['businessType'] ?? '',
      phoneNo: userProfile['phoneNo'] ?? '',
      address: userProfile['address'] ?? '',
      kbisNumber: userProfile['kbisNumber'] ?? '',
      managerName: userProfile['managerName'],
      email: userProfile['email'],
      createdAt: userProfile['createdAt'],
      updatedAt: userProfile['updatedAt'],
    );
  }
}
