// To parse this JSON data, do
//
//     final categoryListModel = categoryListModelFromJson(jsonString);

import 'dart:convert';

CategoryListModel categoryListModelFromJson(String str) =>
    CategoryListModel.fromJson(json.decode(str));

String categoryListModelToJson(CategoryListModel data) =>
    json.encode(data.toJson());

class CategoryListModel {
  String? status;
  String? message;
  List<CategoryList>? category;
  List<CommodityList>? comodityList;
  List<ServiceTypeList>? servicesList;

  CategoryListModel({
    this.status,
    this.message,
    this.category,
    this.comodityList,
    this.servicesList,
  });

  factory CategoryListModel.fromJson(Map<String, dynamic> json) =>
      CategoryListModel(
        status: json["status"],
        message: json["message"],
        category: json["Category"] == null
            ? []
            : List<CategoryList>.from(
                json["Category"]!.map(
                  (x) => CategoryList.fromJson(x),
                ),
              ),
        servicesList: json["Services"] == null
            ? []
            : List<ServiceTypeList>.from(
                json["Services"]!.map(
                  (x) => ServiceTypeList.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "Category": category == null
            ? []
            : List<dynamic>.from(category!.map((x) => x.toJson())),
        "Commodity": comodityList == null
            ? []
            : List<dynamic>.from(comodityList!.map((x) => x.toJson())),
        "Services": servicesList == null
            ? []
            : List<dynamic>.from(servicesList!.map((x) => x.toJson())),
      };
}

class CategoryList {
  String? id;
  String? name;
  String? productUnit;

  CategoryList({
    this.id,
    this.name,
    this.productUnit,
  });

  factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
        id: json["id"],
        name: json["name"],
        productUnit: json["product_unit"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "product_unit": productUnit,
      };
}

class CommodityList {
  String? id;
  String? name;
  String? categoryId;

  CommodityList({
    this.id,
    this.name,
    this.categoryId,
  });

  factory CommodityList.fromJson(Map<String, dynamic> json) => CommodityList(
        id: json["id"],
        name: json["name"],
        categoryId: json["category_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category_id": categoryId,
      };
}

class ServiceTypeList {
  String? id;
  String? name;
  String? price;
  String? hsnSacValue;

  ServiceTypeList({
    this.id,
    this.name,
    this.price,
    this.hsnSacValue,
  });

  factory ServiceTypeList.fromJson(Map<String, dynamic> json) =>
      ServiceTypeList(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        hsnSacValue: json["hsn_sac_value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "hsn_sac_value": hsnSacValue,
      };
}
