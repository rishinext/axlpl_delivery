import 'dart:convert';
import 'dart:developer';

import 'package:axlpl_delivery/app/data/models/shipment_req_static_model.dart';
import 'package:axlpl_delivery/app/data/networking/api_client.dart';
import 'package:axlpl_delivery/app/data/networking/api_endpoint.dart';
import 'package:dio/dio.dart';

import "dart:async";
import 'api_response.dart';

const _sendOtpEndpoint = 'user/send-otp';
const _verifyOtpEndpoint = 'user/verify-otp';

class ApiServices {
  static final ApiClient _api = ApiClient();

  Future<APIResponse> sendOtpService(String mobile) async {
    final data = {'mobile': mobile};
    return _api.post(
      _sendOtpEndpoint,
      data,
      contentType: ContentType.json,
    );
  }

  Future<APIResponse> verifyOtpService(
    String mobile,
    String otp,
    String fcmToken,
    String appVersion,
    String latitude,
    String longitude,
    String deviceId,
  ) async {
    final data = {
      'mobile': mobile,
      'otp': otp,
      'fcm_token': fcmToken,
      'app_version': appVersion,
      'latitude': latitude,
      'longitude': longitude,
      'device_id': deviceId,
    };
    return _api.post(
      _verifyOtpEndpoint,
      data,
      contentType: ContentType.json,
    );
  }

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
    return _api.get(
      historyPickupPoint,
      query: body,
      token: token,
    );
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

  Future<APIResponse> getCustomerDashboardData(
    String custID,

    // String zipcode,
    String token,
  ) async {
    final body = {
      'customer_id': custID,
    };
    return _api.post(
      customerDashboardDataPoint,
      body,
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

  Future<APIResponse> getPincodeDetailsRegister(String pincode) async {
    final body = {
      'pincode': pincode,
    };
    return _api.post(
      getPincodeDetailsRegisterPoint,
      body,
    );
  }

  Future<APIResponse> getAllAeraByZip(String token, String pincode) async {
    final body = {
      'pincode': pincode,
    };
    return _api.post(getAllAreaByZipcodePoint, body, token: token);
  }

  Future<APIResponse> getAllAeraByZipRegistration(String pincode) async {
    final body = {
      'pincode': pincode,
    };
    return _api.post(
      getAllAeraByZipRegisterPoint,
      body,
    );
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

  Future<APIResponse> customerRegister(
    final companyName,
    final fullName,
    final categoryID,
    final natureBusinessID,
    final email,
    final mobile,
    final telephone,
    final faxNo,
    final gstNo,
    final panNo,
    final axlplInsuranceValue,
    final thirdPartyInsuranceValue,
    final thirdPartyPolicyNo,
    final thirdPartyExpDate,
    final password,
    final countryID,
    final stateID,
    final cityID,
    final areaID,
    final pincode,
    final address1,
    final address2,
    final uploadProfile,
    final uploadGst,
    final uploadPan,
  ) async {
    // Convert files to MultipartFile (following your POD repo pattern)
    MultipartFile? profileAttachment;
    MultipartFile? gstAttachment;
    MultipartFile? panAttachment;

    // Profile is optional
    if (uploadProfile != null) {
      profileAttachment = await MultipartFile.fromFile(
        uploadProfile.path,
        filename: uploadProfile.path.split('/').last,
      );
    }

    // GST is required
    if (uploadGst != null) {
      gstAttachment = await MultipartFile.fromFile(
        uploadGst.path,
        filename: uploadGst.path.split('/').last,
      );
    }

    // PAN is required
    if (uploadPan != null) {
      panAttachment = await MultipartFile.fromFile(
        uploadPan.path,
        filename: uploadPan.path.split('/').last,
      );
    }

    final body = FormData.fromMap({
      // Match exact Postman field names
      'company_name': companyName,
      'full_name': fullName,
      'category': categoryID,
      'nature_of_business': natureBusinessID,
      'reg_address1': address1, // Changed from 'registered_address1'
      'reg_address2': address2, // Changed from 'registered_address2'
      'country_id': countryID,
      'state_id': stateID,
      'city_id': cityID,
      'area_id': areaID,
      'branch_id': '1', // Changed from 'cust_branch_id'
      'pincode': pincode,
      'mobile_no': mobile,
      'tel_no': telephone,
      'fax_no': faxNo,
      'email': email, // Changed from 'email_address'
      'password': password,
      'pan_no': panNo,
      'gst_no': gstNo,
      'axlpl_insurance_value': axlplInsuranceValue,
      'third_party_insurance_value': thirdPartyInsuranceValue,
      'third_party_policy_no': thirdPartyPolicyNo,
      'third_party_exp_date': thirdPartyExpDate,
      // Add files (required files should always be present)
      'upload_gst': gstAttachment,
      'upload_pancard': panAttachment,
      // Optional profile image
      if (profileAttachment != null) 'cust_profile_img': profileAttachment,
    });

    log('FormData fields: ${body.fields}');
    log('FormData files: ${body.files.map((e) => e.key).toList()}');

    return _api.post(customerRegisterPoint, body);
  }

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

  Future<APIResponse> verifyLoginOtpService(
    String mobile,
    // final email,
    String otp,

    // String token
  ) {
    final Map<String, dynamic> body = {
      'mobile': mobile,
      'otp': otp,
    };

    return _api.post(verifyLoginOtpPoint, body);
  }

  Future<APIResponse> logout(
    String userID,
    String role,
    String latitude,
    String longitude,
    final token,
    final deviceId,
  ) {
    final body = {
      'm_id': userID,
      'role': role,
      'latitude': latitude,
      'longitude': longitude,
      'device_id': deviceId,
    };
    return _api.post(
      logoutPoint,
      body,
      token: token,
    );
  }

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

  Future<APIResponse> contractView(final custID) async {
    final body = {
      'customer_id': custID,
    };
    return _api.post(
      contractViewPoint,
      body,
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
    final contractWeight,
    final contractRate,
  ) {
    final body = {
      'net_weight': netWeight,
      'gross_weight': grossWeight,
      'calculation_status': status,
      'product_id': productID,
      'contract_weight': contractWeight,
      'contract_rate': contractRate,
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

  Future<APIResponse> getContractDetails(
    final customerID,
    final categoryID,
    final token,
  ) {
    final body = {
      'customer_id': customerID,
      'category_id': categoryID,
    };
    return _api.post(
      getContractDetailsPoint,
      body,
      token: token,
    );
  }

  Future<APIResponse> getCustomerInvoice(
    final custID,
  ) {
    final body = {"customer_id": custID};
    return _api.post(getCustomerInvoicePoint, body);
  }

  Future<APIResponse> getPaymentMode() {
    return _api.get(
      getPaymentModePoint,
    );
  }

  Future<APIResponse> getCashCollectionLog(
    final token,
    final nextID,
    final userID,
  ) {
    final body = {
      'token': token,
      'next_id': nextID,
      'messanger_id': userID,
    };
    return _api.post(
      getCashCollectionLogPoint,
      body,
      token: token,
    );
  }

  Future<APIResponse> getCustomerCategory(
    final token,
  ) {
    return _api.get(
      getCustomerCategoryPoint,
      token: token,
    );
  }

  Future<APIResponse> getNatureOfBusiness(
    final token,
  ) {
    return _api.get(
      getNatureOfBusinessPoint,
      token: token,
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
