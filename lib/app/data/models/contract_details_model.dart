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
  String? startDate;
  String? endDate;
  String? categoryId;
  String? categoryName;
  String? ratePerGram;
  String? assignedWeight;
  String? usedWeight;
  String? remainingWeight;
  String? assignedValue;
  String? usedValue;
  String? remainingValue;
  String? billingCycle;
  String? active;
  String? viewLink;

  Contract({
    this.id,
    this.startDate,
    this.endDate,
    this.categoryId,
    this.categoryName,
    this.ratePerGram,
    this.assignedWeight,
    this.usedWeight,
    this.remainingWeight,
    this.assignedValue,
    this.usedValue,
    this.remainingValue,
    this.billingCycle,
    this.active,
    this.viewLink,
  });

  factory Contract.fromJson(Map<String, dynamic> json) => Contract(
        id: json["id"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        ratePerGram: json["rate_per_gram"],
        assignedWeight: json["assigned_weight"],
        usedWeight: json["used_weight"],
        remainingWeight: json["remaining_weight"],
        assignedValue: json["assigned_value"],
        usedValue: json["used_value"],
        remainingValue: json["remaining_value"],
        billingCycle: json["billing_cycle"],
        active: json["active"],
        viewLink: json["view_link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "start_date": startDate,
        "end_date": endDate,
        "category_id": categoryId,
        "category_name": categoryName,
        "rate_per_gram": ratePerGram,
        "assigned_weight": assignedWeight,
        "used_weight": usedWeight,
        "remaining_weight": remainingWeight,
        "assigned_value": assignedValue,
        "used_value": usedValue,
        "remaining_value": remainingValue,
        "billing_cycle": billingCycle,
        "active": active,
        "view_link": viewLink,
      };
}
