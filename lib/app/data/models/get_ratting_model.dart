import 'dart:convert';

GetRattingModel getRattingModelFromJson(String str) =>
    GetRattingModel.fromJson(json.decode(str));

String getRattingModelToJson(GetRattingModel data) =>
    json.encode(data.toJson());

class GetRattingModel {
  String? status;
  RattingDataModel? data;

  GetRattingModel({
    this.status,
    this.data,
  });

  factory GetRattingModel.fromJson(Map<String, dynamic> json) =>
      GetRattingModel(
        status: json["status"],
        data: json["data"] != null
            ? RattingDataModel.fromJson(json["data"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class RattingDataModel {
  String? messangerId;
  int? totalRatings;
  double? averageRating;
  int? deliveredCount;

  RattingDataModel({
    this.messangerId,
    this.totalRatings,
    this.averageRating,
    this.deliveredCount,
  });

  factory RattingDataModel.fromJson(Map<String, dynamic> json) =>
      RattingDataModel(
        messangerId: json["messanger_id"]?.toString(),
        totalRatings: json["total_ratings"],
        averageRating: (json["average_rating"] != null)
            ? json["average_rating"].toDouble()
            : 0.0,
        deliveredCount: json["delivered_count"],
      );

  Map<String, dynamic> toJson() => {
        "messanger_id": messangerId,
        "total_ratings": totalRatings,
        "average_rating": averageRating,
        "delivered_count": deliveredCount,
      };
}
