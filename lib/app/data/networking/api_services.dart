import 'dart:convert';
import 'dart:developer';

import 'package:axlpl_delivery/app/data/models/shipment_req_static_model.dart';
import 'package:axlpl_delivery/app/data/networking/api_client.dart';
import 'package:axlpl_delivery/app/data/networking/api_endpoint.dart';
import 'package:dio/dio.dart';

import "dart:async";
import 'api_response.dart';

class ApiServices {
  static final ApiClient _api = ApiClient();

  Future<APIResponse> getConsignment(
    String consigenmentID,
    final branchID,
    final token,
    // String zipcode,
  ) async {
    final body = {
      'consignment_no': consigenmentID,
      'branch_id': branchID
      // 'zipcode': zipcode,
    };
    return _api.get(
      getConsignmentPoint,
      query: body,
      token: token,
    );
  }

  Future<APIResponse> getDeliveryHistory(
    String userID,
    String zipcode,
    String branchID,
    String nextID,
    String token,
  ) async {
    final query = {
      'messanger_id': userID,
      'zipcode': zipcode,
      'branch_id': branchID,
      'next_id': nextID
    };
    return _api.get(
      deliveryHistoryPoint,
      query: query,
      token: token,
    );
  }

  Future<APIResponse> getPickupHistory(
    String userID,
    String branchID,
    // String zipcode,
    // String paymentMode,
    String token,
  ) async {
    final body = {
      'messanger_id': userID,
      // 'zipcode': zipcode,
      'branch_id': branchID
    };
    return _api.get(historyPickupPoint, query: body, token: token);
  }

  Future<APIResponse> getDashboardData(
    String userID,
    String branchID,
    // String zipcode,
    String token,
  ) async {
    final query = {
      'messanger_id': userID,
      'branch_id': branchID,
    };
    return _api.get(
      dashboardDataPoint,
      query: query,
      token: token,
    );
  }

  Future<APIResponse> getCustomersList(
    String userID,
    String branchID,
    String? search,
    String nextID,
    String token,
  ) async {
    final query = {
      'm_id': userID,
      'branch_id': branchID,
      'search_query': search ?? "",
      'next_id': nextID
    };
    return _api.get(getCustomersListPoint, query: query, token: token);
  }

  Future<APIResponse> getCategoryList(
    String? search,
    String token,
  ) async {
    final query = {
      'search_query': search ?? "",
    };
    return _api.get(getCategoryListPoint, query: query, token: token);
  }

  Future<APIResponse> getAllDelivery(
    final id,
    final brachID,
    final nextID,
    final token,
  ) {
    final body = {
      'messanger_id': id,
      'branch_id': brachID,
      'next_id': nextID,
      'token': token,
    };
    return _api.post(
      getAllDeliveryPoint,
      body,
      token: token,
    );
  }

  Future<APIResponse> getCommodityList(
    String? search,
    String? categoryID,
    String token,
  ) async {
    final body = {
      'search_query': search ?? "",
      'category_id': categoryID,
    };
    return _api.post(getCommodityListPoint, body, token: token);
  }

  Future<APIResponse> getServiceTypeList(
    String token,
  ) async {
    final body = {};
    return _api.post(getServiceTypePoint, body, token: token);
  }

  Future<APIResponse> getPincodeDetails(String token, String pincode) async {
    final body = {
      'pincode': pincode,
    };
    return _api.post(getPincodeDetailsPoint, body, token: token);
  }

  Future<APIResponse> getAllAeraByZip(String token, String pincode) async {
    final body = {
      'pincode': pincode,
    };
    return _api.post(getAllAreaByZipcodePoint, body, token: token);
  }

