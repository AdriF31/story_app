import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Sensitive Data Storage
class SecureStorage {
  static const String _token = 'token';

  static FlutterSecureStorage get secureStorage => const FlutterSecureStorage(
        iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
      );

  /// LOGIN TOKEN
  static Future<String> getToken() async =>
      await secureStorage.read(key: _token) ?? "";

  static setToken({required String? value}) async =>
      await secureStorage.write(key: _token, value: value);

  static Future deleteToken() async =>
      secureStorage.delete(key: _token);

  /// DELETE ALL TOKEN
  static Future deleteAllSecureStorage() async => secureStorage.deleteAll();

  static Future deleteAllToken() async {
    secureStorage.delete(key: _token);
  }
}
