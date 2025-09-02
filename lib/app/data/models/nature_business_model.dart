// To parse this JSON data, do
//
//     final natureOfBusniessModel = natureOfBusniessModelFromJson(jsonString);

import 'dart:convert';

NatureOfBusniessModel natureOfBusniessModelFromJson(String str) =>
    NatureOfBusniessModel.fromJson(json.decode(str));

String natureOfBusniessModelToJson(NatureOfBusniessModel data) =>
    json.encode(data.toJson());

class NatureOfBusniessModel {
  String? status;
  String? message;
  List<NatureOfBusiness>? natureOfBusiness;

  NatureOfBusniessModel({
    this.status,
    this.message,
    this.natureOfBusiness,
  });

  factory NatureOfBusniessModel.fromJson(Map<String, dynamic> json) =>
      NatureOfBusniessModel(
        status: json["status"],
        message: json["message"],
        natureOfBusiness: json["nature_of_business"] == null
            ? []
            : List<NatureOfBusiness>.from(json["nature_of_business"]!
                .map((x) => NatureOfBusiness.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "nature_of_business": natureOfBusiness == null
            ? []
            : List<dynamic>.from(natureOfBusiness!.map((x) => x.toJson())),
      };
}

class NatureOfBusiness {
  String? name;
  String? value;

  NatureOfBusiness({
    this.name,
    this.value,
  });

  factory NatureOfBusiness.fromJson(Map<String, dynamic> json) =>
      NatureOfBusiness(
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
      };
}
