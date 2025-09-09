class CustomerDashboardDataModel {
  CustomerDashboardDataModel({
    required this.error,
    required this.code,
    required this.type,
    required this.message,
    required this.dashboardData,
  });

  final bool? error;
  final int? code;
  final String? type;
  final String? message;
  final DashboardData? dashboardData;

  factory CustomerDashboardDataModel.fromJson(Map<String, dynamic> json) {
    return CustomerDashboardDataModel(
      error: json["error"],
      code: json["code"],
      type: json["type"],
      message: json["message"],
      dashboardData: json["dashboardData"] == null
          ? null
          : DashboardData.fromJson(json["dashboardData"]),
    );
  }
}

class DashboardData {
  DashboardData({
    required this.pickedupCount,
    required this.outForDeliveryCount,
    required this.waitingForPickupCount,
    required this.shippedCount,
    required this.approvedCount,
    required this.archivedCount,
  });

  final int? pickedupCount;
  final int? outForDeliveryCount;
  final int? waitingForPickupCount;
  final int? shippedCount;
  final int? approvedCount;
  final int? archivedCount;

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      pickedupCount: json["pickedup_count"],
      outForDeliveryCount: json["out_for_delivery_count"],
      waitingForPickupCount: json["waiting_for_pickup_count"],
      shippedCount: json["shipped_count"],
      approvedCount: json["approved_count"],
      archivedCount: json["archived_count"],
    );
  }
}
