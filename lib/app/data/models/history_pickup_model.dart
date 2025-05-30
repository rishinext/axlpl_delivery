class HistoryPickupModel {
  String? status;
  String? message;
  List<HistoryPickup>? historyPickup;
  List<Next>? next;

  HistoryPickupModel(
      {this.status, this.message, this.historyPickup, this.next});

  HistoryPickupModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['HistoryPickup'] != null) {
      historyPickup = <HistoryPickup>[];
      json['HistoryPickup'].forEach((v) {
        historyPickup!.add(HistoryPickup.fromJson(v));
      });
    }
    if (json['next'] != null) {
      next = <Next>[];
      json['next'].forEach((v) {
        next!.add(Next.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (historyPickup != null) {
      data['HistoryPickup'] = historyPickup!.map((v) => v.toJson()).toList();
    }
    if (next != null) {
      data['next'] = next!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HistoryPickup {
  int? id;
  String? messangerName;
  String? paymentMode;
  String? subPaymentMode;
  String? shipmentId;
  String? axlplInsurance;
  String? status;
  String? name;
  String? companyName;
  String? mobile;
  int? areaId;
  String? areaName;
  String? pincode;
  String? address1;
  String? address2;
  String? cityName;
  DateTime? date;
  String? receiverCityName;

  HistoryPickup({
    this.id,
    this.messangerName,
    this.paymentMode,
    this.subPaymentMode,
    this.shipmentId,
    this.axlplInsurance,
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
    this.receiverCityName,
  });

  factory HistoryPickup.fromJson(Map<String, dynamic> json) => HistoryPickup(
        id: json["id"],
        messangerName: json["messanger_name"],
        paymentMode: json["payment_mode"],
        subPaymentMode: json["sub_payment_mode"],
        shipmentId: json["shipment_id"],
        axlplInsurance: json["axlpl_insurance"],
        status: json["status"],
        name: json["name"],
        companyName: json["company_name"],
        mobile: json["mobile"],
        areaId: json["area_id"],
        areaName: json["area_name"],
        pincode: json["pincode"],
        address1: json["address1"],
        address2: json["address2"],
        cityName: json["city_name"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        receiverCityName: json["receiver_city_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "messanger_name": messangerName,
        "payment_mode": paymentMode,
        "sub_payment_mode": subPaymentMode,
        "shipment_id": shipmentId,
        "axlpl_insurance": axlplInsurance,
        "status": status,
        "name": name,
        "company_name": companyName,
        "mobile": mobile,
        "area_id": areaId,
        "area_name": areaName,
        "pincode": pincode,
        "address1": address1,
        "address2": address2,
        "city_name": cityName,
        "date": date?.toIso8601String(),
        "receiver_city_name": receiverCityName,
      };
}

class Next {
  String? total;
  String? nextId;

  Next({this.total, this.nextId});

  Next.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    nextId = json['next_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['next_id'] = nextId;
    return data;
  }
}
