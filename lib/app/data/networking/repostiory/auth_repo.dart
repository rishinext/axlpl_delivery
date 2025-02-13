import 'dart:convert';
import 'dart:developer';

import 'package:axlpl_delivery/app/data/localstorage/local_storage.dart';
import 'package:axlpl_delivery/app/data/models/login_model.dart';
import 'package:axlpl_delivery/app/data/networking/api_client.dart';
import 'package:axlpl_delivery/app/data/networking/api_response.dart';
import 'package:axlpl_delivery/app/data/networking/api_services.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:mobile_device_identifier/mobile_device_identifier.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AuthRepo {
  // final ApiClient _apiClient = ApiClient();
  final ApiServices _apiServices = ApiServices();
  final Utils _utils = Utils();
  final LocalStorage _localStorage = LocalStorage();

  Future<bool> loginRepo(
    String mobile,
    String password,
  ) async {
    final fcmToken = _utils.fcmToken;
    final packageInfo = await PackageInfo.fromPlatform();
    final appVersion = "${packageInfo.version}-${packageInfo.buildNumber}";
    final deviceId = MobileDeviceIdentifier().getDeviceId();
    String location;

    try {
      location = await _utils.getUserLocation();
    } catch (e) {
      location = '';
    }
    final response = await _apiServices.loginUser(
      mobile,
      password,
      fcmToken,
      appVersion,
      location,
      location,
      deviceId,
    );
    return response.when(
      success: (body) async {
        final loginData = LoginModel.fromJson(body);

        if (loginData.status != "success") {
          throw Exception(loginData.message ?? "Login Failed: Unknown Error");
        }

        /*   if (loginData.messangerdetail!.token != null) {
          await _localStorage
              .saveToken(loginData.messangerdetail!.token.toString());
        }
        await _localStorage
            .saveUserId(loginData.messangerdetail!.id.toString());
            */
        await storage.write(
            key: _localStorage.userRole, value: loginData.role.toString());

        await storage.write(
            key: _localStorage.usersDataKey,
            value: json.encode(loginData.toJson()));

        return true;
      },
      error: (error) {
        throw Exception("Login Failed: ${error.toString()}");
      },
    );
  }

  Future<bool> logoutRepo() async {
    final userData = await LocalStorage().getUserLocalData();
    final String? mId = userData?.messangerdetail?.id?.toString();
    final String? role = userData?.role;

    _utils.logInfo(userData!.messangerdetail?.id.toString() ?? 'No Id found');
    final userID = userData.messangerdetail?.id.toString();
    if (userID != null) {
      try {
        final response = await _apiServices.logout(
            mId.toString(),
            role.toString(),
            '',
            '',
            userData.messangerdetail?.token.toString());
        response.when(success: (success) {
          _localStorage.clearAll();
          return true;
        }, error: (error) {
          log("API Logout Error: $error");
        });
        return true;
      } catch (e) {
        _utils.logError("$e", 'API Logout Error');
        return false;
      }
    } else {
      _utils.logInfo('API Logout Error');
      return false;
    }
  }
}
