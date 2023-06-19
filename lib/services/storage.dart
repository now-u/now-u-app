import 'package:meta/meta.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageProvider {
  StorageProvider({required this.flutterSecureStorage})
      : assert(flutterSecureStorage != null);

  final FlutterSecureStorage flutterSecureStorage;

  static const String storageUserEmailKey = 'userEmailAddress';
  static const String storageUserNameKey = 'userName';

  // email
  Future<void> setEmail(String email) async {
    await flutterSecureStorage.write(key: storageUserEmailKey, value: email);
  }

  Future<void> setName(String name) async {
    await flutterSecureStorage.write(key: storageUserNameKey, value: name);
  }

  Future<void> clearEmail() async {
    await flutterSecureStorage.delete(key: storageUserEmailKey);
  }

  Future<String?> getEmail() async {
    return await flutterSecureStorage.read(key: storageUserEmailKey);
  }

  Future<String?> getName() async {
    return await flutterSecureStorage.read(key: storageUserNameKey);
  }
}

class SecureStorageService {
  final _store = StorageProvider(flutterSecureStorage: FlutterSecureStorage());

  Future<void> setEmail(String email) => _store.setEmail(email);
  Future<void> setName(String name) => _store.setEmail(name);

  Future<void> clearEmail() => _store.clearEmail();

  Future<String?> getEmail() => _store.getEmail();
  Future<String?> getName() => _store.getName();
}
