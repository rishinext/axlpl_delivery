class TrackingModel {
  List<TrackingStatusList>? tracking;

  TrackingModel({this.tracking});

  TrackingModel.fromJson(Map<String, dynamic> json) {
    if (json['tracking'] != null) {
      tracking = <TrackingStatusList>[];
      json['tracking'].forEach((v) {
        tracking!.add(new TrackingStatusList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tracking != null) {
      data['tracking'] = this.tracking!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TrackingStatusList {
  List<TrackingStatus>? trackingStatus;
  List<SenderData>? senderData;
  List<ReceiverData>? receiverData;
  bool? error;
  int? code;
  String? type;
  String? message;

  TrackingStatusList(
      {this.trackingStatus,
      this.senderData,
      this.receiverData,
      this.error,
      this.code,
      this.type,
      this.message});

  TrackingStatusList.fromJson(Map<String, dynamic> json) {
    if (json['TrackingStatus'] != null) {
      trackingStatus = <TrackingStatus>[];
      json['TrackingStatus'].forEach((v) {
        trackingStatus!.add(new TrackingStatus.fromJson(v));
      });
    }
    if (json['SenderData'] != null) {
      senderData = <SenderData>[];
      json['SenderData'].forEach((v) {
        senderData!.add(new SenderData.fromJson(v));
      });
    }
    if (json['ReceiverData'] != null) {
      receiverData = <ReceiverData>[];
      json['ReceiverData'].forEach((v) {
        receiverData!.add(new ReceiverData.fromJson(v));
      });
    }
    error = json['error'];
    code = json['code'];
    type = json['type'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.trackingStatus != null) {
      data['TrackingStatus'] =
          this.trackingStatus!.map((v) => v.toJson()).toList();
    }
    if (this.senderData != null) {
      data['SenderData'] = this.senderData!.map((v) => v.toJson()).toList();
    }
    if (this.receiverData != null) {
      data['ReceiverData'] = this.receiverData!.map((v) => v.toJson()).toList();
    }
    data['error'] = this.error;
    data['code'] = this.code;
    data['type'] = this.type;
    data['message'] = this.message;
    return data;
  }
}

class TrackingStatus {
  String? status;
  String? dateTime;

  TrackingStatus({this.status, this.dateTime});

  TrackingStatus.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    dateTime = json['date_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['date_time'] = this.dateTime;
    return data;
  }
}

class SenderData {
  String? senderName;
  String? companyName;
  String? address1;
  String? address2;

  SenderData({this.senderName, this.companyName, this.address1, this.address2});

  SenderData.fromJson(Map<String, dynamic> json) {
    senderName = json['sender_name'];
    companyName = json['company_name'];
    address1 = json['address1'];
    address2 = json['address2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sender_name'] = this.senderName;
    data['company_name'] = this.companyName;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    return data;
  }
}

class ReceiverData {
  String? receiverName;
  String? companyName;
  String? address1;
  String? address2;

  ReceiverData(
      {this.receiverName, this.companyName, this.address1, this.address2});

  ReceiverData.fromJson(Map<String, dynamic> json) {
    receiverName = json['receiver_name'];
    companyName = json['company_name'];
    address1 = json['address1'];
    address2 = json['address2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['receiver_name'] = this.receiverName;
    data['company_name'] = this.companyName;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    return data;
  }
}
