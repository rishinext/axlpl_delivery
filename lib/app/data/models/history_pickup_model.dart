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
  String? id;
  String? shipmentId;
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

  HistoryPickup(
      {this.id,
      this.shipmentId,
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

  HistoryPickup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shipmentId = json['shipment_id'];
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['shipment_id'] = shipmentId;
    data['status'] = status;
    data['name'] = name;
    data['company_name'] = companyName;
    data['mobile'] = mobile;
    data['area_id'] = areaId;
    data['area_name'] = areaName;
    data['pincode'] = pincode;
    data['address1'] = address1;
    data['address2'] = address2;
    data['city_name'] = cityName;
    data['date'] = date;
    data['receiver_city_name'] = receiverCityName;
    return data;
  }
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
