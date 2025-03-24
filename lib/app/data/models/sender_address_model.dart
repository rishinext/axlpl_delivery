// To parse this JSON data, do
//
//     final getSenderAddressModel = getSenderAddressModelFromJson(jsonString);

import 'dart:convert';

GetSenderAddressModel getSenderAddressModelFromJson(String str) =>
    GetSenderAddressModel.fromJson(json.decode(str));

String getSenderAddressModelToJson(GetSenderAddressModel data) =>
    json.encode(data.toJson());

class GetSenderAddressModel {
  String? status;
  String? message;
  List<AddressDatum>? addressData;
  List<Next>? next;

  GetSenderAddressModel({
    this.status,
    this.message,
    this.addressData,
    this.next,
  });

  factory GetSenderAddressModel.fromJson(Map<String, dynamic> json) =>
      GetSenderAddressModel(
        status: json["status"],
        message: json["message"],
        addressData: json["addressData"] == null
            ? []
            : List<AddressDatum>.from(
                json["addressData"]!.map((x) => AddressDatum.fromJson(x))),
        next: json["next"] == null
            ? []
            : List<Next>.from(json["next"]!.map((x) => Next.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "addressData": addressData == null
            ? []
            : List<dynamic>.from(addressData!.map((x) => x.toJson())),
        "next": next == null
            ? []
            : List<dynamic>.from(next!.map((x) => x.toJson())),
      };
}

class AddressDatum {
  String? id;
  String? custId;
  String? name;
  String? companyName;
  String? countryId;
  dynamic countryName;
  String? stateId;
  dynamic stateName;
  String? cityId;
  dynamic cityName;
  String? areaId;
  String? areaName;
  String? zipCode;
  String? address1;
  String? address2;
  String? mobileNo;
  String? email;
  String? senderGstNo;
  String? receiverGstNo;

  AddressDatum({
    this.id,
    this.custId,
    this.name,
    this.companyName,
    this.countryId,
    this.countryName,
    this.stateId,
    this.stateName,
    this.cityId,
    this.cityName,
    this.areaId,
    this.areaName,
    this.zipCode,
    this.address1,
    this.address2,
    this.mobileNo,
    this.email,
    this.senderGstNo,
    this.receiverGstNo,
  });

  factory AddressDatum.fromJson(Map<String, dynamic> json) => AddressDatum(
        id: json["id"],
        custId: json["cust_id"],
        name: json["name"],
        companyName: json["company_name"],
        countryId: json["country_id"],
        countryName: json["country_name"],
        stateId: json["state_id"],
        stateName: json["state_name"],
        cityId: json["city_id"],
        cityName: json["city_name"],
        areaId: json["area_id"],
        areaName: json["area_name"],
        zipCode: json["zip_code"],
        address1: json["address1"],
        address2: json["address2"],
        mobileNo: json["mobile_no"],
        email: json["email"],
        senderGstNo: json["sender_gst_no"],
        receiverGstNo: json["receiver_gst_no"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cust_id": custId,
        "name": name,
        "company_name": companyName,
        "country_id": countryId,
        "country_name": countryName,
        "state_id": stateId,
        "state_name": stateName,
        "city_id": cityId,
        "city_name": cityName,
        "area_id": areaId,
        "area_name": areaName,
        "zip_code": zipCode,
        "address1": address1,
        "address2": address2,
        "mobile_no": mobileNo,
        "email": email,
        "sender_gst_no": senderGstNo,
        "receiver_gst_no": receiverGstNo,
      };
}

class Next {
  String? total;
  String? nextId;

  Next({
    this.total,
    this.nextId,
  });

  factory Next.fromJson(Map<String, dynamic> json) => Next(
        total: json["total"],
        nextId: json["next_id"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "next_id": nextId,
      };
}
