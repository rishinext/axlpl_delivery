// To parse this JSON data, do
//
//     final cashCollectionLogModel = cashCollectionLogModelFromJson(jsonString);

import 'dart:convert';

CashCollectionLogModel cashCollectionLogModelFromJson(String str) =>
    CashCollectionLogModel.fromJson(json.decode(str));

String cashCollectionLogModelToJson(CashCollectionLogModel data) =>
    json.encode(data.toJson());

class CashCollectionLogModel {
  List<CashLog>? cashLog;
  String? status;
  String? message;
  int? totalCashAmount;

  CashCollectionLogModel({
    this.cashLog,
    this.status,
    this.message,
    this.totalCashAmount,
  });

  factory CashCollectionLogModel.fromJson(Map<String, dynamic> json) =>
      CashCollectionLogModel(
        cashLog: json["CashLog"] == null
            ? []
            : List<CashLog>.from(
                json["CashLog"]!.map((x) => CashLog.fromJson(x))),
        status: json["status"],
        message: json["message"],
        totalCashAmount: json["total_cash_amount"],
      );

  Map<String, dynamic> toJson() => {
        "CashLog": cashLog == null
            ? []
            : List<dynamic>.from(cashLog!.map((x) => x.toJson())),
        "status": status,
        "message": message,
        "total_cash_amount": totalCashAmount,
      };
}

class CashLog {
  String? shipmentId;
  double? amount;
  int? cashamount;
  String? custId;
  String? customerName;
  String? paymentMode;
  String? subPaymentMode;
  DateTime? createdDate;

  CashLog({
    this.shipmentId,
    this.amount,
    this.cashamount,
    this.custId,
    this.customerName,
    this.paymentMode,
    this.subPaymentMode,
    this.createdDate,
  });

  factory CashLog.fromJson(Map<String, dynamic> json) => CashLog(
        shipmentId: json["shipment_id"],
        amount: json["amount"]?.toDouble(),
        cashamount: json["cashamount"],
        custId: json["cust_id"],
        customerName: json["customer_name"],
        paymentMode: json["payment_mode"],
        subPaymentMode: json["sub_payment_mode"],
        createdDate: json["created_date"] == null
            ? null
            : DateTime.parse(json["created_date"]),
      );

  Map<String, dynamic> toJson() => {
        "shipment_id": shipmentId,
        "amount": amount,
        "cashamount": cashamount,
        "cust_id": custId,
        "customer_name": customerName,
        "payment_mode": paymentMode,
        "sub_payment_mode": subPaymentMode,
        "created_date": createdDate?.toIso8601String(),
      };
}
