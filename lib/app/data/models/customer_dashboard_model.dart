// To parse this JSON data, do
//
//     final customerDashboardDataModel = customerDashboardDataModelFromJson(jsonString);

import 'dart:convert';

CustomerDashboardDataModel customerDashboardDataModelFromJson(String str) =>
    CustomerDashboardDataModel.fromJson(json.decode(str));

String customerDashboardDataModelToJson(CustomerDashboardDataModel data) =>
    json.encode(data.toJson());

class CustomerDashboardDataModel {
  String? status;
  String? message;
  String? pickedupCount;
  String? outForDeliveryCount;
  String? waitingForPickupCount;
  String? shippedCount;
  String? approvedCount;
  String? archivedCount;

  CustomerDashboardDataModel({
    this.status,
    this.message,
    this.pickedupCount,
    this.outForDeliveryCount,
    this.waitingForPickupCount,
    this.shippedCount,
    this.approvedCount,
    this.archivedCount,
  });

  factory CustomerDashboardDataModel.fromJson(Map<String, dynamic> json) =>
      CustomerDashboardDataModel(
        status: json["status"],
        message: json["message"],
        pickedupCount: json["pickedup_count"],
        outForDeliveryCount: json["out_for_delivery_count"],
        waitingForPickupCount: json["waiting_for_pickup_count"],
        shippedCount: json["shipped_count"],
        approvedCount: json["approved_count"],
        archivedCount: json["archived_count"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "pickedup_count": pickedupCount,
        "out_for_delivery_count": outForDeliveryCount,
        "waiting_for_pickup_count": waitingForPickupCount,
        "shipped_count": shippedCount,
        "approved_count": approvedCount,
        "archived_count": archivedCount,
      };
}
