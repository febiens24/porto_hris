// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage flutterSecureStorage;
  static const _userKey = 'USER_KEY';
  SecureStorage({required this.flutterSecureStorage});

  Future<void> persistUser(String user) async {
    await flutterSecureStorage.write(key: _userKey, value: user);
  }

  Future<bool> hasUser() async {
    var value = await flutterSecureStorage.read(key: _userKey);
    if (value != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> deleteUser() async {
    return flutterSecureStorage.delete(key: _userKey);
  }

  Future<void> deleteAll() async {
    return flutterSecureStorage.deleteAll();
  }

  Future<String?> getUser() async {
    var value = await flutterSecureStorage.read(key: _userKey);
    if (value != null) {
      return value;
    } else {
      return null;
    }
  }
}
