import 'dart:developer';

class DashboardDataModel {
  DashboardDataModel({
    required this.status,
    required this.message,
    required this.totalPickup,
    required this.totalDelivery,
  });

  final String status;
  final String message;
  final String totalPickup;
  final String totalDelivery;

  factory DashboardDataModel.fromJson(Map<String, dynamic> json) {
    log("Parsing JSON: $json"); // Debug log to see what's inside JSON

    return DashboardDataModel(
      status: json["status"] ?? "", // Ensure it doesn't break if key is missing
      message: json["message"] ?? "",
      totalPickup:
          json["totalPickup"]?.toString() ?? "0", // Convert to string if needed
      totalDelivery: json["totalDelivery"]?.toString() ?? "0",
    );
  }
}

/*
{
	"status": "success",
	"message": "Dashboard Data",
	"totalPickup": "0",
	"totalDelivery": "0"
}*/
