// To parse this JSON data, do
//
//     final contractsDeatilsModel = contractsDeatilsModelFromJson(jsonString);

import 'dart:convert';

ContractsDeatilsModel contractsDeatilsModelFromJson(String str) =>
    ContractsDeatilsModel.fromJson(json.decode(str));

String contractsDeatilsModelToJson(ContractsDeatilsModel data) =>
    json.encode(data.toJson());

class ContractsDeatilsModel {
  List<Contract>? contracts;
  String? status;
  String? message;

  ContractsDeatilsModel({
    this.contracts,
    this.status,
    this.message,
  });

  factory ContractsDeatilsModel.fromJson(Map<String, dynamic> json) =>
      ContractsDeatilsModel(
        contracts: json["contracts"] == null
            ? []
            : List<Contract>.from(
                json["contracts"]!.map((x) => Contract.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "contracts": contracts == null
            ? []
            : List<dynamic>.from(contracts!.map((x) => x.toJson())),
        "status": status,
        "message": message,
      };
}

class Contract {
  String? id;
  String? customerId;
  DateTime? startDate;
  DateTime? endDate;
  String? billingCycle;
  String? categoryId;
  String? ratePerGram;
  String? weight;
  String? active;
  DateTime? createdDate;
  DateTime? modifiedDate;

  Contract({
    this.id,
    this.customerId,
    this.startDate,
    this.endDate,
    this.billingCycle,
    this.categoryId,
    this.ratePerGram,
    this.weight,
    this.active,
    this.createdDate,
    this.modifiedDate,
  });

  factory Contract.fromJson(Map<String, dynamic> json) => Contract(
        id: json["id"],
        customerId: json["customer_id"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        billingCycle: json["billing_cycle"],
        categoryId: json["category_id"],
        ratePerGram: json["rate_per_gram"],
        weight: json["weight"],
        active: json["active"],
        createdDate: json["created_date"] == null
            ? null
            : DateTime.parse(json["created_date"]),
        modifiedDate: json["modified_date"] == null
            ? null
            : DateTime.parse(json["modified_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "billing_cycle": billingCycle,
        "category_id": categoryId,
        "rate_per_gram": ratePerGram,
        "weight": weight,
        "active": active,
        "created_date": createdDate?.toIso8601String(),
        "modified_date": modifiedDate?.toIso8601String(),
      };
}
