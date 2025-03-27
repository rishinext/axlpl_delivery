import 'package:axlpl_delivery/app/data/networking/api_client.dart';
import 'package:axlpl_delivery/app/data/networking/api_endpoint.dart';

import 'api_response.dart';

class ApiServices {
  static final ApiClient _api = ApiClient();

  Future<APIResponse> loginUser(
    String mobile,
    String password,
    String fcmToken,
    String appVersion,
    String latitude,
    String longitude,
    final deviceId,

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

  Future<APIResponse> logout(String userID, String role, String latitude,
      String longitude, final token) {
    final body = {
      'm_id': userID,
      'role': role,
      'latitude': latitude,
      'longitude': longitude
    };
    return _api.post(logoutPoint, body, token: token);
  }

  Future<APIResponse> getDeliveryHistory(
    String userID,
    String branchID,
    // String zipcode,
    String token,
  ) async {
    final body = {
      'messanger_id': userID,
      // 'zipcode': zipcode,
      'branch_id': branchID
    };
    return _api.get(deliveryHistoryPoint, query: body, token: token);
  }

  Future<APIResponse> getPickupHistory(
    String userID,
    String branchID,
    // String zipcode,
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
    String fcmToken,
    String version,
    final deviceID,
  ) async {
    final query = {
      'messanger_id': userID,
      'branch_id': branchID,
      'fcm_token': fcmToken,
      'version': version,
      'device_id': deviceID
    };
    return _api.get(dashboardDataPoint, query: query, token: token);
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
    final userID,
    final nextID,
  ) async {
    final body = {
      'user_id': userID,
      'next_id': nextID
      //more params will come
    };
    return _api.post(
      getShipmentDataListPoint,
      body,
    );
  }
}
