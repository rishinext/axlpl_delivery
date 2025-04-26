// To parse this JSON data, do
//
//     final messangersDetailsModel = messangersDetailsModelFromJson(jsonString);

import 'dart:convert';

MessangersDetailsModel messangersDetailsModelFromJson(String str) =>
    MessangersDetailsModel.fromJson(json.decode(str));

String messangersDetailsModelToJson(MessangersDetailsModel data) =>
    json.encode(data.toJson());

class MessangersDetailsModel {
  Messangerdetail? messangerdetail;

  MessangersDetailsModel({
    this.messangerdetail,
  });

  factory MessangersDetailsModel.fromJson(Map<String, dynamic> json) =>
      MessangersDetailsModel(
        messangerdetail: json["Messangerdetail"] == null
            ? null
            : Messangerdetail.fromJson(json["Messangerdetail"]),
      );

  Map<String, dynamic> toJson() => {
        "Messangerdetail": messangerdetail?.toJson(),
      };
}

class Messangerdetail {
  String? id;
  String? name;
  String? code;
  String? branchId;
  String? branchName;
  String? countryId;
  String? countryName;
  String? stateId;
  String? stateName;
  String? cityId;
  String? cityName;
  String? routeId;
  String? routeCode;
  String? phone;
  String? email;
  String? vehicleNo;
  String? path;
  String? photo;
  String? panCard;
  String? aadharCard;
  String? drivingLicence;
  String? active;
  String? token;

  Messangerdetail({
    this.id,
    this.name,
    this.code,
    this.branchId,
    this.branchName,
    this.countryId,
    this.countryName,
    this.stateId,
    this.stateName,
    this.cityId,
    this.cityName,
    this.routeId,
    this.routeCode,
    this.phone,
    this.email,
    this.vehicleNo,
    this.path,
    this.photo,
    this.panCard,
    this.aadharCard,
    this.drivingLicence,
    this.active,
    this.token,
  });

  factory Messangerdetail.fromJson(Map<String, dynamic> json) =>
      Messangerdetail(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        branchId: json["branch_id"],
        branchName: json["branch_name"],
        countryId: json["country_id"],
        countryName: json["country_name"],
        stateId: json["state_id"],
        stateName: json["state_name"],
        cityId: json["city_id"],
        cityName: json["city_name"],
        routeId: json["route_id"],
        routeCode: json["route_code"],
        phone: json["phone"],
        email: json["email"],
        vehicleNo: json["vehicle_no"],
        path: json["path"],
        photo: json["photo"],
        panCard: json["pan_card"],
        aadharCard: json["aadhar_card"],
        drivingLicence: json["driving_licence"],
        active: json["active"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "branch_id": branchId,
        "branch_name": branchName,
        "country_id": countryId,
        "country_name": countryName,
        "state_id": stateId,
        "state_name": stateName,
        "city_id": cityId,
        "city_name": cityName,
        "route_id": routeId,
        "route_code": routeCode,
        "phone": phone,
        "email": email,
        "vehicle_no": vehicleNo,
        "path": path,
        "photo": photo,
        "pan_card": panCard,
        "aadhar_card": aadharCard,
        "driving_licence": drivingLicence,
        "active": active,
        "token": token,
      };
}
