import 'dart:developer';

import 'package:flutter_application_copcup/src/core/api_end_points.dart';

class UserProfessionalModel {
  final int id;
  final int? eventId;
  final String name;
  final String surName;
  final String email;
  final String? emailVerifiedAt;
  final String contactNumber;
  final String? image;
  final String pin;
  final String pinExpiresAt;
  final String? stripeAccountId;
  final String walletBalance;
  final String createdAt;
  final String? qrcode;
  final String updatedAt;
  final List<Role> roles;
  final List<Professional> professional;
  final String latitude;
  final String longitude;
  final String? countryCode;

  UserProfessionalModel({
    required this.qrcode,
    required this.latitude,
    required this.longitude,
    required this.countryCode,
    required this.id,
    this.eventId,
    required this.name,
    required this.surName,
    required this.email,
    this.emailVerifiedAt,
    required this.contactNumber,
    this.image,
    required this.pin,
    required this.pinExpiresAt,
    this.stripeAccountId,
    required this.walletBalance,
    required this.createdAt,
    required this.updatedAt,
    required this.roles,
    required this.professional,
  });

  factory UserProfessionalModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> list = json['professional'] ?? [];
    List<Professional> professional = list.isNotEmpty
        ? list.map((abc) => Professional.fromJson(abc)).toList()
        : [];

    String image = json['image'] ??
        'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
    if (!image.contains('http')) {
      image = ApiEndpoints.baseImageUrl + image;
    }

    String qrcode = json['qr_code'] ?? '';
    if (qrcode.isNotEmpty && !qrcode.contains('http')) {
      qrcode = ApiEndpoints.baseImageUrl + qrcode;
    }
    log(qrcode);

    return UserProfessionalModel(
      qrcode: qrcode,
      latitude: json['latitude'] ?? '',
      longitude: json['longitude'] ?? '',
      id: json['id'] ?? 0,
      eventId: json['event_id'],
      name: json['name'] ?? '',
      countryCode: json['country_code'] ?? '',
      surName: json['sur_name'] ?? '',
      email: json['email'] ?? '',
      emailVerifiedAt: json['email_verified_at'],
      contactNumber: json['contact_number'] ?? '',
      image: image,
      pin: json['pin'] ?? '',
      pinExpiresAt: json['pin_expires_at'] ?? '',
      stripeAccountId: json['stripe_account_id'] ?? '',
      walletBalance: json['wallet_balance'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      roles: List<Role>.from(
          (json['roles'] ?? []).map((roleJson) => Role.fromJson(roleJson))),
      professional: professional,
    );
  }
}

class Role {
  final int id;
  final String name;
  final String guardName;

  Role({
    required this.id,
    required this.name,
    required this.guardName,
  });

  // fromJson method
  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      name: json['name'],
      guardName: json['guard_name'],
    );
  }
}

class Professional {
  final int id;
  final int userId;
  final String companyName;
  final String businessType;
  final String phoneNumber;
  final String address;
  final String kbisNumber;
  final String createdAt;
  final String updatedAt;
  final String? bannerImage;

  Professional({
    required this.bannerImage,
    required this.id,
    required this.userId,
    required this.companyName,
    required this.businessType,
    required this.phoneNumber,
    required this.address,
    required this.kbisNumber,
    required this.createdAt,
    required this.updatedAt,
  });

  // fromJson method
  factory Professional.fromJson(Map<String, dynamic> json) {
    String bannerImage = json['banner_image'] ??
        'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
    if (!bannerImage.contains('http')) {
      bannerImage = ApiEndpoints.baseImageUrl + bannerImage;
    }
    return Professional(
      bannerImage: bannerImage,
      id: json['id'],
      userId: json['user_id'],
      companyName: json['company_name'],
      businessType: json['business_type'],
      phoneNumber: json['phone_number'],
      address: json['address'],
      kbisNumber: json['kbis_number'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
