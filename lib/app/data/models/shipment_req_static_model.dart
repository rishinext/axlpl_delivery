class ShipmentRequestModel {
  String? shipmentSelectedDate;
  String? selectedCate;
  String? selectedCommdity;
  String? newWeight;
  String? grossWeight;
  String? paymentMode;
  String? noOfParcel;
  String? serviceType;
  String? insurance;
  String? policyNo;
  String? expireDate;
  String? insuranceAmt;
  String? invoiceNo;
  String? remark;

  ShipmentRequestModel({
    this.shipmentSelectedDate,
    this.selectedCate,
    this.selectedCommdity,
    this.newWeight,
    this.grossWeight,
    this.paymentMode,
    this.noOfParcel,
    this.serviceType,
    this.insurance,
    this.policyNo,
    this.expireDate,
    this.insuranceAmt,
    this.invoiceNo,
    this.remark,
  });

  ShipmentRequestModel copyWith({
    String? shipmentSelectedDate,
    String? selectedCate,
    String? selectedCommdity,
    String? newWeight,
    String? grossWeight,
    String? paymentMode,
    String? noOfParcel,
    String? serviceType,
    String? insurance,
    String? policyNo,
    String? expireDate,
    String? insuranceAmt,
    String? invoiceNo,
    String? remark,
  }) {
    return ShipmentRequestModel(
      shipmentSelectedDate: shipmentSelectedDate ?? this.shipmentSelectedDate,
      selectedCate: selectedCate ?? this.selectedCate,
      selectedCommdity: selectedCommdity ?? this.selectedCommdity,
      newWeight: newWeight ?? this.newWeight,
      grossWeight: grossWeight ?? this.grossWeight,
      paymentMode: paymentMode ?? this.paymentMode,
      noOfParcel: noOfParcel ?? this.noOfParcel,
      serviceType: serviceType ?? this.serviceType,
      insurance: insurance ?? this.insurance,
      policyNo: policyNo ?? this.policyNo,
      expireDate: expireDate ?? this.expireDate,
      insuranceAmt: insuranceAmt ?? this.insuranceAmt,
      invoiceNo: invoiceNo ?? this.invoiceNo,
      remark: remark ?? this.remark,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ship_date': shipmentSelectedDate,
      'selected_cate': selectedCate,
      'selected_commo': selectedCommdity,
      'payment_mode': paymentMode,
      'net_weight': newWeight,
      'gross_weight': grossWeight,
      'no_of_parcel': noOfParcel,
      'service_type': serviceType,
      'insurance': insurance,
      'policy_no': policyNo,
      'exp_date': expireDate,
      'insurnce_amt': insuranceAmt,
      'invoice_no': invoiceNo,
      'remark': remark,
    };
  }
}
