// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final trackingModel = trackingModelFromJson(jsonString);

import 'dart:convert';

TrackingModel trackingModelFromJson(String str) =>
    TrackingModel.fromJson(json.decode(str));

String trackingModelToJson(TrackingModel data) => json.encode(data.toJson());

class TrackingModel {
  List<Tracking>? tracking;
  bool? error;
  int? code;
  String? type;
  String? message;

  TrackingModel({
    this.tracking,
    this.error,
    this.code,
    this.type,
    this.message,
  });

  factory TrackingModel.fromJson(Map<String, dynamic> json) => TrackingModel(
        tracking: json["tracking"] == null
            ? []
            : List<Tracking>.from(
                json["tracking"]!.map((x) => Tracking.fromJson(x))),
        error: json["error"],
        code: json["code"],
        type: json["type"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "tracking": tracking == null
            ? []
            : List<dynamic>.from(tracking!.map((x) => x.toJson())),
        "error": error,
        "code": code,
        "type": type,
        "message": message,
      };
}

class Tracking {
  List<TrackingStatus>? trackingStatus;
  ErDatum? senderData; // changed from List<ErDatum>? to ErDatum?
  ErDatum? receiverData; // same
  ShipmentDetails? shipmentDetails;

  Tracking({
    this.trackingStatus,
    this.senderData,
    this.receiverData,
    this.shipmentDetails,
  });

  factory Tracking.fromJson(Map<String, dynamic> json) => Tracking(
        trackingStatus: json["TrackingStatus"] == null
            ? null
            : List<TrackingStatus>.from(
                (json["TrackingStatus"] as List<dynamic>)
                    .map((x) => TrackingStatus.fromJson(x))),
        senderData: json["SenderData"] == null
            ? null
            : ErDatum.fromJson(json["SenderData"]), // SINGLE OBJECT
        receiverData: json["ReceiverData"] == null
            ? null
            : ErDatum.fromJson(json["ReceiverData"]),
        shipmentDetails: json["ShipmentDetails"] == null
            ? null
            : ShipmentDetails.fromJson(json["ShipmentDetails"]),
      );

  Map<String, dynamic> toJson() => {
        if (trackingStatus != null)
          "TrackingStatus":
              List<dynamic>.from(trackingStatus!.map((x) => x.toJson())),
        if (senderData != null) "SenderData": senderData!.toJson(),
        if (receiverData != null) "ReceiverData": receiverData!.toJson(),
        if (shipmentDetails != null)
          "ShipmentDetails": shipmentDetails!.toJson(),
      };
}

class ErDatum {
  String? receiverName;
  String? companyName;
  String? mobile;
  String? address1;
  String? address2;
  String? senderName;
  String? state;
  String? city;
  String? area;
  String? pincode;

  ErDatum({
    this.receiverName,
    this.companyName,
    this.mobile,
    this.address1,
    this.address2,
    this.senderName,
    this.state,
    this.city,
    this.area,
    this.pincode,
  });

  factory ErDatum.fromJson(Map<String, dynamic> json) => ErDatum(
        receiverName: json["receiver_name"],
        companyName: json["company_name"],
        mobile: json["mobile"],
        address1: json["address1"],
        address2: json["address2"],
        senderName: json["sender_name"],
        state: json["state"],
        city: json["city"],
        area: json["area"],
        pincode: json["pincode"],
      );

  Map<String, dynamic> toJson() => {
        "receiver_name": receiverName,
        "company_name": companyName,
        "mobile": mobile,
        "address1": address1,
        "address2": address2,
        "sender_name": senderName,
        "state": state,
        "city": city,
        "area": area,
        "pincode": pincode,
      };
}

class TrackingStatus {
  String? status;
  DateTime? dateTime;

  TrackingStatus({
    this.status,
    this.dateTime,
  });

