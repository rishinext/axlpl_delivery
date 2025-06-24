class ShipmentModel {
  final shipmentId;
  final customerId;
  final categoryId;
  final productId;
  final netWeight;
  final grossWeight;
  final paymentMode;
  final serviceId;
  final invoiceValue;
  final axlplInsurance;
  final policyNo;
  final expDate;
  final insuranceValue;
  final shipmentStatus;
  final calculationStatus;
  final addedBy;
  final addedByType;
  final preAlertShipment;
  final shipmentInvoiceNo;
  final isAmtEditedByUser;
  final remark;
  final billTo;
  final numberOfParcel;
  final additionalAxlplInsurance;
  final shipmentCharges;
  final insuranceCharges;
  final invoiceCharges;
  final handlingCharges;
  final tax;
  final totalCharges;
  final grandTotal;
  final docketNo;
  final shipmentDate;

  final senderName;
  final senderCompanyName;
  final senderCountry;
  final senderState;
  final senderCity;
  final senderArea;
  final senderPincode;
  final senderAddress1;
  final senderAddress2;
  final senderMobile;
  final senderEmail;
  final senderSaveAddress;
  final senderIsNewSenderAddress;
  final senderGstNo;
  final senderCustomerId;

  final receiverName;
  final receiverCompanyName;
  final receiverCountry;
  final receiverState;
  final receiverCity;
  final receiverArea;
  final receiverPincode;
  final receiverAddress1;
  final receiverAddress2;
  final receiverMobile;
  final receiverEmail;
  final receiverSaveAddress;
  final receiverIsNewReceiverAddress;
  final receiverGstNo;
  final receiverCustomerId;

  final isDiffAdd;
  final diffReceiverCountry;
  final diffReceiverState;
  final diffReceiverCity;
  final diffReceiverArea;
  final diffReceiverPincode;
  final diffReceiverAddress1;
  final diffReceiverAddress2;

  ShipmentModel({
    this.shipmentId,
    this.customerId,
    this.categoryId,
    this.productId,
    this.netWeight,
    this.grossWeight,
    this.paymentMode,
    this.serviceId,
    this.invoiceValue,
    this.axlplInsurance,
    this.policyNo,
    this.expDate,
    this.insuranceValue,
    this.shipmentStatus,
    this.calculationStatus,
    this.addedBy,
    this.addedByType,
    this.preAlertShipment,
    this.shipmentInvoiceNo,
    this.isAmtEditedByUser,
    this.remark,
    this.billTo,
    this.numberOfParcel,
    this.additionalAxlplInsurance,
    this.shipmentCharges,
    this.insuranceCharges,
    this.invoiceCharges,
    this.handlingCharges,
    this.tax,
    this.totalCharges,
    this.grandTotal,
    this.docketNo,
    this.shipmentDate,
    this.senderName,
    this.senderCompanyName,
    this.senderCountry,
    this.senderState,
    this.senderCity,
    this.senderArea,
    this.senderPincode,
    this.senderAddress1,
    this.senderAddress2,
    this.senderMobile,
    this.senderEmail,
    this.senderSaveAddress,
    this.senderIsNewSenderAddress,
    this.senderGstNo,
    this.senderCustomerId,
    this.receiverName,
    this.receiverCompanyName,
    this.receiverCountry,
    this.receiverState,
    this.receiverCity,
    this.receiverArea,
    this.receiverPincode,
    this.receiverAddress1,
    this.receiverAddress2,
    this.receiverMobile,
    this.receiverEmail,
    this.receiverSaveAddress,
    this.receiverIsNewReceiverAddress,
    this.receiverGstNo,
    this.receiverCustomerId,
    this.isDiffAdd,
    this.diffReceiverCountry,
    this.diffReceiverState,
    this.diffReceiverCity,
    this.diffReceiverArea,
    this.diffReceiverPincode,
    this.diffReceiverAddress1,
    this.diffReceiverAddress2,
  });

  Map<String, dynamic> toJson() => {
        'shipment_id': shipmentId,
        'customer_id': customerId,
        'category_id': categoryId,
        'product_id': productId,
        'net_weight': netWeight,
        'gross_weight': grossWeight,
        'payment_mode': paymentMode,
        'service_id': serviceId,
        'invoice_value': invoiceValue,
        'axlpl_insurance': axlplInsurance,
        'policy_no': policyNo,
        'exp_date': expDate,
        'insurance_value': insuranceValue,
        'shipment_status': shipmentStatus,
        'calculation_status': calculationStatus,
        'added_by': addedBy,
        'added_by_type': addedByType,
        'pre_alert_shipment': preAlertShipment,
        'shipment_invoice_no': shipmentInvoiceNo,
        'is_amt_edited_by_user': isAmtEditedByUser,
        'remark': remark,
        'bill_to': billTo,
        'number_of_parcel': numberOfParcel,
        'additional_axlpl_insurance': additionalAxlplInsurance,
        'shipment_charges': shipmentCharges,
        'insurance_charges': insuranceCharges,
        'invoice_charges': invoiceCharges,
        'handling_charges': handlingCharges,
        'tax': tax,
        'total_charges': totalCharges,
        'grand_total': grandTotal,
        'docket_no': docketNo,
        'shipment_date': shipmentDate,
        'sender_name': senderName,
        'sender_company_name': senderCompanyName,
        'sender_country': senderCountry,
        'sender_state': senderState,
        'sender_city': senderCity,
        'sender_area': senderArea,
        'sender_pincode': senderPincode,
        'sender_address1': senderAddress1,
        'sender_address2': senderAddress2,
        'sender_mobile': senderMobile,
        'sender_email': senderEmail,
        'sender_save_address': senderSaveAddress,
        'sender_is_new_sender_address': senderIsNewSenderAddress,
        'sender_gst_no': senderGstNo,
        'sender_customer_id': senderCustomerId,
        'receiver_name': receiverName,
        'receiver_company_name': receiverCompanyName,
        'receiver_country': receiverCountry,
        'receiver_state': receiverState,
        'receiver_city': receiverCity,
        'receiver_area': receiverArea,
        'receiver_pincode': receiverPincode,
        'receiver_address1': receiverAddress1,
        'receiver_address2': receiverAddress2,
        'receiver_mobile': receiverMobile,
        'receiver_email': receiverEmail,
        'receiver_save_address': receiverSaveAddress,
        'receiver_is_new_receiver_address': receiverIsNewReceiverAddress,
        'receiver_gst_no': receiverGstNo,
        'receiver_customer_id': receiverCustomerId,
        'is_diff_add': isDiffAdd,
        'diff_receiver_country': diffReceiverCountry,
        'diff_receiver_state': diffReceiverState,
        'diff_receiver_city': diffReceiverCity,
        'diff_receiver_area': diffReceiverArea,
        'diff_receiver_pincode': diffReceiverPincode,
        'diff_receiver_address1': diffReceiverAddress1,
        'diff_receiver_address2': diffReceiverAddress2,
      };
}
