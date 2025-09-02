// To parse this JSON data, do
//
//     final registerCategoryModel = registerCategoryModelFromJson(jsonString);

import 'dart:convert';

RegisterCategoryModel registerCategoryModelFromJson(String str) =>
    RegisterCategoryModel.fromJson(json.decode(str));

String registerCategoryModelToJson(RegisterCategoryModel data) =>
    json.encode(data.toJson());

class RegisterCategoryModel {
  String? status;
  String? message;
  List<RegisterCategoryList>? categories;

  RegisterCategoryModel({
    this.status,
    this.message,
    this.categories,
  });

  factory RegisterCategoryModel.fromJson(Map<String, dynamic> json) =>
      RegisterCategoryModel(
        status: json["status"],
        message: json["message"],
        categories: json["categories"] == null
            ? []
            : List<RegisterCategoryList>.from(json["categories"]!
                .map((x) => RegisterCategoryList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
      };
}

class RegisterCategoryList {
  String? name;
  String? value;

  RegisterCategoryList({
    this.name,
    this.value,
  });

  factory RegisterCategoryList.fromJson(Map<String, dynamic> json) =>
      RegisterCategoryList(
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
      };
}