  factory TrackingStatus.fromJson(Map<String, dynamic> json) => TrackingStatus(
        status: json["status"],
        dateTime: json["date_time"] == null
            ? null
            : DateTime.parse(json["date_time"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "date_time": dateTime?.toIso8601String(),
      };
}

class ShipmentDetails {
  String? shipmentId;
  String? shipmentStatus;
  String? custId;
  String? parcelDetail;
  String? categoryId;
  String? netWeight;
  String? grossWeight;
  String? paymentMode;
  String? serviceId;
  String? invoiceValue;
  String? axlplInsurance;
  String? policyNo;
  DateTime? expDate;
  String? insuranceValue;
  String? remark;
  String? billTo;
  String? numberOfParcel;
  String? additionalAxlplInsurance;
  String? shipmentCharges;
  String? insuranceCharges;
  String? invoiceCharges;
  String? invoiceNumber;
  String? invoicePath;
  String? invoicePhoto;
  String? handlingCharges;
  String? tax;
  String? totalCharges;
  String? grandTotal;
  ShipmentDetails({
    this.shipmentId,
    this.shipmentStatus,
    this.custId,
    this.parcelDetail,
    this.categoryId,
    this.netWeight,
    this.grossWeight,
    this.paymentMode,
    this.serviceId,
    this.invoiceValue,
    this.axlplInsurance,
    this.policyNo,
    this.expDate,
    this.insuranceValue,
    this.remark,
    this.billTo,
    this.numberOfParcel,
    this.additionalAxlplInsurance,
    this.shipmentCharges,
    this.insuranceCharges,
    this.invoiceCharges,
    this.invoiceNumber,
    this.invoicePath,
    this.invoicePhoto,
    this.handlingCharges,
    this.tax,
    this.totalCharges,
    this.grandTotal,
  });

  factory ShipmentDetails.fromJson(Map<String, dynamic> json) =>
      ShipmentDetails(
        shipmentId: json["shipment_id"],
        shipmentStatus: json["shipment_status"],
        custId: json["cust_id"],
        parcelDetail: json["parcel_detail"],
        categoryId: json["category_id"],
        netWeight: json["net_weight"],
        grossWeight: json["gross_weight"],
        paymentMode: json["payment_mode"],
        serviceId: json["service_id"],
        invoiceValue: json["invoice_value"],
        axlplInsurance: json["axlpl_insurance"],
        policyNo: json["policy_no"],
        expDate:
            json["exp_date"] == null ? null : DateTime.parse(json["exp_date"]),
        insuranceValue: json["insurance_value"],
        remark: json["remark"],
        billTo: json["bill_to"],
        numberOfParcel: json["number_of_parcel"],
        additionalAxlplInsurance: json["additional_axlpl_insurance"],
        invoiceNumber: json["invoice_number"],
        invoicePath: json["invoice_path"],
        invoicePhoto: json["invoice_file"],
        shipmentCharges: json["shipment_charges"],
        insuranceCharges: json["insurance_charges"],
        invoiceCharges: json["invoice_charges"],
        handlingCharges: json["handling_charges"],
        tax: json["tax"],
        totalCharges: json["total_charges"],
        grandTotal: json["grand_total"],
      );

  Map<String, dynamic> toJson() => {
        "shipment_id": shipmentId,
        "cust_id": custId,
        "parcel_detail": parcelDetail,
        "category_id": categoryId,
        "net_weight": netWeight,
        "gross_weight": grossWeight,
        "payment_mode": paymentMode,
        "service_id": serviceId,
        "invoice_value": invoiceValue,
        "axlpl_insurance": axlplInsurance,
        "invoice_number": invoiceNumber,
        "policy_no": policyNo,
        "exp_date":
            "${expDate!.year.toString().padLeft(4, '0')}-${expDate!.month.toString().padLeft(2, '0')}-${expDate!.day.toString().padLeft(2, '0')}",
        "insurance_value": insuranceValue,
        "remark": remark,
        "bill_to": billTo,
        "number_of_parcel": numberOfParcel,
        "additional_axlpl_insurance": additionalAxlplInsurance,
        "shipment_charges": shipmentCharges,
        "insurance_charges": insuranceCharges,
        "invoice_charges": invoiceCharges,
        "handling_charges": handlingCharges,
        "tax": tax,
        "total_charges": totalCharges,
      };
}
