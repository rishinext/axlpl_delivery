// To parse this JSON data, do
//
//     final shipmentDataModel = shipmentDataModelFromJson(jsonString);

import 'dart:convert';

ShipmentDataModel shipmentDataModelFromJson(String str) =>
    ShipmentDataModel.fromJson(json.decode(str));

String shipmentDataModelToJson(ShipmentDataModel data) =>
    json.encode(data.toJson());

class ShipmentDataModel {
  List<Shipment>? shipment;

  ShipmentDataModel({
    this.shipment,
  });

  factory ShipmentDataModel.fromJson(Map<String, dynamic> json) =>
      ShipmentDataModel(
        shipment: json["shipment"] == null
            ? []
            : List<Shipment>.from(
                json["shipment"]!.map((x) => Shipment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "shipment": shipment == null
            ? []
            : List<dynamic>.from(shipment!.map((x) => x.toJson())),
      };
}

class Shipment {
  List<ShipmentDatum>? shipmentData;
  bool? error;
  int? code;
  String? type;
  String? message;

  Shipment({
    this.shipmentData,
    this.error,
    this.code,
    this.type,
    this.message,
  });

  factory Shipment.fromJson(Map<String, dynamic> json) => Shipment(
        shipmentData: json["shipmentData"] == null
            ? []
            : List<ShipmentDatum>.from(
                json["shipmentData"]!.map((x) => ShipmentDatum.fromJson(x))),
        error: json["error"],
        code: json["code"],
        type: json["type"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "shipmentData": shipmentData == null
            ? []
            : List<dynamic>.from(shipmentData!.map((x) => x.toJson())),
        "error": error,
        "code": code,
        "type": type,
        "message": message,
      };
}

class ShipmentDatum {
  DateTime? createdDate;
  String? shipmentId;
  String? senderCompanyName;
  String? receiverCompanyName;
  String? origin;
  String? destination;
  String? senderAreaname;
  String? receiverAreaname;
  String? senderGstNo;
  String? receiverGstNo;
  String? shipmentStatus;
  final shipmentLabel;

  ShipmentDatum({
    this.createdDate,
    this.shipmentId,
    this.senderCompanyName,
    this.receiverCompanyName,
    this.origin,
    this.destination,
    this.senderAreaname,
    this.receiverAreaname,
    this.senderGstNo,
    this.receiverGstNo,
    this.shipmentStatus,
    this.shipmentLabel,
  });

  factory ShipmentDatum.fromJson(Map<String, dynamic> json) => ShipmentDatum(
        createdDate: json["created_date"] == null
            ? null
            : DateTime.parse(json["created_date"]),
        shipmentId: json["shipment_id"],
        senderCompanyName: json["sender_company_name"],
        receiverCompanyName: json["receiver_company_name"],
        origin: json["origin"],
        destination: json["destination"],
        senderAreaname: json["sender_areaname"],
        receiverAreaname: json["receiver_areaname"],
        senderGstNo: json["sender_gst_no"],
        receiverGstNo: json["receiver_gst_no"],
        shipmentStatus: json["shipment_status"],
        shipmentLabel: json["shipment_label"],
      );

  Map<String, dynamic> toJson() => {
        "created_date": createdDate?.toIso8601String(),
        "shipment_id": shipmentId,
        "sender_company_name": senderCompanyName,
        "receiver_company_name": receiverCompanyName,
        "origin": origin,
        "destination": destination,
        "sender_areaname": senderAreaname,
        "receiver_areaname": receiverAreaname,
        "sender_gst_no": senderGstNo,
        "receiver_gst_no": receiverGstNo,
        "shipment_status": shipmentStatus,
        "shipment_label": shipmentLabel,
      };
}
