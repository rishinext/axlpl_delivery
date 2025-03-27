class ShipmentDataModel {
  List<Shipment>? shipment;

  ShipmentDataModel({this.shipment});

  ShipmentDataModel.fromJson(Map<String, dynamic> json) {
    if (json['shipment'] != null) {
      shipment = <Shipment>[];
      json['shipment'].forEach((v) {
        shipment!.add(Shipment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (shipment != null) {
      data['shipment'] = shipment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Shipment {
  List<ShipmentDataList>? shipmentData;
  bool? error;
  int? code;
  String? type;
  String? message;

  Shipment({this.shipmentData, this.error, this.code, this.type, this.message});

  Shipment.fromJson(Map<String, dynamic> json) {
    if (json['shipmentData'] != null) {
      shipmentData = <ShipmentDataList>[];
      json['shipmentData'].forEach((v) {
        shipmentData!.add(ShipmentDataList.fromJson(v));
      });
    }
    error = json['error'];
    code = json['code'];
    type = json['type'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (shipmentData != null) {
      data['shipmentData'] = shipmentData!.map((v) => v.toJson()).toList();
    }
    data['error'] = error;
    data['code'] = code;
    data['type'] = type;
    data['message'] = message;
    return data;
  }
}

class ShipmentDataList {
  String? createdDate;
  String? shipmentId;
  String? senderCompanyName;
  String? receiverCompanyName;
  String? origin;
  String? destination;
  String? senderAreaname;
  String? receiverAreaname;
  String? senderGstNo;
  String? receiverGstNo;
  String? shipmentStatus;

  ShipmentDataList(
      {this.createdDate,
      this.shipmentId,
      this.senderCompanyName,
      this.receiverCompanyName,
      this.origin,
      this.destination,
      this.senderAreaname,
      this.receiverAreaname,
      this.senderGstNo,
      this.receiverGstNo,
      this.shipmentStatus});

  ShipmentDataList.fromJson(Map<String, dynamic> json) {
    createdDate = json['created_date'];
    shipmentId = json['shipment_id'];
    senderCompanyName = json['sender_company_name'];
    receiverCompanyName = json['receiver_company_name'];
    origin = json['origin'];
    destination = json['destination'];
    senderAreaname = json['sender_areaname'];
    receiverAreaname = json['receiver_areaname'];
    senderGstNo = json['sender_gst_no'];
    receiverGstNo = json['receiver_gst_no'];
    shipmentStatus = json['shipment_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_date'] = createdDate;
    data['shipment_id'] = shipmentId;
    data['sender_company_name'] = senderCompanyName;
    data['receiver_company_name'] = receiverCompanyName;
    data['origin'] = origin;
    data['destination'] = destination;
    data['sender_areaname'] = senderAreaname;
    data['receiver_areaname'] = receiverAreaname;
    data['sender_gst_no'] = senderGstNo;
    data['receiver_gst_no'] = receiverGstNo;
    data['shipment_status'] = shipmentStatus;
    return data;
  }
}
