// To parse this JSON data, do
//
//     final getPincodeDetailsModel = getPincodeDetailsModelFromJson(jsonString);

import 'dart:convert';

GetPincodeDetailsModel getPincodeDetailsModelFromJson(String str) =>
    GetPincodeDetailsModel.fromJson(json.decode(str));

String getPincodeDetailsModelToJson(GetPincodeDetailsModel data) =>
    json.encode(data.toJson());

class GetPincodeDetailsModel {
  String? status;
  String? message;
  String? areaId;
  String? areaName;
  String? cityId;
  String? cityName;
  String? stateId;
  String? stateName;
  String? countryId;
  String? countryName;

  GetPincodeDetailsModel({
    this.status,
    this.message,
    this.areaId,
    this.areaName,
    this.cityId,
    this.cityName,
    this.stateId,
    this.stateName,
    this.countryId,
    this.countryName,
  });

  factory GetPincodeDetailsModel.fromJson(Map<String, dynamic> json) =>
      GetPincodeDetailsModel(
        status: json["status"],
        message: json["message"],
        areaId: json["area_id"],
        areaName: json["area_name"],
        cityId: json["city_id"],
        cityName: json["city_name"],
        stateId: json["state_id"],
        stateName: json["state_name"],
        countryId: json["country_id"],
        countryName: json["country_name"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "area_id": areaId,
        "area_name": areaName,
        "city_id": cityId,
        "city_name": cityName,
        "state_id": stateId,
        "state_name": stateName,
        "country_id": countryId,
        "country_name": countryName,
      };
}
