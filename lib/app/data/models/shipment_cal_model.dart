// To parse this JSON data, do
//
//     final shipmentCalModel = shipmentCalModelFromJson(jsonString);

import 'dart:convert';

ShipmentCalModel shipmentCalModelFromJson(String str) =>
    ShipmentCalModel.fromJson(json.decode(str));

String shipmentCalModelToJson(ShipmentCalModel data) =>
    json.encode(data.toJson());

class ShipmentCalModel {
  List<PaymentInformation>? paymentInformation;
  String? status;
  String? message;

  ShipmentCalModel({
    this.paymentInformation,
    this.status,
    this.message,
  });

  factory ShipmentCalModel.fromJson(Map<String, dynamic> json) =>
      ShipmentCalModel(
        paymentInformation: json["payment_information"] == null
            ? []
            : List<PaymentInformation>.from(json["payment_information"]!
                .map((x) => PaymentInformation.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "payment_information": paymentInformation == null
            ? []
            : List<dynamic>.from(paymentInformation!.map((x) => x.toJson())),
        "status": status,
        "message": message,
      };
}

class PaymentInformation {
  String? shipmentId;
  String? shipmentCharges;
  String? insuranceCharges;
  String? handlingCharges;
  String? tax;
  String? totalCharges;
  String? grandTotal;
  String? invoiceCharges;
  String? calculationStatus;
  String? additionalAxlplInsurance;

  PaymentInformation({
    this.shipmentId,
    this.shipmentCharges,
    this.insuranceCharges,
    this.handlingCharges,
    this.tax,
    this.totalCharges,
    this.grandTotal,
    this.invoiceCharges,
    this.calculationStatus,
    this.additionalAxlplInsurance,
  });

  factory PaymentInformation.fromJson(Map<String, dynamic> json) =>
      PaymentInformation(
        shipmentId: json["shipment_id"],
        shipmentCharges: json["shipment_charges"],
        insuranceCharges: json["insurance_charges"],
        handlingCharges: json["handling_charges"],
        tax: json["tax"],
        totalCharges: json["total_charges"],
        grandTotal: json["grand_total"],
        invoiceCharges: json["invoice_charges"],
        calculationStatus: json["calculation_status"],
        additionalAxlplInsurance: json["additional_axlpl_insurance"],
      );

  Map<String, dynamic> toJson() => {
        "shipment_id": shipmentId,
        "shipment_charges": shipmentCharges,
        "insurance_charges": insuranceCharges,
        "handling_charges": handlingCharges,
        "tax": tax,
        "total_charges": totalCharges,
        "grand_total": grandTotal,
        "invoice_charges": invoiceCharges,
        "calculation_status": calculationStatus,
        "additional_axlpl_insurance": additionalAxlplInsurance,
      };
}
