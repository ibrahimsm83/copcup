// class Transaction {
//   final int id;
//   final int userId;
//   final double amount;
//   final String status;
//   final String stripeSessionId;
//   final int sellerId;
//   final String createdAt;
//   final String updatedAt;
//   final String confirmationToken;
//   final User user;

//   Transaction({
//     required this.id,
//     required this.userId,
//     required this.amount,
//     required this.status,
//     required this.stripeSessionId,
//     required this.sellerId,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.confirmationToken,
//     required this.user,
//   });

//   // fromJson method
//   factory Transaction.fromJson(Map<String, dynamic> json) {
//     return Transaction(
//       id: json['id'] ?? 0,
//       userId: json['user_id'] ?? 0,
//       amount: double.tryParse(json['amount'].toString()) ?? 0.0,
//       status: json['status'] ?? '',
//       stripeSessionId: json['stripe_session_id'] ?? '',
//       sellerId: json['seller_id'] ?? 0,
//       createdAt: json['created_at'] ?? '',
//       updatedAt: json['updated_at'] ?? '',
//       confirmationToken: json['confirmation_token'] ?? '',
//       user: User.fromJson(json['user']),
//     );
//   }
// }

// class User {
//   final int id;
//   final String name;
//   final String surName;
//   final String email;
//   final String latitude;
//   final String longitude;
//   final String contactNumber;
//   final String countryCode;
//   final String qrCode;
//   final double walletBalance;
//   final bool isOnline;

//   User({
//     required this.id,
//     required this.name,
//     required this.surName,
//     required this.email,
//     required this.latitude,
//     required this.longitude,
//     required this.contactNumber,
//     required this.countryCode,
//     required this.qrCode,
//     required this.walletBalance,
//     required this.isOnline,
//   });

//   // fromJson method for User
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'] ?? 0,
//       name: json['name'] ?? '',
//       surName: json['sur_name'] ?? '',
//       email: json['email'] ?? '',
//       latitude: json['latitude'] ?? '',
//       longitude: json['longitude'] ?? '',
//       contactNumber: json['contact_number'] ?? '',
//       countryCode: json['country_code'] ?? '',
//       qrCode: json['qr_code'] ?? '',
//       walletBalance: double.tryParse(json['wallet_balance'].toString()) ?? 0.0,
//       isOnline: json['is_online'] == 1,
//     );
//   }
// }

class Transaction {
  final int id;
  final int userId;
  final double amount;
  final String status;
  final int sellerId;
  final String createdAt;
  final String updatedAt;
  final String transactionType;
  final double stripeFee;
  final double adminFee;
  final double netAmount;
  final User seller; // Renamed from 'user' to 'seller'

  Transaction({
    required this.id,
    required this.userId,
    required this.amount,
    required this.status,
    required this.sellerId,
    required this.createdAt,
    required this.updatedAt,
    required this.transactionType,
    required this.stripeFee,
    required this.adminFee,
    required this.netAmount,
    required this.seller,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      amount: double.tryParse(json['amount'].toString()) ?? 0.0,
      status: json['status'] ?? '',
      sellerId: json['seller_id'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      transactionType: json['transaction_type'] ?? '',
      stripeFee: double.tryParse(json['stripe_fee'].toString()) ?? 0.0,
      adminFee: double.tryParse(json['admin_fee'].toString()) ?? 0.0,
      netAmount: double.tryParse(json['net_amount'].toString()) ?? 0.0,
      seller: User.fromJson(json['seller']),
    );
  }
}

class User {
  final int id;
  final String name;
  final String surName;
  final String email;
  final String? latitude;
  final String? longitude;
  final String? contactNumber;
  final String? countryCode;
  final String? image;
  final double walletBalance;
  final bool isOnline;

  User({
    required this.id,
    required this.name,
    required this.surName,
    required this.email,
    this.latitude,
    this.longitude,
    this.contactNumber,
    this.countryCode,
    this.image,
    required this.walletBalance,
    required this.isOnline,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      surName: json['sur_name'] ?? '',
      email: json['email'] ?? '',
      latitude: json['latitude'],
      longitude: json['longitude'],
      contactNumber: json['contact_number'],
      countryCode: json['country_code'],
      image: json['image'],
      walletBalance: double.tryParse(json['wallet_balance'].toString()) ?? 0.0,
      isOnline: json['is_online'] == 1,
    );
  }
}
