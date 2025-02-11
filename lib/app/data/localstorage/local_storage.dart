import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final FlutterSecureStorage storage = FlutterSecureStorage();

class LocalStorage {
  final String tokenKey = 'token';
  final String loginKey = 'Messangerdetail';
  final String userRole = 'role';

  // Save token
  Future<void> saveToken(String token) async {
    await storage.write(key: tokenKey, value: token);
  }

  // Read token
  Future<String?> readToken() async {
    return await storage.read(key: tokenKey);
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
