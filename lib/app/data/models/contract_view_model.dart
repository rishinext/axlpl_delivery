// To parse this JSON data, do
//
//     final contractViewModel = contractViewModelFromJson(jsonString);

import 'dart:convert';

ContractViewModel contractViewModelFromJson(String str) =>
    ContractViewModel.fromJson(json.decode(str));

String contractViewModelToJson(ContractViewModel data) =>
    json.encode(data.toJson());

class ContractViewModel {
  String? status;
  String? message;
  String? customerId;
  List<Contract>? contracts;

  ContractViewModel({
    this.status,
    this.message,
    this.customerId,
    this.contracts,
  });

  factory ContractViewModel.fromJson(Map<String, dynamic> json) =>
      ContractViewModel(
        status: json["status"],
        message: json["message"],
        customerId: json["customer_id"],
        contracts: json["contracts"] == null
            ? []
            : List<Contract>.from(
                json["contracts"]!.map((x) => Contract.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "customer_id": customerId,
        "contracts": contracts == null
            ? []
            : List<dynamic>.from(contracts!.map((x) => x.toJson())),
      };
}

class Contract {
  String? id;
  String? startDate;
  String? endDate;
  String? categoryId;
  String? categoryName;
  String? ratePerGram;
  String? weight;
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
    this.weight,
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
        weight: json["weight"],
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
        "weight": weight,
        "billing_cycle": billingCycle,
        "active": active,
        "view_link": viewLink,
      };
}
