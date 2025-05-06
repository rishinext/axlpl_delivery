// To parse this JSON data, do
//
//     final congismentModel = congismentModelFromJson(jsonString);

import 'dart:convert';

CongismentModel congismentModelFromJson(String str) =>
    CongismentModel.fromJson(json.decode(str));

String congismentModelToJson(CongismentModel data) =>
    json.encode(data.toJson());

class CongismentModel {
  List<Shipment>? shipment;

  CongismentModel({
    this.shipment,
  });

  factory CongismentModel.fromJson(Map<String, dynamic> json) =>
      CongismentModel(
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
  String? shipmentId;
  String? customerId;
  String? origin;
  String? destination;
  String? senderName;
  String? senderMobile;
  String? senderAddress1;
  String? senderEmail;
  String? receiverName;
  String? receiverMobile;
  String? receiverAddress1;
  String? receiverEmail;
  String? paymentMode;
  String? shipmentCharges;
  String? insuranceValue;
  String? remark;
  String? axlplInsurance;
  String? grossWeight;
  String? invoiceValue;

  ShipmentDatum({
    this.shipmentId,
    this.customerId,
    this.origin,
    this.destination,
    this.senderName,
    this.senderMobile,
    this.senderAddress1,
    this.senderEmail,
    this.receiverName,
    this.receiverMobile,
    this.receiverAddress1,
    this.receiverEmail,
    this.paymentMode,
    this.shipmentCharges,
    this.insuranceValue,
    this.remark,
    this.axlplInsurance,
    this.grossWeight,
    this.invoiceValue,
  });

  factory ShipmentDatum.fromJson(Map<String, dynamic> json) => ShipmentDatum(
        shipmentId: json["shipment_id"],
        customerId: json["customer_id"],
        origin: json["origin"],
        destination: json["destination"],
        senderName: json["sender_name"],
        senderMobile: json["sender_mobile"],
        senderAddress1: json["sender_address1"],
        senderEmail: json["sender_email"],
        receiverName: json["receiver_name"],
        receiverMobile: json["receiver_mobile"],
        receiverAddress1: json["receiver_address1"],
        receiverEmail: json["receiver_email"],
        paymentMode: json["payment_mode"],
        shipmentCharges: json["shipment_charges"],
        insuranceValue: json["insurance_value"],
        remark: json["remark"],
        axlplInsurance: json["axlpl_insurance"],
        grossWeight: json["gross_weight"],
        invoiceValue: json["invoice_value"],
      );

  Map<String, dynamic> toJson() => {
        "shipment_id": shipmentId,
        "customer_id": customerId,
        "origin": origin,
        "destination": destination,
        "sender_name": senderName,
        "sender_mobile": senderMobile,
        "sender_address1": senderAddress1,
        "sender_email": senderEmail,
        "receiver_name": receiverName,
        "receiver_mobile": receiverMobile,
        "receiver_address1": receiverAddress1,
        "receiver_email": receiverEmail,
        "payment_mode": paymentMode,
        "shipment_charges": shipmentCharges,
        "insurance_value": insuranceValue,
        "remark": remark,
        "axlpl_insurance": axlplInsurance,
        "gross_weight": grossWeight,
        "invoice_value": invoiceValue,
      };
}
