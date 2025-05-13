// To parse this JSON data, do
//
//     final messangerModel = messangerModelFromJson(jsonString);

import 'dart:convert';

MessangerModel messangerModelFromJson(String str) =>
    MessangerModel.fromJson(json.decode(str));

String messangerModelToJson(MessangerModel data) => json.encode(data.toJson());

class MessangerModel {
  List<MessangerList>? messangersList;
  List<Next>? next;

  MessangerModel({
    this.messangersList,
    this.next,
  });

  factory MessangerModel.fromJson(Map<String, dynamic> json) => MessangerModel(
        messangersList: json["Messangers"] == null
            ? []
            : List<MessangerList>.from(
                json["Messangers"]!.map((x) => MessangerList.fromJson(x))),
        next: json["next"] == null
            ? []
            : List<Next>.from(json["next"]!.map((x) => Next.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Messangers": messangersList == null
            ? []
            : List<dynamic>.from(messangersList!.map((x) => x.toJson())),
        "next": next == null
            ? []
            : List<dynamic>.from(next!.map((x) => x.toJson())),
      };
}

class MessangerList {
  String? id;
  String? name;
  String? code;
  String? phone;
  String? email;
  String? path;
  String? photo;

  MessangerList({
    this.id,
    this.name,
    this.code,
    this.phone,
    this.email,
    this.path,
    this.photo,
  });

  factory MessangerList.fromJson(Map<String, dynamic> json) => MessangerList(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        phone: json["phone"],
        email: json["email"],
        path: json["path"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "phone": phone,
        "email": email,
        "path": path,
        "photo": photo,
      };
}

class Next {
  String? lastId;
  String? nextId;

  Next({
    this.lastId,
    this.nextId,
  });

  factory Next.fromJson(Map<String, dynamic> json) => Next(
        lastId: json["last_id"],
        nextId: json["next_id"],
      );

  Map<String, dynamic> toJson() => {
        "last_id": lastId,
        "next_id": nextId,
      };
}
