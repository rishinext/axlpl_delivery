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
  final String loginKey = 'Messangerdetail';
  final String userRole = 'role';

  // Save token
  Future<void> saveToken(String token) async {
    await storage.write(key: tokenKey, value: token);
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
