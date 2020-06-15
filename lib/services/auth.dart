//import 'package:firebase_auth/firebase_auth.dart';

import 'package:app/models/User.dart';
import 'package:app/models/Campaigns.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthenticationService {

  //final String domainPrefix = "https://now-u-api.herokuapp.com/api/v1/";
  final String domainPrefix = "https://api.now-u.com/api/v1/";

  //final FirebaseAuth _auth = FirebaseAuth.instance;

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

  Future<User> signInWithEmailLink(String email, String token) async {

    // TODO handle errors

    print("The email is: " + email);
    print("The token is: " + token);
    http.Response response = await http.post(
      domainPrefix + 'users/login',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'token': token, 
      }),
    );
    if (response.statusCode == 200) {
      print("THE RESPONSE BODY IS");
      print(response.body);

      User u = await getUser(json.decode(response.body)['data']['token']);
      return u;
    }
    print("There was an error");
    print(response.headers);
    return null;
    //return _auth.signInWithEmailAndLink(email: email, link: link);
  }


  //Future<AuthResult> signInWithCredential(AuthCredential credential) async {
  //  return _auth.signInWithCredential(credential);
  //}

  Future<User> getUser(String token) async {
    http.Response userResponse = await http.get(
      domainPrefix + 'users/me',
      headers: <String, String>{
        'token': token,
      }
    );
    print("The returned user is:");
    print(userResponse.body);
    User u = User.fromJson(json.decode(userResponse.body)["data"]);
    print("The returned user token is:");
    print(u.getToken());
    return u;
  }

  Future<User> updateUserDetails(User user) async {
    print("The user token is" + user.getToken());
    print("User attribues are");
    print(user.getAttributes());
    print(json.encode(user.getAttributes()));
    http.Response response = await http.put(
      domainPrefix + 'users/me',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': user.getToken(), 
      },
      body: json.encode(user.getAttributes()),
    );
    if (response.statusCode == 200) {
      print("The new user deets are");
      print(response.body);
      User u = User.fromJson(json.decode(response.body));
      return u;
    } else {
      print("There was an error updateing user details");
      return null;
    }
  }

  Future<User> completeAction(String token, int actionId) async {
    http.Response response = await http.post(
      domainPrefix + 'users/me/actions/${actionId}/complete',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token, 
      },
    );
    if (response.statusCode == 200) {
      print("The new deets after joining campaign are");
      print(response.body);
      User u = User.fromJson(json.decode(response.body)['data']);
      return u;
    } else {
      print("There was an error updateing user details");
      return null;
    }
  }

  Future<User> joinCampaign(String token, int campaignId) async {
    http.Response response = await http.post(
      domainPrefix + 'users/me/campaigns/${campaignId}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token, 
      },
    );
    if (response.statusCode == 200) {
      print("The new deets after joining campaign are");
      print(response.body);
      User u = User.fromJson(json.decode(response.body)["data"]);
      return u;
    } else {
      print("There was an error updateing user details");
      return null;
    }

  }
}
