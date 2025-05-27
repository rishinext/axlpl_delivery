// To parse this JSON data, do
//
//     final trackingModel = trackingModelFromJson(jsonString);

import 'dart:convert';

TrackingModel trackingModelFromJson(String str) =>
    TrackingModel.fromJson(json.decode(str));

String trackingModelToJson(TrackingModel data) => json.encode(data.toJson());

class TrackingModel {
  List<Tracking>? tracking;
  bool? error;
  int? code;
  String? type;
  String? message;

  TrackingModel({
    this.tracking,
    this.error,
    this.code,
    this.type,
    this.message,
  });

  factory TrackingModel.fromJson(Map<String, dynamic> json) => TrackingModel(
        tracking: json["tracking"] == null
            ? []
            : List<Tracking>.from(
                json["tracking"]!.map((x) => Tracking.fromJson(x))),
        error: json["error"],
        code: json["code"],
        type: json["type"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "tracking": tracking == null
            ? []
            : List<dynamic>.from(tracking!.map((x) => x.toJson())),
        "error": error,
        "code": code,
        "type": type,
        "message": message,
      };
}

class Tracking {
  List<TrackingStatus>? trackingStatus;
  List<ErDatum>? senderData;
  List<ErDatum>? receiverData;

  Tracking({
    this.trackingStatus,
    this.senderData,
    this.receiverData,
  });

  factory Tracking.fromJson(Map<String, dynamic> json) => Tracking(
        trackingStatus: json["TrackingStatus"] == null
            ? null
            : List<TrackingStatus>.from(
                json["TrackingStatus"].map((x) => TrackingStatus.fromJson(x))),
        senderData: json["SenderData"] == null
            ? null
            : List<ErDatum>.from(
                json["SenderData"].map((x) => ErDatum.fromJson(x))),
        receiverData: json["ReceiverData"] == null
            ? null
            : List<ErDatum>.from(
                json["ReceiverData"].map((x) => ErDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        if (trackingStatus != null)
          "TrackingStatus":
              List<dynamic>.from(trackingStatus!.map((x) => x.toJson())),
        if (senderData != null)
          "SenderData": List<dynamic>.from(senderData!.map((x) => x.toJson())),
        if (receiverData != null)
          "ReceiverData":
              List<dynamic>.from(receiverData!.map((x) => x.toJson())),
      };
}

class ErDatum {
  String? receiverName;
  String? companyName;
  String? address1;
  String? address2;
  String? senderName;

  ErDatum({
    this.receiverName,
    this.companyName,
    this.address1,
    this.address2,
    this.senderName,
  });

  factory ErDatum.fromJson(Map<String, dynamic> json) => ErDatum(
        receiverName: json["receiver_name"],
        companyName: json["company_name"],
        address1: json["address1"],
        address2: json["address2"],
        senderName: json["sender_name"],
      );

  Map<String, dynamic> toJson() => {
        "receiver_name": receiverName,
        "company_name": companyName,
        "address1": address1,
        "address2": address2,
        "sender_name": senderName,
      };
}

class TrackingStatus {
  String? status;
  DateTime? dateTime;

  TrackingStatus({
    this.status,
    this.dateTime,
  });

  factory TrackingStatus.fromJson(Map<String, dynamic> json) => TrackingStatus(
        status: json["status"],
        dateTime: json["date_time"] == null
            ? null
            : DateTime.parse(json["date_time"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "date_time": dateTime?.toIso8601String(),
      };
}
