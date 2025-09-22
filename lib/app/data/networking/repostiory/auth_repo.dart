import 'dart:convert';
import 'dart:developer';

import 'package:axlpl_delivery/app/data/localstorage/local_storage.dart';
import 'package:axlpl_delivery/app/data/models/lat_long_model.dart';
import 'package:axlpl_delivery/app/data/models/login_model.dart';
import 'package:axlpl_delivery/app/data/networking/api_services.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
    // final deviceId = await MobileDeviceIdentifier().getDeviceId();
    // log("device id : ===> $deviceId");
    final deviceId = await _utils.getDeviceId();
    UserLocation location = await _utils.getUserLocation();

    print("Lat: ${location.latitude}");
    print("Lng: ${location.longitude}");
    print("Address: ${location.address}");

    try {
      final response = await _apiServices.loginUserService(
          mobile,
          password,
          fcmToken.toString(),
          appVersion,
          location.latitude.toString(),
          location.longitude.toString(),
          deviceId.toString());
      return response.when(
        success: (body) async {
          final loginData = LoginModel.fromJson(body);
          _utils.logInfo(fcmToken.toString());
          log('device id ${deviceId.toString()}');
          if (loginData.status != "success") {
            throw loginData.message ?? "Login Failed: Unknown Error";
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
    } catch (e) {
      throw Exception("Login Failed: ${e.toString()}");
    }
  }

  Future<bool> verifyLoginOtpRepo(
    String mobile,
    String otp,
  ) async {
    String? fcmToken = await storage.read(key: _localStorage.fcmToken);
    log("fcmToken ${fcmToken.toString()}");
    final packageInfo = await PackageInfo.fromPlatform();
    final appVersion = "${packageInfo.version}-${packageInfo.buildNumber}";
    // final deviceId = await MobileDeviceIdentifier().getDeviceId();
    // log("device id : ===> $deviceId");
    final deviceId = await _utils.getDeviceId();
    UserLocation location = await _utils.getUserLocation();

    print("Lat: ${location.latitude}");
    print("Lng: ${location.longitude}");
    print("Address: ${location.address}");

    try {
      final response = await _apiServices.verifyLoginOtpService(mobile, otp);
      return response.when(
        success: (body) async {
          final loginData = LoginModel.fromJson(body);
          _utils.logInfo(fcmToken.toString());
          log('device id ${deviceId.toString()}');
          if (loginData.status != "success") {
            throw loginData.message ?? "Login Failed: Unknown Error";
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
            log('login via otp');
          }

          return true;
        },
        error: (error) {
          throw Exception("Login Failed: ${error.toString()}");
        },
      );
    } catch (e) {
      throw Exception("Login Failed: ${e.toString()}");
    }
  }

  Future<bool> logoutRepo() async {
    final userData = await LocalStorage().getUserLocalData();

    final deviceId = await _utils.getDeviceId();

    if (userData == null) return false;
    final String? role = userData.role;
    final String? mId = userData.messangerdetail?.id?.toString();
    final String? custID = userData.customerdetail?.id.toString();
    final String? token = userData.messangerdetail?.token.toString() ??
        userData.customerdetail?.token.toString();
    _utils.logInfo(userData.messangerdetail?.id.toString() ?? custID);
    UserLocation location = await _utils.getUserLocation();
    final String? userID = mId ?? custID;
    if (userID == null || role == null || token == null) {
      Utils().logInfo('Logout skipped - user data incomplete');
      return false;
    }

    try {
      final response = await _apiServices.logout(
        mId ?? custID.toString(),
        role.toString(),
        location.latitude.toString(),
        location.longitude.toString(),
        token,
        deviceId,
      );
      response.when(success: (success) async {
        // _localStorage.clearAll();
        log('logout device id ${deviceId.toString()}');

        await _localStorage.deleteRole();
        String? role = await storage.read(key: _localStorage.userRole);
        log("After deletion, role is: $role");

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
