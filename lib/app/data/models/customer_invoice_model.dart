// To parse this JSON data, do
//
//     final customerInvoiceListModel = customerInvoiceListModelFromJson(jsonString);

import 'dart:convert';

CustomerInvoiceListModel customerInvoiceListModelFromJson(String str) =>
    CustomerInvoiceListModel.fromJson(json.decode(str));

String customerInvoiceListModelToJson(CustomerInvoiceListModel data) =>
    json.encode(data.toJson());

class CustomerInvoiceListModel {
  String? status;
  List<CustomerInvoiceModel>? data;

  CustomerInvoiceListModel({
    this.status,
    this.data,
  });

  factory CustomerInvoiceListModel.fromJson(Map<String, dynamic> json) =>
      CustomerInvoiceListModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<CustomerInvoiceModel>.from(
                json["data"]!.map((x) => CustomerInvoiceModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CustomerInvoiceModel {
  String? id;
  String? billTo;
  String? shipmentIds;
  String? shipmentInvoiceId;
  String? customerName;
  String? branchId;
  String? custCompanyName;
  String? invoiceNo;
  String? invoiceType;
  String? invoicePrefix;
  String? invoiceNoPrefix;
  String? paymentMode;
  DateTime? invoiceDate;
  String? invoiceDateStr;
  DateTime? dueDate;
  String? invoiceDueDateStr;
  DateTime? invoicePaidDate;
  String? invoicePaidStr;
  String? totalAmt;
  String? customerReceiverName;
  String? receiverCompanyName;
  String? paymentStatus;
  String? invoiceLink;

  CustomerInvoiceModel({
    this.id,
    this.billTo,
    this.shipmentIds,
    this.shipmentInvoiceId,
    this.customerName,
    this.branchId,
    this.custCompanyName,
    this.invoiceNo,
    this.invoiceType,
    this.invoicePrefix,
    this.invoiceNoPrefix,
    this.paymentMode,
    this.invoiceDate,
    this.invoiceDateStr,
    this.dueDate,
    this.invoiceDueDateStr,
    this.invoicePaidDate,
    this.invoicePaidStr,
    this.totalAmt,
    this.customerReceiverName,
    this.receiverCompanyName,
    this.paymentStatus,
    this.invoiceLink,
  });

  factory CustomerInvoiceModel.fromJson(Map<String, dynamic> json) =>
      CustomerInvoiceModel(
        id: json["id"],
        billTo: json["bill_to"],
        shipmentIds: json["shipment_ids"],
        shipmentInvoiceId: json["shipment_invoice_id"],
        customerName: json["customer_name"],
        branchId: json["branch_id"],
        custCompanyName: json["cust_company_name"],
        invoiceNo: json["invoice_no"],
        invoiceType: json["invoice_type"],
        invoicePrefix: json["invoice_prefix"],
        invoiceNoPrefix: json["invoice_no_prefix"],
        paymentMode: json["payment_mode"],
        invoiceDate: json["invoice_date"] == null
            ? null
            : DateTime.parse(json["invoice_date"]),
        invoiceDateStr: json["invoice_date_str"],
        dueDate:
            json["due_date"] == null ? null : DateTime.parse(json["due_date"]),
        invoiceDueDateStr: json["invoice_due_date_str"],
        invoicePaidDate: json["invoice_paid_date"] == null
            ? null
            : DateTime.parse(json["invoice_paid_date"]),
        invoicePaidStr: json["invoice_paid_str"],
        totalAmt: json["total_amt"],
        customerReceiverName: json["customer_receiver_name"],
        receiverCompanyName: json["receiver_company_name"],
        paymentStatus: json["payment_status"],
        invoiceLink: json["invoice_link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bill_to": billTo,
        "shipment_ids": shipmentIds,
        "shipment_invoice_id": shipmentInvoiceId,
        "customer_name": customerName,
        "branch_id": branchId,
        "cust_company_name": custCompanyName,
        "invoice_no": invoiceNo,
        "invoice_type": invoiceType,
        "invoice_prefix": invoicePrefix,
        "invoice_no_prefix": invoiceNoPrefix,
        "payment_mode": paymentMode,
        "invoice_date": invoiceDate?.toIso8601String(),
        "invoice_date_str": invoiceDateStr,
        "due_date": dueDate?.toIso8601String(),
        "invoice_due_date_str": invoiceDueDateStr,
        "invoice_paid_date": invoicePaidDate?.toIso8601String(),
        "invoice_paid_str": invoicePaidStr,
        "total_amt": totalAmt,
        "customer_receiver_name": customerReceiverName,
        "receiver_company_name": receiverCompanyName,
        "payment_status": paymentStatus,
        "invoice_link": invoiceLink,
      };
}
