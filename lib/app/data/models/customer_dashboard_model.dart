// To parse this JSON data, do
//
//     final customerDashboardDataModel = customerDashboardDataModelFromJson(jsonString);

import 'dart:convert';

import 'package:axlpl_delivery/app/data/models/contract_details_model.dart';

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
  String? contractID;

  List<Contract>? contracts;

  CustomerDashboardDataModel({
    this.status,
    this.message,
    this.pickedupCount,
    this.outForDeliveryCount,
    this.waitingForPickupCount,
    this.shippedCount,
    this.approvedCount,
    this.archivedCount,
    this.contracts,
    this.contractID,
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
        contractID: json["active_contract_id"],
        contracts: json["contracts"] == null
            ? []
            : List<Contract>.from(
                json["contracts"]!.map((x) => Contract.fromJson(x))),
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
        'active_contract_id': contractID,
        "contracts": contracts == null
            ? []
            : List<dynamic>.from(contracts!.map((x) => x.toJson())),
      };
}
