// To parse this JSON data, do
//
//     final historyPickupModel = historyPickupModelFromJson(jsonString);

import 'dart:convert';

HistoryPickupModel historyPickupModelFromJson(String str) =>
    HistoryPickupModel.fromJson(json.decode(str));

String historyPickupModelToJson(HistoryPickupModel data) =>
    json.encode(data.toJson());

class HistoryPickupModel {
  String? status;
  String? message;
  List<HistoryPickup>? historyPickup;
  List<Next>? next;

  HistoryPickupModel({
    this.status,
    this.message,
    this.historyPickup,
    this.next,
  });

  factory HistoryPickupModel.fromJson(Map<String, dynamic> json) =>
      HistoryPickupModel(
        status: json["status"],
        message: json["message"],
        historyPickup: json["HistoryPickup"] == null
            ? []
            : List<HistoryPickup>.from(
                json["HistoryPickup"]!.map((x) => HistoryPickup.fromJson(x))),
        next: json["next"] == null
            ? []
            : List<Next>.from(json["next"]!.map((x) => Next.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "HistoryPickup": historyPickup == null
            ? []
            : List<dynamic>.from(historyPickup!.map((x) => x.toJson())),
        "next": next == null
            ? []
            : List<dynamic>.from(next!.map((x) => x.toJson())),
      };
}

class HistoryPickup {
  int? id;
  int? messangerId;
  String? messangerName;
  String? paymentMode;
  String? subPaymentMode;
  String? shipmentId;
  String? invoicePath;
  String? invoiceFile;
  String? totalCharges;
  String? tax;
  String? axlplInsurance;
  String? status;
  String? name;
  String? companyName;
  String? mobile;
  int? areaId;
  String? areaName;
  String? pincode;
  String? address1;
  String? address2;
  String? cityName;
  DateTime? date;
  String? receiverCityName;
  int? paidAmount;
  int? transactionId;

  HistoryPickup({
    this.id,
    this.messangerId,
    this.messangerName,
    this.paymentMode,
    this.subPaymentMode,
    this.shipmentId,
    this.invoicePath,
    this.invoiceFile,
    this.totalCharges,
    this.tax,
    this.axlplInsurance,
    this.status,
    this.name,
    this.companyName,
    this.mobile,
    this.areaId,
    this.areaName,
    this.pincode,
    this.address1,
    this.address2,
    this.cityName,
    this.date,
    this.receiverCityName,
    this.paidAmount,
    this.transactionId,
  });

  factory HistoryPickup.fromJson(Map<String, dynamic> json) => HistoryPickup(
        id: json["id"],
        messangerId: json["messanger_id"],
        messangerName: json["messanger_name"],
        paymentMode: json["payment_mode"],
        subPaymentMode: json["sub_payment_mode"],
        shipmentId: json["shipment_id"],
        invoicePath: json["invoice_path"],
        invoiceFile: json["invoice_file"],
        totalCharges: json["total_charges"],
        tax: json["tax"],
        axlplInsurance: json["axlpl_insurance"],
        status: json["status"],
        name: json["name"],
        companyName: json["company_name"],
        mobile: json["mobile"],
        areaId: json["area_id"],
        areaName: json["area_name"],
        pincode: json["pincode"],
        address1: json["address1"],
        address2: json["address2"],
        cityName: json["city_name"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        receiverCityName: json["receiver_city_name"],
        paidAmount: json["paidAmount"],
        transactionId: json["transaction_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "messanger_id": messangerId,
        "messanger_name": messangerName,
        "payment_mode": paymentMode,
        "sub_payment_mode": subPaymentMode,
        "shipment_id": shipmentId,
        "invoice_path": invoicePath,
        "invoice_file": invoiceFile,
        "total_charges": totalCharges,
        "tax": tax,
        "axlpl_insurance": axlplInsurance,
        "status": status,
        "name": name,
        "company_name": companyName,
        "mobile": mobile,
        "area_id": areaId,
        "area_name": areaName,
        "pincode": pincode,
        "address1": address1,
        "address2": address2,
        "city_name": cityName,
        "date": date?.toIso8601String(),
        "receiver_city_name": receiverCityName,
        "paidAmount": paidAmount,
        "transaction_id": transactionId,
      };
}

class Next {
  String? total;
  String? nextId;

  Next({
    this.total,
    this.nextId,
  });

  factory Next.fromJson(Map<String, dynamic> json) => Next(
        total: json["total"],
        nextId: json["next_id"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "next_id": nextId,
      };
}
