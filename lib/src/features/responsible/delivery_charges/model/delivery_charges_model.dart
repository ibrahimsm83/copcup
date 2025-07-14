class DeliveryChargesModel {
  final int id;
  final int sellerId;
  final String baseDeliveryFee;
  final String deliveryPerKm;
  final String minimumOrderFee;
  final String freeDeliveryThreshold;
  final int isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  DeliveryChargesModel({
    required this.id,
    required this.sellerId,
    required this.baseDeliveryFee,
    required this.deliveryPerKm,
    required this.minimumOrderFee,
    required this.freeDeliveryThreshold,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DeliveryChargesModel.fromJson(Map<String, dynamic> json) {
    return DeliveryChargesModel(
      id: json['id'] as int,
      sellerId: json['professional_id'] as int,
      baseDeliveryFee: json['base_delivery_fee'] as String,
      deliveryPerKm: json['delivery_per_km'] as String,
      minimumOrderFee: json['minimum_order_fee'] as String,
      freeDeliveryThreshold: json['free_delivery_threshold'] as String,
      isActive: json['is_active'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'professional_id': sellerId,
      'base_delivery_fee': baseDeliveryFee,
      'delivery_per_km': deliveryPerKm,
      'minimum_order_fee': minimumOrderFee,
      'free_delivery_threshold': freeDeliveryThreshold,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
