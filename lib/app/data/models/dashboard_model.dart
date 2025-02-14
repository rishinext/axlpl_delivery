// To parse this JSON data, do
//
//     final dashboardDataModel = dashboardDataModelFromJson(jsonString);

import 'dart:convert';

DashboardDataModel dashboardDataModelFromJson(String str) =>
    DashboardDataModel.fromJson(json.decode(str));

String dashboardDataModelToJson(DashboardDataModel data) =>
    json.encode(data.toJson());

class DashboardDataModel {
  String? status;
  String? message;
  String? totalPickup;
  String? totalDelivery;

  DashboardDataModel({
    this.status,
    this.message,
    this.totalPickup,
    this.totalDelivery,
  });

  factory DashboardDataModel.fromJson(Map<String, dynamic> json) =>
      DashboardDataModel(
        status: json["status"],
        message: json["message"],
        totalPickup: json["totalPickup"],
        totalDelivery: json["totalDelivery"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "totalPickup": totalPickup,
        "totalDelivery": totalDelivery,
      };
}
