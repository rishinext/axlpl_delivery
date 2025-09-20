class CustomerInvoiceListModel {
  String? status;
  List<Data>? invoiceList;

  CustomerInvoiceListModel({this.status, this.invoiceList});

  CustomerInvoiceListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      invoiceList = <Data>[];
      json['data'].forEach((v) {
        invoiceList!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.invoiceList != null) {
      data['data'] = this.invoiceList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
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
  String? invoiceDate;
  String? invoiceDateStr;
  String? dueDate;
  String? invoiceDueDateStr;
  String? invoicePaidDate;
  String? invoicePaidStr;
  String? totalAmt;
  String? customerReceiverName;
  String? receiverCompanyName;
  String? paymentStatus;
  String? invoiceLink;

  Data(
      {this.id,
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
      this.invoiceLink});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    billTo = json['bill_to'];
    shipmentIds = json['shipment_ids'];
    shipmentInvoiceId = json['shipment_invoice_id'];
    customerName = json['customer_name'];
    branchId = json['branch_id'];
    custCompanyName = json['cust_company_name'];
    invoiceNo = json['invoice_no'];
    invoiceType = json['invoice_type'];
    invoicePrefix = json['invoice_prefix'];
    invoiceNoPrefix = json['invoice_no_prefix'];
    paymentMode = json['payment_mode'];
    invoiceDate = json['invoice_date'];
    invoiceDateStr = json['invoice_date_str'];
    dueDate = json['due_date'];
    invoiceDueDateStr = json['invoice_due_date_str'];
    invoicePaidDate = json['invoice_paid_date'];
    invoicePaidStr = json['invoice_paid_str'];
    totalAmt = json['total_amt'];
    customerReceiverName = json['customer_receiver_name'];
    receiverCompanyName = json['receiver_company_name'];
    paymentStatus = json['payment_status'];
    invoiceLink = json['invoice_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bill_to'] = this.billTo;
    data['shipment_ids'] = this.shipmentIds;
    data['shipment_invoice_id'] = this.shipmentInvoiceId;
    data['customer_name'] = this.customerName;
    data['branch_id'] = this.branchId;
    data['cust_company_name'] = this.custCompanyName;
    data['invoice_no'] = this.invoiceNo;
    data['invoice_type'] = this.invoiceType;
    data['invoice_prefix'] = this.invoicePrefix;
    data['invoice_no_prefix'] = this.invoiceNoPrefix;
    data['payment_mode'] = this.paymentMode;
    data['invoice_date'] = this.invoiceDate;
    data['invoice_date_str'] = this.invoiceDateStr;
    data['due_date'] = this.dueDate;
    data['invoice_due_date_str'] = this.invoiceDueDateStr;
    data['invoice_paid_date'] = this.invoicePaidDate;
    data['invoice_paid_str'] = this.invoicePaidStr;
    data['total_amt'] = this.totalAmt;
    data['customer_receiver_name'] = this.customerReceiverName;
    data['receiver_company_name'] = this.receiverCompanyName;
    data['payment_status'] = this.paymentStatus;
    data['invoice_link'] = this.invoiceLink;
    return data;
  }
}
