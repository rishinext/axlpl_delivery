// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  List<NotificationList>? notificationList;
  List<Next>? next;
  String? status;
  String? message;

  NotificationModel({
    this.notificationList,
    this.next,
    this.status,
    this.message,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        notificationList: json["notificationList"] == null
            ? []
            : List<NotificationList>.from(json["notificationList"]!
                .map((x) => NotificationList.fromJson(x))),
        next: json["next"] == null
            ? []
            : List<Next>.from(json["next"]!.map((x) => Next.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "notificationList": notificationList == null
            ? []
            : List<dynamic>.from(notificationList!.map((x) => x.toJson())),
        "next": next == null
            ? []
            : List<dynamic>.from(next!.map((x) => x.toJson())),
        "status": status,
        "message": message,
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

class NotificationList {
  String? notificationId;
  Title? title;
  Message? message;
  String? messangerId;
  DateTime? createdDate;

  NotificationList({
    this.notificationId,
    this.title,
    this.message,
    this.messangerId,
    this.createdDate,
  });

  factory NotificationList.fromJson(Map<String, dynamic> json) =>
      NotificationList(
        notificationId: json["notification_id"],
        title: titleValues.map[json["title"]]!,
        message: messageValues.map[json["message"]]!,
        messangerId: json["messanger_id"],
        createdDate: json["created_date"] == null
            ? null
            : DateTime.parse(json["created_date"]),
      );

  Map<String, dynamic> toJson() => {
        "notification_id": notificationId,
        "title": titleValues.reverse[title],
        "message": messageValues.reverse[message],
        "messanger_id": messangerId,
        "created_date": createdDate?.toIso8601String(),
      };
}

enum Message { SHIPMENT_PICKED_UP }

final messageValues =
    EnumValues({"Shipment Picked up.": Message.SHIPMENT_PICKED_UP});

enum Title { SHIPMENT_PICKED_UP }

final titleValues =
    EnumValues({"Shipment Picked up": Title.SHIPMENT_PICKED_UP});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