  Future<APIResponse> getShipmentDataList(
      final token,
      final userID,
      final nextID,
      final shimentStatus,
      final receiverGSTNo,
      final senderGSTNo,
      final receiverAeraName,
      final senderAeraName,
      final destination,
      final orgin,
      final receiverCompanyName,
      final senderCompanyName,
      final shipmentID) async {
    final body = {
      'user_id': userID,
      'next_id': nextID,
      'shipment_status': shimentStatus,
      'receiver_gst_no': receiverGSTNo,
      'sender_gst_no': senderGSTNo,
      'receiver_areaname': receiverAeraName,
      'sender_areaname': senderAeraName,
      'destination': destination,
      'origin': orgin,
      'receiver_company_name': receiverCompanyName,
      'sender_company_name': senderCompanyName,
      'shipment_id': shipmentID,
    };
    return _api.post(
      getShipmentDataListPoint,
      token: token,
      body,
    );
  }

// post call
  Future<APIResponse> loginUserService(
    String mobile,
    // final email,
    String password,
    String fcmToken,
    String appVersion,
    String latitude,
    String longitude,
    String deviceId,

    // String token
  ) {
    final Map<String, dynamic> body = {
      'mobile': mobile,
      'password': password,
      'fcm_token': fcmToken,
      // 'token': token,
      'version': appVersion,
      'latitude': latitude,
      'longitude': longitude,
      'device_id': deviceId,
    };

    return _api.post(loginPoint, body);
  }

  Future<APIResponse> logout(
    String userID,
    String role,
    String latitude,
    String longitude,
    final token,
  ) {
    final body = {
      'm_id': userID,
      'role': role,
      'latitude': latitude,
      'longitude': longitude,
    };
    return _api.post(
      logoutPoint,
      body,
      token: token,
    );
  }

/*  Future<APIResponse> addShipment(
    final custID,
    final cateID,
    final productID,
    final netWeight,
    final grossWeight,
    final paymentModeID,
    final serviceTypeID,
    final policyNo,
    final expDate,
    final invoiceAmt,
    final insurance,
    final addInsurance,
    final shipmentStatus,
    final caculationStatus,
    final addedBy,
    final addedType,
    final alertShipment,
    final shipmentInvoice,
    final isAmtEditedByUser,
    final shipmentID,
    final senderName,
    final senderCompanyName,
    final senderCountry,
    final senderState,
    final senderCity,
    final senderAera,
    final senderPincode,
    final senderAddress1,
    final senderAddress2,
    final senderMobile,
    final senderEmail,
    final senderSaveAddress,
    final senderisNewAdresss,
    final senderGstNo,
    final senderCustID,
    final receiverName,
    final remark,
    final billTo,
    final noOfParcel,
    final receiverCompanyName,
    final receiverCountry,
    final receiverState,
    final receiverCity,
    final receiverAera,
    final receiverPincode,
    final receiverAddress1,
    final receiverAddress2,
    final receiverMobile,
    final receiverEmail,
    final receiverSaveAddress,
    final receiverisNewAdresss,
    final receiverGstNo,
    final receiverCustID,
    final isDiffAdd,
    final diffReceiverCountry,
    final diffReceiverState,
    final diffReceiverCity,
    final diffReceiverAera,
    final diffReceiverPincode,
    final diffReceiverAddress1,
    final diffReceiverAddress2,
    final shipmentCharges,
    final insuranceCharges,
    final insuranceValue,
    final invoiceCharges,
    final handlingCharges,
    final tax,
    final totalCharges,
    final grandeTotal,
    final docketNo,
    final shipmentDate,
    final token,
  ) async {
    final body = {
      'customer_id': custID,
      'category_id': cateID,
      'product_id': productID,
      'net_weight': double.tryParse(netWeight ?? '0') ?? 0,
      'gross_weight': double.tryParse(grossWeight ?? '0') ?? 0,
      'payment_mode': paymentModeID?.toString() ?? '1',
      'service_id': serviceTypeID,
      'invoice_value': invoiceAmt,
      'axlpl_insurance': insurance,
      'policy_no': policyNo,
      'exp_date': expDate,
      'insurance_value': insuranceValue,
      'remark': remark,
      'bill_to': billTo,
      'number_of_parcel': double.tryParse(noOfParcel ?? '0') ?? 0,
      'additional_axlpl_insurance': addInsurance,
      'shipment_status': shipmentStatus,
      'calculation_status': caculationStatus,
      'added_by': addedBy,
      'added_by_type': addedType,
      'pre_alert_shipment': alertShipment,
      'shipment_invoice_no': shipmentInvoice,
      'is_amt_edited_by_user': isAmtEditedByUser,
      'shipment_id': shipmentID,
      'sender_name': senderName?.toString() ?? 'Default Sender',
      'sender_company_name': senderCompanyName,
      'sender_country': senderCountry,
      'sender_state': senderState?.toString() ?? 'Default State',
      'sender_city': senderCity,
      'sender_area': senderAera,
      'sender_pincode': senderPincode,
      'sender_address1': senderAddress1,
      'sender_address2': senderAddress2,
      'sender_mobile': senderMobile?.toString() ?? '9999999999',
      'sender_email': senderEmail,
      'sender_save_address': senderisNewAdresss,
      'sender_gst_no': senderGstNo,
      'sender_customer_id': senderCustID,
      'receiver_name': receiverName,
      'receiver_company_name': receiverCompanyName,
      'receiver_country': receiverCountry,
      'receiver_state': receiverState,
      'receiver_city': receiverCity,
      'receiver_area': receiverAera,
      'receiver_pincode': receiverPincode,
      'receiver_address1': receiverAddress1,
      'receiver_address2': receiverAddress2,
      'receiver_mobile': receiverMobile,
      'receiver_email': receiverEmail,
      'receiver_save_address': receiverSaveAddress,
      'receiver_is_new_receiver_address': receiverisNewAdresss,
      'receiver_gst_no': receiverGstNo,
      'receiver_customer_id': receiverCustID,
      'is_diff_add': isDiffAdd,
      'diff_receiver_country': diffReceiverCountry,
      'diff_receiver_state': diffReceiverState,
      'diff_receiver_city': diffReceiverCity,
      'diff_receiver_area': diffReceiverAera,
      'diff_receiver_pincode': diffReceiverPincode,
      'diff_receiver_address1': diffReceiverAddress1,
      'diff_receiver_address2': diffReceiverAddress2,
      'shipment_charges': shipmentCharges,
      'insurance_charges': insuranceCharges,
      'invoice_charges': invoiceCharges?.toString() ?? '0',
      'handling_charges': handlingCharges,
      'tax': tax,
      'total_charges': totalCharges,
      'grand_total': grandeTotal?.toString() ?? '0.0',
      'docket_no': docketNo,
      'shipment_date': shipmentDate,
      'token': token,
    };
    

    return _api.post(
      addShipmentPoint,
      body,
      token: token,
    );
  }*/

