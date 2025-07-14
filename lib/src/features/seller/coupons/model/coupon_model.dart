class CouponModel {
  final int id;
  final int professionalId;
  final String code;
  final double discountAmount;
  final double discountPercentage;
  final DateTime validFrom;
  final DateTime validUntil;
  final int usageLimit;
  final int usedCount;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  CouponModel({
    required this.id,
    required this.professionalId,
    required this.code,
    required this.discountAmount,
    required this.discountPercentage,
    required this.validFrom,
    required this.validUntil,
    required this.usageLimit,
    required this.usedCount,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      id: json['id'],
      professionalId: json['professional_id'],
      code: json['code'],
      discountAmount: double.parse(json['discount_amount']),
      discountPercentage: double.parse(json['discount_percentage']),
      validFrom: DateTime.parse(json['valid_from']),
      validUntil: DateTime.parse(json['valid_until']),
      usageLimit: json['usage_limit'],
      usedCount: json['used_count'],
      isActive: json['is_active'] == 1,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'professional_id': professionalId,
      'code': code,
      'discount_amount': discountAmount.toStringAsFixed(2),
      'discount_percentage': discountPercentage.toStringAsFixed(2),
      'valid_from': validFrom.toIso8601String(),
      'valid_until': validUntil.toIso8601String(),
      'usage_limit': usageLimit,
      'used_count': usedCount,
      'is_active': isActive ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
