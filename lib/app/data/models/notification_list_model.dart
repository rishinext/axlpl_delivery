class NotificationModel {
  List<NotificationList>? notificationList;
  List<Next>? next;
  String? status;
  String? message;

  NotificationModel(
      {this.notificationList, this.next, this.status, this.message});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    if (json['notificationList'] != null) {
      notificationList = <NotificationList>[];
      json['notificationList'].forEach((v) {
        notificationList!.add(new NotificationList.fromJson(v));
      });
    }
    if (json['next'] != null) {
      next = <Next>[];
      json['next'].forEach((v) {
        next!.add(new Next.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notificationList != null) {
      data['notificationList'] =
          this.notificationList!.map((v) => v.toJson()).toList();
    }
    if (this.next != null) {
      data['next'] = this.next!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

class NotificationList {
  String? notificationId;
  String? title;
  String? message;
  String? messangerId;
  String? createdDate;

  NotificationList(
      {this.notificationId,
      this.title,
      this.message,
      this.messangerId,
      this.createdDate});

  NotificationList.fromJson(Map<String, dynamic> json) {
    notificationId = json['notification_id'];
    title = json['title'];
    message = json['message'];
    messangerId = json['messanger_id'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notification_id'] = this.notificationId;
    data['title'] = this.title;
    data['message'] = this.message;
    data['messanger_id'] = this.messangerId;
    data['created_date'] = this.createdDate;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['next_id'] = this.nextId;
    return data;
  }
}
