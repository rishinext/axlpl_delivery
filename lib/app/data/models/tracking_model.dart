// To parse this JSON data, do
//
//     final trackingModel = trackingModelFromJson(jsonString);

import 'dart:convert';

import 'package:axlpl_delivery/app/data/models/transtion_history_model.dart';

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
  ErData? senderData;
  ErData? receiverData;
  ShipmentDetails? shipmentDetails;
  List<CashLog>? cashLog;
  int? totalPaidAmount;

  Tracking({
    this.trackingStatus,
    this.senderData,
    this.receiverData,
    this.shipmentDetails,
    this.cashLog,
    this.totalPaidAmount,
  });

  factory Tracking.fromJson(Map<String, dynamic> json) => Tracking(
        trackingStatus: json["TrackingStatus"] == null
            ? []
            : List<TrackingStatus>.from(
                json["TrackingStatus"]!.map((x) => TrackingStatus.fromJson(x))),
        senderData: json["SenderData"] == null
            ? null
            : ErData.fromJson(json["SenderData"]),
        receiverData: json["ReceiverData"] == null
            ? null
            : ErData.fromJson(json["ReceiverData"]),
        shipmentDetails: json["ShipmentDetails"] == null
            ? null
            : ShipmentDetails.fromJson(json["ShipmentDetails"]),
        cashLog: json["CashLog"] == null
            ? []
            : List<CashLog>.from(
                json["CashLog"]!.map((x) => CashLog.fromJson(x))),
        totalPaidAmount: json["TotalPaidAmount"],
      );

  Map<String, dynamic> toJson() => {
        "TrackingStatus": trackingStatus == null
            ? []
            : List<dynamic>.from(trackingStatus!.map((x) => x.toJson())),
        "SenderData": senderData?.toJson(),
        "ReceiverData": receiverData?.toJson(),
        "ShipmentDetails": shipmentDetails?.toJson(),
        "CashLog": cashLog == null
            ? []
            : List<dynamic>.from(cashLog!.map((x) => x.toJson())),
        "TotalPaidAmount": totalPaidAmount,
      };
}

class ErData {
  String? receiverName;
  String? companyName;
  String? mobile;
  String? address1;
  String? address2;
  String? state;
  String? city;
  String? area;
  String? pincode;
  String? senderName;

  ErData({
    this.receiverName,
    this.companyName,
    this.mobile,
    this.address1,
    this.address2,
    this.state,
    this.city,
    this.area,
    this.pincode,
    this.senderName,
  });

  factory ErData.fromJson(Map<String, dynamic> json) => ErData(
        receiverName: json["receiver_name"],
        companyName: json["company_name"],
        mobile: json["mobile"],
        address1: json["address1"],
        address2: json["address2"],
        state: json["state"],
        city: json["city"],
        area: json["area"],
        pincode: json["pincode"],
        senderName: json["sender_name"],
      );

  Map<String, dynamic> toJson() => {
        "receiver_name": receiverName,
        "company_name": companyName,
        "mobile": mobile,
        "address1": address1,
        "address2": address2,
        "state": state,
        "city": city,
        "area": area,
        "pincode": pincode,
        "sender_name": senderName,
      };
}

class ShipmentDetails {
  String? shipmentId;
  String? shipmentStatus;
  String? shipmentLabel;
  String? custId;
  String? branchName;
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
  String? invoiceNumber;
  String? invoicePath;
  String? invoiceFile;
  String? shipmentCharges;
  String? insuranceCharges;
  int? invoiceCharges;
  int? handlingCharges;
  int? tax;
  int? totalCharges;
  int? gst;
  final grandTotal;

  ShipmentDetails({
    this.shipmentId,
    this.shipmentStatus,
    this.shipmentLabel,
    this.custId,
    this.branchName,
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
    this.invoiceNumber,
    this.invoicePath,
    this.invoiceFile,
    this.shipmentCharges,
    this.insuranceCharges,
    this.invoiceCharges,
    this.handlingCharges,
    this.tax,
    this.totalCharges,
    this.gst,
    this.grandTotal,
  });

  factory ShipmentDetails.fromJson(Map<String, dynamic> json) =>
      ShipmentDetails(
        shipmentId: json["shipment_id"],
        shipmentStatus: json["shipment_status"],
        shipmentLabel: json["shipment_label"],
        custId: json["cust_id"],
        branchName: json["branch_name"],
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
        invoiceFile: json["invoice_file"],
        shipmentCharges: json["shipment_charges"],
        insuranceCharges: json["insurance_charges"],
        invoiceCharges: json["invoice_charges"] != null
            ? (json["invoice_charges"] as num).toInt()
            : null,
        handlingCharges: json["handling_charges"] != null
            ? (json["handling_charges"] as num).toInt()
            : null,
        tax: json["tax"] != null ? (json["tax"] as num).toInt() : null,
        totalCharges: json["total_charges"] != null
            ? (json["total_charges"] as num).toInt()
            : null,
        gst: json["gst"] != null ? (json["gst"] as num).toInt() : null,
        grandTotal: json["grand_total"],
      );

  Map<String, dynamic> toJson() => {
        "shipment_id": shipmentId,
        "shipment_status": shipmentStatus,
        "shipment_label": shipmentLabel,
        "cust_id": custId,
        "branch_name": branchName,
        "parcel_detail": parcelDetail,
        "category_id": categoryId,
        "net_weight": netWeight,
        "gross_weight": grossWeight,
        "payment_mode": paymentMode,
        "service_id": serviceId,
        "invoice_value": invoiceValue,
        "axlpl_insurance": axlplInsurance,
        "policy_no": policyNo,
        "exp_date":
            "${expDate!.year.toString().padLeft(4, '0')}-${expDate!.month.toString().padLeft(2, '0')}-${expDate!.day.toString().padLeft(2, '0')}",
        "insurance_value": insuranceValue,
        "remark": remark,
        "bill_to": billTo,
        "number_of_parcel": numberOfParcel,
        "additional_axlpl_insurance": additionalAxlplInsurance,
        "invoice_number": invoiceNumber,
        "invoice_path": invoicePath,
        "invoice_file": invoiceFile,
        "shipment_charges": shipmentCharges,
        "insurance_charges": insuranceCharges,
        "invoice_charges": invoiceCharges,
        "handling_charges": handlingCharges,
        "tax": tax,
        "total_charges": totalCharges,
        "gst": gst,
        "grand_total": grandTotal,
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
