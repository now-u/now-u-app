import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageProvider {
  final FlutterSecureStorage flutterSecureStorage;

  StorageProvider({required this.flutterSecureStorage});

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
  final _store =
      StorageProvider(flutterSecureStorage: const FlutterSecureStorage());

  Future<void> setEmail(String email) => _store.setEmail(email);
  Future<void> setName(String name) => _store.setEmail(name);

  Future<void> clearEmail() => _store.clearEmail();

  Future<String?> getEmail() => _store.getEmail();
  Future<String?> getName() => _store.getName();
}
