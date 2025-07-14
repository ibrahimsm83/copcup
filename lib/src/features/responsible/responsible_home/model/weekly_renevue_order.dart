class WeeklyRevenueModel {
  final String? message;
  final String? period;
  final String? eventId;
  final List<DailyRevenueData> data;

  WeeklyRevenueModel({
    this.message,
    this.period,
    this.eventId,
    required this.data,
  });

  factory WeeklyRevenueModel.fromJson(Map<String, dynamic> json) {
    return WeeklyRevenueModel(
      message: json['message'] as String?,
      period: json['period'] as String?,
      eventId: json['event_id']?.toString(), // Ensure it's always a String
      data: (json['data'] as List?)
              ?.map((item) => DailyRevenueData.fromJson(item))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'period': period,
      'event_id': eventId,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class DailyRevenueData {
  final String date;
  final int totalOrders;
  final int totalRevenue;

  DailyRevenueData({
    required this.date,
    required this.totalOrders,
    required this.totalRevenue,
  });

  factory DailyRevenueData.fromJson(Map<String, dynamic> json) {
    return DailyRevenueData(
      date: json['date'],
      totalOrders: json['total_orders'],
      totalRevenue: json['total_revenue'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'total_orders': totalOrders,
      'total_revenue': totalRevenue,
    };
  }
}

class AllIncomeModel {
  final String establishment;
  final double totalRevenue;
  final int totalOrders;

  AllIncomeModel({
    required this.establishment,
    required this.totalRevenue,
    required this.totalOrders,
  });

  // Factory constructor to parse from JSON
  factory AllIncomeModel.fromJson(Map<String, dynamic> json) {
    return AllIncomeModel(
      establishment: json['establishment'] ?? '',
      totalRevenue: double.tryParse(json['total_revenue'] ?? '0') ?? 0.0,
      totalOrders: json['total_orders'] ?? 0,
    );
  }

  // Convert to JSON (optional)
  Map<String, dynamic> toJson() {
    return {
      'establishment': establishment,
      'total_revenue': totalRevenue.toStringAsFixed(2),
      'total_orders': totalOrders,
    };
  }
}
