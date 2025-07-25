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
  String? messangerId;
  String? messangerName;
  String? paymentMode;
  String? invoicePath;
  String? invoiceFile;
  String? subPaymentMode;
  String? axlplInsurance;
  String? totalCharges;
  String? tax;
  String? branchName;
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
      this.messangerId,
      this.messangerName,
      this.paymentMode,
      this.invoicePath,
      this.invoiceFile,
      this.subPaymentMode,
      this.axlplInsurance,
      this.totalCharges,
      this.tax,
      this.branchName,
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
    messangerId = json['messanger_id'];
    messangerName = json['messanger_name'];
    paymentMode = json['payment_mode'];
    invoicePath = json['invoice_path'];
    invoiceFile = json['invoice_file'];
    subPaymentMode = json['sub_payment_mode'];
    axlplInsurance = json['axlpl_insurance'];
    totalCharges = json['total_charges'];
    tax = json['tax'];
    branchName = json['branch_name'];
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
    data['messanger_id'] = this.messangerId;
    data['messanger_name'] = this.messangerName;
    data['payment_mode'] = this.paymentMode;
    data['sub_payment_mode'] = this.subPaymentMode;
    data['axlpl_insurance'] = this.axlplInsurance;
    data['total_charges'] = this.totalCharges;
    data['tax'] = this.tax;
    data['branch_name'] = this.branchName;
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
  String? messangerId;
  String? messangerName;
  String? paymentMode;
  String? subPaymentMode;
  String? axlplInsurance;
  String? invoicePath;
  String? invoiceFile;
  String? totalCharges;
  String? tax;
  String? branchName;
  String? status;
  String? name;
  String? companyName;
  String? mobile;
  DateTime? date;
  String? senderCityName;
  String? grandTotal;
  String? areaId;
  String? areaName;
  String? cityName;
  String? pincode;
  String? address1;
  String? address2;
  String? receiverCityName;

  RunningDelivery({
    this.id,
    this.shipmentId,
    this.messangerId,
    this.messangerName,
    this.paymentMode,
    this.subPaymentMode,
    this.axlplInsurance,
    this.invoicePath,
    this.invoiceFile,
    this.totalCharges,
    this.tax,
    this.branchName,
    this.status,
    this.name,
    this.companyName,
    this.mobile,
    this.date,
    this.senderCityName,
    this.grandTotal,
    this.areaId,
    this.areaName,
    this.cityName,
    this.pincode,
    this.address1,
    this.address2,
    this.receiverCityName,
  });

  factory RunningDelivery.fromJson(Map<String, dynamic> json) =>
      RunningDelivery(
        id: json["id"],
        shipmentId: json["shipment_id"],
        messangerId: json["messanger_id"],
        messangerName: json["messanger_name"],
        paymentMode: json["payment_mode"],
        subPaymentMode: json["sub_payment_mode"],
        axlplInsurance: json["axlpl_insurance"],
        invoicePath: json["invoice_path"],
        invoiceFile: json["invoice_file"],
        totalCharges: json["total_charges"],
        tax: json["tax"],
        branchName: json["branch_name"],
        status: json["status"],
        name: json["name"],
        companyName: json["company_name"],
        mobile: json["mobile"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        senderCityName: json["sender_city_name"],
        grandTotal: json["grand_total"],
        areaId: json["area_id"],
        areaName: json["area_name"],
        cityName: json["city_name"],
        pincode: json["pincode"],
        address1: json["address1"],
        address2: json["address2"],
        receiverCityName: json["receiver_city_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "shipment_id": shipmentId,
        "messanger_id": messangerId,
        "messanger_name": messangerName,
        "payment_mode": paymentMode,
        "sub_payment_mode": subPaymentMode,
        "axlpl_insurance": axlplInsurance,
        "invoice_path": invoicePath,
        "invoice_file": invoiceFile,
        "total_charges": totalCharges,
        "tax": tax,
        "branch_name": branchName,
        "status": status,
        "name": name,
        "company_name": companyName,
        "mobile": mobile,
        "date": date?.toIso8601String(),
        "sender_city_name": senderCityName,
        "grand_total": grandTotal,
        "area_id": areaId,
        "area_name": areaName,
        "city_name": cityName,
        "pincode": pincode,
        "address1": address1,
        "address2": address2,
        "receiver_city_name": receiverCityName,
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
