import 'dart:convert';
import 'dart:developer';

import 'package:axlpl_delivery/app/data/models/login_model.dart';
import 'package:axlpl_delivery/utils/utils.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final FlutterSecureStorage storage = FlutterSecureStorage();

class LocalStorage {
  LocalStorage._privateConstructor();
  static final LocalStorage instance = LocalStorage._privateConstructor();

  LocalStorage._internal();
  static final LocalStorage _instance = LocalStorage._internal();

  factory LocalStorage() {
    return _instance;
  }

  final String tokenKey = 'token';
  final String userID = 'id';
  final String adminDataKey = 'Messangerdetail';
  final String customerDataKey = 'Customerdetail';
  final String userRole = 'role';
  final String fcmToken = 'fcmToken';

// get users data

  Future<LoginModel?> getUserLocalData() async {
    try {
      String? role = await storage.read(key: userRole);
      if (role == null) return null;

      String? rawData;

      if (role == "messanger") {
        rawData = await storage.read(key: adminDataKey!);
      } else if (role == "customer") {
        rawData = await storage.read(key: customerDataKey!);
      }

      if (rawData == null) {
        Utils().logInfo("No user data found for role: $role");
        return null;
      }

      final loginData = LoginModel(role: role); // ✅ Optional: keep role
      final parsedJson = json.decode(rawData);

      if (role == "messanger") {
        loginData.messangerdetail = Messangerdetail.fromJson(parsedJson);
      } else if (role == "customer") {
        loginData.customerdetail = Customerdetail.fromJson(parsedJson);
      }

      return loginData;
    } catch (e) {
      Utils().logError(
        "getUserLocalData error ${e.toString()}",
      );
      return null;
    }
  }

  Future<String?> getUserRole() async {
    return await storage.read(key: userRole);
  }

  // Save token
  Future<void> saveToken(String token) async {
    await storage.write(key: tokenKey, value: token);
  }

  Future<void> saveUserId(String userId) async {
    await storage.write(key: userID, value: userId);
  }

  // Read token
  Future<bool> readToken() async {
    String? token = await storage.read(key: tokenKey);
    return token != null && token.isNotEmpty;
  }

  // Delete token
  Future<void> deleteToken() async {
    await storage.delete(key: tokenKey);
  }

  // Clear all data
  Future<void> clearAll() async {
    await storage.deleteAll();
  }
}