  // Future<APIResponse> addShipment({
  //   required ShipmentDetails shipmentDetails,
  //   required SenderData sender,
  //   required ReceiverData receiver,
  //   required bool isDiffAdd,
  //   required String docketNo,
  //   required String shipmentDate,
  //   bool alertShipment = false,
  //   bool isAmtEditedByUser = false,
  //   String shipmentStatus = 'Approved',
  //   String calculationStatus = 'pending',
  //   String? diffReceiverCountry,
  //   String? diffReceiverState,
  //   String? diffReceiverCity,
  //   String? diffReceiverAera,
  //   String? diffReceiverPincode,
  //   String? diffReceiverAddress1,
  //   String? diffReceiverAddress2,
  //   required String token,
  // }) async {
  //   final body = {
  //     ...shipmentDetails.toJson(),
  //     ...sender.toJson(),
  //     ...receiver.toJson(),
  //     'is_diff_add': isDiffAdd,
  //     'docket_no': docketNo,
  //     'shipment_date': shipmentDate,
  //     'pre_alert_shipment': alertShipment,
  //     'is_amt_edited_by_user': isAmtEditedByUser,
  //     'shipment_status': shipmentStatus,
  //     'calculation_status': calculationStatus,
  //     'diff_receiver_country': diffReceiverCountry,
  //     'diff_receiver_state': diffReceiverState,
  //     'diff_receiver_city': diffReceiverCity,
  //     'diff_receiver_area': diffReceiverAera,
  //     'diff_receiver_pincode': diffReceiverPincode,
  //     'diff_receiver_address1': diffReceiverAddress1,
  //     'diff_receiver_address2': diffReceiverAddress2,
  //     'token': token,
  //   };

  //   log("Shipment API Body: ${json.encode(body)}");

  //   return _api.post(addShipmentPoint, body, token: token);
  // }

