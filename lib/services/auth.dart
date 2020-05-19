import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sendSignInWithEmailLink(String email) async {
    return _auth.sendSignInWithEmailLink(
        email: email,
        url: "https://nowu.page.link",
        androidInstallIfNotAvailable: true,
        androidMinimumVersion: '21',
        // TODO: replace name
        androidPackageName: 'com.example.passwordlessdemo',
        handleCodeInApp: true,
        // TODO: replace id
        iOSBundleID: 'com.example.passwordlessdemo');
  }

  Future<AuthResult> signInWithEmailLink(String email, String link) async {
    return _auth.signInWithEmailAndLink(email: email, link: link);
  }

  Future<AuthResult> signInWithCredential(AuthCredential credential) async {
    return _auth.signInWithCredential(credential);
  }

  Future<FirebaseUser> getCurrentUser() {
    return _auth.currentUser();
  }
}
