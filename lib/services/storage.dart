import 'package:app/services/auth.dart';

import 'package:meta/meta.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class StorageProvider {
  StorageProvider({@required this.flutterSecureStorage})
      : assert(flutterSecureStorage != null);

  final FlutterSecureStorage flutterSecureStorage;

  static const String storageUserEmailKey = 'userEmailAddress';

  // email
  Future<void> setEmail(String email) async {
    await flutterSecureStorage.write(key: storageUserEmailKey, value: email);
  }

  Future<void> clearEmail() async {
    await flutterSecureStorage.delete(key: storageUserEmailKey);
  }

  Future<String> getEmail() async {
    return await flutterSecureStorage.read(key: storageUserEmailKey);
  }
}

class SecureStorageService {
  final _store =
      StorageProvider(flutterSecureStorage: new FlutterSecureStorage());

  Future<void> setEmail(String email) => _store.setEmail(email);

  Future<void> clearEmail() => _store.clearEmail();

  Future<String> getEmail() => _store.getEmail();
}
