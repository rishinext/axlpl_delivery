// To parse this JSON data, do
//
//     final pickUpModel = pickUpModelFromJson(jsonString);

import 'dart:convert';

PickUpModel pickUpModelFromJson(String str) =>
    PickUpModel.fromJson(json.decode(str));

String pickUpModelToJson(PickUpModel data) => json.encode(data.toJson());

class PickUpModel {
  String? status;
  String? message;
  List<RunningPickUp>? runningPickUp;
  List<RunningDelivery>? runningDelivery;
  List<Next>? next;

  PickUpModel({
    this.status,
    this.message,
    this.runningPickUp,
    this.runningDelivery,
    this.next,
  });

  factory PickUpModel.fromJson(Map<String, dynamic> json) => PickUpModel(
        status: json["status"],
        message: json["message"],
        runningPickUp: json["RunningPickUp"] == null
            ? []
            : List<RunningPickUp>.from(
                json["RunningPickUp"]!.map((x) => RunningPickUp.fromJson(x))),
        runningDelivery: json["RunningDelivery"] == null
            ? []
            : List<RunningDelivery>.from(json["RunningDelivery"]!
                .map((x) => RunningDelivery.fromJson(x))),
        next: json["next"] == null
            ? []
            : List<Next>.from(json["next"]!.map((x) => Next.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "RunningPickUp": runningPickUp == null
            ? []
            : List<dynamic>.from(runningPickUp!.map((x) => x.toJson())),
        "RunningDelivery": runningDelivery == null
            ? []
            : List<dynamic>.from(runningDelivery!.map((x) => x.toJson())),
        "next": next == null
            ? []
            : List<dynamic>.from(next!.map((x) => x.toJson())),
      };
}

class RunningPickUp {
  String? id;
  String? shipmentId;
  String? messangerName;
  String? paymentMode;
  String? axlpInsurance;
  String? status;
  String? name;
  String? companyName;
  String? mobile;
  String? areaId;
  String? areaName;
  String? pincode;
  String? address1;
  String? address2;
  String? cityName;
  String? date;
  String? receiverCityName;

  RunningPickUp(
      {this.id,
      this.shipmentId,
      this.axlpInsurance,
      this.paymentMode,
      this.messangerName,
      this.status,
      this.name,
      this.companyName,
      this.mobile,
      this.areaId,
      this.areaName,
      this.pincode,
      this.address1,
      this.address2,
      this.cityName,
      this.date,
      this.receiverCityName});

  RunningPickUp.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shipmentId = json['shipment_id'];
    axlpInsurance = json['axlpl_insurance'];
    messangerName = json['messanger_name'];
    paymentMode = json['payment_mode'];
    status = json['status'];
    name = json['name'];
    companyName = json['company_name'];
    mobile = json['mobile'];
    areaId = json['area_id'];
    areaName = json['area_name'];
    pincode = json['pincode'];
    address1 = json['address1'];
    address2 = json['address2'];
    cityName = json['city_name'];
    date = json['date'];
    receiverCityName = json['receiver_city_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shipment_id'] = this.shipmentId;
    data['axlpl_insurance'] = this.axlpInsurance;
    data['messanger_name'] = this.messangerName;
    data['payment_mode'] = this.paymentMode;
    data['status'] = this.status;
    data['name'] = this.name;
    data['company_name'] = this.companyName;
    data['mobile'] = this.mobile;
    data['area_id'] = this.areaId;
    data['area_name'] = this.areaName;
    data['pincode'] = this.pincode;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['city_name'] = this.cityName;
    data['date'] = this.date;
    data['receiver_city_name'] = this.receiverCityName;
    return data;
  }
}

class RunningDelivery {
  String? id;
  String? shipmentId;
  String? status;
  String? name;
  String? companyName;
  String? mobile;
  String? paymentMode;
  DateTime? date;
  String? senderCityName;
  String? grandTotal;
  String? areaId;
  String? areaName;
  String? cityName;
  String? pincode;
  String? address1;
  String? address2;

  RunningDelivery({
    this.id,
    this.shipmentId,
    this.status,
    this.name,
    this.companyName,
    this.mobile,
    this.paymentMode,
    this.date,
    this.senderCityName,
    this.grandTotal,
    this.areaId,
    this.areaName,
    this.cityName,
    this.pincode,
    this.address1,
    this.address2,
  });

  factory RunningDelivery.fromJson(Map<String, dynamic> json) =>
      RunningDelivery(
        id: json["id"],
        shipmentId: json["shipment_id"],
        status: json["status"],
        name: json["name"],
        companyName: json["company_name"],
        mobile: json["mobile"],
        paymentMode: json["payment_mode"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        senderCityName: json["sender_city_name"],
        grandTotal: json["grand_total"],
        areaId: json["area_id"],
        areaName: json["area_name"],
        cityName: json["city_name"],
        pincode: json["pincode"],
        address1: json["address1"],
        address2: json["address2"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "shipment_id": shipmentId,
        "status": status,
        "name": name,
        "company_name": companyName,
        "mobile": mobile,
        "payment_mode": paymentMode,
        "date": date?.toIso8601String(),
        "sender_city_name": senderCityName,
        "grand_total": grandTotal,
        "area_id": areaId,
        "area_name": areaName,
        "city_name": cityName,
        "pincode": pincode,
        "address1": address1,
        "address2": address2,
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
