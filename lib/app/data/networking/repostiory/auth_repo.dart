import 'dart:convert';
import 'dart:developer';

import 'package:axlpl_delivery/app/data/localstorage/local_storage.dart';
import 'package:axlpl_delivery/app/data/models/login_model.dart';
import 'package:axlpl_delivery/app/data/networking/api_client.dart';
import 'package:axlpl_delivery/app/data/networking/api_response.dart';
import 'package:axlpl_delivery/app/data/networking/api_services.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_device_identifier/mobile_device_identifier.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AuthRepo {
  // final ApiClient _apiClient = ApiClient();
  final ApiServices _apiServices = ApiServices();
  final Utils _utils = Utils();
  final LocalStorage _localStorage = LocalStorage();
  final FlutterSecureStorage storage = FlutterSecureStorage();
  Future<bool> loginRepo(
    String mobile,
    String password,
  ) async {
    String? fcmToken = await storage.read(key: _localStorage.fcmToken);
    log("fcmToken ${fcmToken.toString()}");
    final packageInfo = await PackageInfo.fromPlatform();
    final appVersion = "${packageInfo.version}-${packageInfo.buildNumber}";
    final deviceId = await MobileDeviceIdentifier().getDeviceId();
    log("device id : ===> $deviceId");

    String location;

    try {
      location = await _utils.getUserLocation();
    } catch (e) {
      location = '';
    }
    final response = await _apiServices.loginUserService(
      mobile,
      password,
      fcmToken.toString(),
      appVersion,
      location,
      location,
      deviceId.toString(),
    );
    return response.when(
      success: (body) async {
        final loginData = LoginModel.fromJson(body);
        _utils.logInfo(fcmToken.toString());
        if (loginData.status != "success") {
          throw Exception(loginData.message ?? "Login Failed: Unknown Error");
        }

        // Utils().logInfo("repo login data : ${loginData.toJson()}");
        await storage.write(
            key: _localStorage.userRole, value: loginData.role.toString());

        if (loginData.role == "messanger") {
          await storage.write(
            key: _localStorage.adminDataKey,
            value: json.encode(loginData.messangerdetail?.toJson()),
          );
        } else if (loginData.role == "customer") {
          await storage.write(
            key: _localStorage.customerDataKey,
            value: json.encode(loginData.customerdetail?.toJson()),
          );
        }

        return true;
      },
      error: (error) {
        throw Exception("Login Failed: ${error.toString()}");
      },
    );
  }

  Future<bool> logoutRepo() async {
    final userData = await LocalStorage().getUserLocalData();
    if (userData == null) return false;
    final String? role = userData.role;
    final String? mId = userData.messangerdetail?.id?.toString();
    final String? custID = userData.customerdetail?.id.toString();
    final String? token = userData.messangerdetail?.token.toString() ??
        userData.customerdetail?.token.toString();
    _utils.logInfo(userData.messangerdetail?.id.toString() ?? custID);

    final String? userID = mId ?? custID;
    if (userID == null || role == null || token == null) {
      Utils().logInfo('Logout skipped - user data incomplete');
      return false;
    }

    try {
      final response = await _apiServices.logout(
          mId ?? custID.toString(), role.toString(), '', '', token);
      response.when(success: (success) {
        // _localStorage.clearAll();
        _localStorage.deleteToken();
        return true;
      }, error: (error) {
        log("API Logout Error: $error");
      });
      return true;
    } catch (e) {
      _utils.logError(
        "$e",
      );
      return false;
    }
  }
}
