import 'package:app/services/auth.dart';

import 'package:meta/meta.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

class StorageRepository {
  final _store =
      StorageProvider(flutterSecureStorage: new FlutterSecureStorage());

  Future<void> setEmail(String email) => _store.setEmail(email);

  Future<void> clearEmail() => _store.clearEmail();

  Future<String> getEmail() => _store.getEmail();
}

class Repository with StorageRepository {
  final _authProvider = AuthProvider();

  Future<bool> sendSignInWithEmailLink(String email) =>
      _authProvider.sendSignInWithEmailLink(email);
      

  Future<AuthResult> signInWithEmailLink(String email, String link) =>
      _authProvider.signInWithEmailLink(email, link);

  Future<AuthResult> signInWithCredential(AuthCredential credential) =>
      _authProvider.signInWithCredential(credential);

  Future<FirebaseUser> getCurrentUser() => _authProvider.getCurrentUser();

  Future<void> verifyPhoneNumber(
          String phone,
          PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout,
          PhoneCodeSent codeSent,
          Duration duration,
          PhoneVerificationCompleted verificationCompleted,
          PhoneVerificationFailed verificationFailed) =>
      _authProvider.verifyPhoneNumber(phone, codeAutoRetrievalTimeout, codeSent,
          duration, verificationCompleted, verificationFailed);
}