  Future<APIResponse> addShipment({
    required ShipmentModel shipmentModel,
    required String token,
  }) async {
    // Convert ShipmentModel to JSON map
    final body = shipmentModel.toJson();

    // Add token if your API requires it in body (or in headers as needed)
    body['token'] = token;

    // Optional: log body for debugging
    log("Shipment API Body: ${json.encode(body)}");

    // Call your API post method
    return _api.post(addShipmentPoint, body, token: token);
  }

  Future<APIResponse> getShipmentCalculation(
    final custID,
    final cateID,
    final commID,
    final netWeight,
    final grossWeight,
    final paymentMode,
    final invoiceValue,
    final insuranceByAxlpl,
    final policyNo,
    final numberOfParcel,
    final expDate,
    final policyValue,
    final senderZip,
    final receiverZip,
  ) async {
    final body = {
      'customer_id': custID,
      'category_id': cateID,
      'commodity_id': commID,
      'net_weight': netWeight,
      'gross_weight': grossWeight,
      'payment_mode': paymentMode,
      'invoice_value': invoiceValue,
      'insurance_by_AXLPL': insuranceByAxlpl,
      'policy_no': policyNo,
      'number_of_parcel': numberOfParcel,
      'policy_expirydate': expDate,
      'policy_value': policyValue,
      'sender_zipcode': senderZip,
      'receiver_zipcode': receiverZip
    };
    return _api.post(
      getShipmentCalclulationPoint,
      body,
    );
  }

  Future<APIResponse> changePassword(
    String id,
    String oldPassword,
    String newPassword,
    String role,
    String token,
  ) {
    final body = {
      'id': id,
      'old_password': oldPassword,
      'new_password': newPassword,
      'user_type': role,
    };
    return _api.post(
      changePasswordPoint,
      body,
      token: token,
    );
  }

  Future<APIResponse> getMessangerRatting(
    String id,
    String token,
  ) {
    final body = {
      'messanger_id': id,
    };
    return _api.post(
      getRatting,
      body,
      token: token,
    );
  }

  Future<APIResponse> tracking(
    String shipmentID,
    String token,
  ) {
    final body = {
      'shipment_id': shipmentID,
    };
    return _api.post(
      trackPoint,
      body,
      token: token,
    );
  }

  Future<APIResponse> uploadPOD(
    final shipmentID,
    final shipmentStatus,
    final shipmentOtp,
    MultipartFile? attetchment,
    final token,
  ) async {
    final formData = FormData.fromMap({
      'shipment_id': shipmentID,
      'shipment_status': shipmentStatus,
      'shipment_otp': shipmentOtp,
    });
    return _api.post(uploadPODPoint, formData, token: token);
  }

  Future<APIResponse> uploadInvoice(
    final shipmentID,
    MultipartFile? attetchment,
    final token,
  ) async {
    final formData = FormData.fromMap({
      'shipment_id': shipmentID,
      'invoice_file': attetchment,
    });
    return _api.post(
      uploadInvoicePoint,
      formData,
      token: token,
    );
  }

  Future<APIResponse> uploadPickup(
    shipmentID,
    shipmentStatus,
    id,
    date,
    lat,
    long,
    cashAmount,
    paymentMode,
    subPaymentMode,
    final otp,
    token, {
    // Start of optional named parameters
    String? chequeNumber,
  }) async {
    final body = {
      'shipment_id': shipmentID,
      'status': shipmentStatus,
      'messanger_id': id,
      'date_time': date,
      'latitude': lat,
      'longitude': long,
      'cash_amount': cashAmount,
      'payment_method': paymentMode,
      'sub_payment_mode': subPaymentMode,
      'pickup_otp': otp,
    };

    if (chequeNumber != null && chequeNumber.isNotEmpty) {
      body['cheque_number'] = chequeNumber;
    }

    return _api.post(
      uploadPickupPoint,
      body,
      token: token,
    );
  }

