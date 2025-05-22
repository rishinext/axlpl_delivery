// To parse this JSON data, do
//
//     final paymentModeModel = paymentModeModelFromJson(jsonString);

import 'dart:convert';

PaymentModeModel paymentModeModelFromJson(String str) =>
    PaymentModeModel.fromJson(json.decode(str));

String paymentModeModelToJson(PaymentModeModel data) =>
    json.encode(data.toJson());

class PaymentModeModel {
  String? status;
  String? message;
  DataList? data;

  PaymentModeModel({
    this.status,
    this.message,
    this.data,
  });

  factory PaymentModeModel.fromJson(Map<String, dynamic> json) =>
      PaymentModeModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : DataList.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataList {
  List<PaymentMode>? paymentModes;
  List<PaymentMode>? subPaymentModes;

  DataList({
    this.paymentModes,
    this.subPaymentModes,
  });

  factory DataList.fromJson(Map<String, dynamic> json) => DataList(
        paymentModes: json["payment_modes"] == null
            ? []
            : List<PaymentMode>.from(
                json["payment_modes"]!.map((x) => PaymentMode.fromJson(x))),
        subPaymentModes: json["sub_payment_modes"] == null
            ? []
            : List<PaymentMode>.from(
                json["sub_payment_modes"]!.map((x) => PaymentMode.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "payment_modes": paymentModes == null
            ? []
            : List<dynamic>.from(paymentModes!.map((x) => x.toJson())),
        "sub_payment_modes": subPaymentModes == null
            ? []
            : List<dynamic>.from(subPaymentModes!.map((x) => x.toJson())),
      };
}

class PaymentMode {
  String? id;
  String? name;

  PaymentMode({
    this.id,
    this.name,
  });

  factory PaymentMode.fromJson(Map<String, dynamic> json) => PaymentMode(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
