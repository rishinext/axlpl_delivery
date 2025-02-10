import 'package:axlpl_delivery/app/data/networking/api_client.dart';

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

    return _api.post('login', body);
  }
}
