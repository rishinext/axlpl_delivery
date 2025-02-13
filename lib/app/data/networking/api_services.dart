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
    final body = {
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
    String zipcode,
    String token,
  ) async {
    final body = {
      'messanger_id': userID,
      'zipcode': zipcode,
      'branch_id': branchID
    };
    return _api.get(deliveryHistoryPoint, query: body, token: token);
  }
}
