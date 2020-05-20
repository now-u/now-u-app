import 'package:firebase_auth/firebase_auth.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthenticationService {

  final String domainPrefix = "https://now-u-api.herokuapp.com/api/v1/";

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sendSignInWithEmailLink(String email) async {
    //return _auth.sendSignInWithEmailLink(
    //    email: email,
    //    url: "https://nowu.page.link",
    //    androidInstallIfNotAvailable: true,
    //    androidMinimumVersion: '21',
    //    // TODO: replace name
    //    androidPackageName: 'com.nowu.app',
    //    handleCodeInApp: true,
    //    // TODO: replace id
    //    iOSBundleID: 'com.nowu.app');
    http.post(
      domainPrefix + 'users',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    ).then( (http.Response response) {
      print("THE RESPONSE BODY IS");
      print(response.body);
    });
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
