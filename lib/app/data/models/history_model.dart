// To parse this JSON data, do
//
//     final historyModel = historyModelFromJson(jsonString);

import 'dart:convert';

HistoryModel historyModelFromJson(String str) =>
    HistoryModel.fromJson(json.decode(str));

String historyModelToJson(HistoryModel data) => json.encode(data.toJson());

class HistoryModel {
  String? status;
  String? message;
  List<HistoryDelivery>? historyDelivery;
  List<Next>? next;

  HistoryModel({
    this.status,
    this.message,
    this.historyDelivery,
    this.next,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        status: json["status"],
        message: json["message"],
        historyDelivery: json["HistoryDelivery"] == null
            ? []
            : List<HistoryDelivery>.from(json["HistoryDelivery"]!
                .map((x) => HistoryDelivery.fromJson(x))),
        next: json["next"] == null
            ? []
            : List<Next>.from(json["next"]!.map((x) => Next.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "HistoryDelivery": historyDelivery == null
            ? []
            : List<dynamic>.from(historyDelivery!.map((x) => x.toJson())),
        "next": next == null
            ? []
            : List<dynamic>.from(next!.map((x) => x.toJson())),
      };
}

class HistoryDelivery {
  String? id;
  String? shipmentId;
  String? status;
  String? name;
  String? companyName;
  String? mobile;
  String? paymentMode;
  String? grandTotal;
  DateTime? date;
  String? senderCityName;
  String? areaId;
  String? areaName;
  String? pincode;
  String? address1;
  String? address2;
  String? cityName;

  HistoryDelivery({
    this.id,
    this.shipmentId,
    this.status,
    this.name,
    this.companyName,
    this.mobile,
    this.paymentMode,
    this.grandTotal,
    this.date,
    this.senderCityName,
    this.areaId,
    this.areaName,
    this.pincode,
    this.address1,
    this.address2,
    this.cityName,
  });

  factory HistoryDelivery.fromJson(Map<String, dynamic> json) =>
      HistoryDelivery(
        id: json["id"],
        shipmentId: json["shipment_id"],
        status: json["status"],
        name: json["name"],
        companyName: json["company_name"],
        mobile: json["mobile"],
        paymentMode: json["payment_mode"],
        grandTotal: json["grand_total"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        senderCityName: json["sender_city_name"],
        areaId: json["area_id"],
        areaName: json["area_name"],
        pincode: json["pincode"],
        address1: json["address1"],
        address2: json["address2"],
        cityName: json["city_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "shipment_id": shipmentId,
        "status": status,
        "name": name,
        "company_name": companyName,
        "mobile": mobile,
        "payment_mode": paymentMode,
        "grand_total": grandTotal,
        "date": date?.toIso8601String(),
        "sender_city_name": senderCityName,
        "area_id": areaId,
        "area_name": areaName,
        "pincode": pincode,
        "address1": address1,
        "address2": address2,
        "city_name": cityName,
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
