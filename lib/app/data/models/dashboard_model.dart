class DashboardDataModel {
  final String? status;
  final String? message;
  final String? totalPickup;
  final String? totalDelivery;

  DashboardDataModel({
    this.status,
    this.message,
    this.totalPickup,
    this.totalDelivery,
  });

  factory DashboardDataModel.fromJson(Map<String, dynamic> json) {
    return DashboardDataModel(
      status: json["status"] ?? "",
      message: json["message"] ?? "",
      totalPickup: json["totalPickup"] ?? "0",
      totalDelivery: json["totalDelivery"] ?? "0",
    );
  }
}