  Future<APIResponse> uploadDelivery(
    shipmentID,
    shipmentStatus,
    id,
    date,
    lat,
    long,
    amtPaid,
    cashAmount,
    paymentMode,
    subPaymentMode,
    deliveryOtp,
    token, {
    // Start of optional named parameters
    String? chequeNumber,
  }) async {
    final body = {
      'shipment_id': shipmentID,
      'status': shipmentStatus,
      'messanger_id': id,
      'date_time': date,
      'latitude': lat,
      'longitude': long,
      'amount_paid': amtPaid,
      'cash_amount': cashAmount,
      'payment_method': paymentMode,
      'sub_payment_mode': subPaymentMode,
      'delivery_otp': deliveryOtp,
      'cheque_number': chequeNumber ?? 0,
    };

    return _api.post(
      uploadDeliveryPoint,
      body,
      token: token,
    );
  }

  Future<APIResponse> getOtp(
    final shipmentID,
  ) async {
    final body = {
      'shipment_id': shipmentID,
    };
    return _api.post(
      getOtpPoint,
      body,
    );
  }

  Future<APIResponse> getShipmentRecord(
    final shipmentID,
    final token,
  ) async {
    final body = {
      'shipment_id': shipmentID,
    };
    return _api.post(
      getShipmentRecordPoint,
      body,
      token: token,
    );
  }

  Future<APIResponse> updateProfile(
    String id,
    String role,
    String name,
    String email,
    String mobile,
    final profileUpdate,
  ) async {
    final formData = FormData.fromMap({
      'id': id,
      'user_role': role,
      'name': name,
      'email': email,
      'mobile_no': mobile,
      // Conditionally set the photo field based on role
      if (profileUpdate != null)
        role == 'customer' ? 'customer_photo' : 'messanger_photo':
            profileUpdate,
    });
    return _api.post(
      updateProfilePoint,
      formData,
    );
  }

  Future<APIResponse> getProfile(final id, final role) async {
    final body = {
      'id': id,
      'user_role': role,
    };
    return _api.post(
      editProfilePoint,
      body,
    );
  }

  Future<APIResponse> getAllPickup(
    final id,
    final brachID,
    final nextID,
    final token,
  ) {
    final body = {
      'messanger_id': id,
      'branch_id': brachID,
      'next_id': nextID,
      'token': token,
    };
    return _api.post(
      getAllPickupPoint,
      body,
      token: token,
    );
  }

  Future<APIResponse> rateMessanger(
    final id,
    final shipmentID,
    final rating,
    final feedback,
  ) {
    final body = {
      'messanger_id': id,
      'shipment_id': shipmentID,
      'rating': rating,
      'feedback': feedback,
    };
    return _api.post(
      ratingPoint,
      body,
    );
  }

  Future<APIResponse> grossCalculation(
    final netWeight,
    final grossWeight,
    final status,
    final productID,
  ) {
    final body = {
      'net_weight': netWeight,
      'gross_weight': grossWeight,
      'status': status,
      'product_id': productID,
    };
    return _api.post(
      grosssCalculationPoint,
      body,
    );
  }

  Future<APIResponse> getNotificationList(
    final id,
    final nextID,
    final token,
  ) {
    final body = {
      'm_id': id,
      'next_id': nextID,
      'token': token,
    };
    return _api.post(
      getNotificationListPoint,
      body,
      token: token,
    );
  }

  Future<APIResponse> transferShipment(
    final shipmentID,
    final transferByID,
    final transferToID,
    final shipmentType,
  ) {
    final body = {
      "shipment_id": shipmentID,
      "transfer_by": transferByID,
      "transfer_to": transferToID,
      "shipment_type": shipmentType,
    };
    return _api.post(transferShipmentPoint, body);
  }

  Future<APIResponse> getAllMessanger(
    final messangerID,
    final routeID,
    final lat,
    final long,
    final nextID,
    final token,
  ) {
    final query = {
      "m_id": messangerID,
      "route": routeID,
      "latitude": lat,
      "longitude": long,
      "next_id": nextID,
    };
    return _api.get(
      getAllMessangerPoint,
      token: token,
      query: query,
    );
  }

  Future<APIResponse> getPaymentMode() {
    return _api.get(
      getPaymentModePoint,
    );
  }

  Future<APIResponse> deleteAccount(
    final id,
    final role,
    final token,
  ) {
    final body = {
      'id': id,
      'user_role': role,
    };
    return _api.post(
      deleteProfilePoint,
      body,
      token: token,
    );
  }
}
