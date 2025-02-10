import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final FlutterSecureStorage storage = FlutterSecureStorage();

class LocalStorage {
  static const String _tokenKey = 'user_token';
  final String loginKey = 'Messangerdetail';
  final String userRole = 'role';

  // Save token
  Future<void> saveToken(String token) async {
    await storage.write(key: _tokenKey, value: token);
  }

  // Read token
  Future<String?> readToken() async {
    return await storage.read(key: _tokenKey);
  }

  // Delete token
  Future<void> deleteToken() async {
    await storage.delete(key: _tokenKey);
  }

  // Clear all data
  Future<void> clearAll() async {
    await storage.deleteAll();
  }
}
