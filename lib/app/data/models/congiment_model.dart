// To parse this JSON data, do
//
//     final consigmentModel = consigmentModelFromJson(jsonString);

import 'dart:convert';

ConsigmentModel consigmentModelFromJson(String str) =>
    ConsigmentModel.fromJson(json.decode(str));

String consigmentModelToJson(ConsigmentModel data) =>
    json.encode(data.toJson());

class ConsigmentModel {
  List<ConsignmentDatum>? consignmentData;
  String? status;
  String? message;

  ConsigmentModel({
    this.consignmentData,
    this.status,
    this.message,
  });

  factory ConsigmentModel.fromJson(Map<String, dynamic> json) =>
      ConsigmentModel(
        consignmentData: json["consignmentData"] == null
            ? []
            : List<ConsignmentDatum>.from(json["consignmentData"]!
                .map((x) => ConsignmentDatum.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "consignmentData": consignmentData == null
            ? []
            : List<dynamic>.from(consignmentData!.map((x) => x.toJson())),
        "status": status,
        "message": message,
      };
}

class ConsignmentDatum {
  String? id;
  String? consignmentNo;
  String? sourceBranchId;
  String? destinationBranchId;
  String? shipmentId;
  DateTime? date;
  DateTime? acceptedDate;
  String? acceptedById;
  String? acceptedByName;
  String? manifest;
  String? sourceBranchName;
  String? destinationBranchName;
  String? shipmentStatus;

  ConsignmentDatum({
    this.id,
    this.consignmentNo,
    this.sourceBranchId,
    this.destinationBranchId,
    this.shipmentId,
    this.date,
    this.acceptedDate,
    this.acceptedById,
    this.acceptedByName,
    this.manifest,
    this.sourceBranchName,
    this.destinationBranchName,
    this.shipmentStatus,
  });

  factory ConsignmentDatum.fromJson(Map<String, dynamic> json) =>
      ConsignmentDatum(
        id: json["id"],
        consignmentNo: json["consignment_no"],
        sourceBranchId: json["source_branch_id"],
        destinationBranchId: json["destination_branch_id"],
        shipmentId: json["shipment_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        acceptedDate: json["accepted_date"] == null
            ? null
            : DateTime.parse(json["accepted_date"]),
        acceptedById: json["accepted_by_id"],
        acceptedByName: json["accepted_by_name"],
        manifest: json["manifest"],
        sourceBranchName: json["source_branch_name"],
        destinationBranchName: json["destination_branch_name"],
        shipmentStatus: json["shipment_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "consignment_no": consignmentNo,
        "source_branch_id": sourceBranchId,
        "destination_branch_id": destinationBranchId,
        "shipment_id": shipmentId,
        "date": date?.toIso8601String(),
        "accepted_date": acceptedDate?.toIso8601String(),
        "accepted_by_id": acceptedById,
        "accepted_by_name": acceptedByName,
        "manifest": manifest,
        "source_branch_name": sourceBranchName,
        "destination_branch_name": destinationBranchName,
        "shipment_status": shipmentStatus,
      };
}
