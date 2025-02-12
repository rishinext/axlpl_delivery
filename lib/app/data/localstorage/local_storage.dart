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
  final String usersDataKey = 'Messangerdetail';
  final String userRole = 'role';

// get users data

  Future<LoginModel?> getUserLocalData() async {
    try {
      String? usersData = await storage.read(key: usersDataKey);
      if (usersData == null) {
        Utils().logInfo("No Localstore UsersData Found!");
        return null;
      }

      return LoginModel.fromJson(json.decode(usersData));
    } catch (e) {
      Utils().logError("Error retrieving/parsing user data:", '$e');
      return null;
    }
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
