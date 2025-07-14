class RenevueModel {
  final String message;
  final String period;
  final List<EstablishmentData> data;

  RenevueModel({
    required this.message,
    required this.period,
    required this.data,
  });

  factory RenevueModel.fromJson(Map<String, dynamic> json) {
    return RenevueModel(
      message: json['message'],
      period: json['period'],
      data: (json['data'] as List)
          .map((item) => EstablishmentData.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'period': period,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class EstablishmentData {
  final int establishmentId;
  final String establishmentName;
  final int totalOrders;
  final String totalRevenue;

  EstablishmentData({
    required this.establishmentId,
    required this.establishmentName,
    required this.totalOrders,
    required this.totalRevenue,
  });

  factory EstablishmentData.fromJson(Map<String, dynamic> json) {
    return EstablishmentData(
      establishmentId: json['establishment_id'],
      establishmentName: json['establishment_name'],
      totalOrders: json['total_orders'],
      totalRevenue: json['total_revenue'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'establishment_id': establishmentId,
      'establishment_name': establishmentName,
      'total_orders': totalOrders,
      'total_revenue': totalRevenue,
    };
  }
}
