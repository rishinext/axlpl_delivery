// To parse this JSON data, do
//
//     final getAllShipmentRecordModel = getAllShipmentRecordModelFromJson(jsonString);

import 'dart:convert';

GetAllShipmentRecordModel getAllShipmentRecordModelFromJson(String str) =>
    GetAllShipmentRecordModel.fromJson(json.decode(str));

String getAllShipmentRecordModelToJson(GetAllShipmentRecordModel data) =>
    json.encode(data.toJson());

class GetAllShipmentRecordModel {
  String? status;
  String? message;
  ShipmentRecordData? shipmentRecordData;

  GetAllShipmentRecordModel({
    this.status,
    this.message,
    this.shipmentRecordData,
  });

  factory GetAllShipmentRecordModel.fromJson(Map<String, dynamic> json) =>
      GetAllShipmentRecordModel(
        status: json["status"],
        message: json["message"],
        shipmentRecordData: json["Shipment"] == null
            ? null
            : ShipmentRecordData.fromJson(json["Shipment"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "Shipment": shipmentRecordData?.toJson(),
      };
}

class ShipmentRecordData {
  String? sId;
  String? shipmentStatus;
  String? podFile;
  String? paymentMode;
  DateTime? createdDate;
  DateTime? shipmentModifiedDate;
  String? senderName;
  String? senderCompanyName;
  String? receiverName;
  String? receiverCompanyName;
  String? senderMobile;
  String? receiverMobile;
  String? senderAddress1;
  String? senderAddress2;
  String? receiverAddress1;
  String? receiverAddress2;
  String? senderPincode;
  String? receiverPincode;
  String? senderArea;
  String? receiverArea;
  String? shipmentGrossWeight;
  String? cName;
  String? senderCityname;
  String? receiverCityname;
  String? senderAreaname;
  String? receiverAreaname;
  String? senderBranchId;

  ShipmentRecordData({
    this.sId,
    this.shipmentStatus,
    this.podFile,
    this.paymentMode,
    this.createdDate,
    this.shipmentModifiedDate,
    this.senderName,
    this.senderCompanyName,
    this.receiverName,
    this.receiverCompanyName,
    this.senderMobile,
    this.receiverMobile,
    this.senderAddress1,
    this.senderAddress2,
    this.receiverAddress1,
    this.receiverAddress2,
    this.senderPincode,
    this.receiverPincode,
    this.senderArea,
    this.receiverArea,
    this.shipmentGrossWeight,
    this.cName,
    this.senderCityname,
    this.receiverCityname,
    this.senderAreaname,
    this.receiverAreaname,
    this.senderBranchId,
  });

  factory ShipmentRecordData.fromJson(Map<String, dynamic> json) =>
      ShipmentRecordData(
        sId: json["s_Id"],
        shipmentStatus: json["shipment_status"],
        podFile: json["pod_file"],
        paymentMode: json["payment_mode"],
        createdDate: json["created_date"] == null
            ? null
            : DateTime.parse(json["created_date"]),
        shipmentModifiedDate: json["shipment_modified_date"] == null
            ? null
            : DateTime.parse(json["shipment_modified_date"]),
        senderName: json["senderName"],
        senderCompanyName: json["sender_company_name"],
        receiverName: json["receiverName"],
        receiverCompanyName: json["receiver_company_name"],
        senderMobile: json["sender_mobile"],
        receiverMobile: json["receiver_mobile"],
        senderAddress1: json["sender_address1"],
        senderAddress2: json["sender_address2"],
        receiverAddress1: json["receiver_address1"],
        receiverAddress2: json["receiver_address2"],
        senderPincode: json["sender_pincode"],
        receiverPincode: json["receiver_pincode"],
        senderArea: json["sender_area"],
        receiverArea: json["receiver_area"],
        shipmentGrossWeight: json["shipment_gross_weight"],
        cName: json["c_Name"],
        senderCityname: json["sender_cityname"],
        receiverCityname: json["receiver_cityname"],
        senderAreaname: json["sender_areaname"],
        receiverAreaname: json["receiver_areaname"],
        senderBranchId: json["sender_branch_id"],
      );

  Map<String, dynamic> toJson() => {
        "s_Id": sId,
        "shipment_status": shipmentStatus,
        "pod_file": podFile,
        "payment_mode": paymentMode,
        "created_date": createdDate?.toIso8601String(),
        "shipment_modified_date": shipmentModifiedDate?.toIso8601String(),
        "senderName": senderName,
        "sender_company_name": senderCompanyName,
        "receiverName": receiverName,
        "receiver_company_name": receiverCompanyName,
        "sender_mobile": senderMobile,
        "receiver_mobile": receiverMobile,
        "sender_address1": senderAddress1,
        "sender_address2": senderAddress2,
        "receiver_address1": receiverAddress1,
        "receiver_address2": receiverAddress2,
        "sender_pincode": senderPincode,
        "receiver_pincode": receiverPincode,
        "sender_area": senderArea,
        "receiver_area": receiverArea,
        "shipment_gross_weight": shipmentGrossWeight,
        "c_Name": cName,
        "sender_cityname": senderCityname,
        "receiver_cityname": receiverCityname,
        "sender_areaname": senderAreaname,
        "receiver_areaname": receiverAreaname,
        "sender_branch_id": senderBranchId,
      };
}
