class UsedContractModel {
  String? status;
  String? message;
  String? contractId;
  String? categoryName;
  String? ratePerGram;
  String? assignedWeight;
  String? assignedValue;
  List<Transactions>? transactions;

  UsedContractModel(
      {this.status,
      this.message,
      this.contractId,
      this.categoryName,
      this.ratePerGram,
      this.assignedWeight,
      this.assignedValue,
      this.transactions});

  UsedContractModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    contractId = json['contract_id'];
    categoryName = json['category_name'];
    ratePerGram = json['rate_per_gram'];
    assignedWeight = json['assigned_weight'];
    assignedValue = json['assigned_value'];
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(new Transactions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['contract_id'] = this.contractId;
    data['category_name'] = this.categoryName;
    data['rate_per_gram'] = this.ratePerGram;
    data['assigned_weight'] = this.assignedWeight;
    data['assigned_value'] = this.assignedValue;
    if (this.transactions != null) {
      data['transactions'] = this.transactions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transactions {
  String? date;
  String? detail;
  String? credit;
  String? debit;
  String? balance;
  String? shipmentID;

  Transactions({this.date, this.detail, this.credit, this.debit, this.balance});

  Transactions.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    detail = json['detail'];
    credit = json['credit'];
    debit = json['debit'];
    balance = json['balance'];
    shipmentID = json['shipment_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['detail'] = this.detail;
    data['credit'] = this.credit;
    data['debit'] = this.debit;
    data['balance'] = this.balance;
    data['shipment_id'] = this.shipmentID;
    return data;
  }
}
