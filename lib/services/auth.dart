//import 'package:firebase_auth/firebase_auth.dart';

import 'package:app/models/User.dart';
import 'package:app/models/Campaigns.dart';

import 'package:app/main.dart';
import 'package:app/routes.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:app/locator.dart';
import 'package:app/services/navigation.dart';

class AuthError {
  static const unauthorized = "unauthorized";
  static const internal = "internal";
  static const unknown = "unknown";
}

class AuthenticationService {
  // This is not final as it can be changed
  String domainPrefix = "https://api.now-u.com/api/v1/";

  void switchToStagingBranch() {
    domainPrefix = "https://stagingapi.now-u.com/api/v1/";
  }
  
  final NavigationService _navigationService = locator<NavigationService>();

  // Generic Reuqest
  // Handle 401 errors
  Future handleAuthRequestErrors(http.Response response) {
    if (response.statusCode == 200) {
      return null;
    }
    else if (response.statusCode == 401) {
      // Generic reaction to someone being unauthorized is just send them to the login screen
      _navigationService.navigateTo(Routes.login);
      return Future.error(AuthError.unauthorized);
    }
    else if (response.statusCode == 500) {
      // Generic reaction to someone being unauthorized is just send them to the login screen
      _navigationService.navigateTo('/');
      return Future.error(AuthError.internal);
    }
    return Future.error(AuthError.unknown);
  }

  //final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sendSignInWithEmailLink(String email, String name) async {
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
    http
        .post(
      domainPrefix + 'users',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'full_name': name,
      }),
    )
        .then((http.Response response) {
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

    if (response.statusCode == 401) return Future.error(AuthError.unauthorized);

    print("THE RESPONSE BODY IS");
    print(response.body);

    User u = await getUser(json.decode(response.body)['data']['token']);
    return u;
    //return _auth.signInWithEmailAndLink(email: email, link: link);
  }

  //Future<AuthResult> signInWithCredential(AuthCredential credential) async {
  //  return _auth.signInWithCredential(credential);
  //}

  Future<User> getUser(String token) async {
    http.Response userResponse =
        await http.get(domainPrefix + 'users/me', headers: <String, String>{
      'token': token,
    });
    if (handleAuthRequestErrors(userResponse) != null) {
      return handleAuthRequestErrors(userResponse);
    }
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
    print(json.encode(user.getPostAttributes()));
    http.Response response = await http.put(
      domainPrefix + 'users/me',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': user.getToken(),
      },
      body: json.encode(user.getPostAttributes()),
    );
    if (handleAuthRequestErrors(response) != null) {
      return handleAuthRequestErrors(response);
    }
    print("The new user deets are");
    print(response.body);
    User u = User.fromJson(json.decode(response.body));
    return u;
    //if (response.statusCode == 401) {
    //  return Future.error(AuthError.unauthorized);
    //} else {
    //  print("There was an error updateing user details");
    //  return null;
    //}
  }

  Future<User> completeAction(String token, int actionId) async {
    http.Response response = await http.post(
      domainPrefix + 'users/me/actions/${actionId}/complete',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token,
      },
    );
    if (handleAuthRequestErrors(response) != null) {
      return handleAuthRequestErrors(response);
    }
    print("The new deets after joining campaign are");
    print(response.body);
    User u = User.fromJson(json.decode(response.body)['data']);
    return u;
    //else if (response.statusCode == 401) {
    //  return Future.error(AuthError.unauthorized);
    //} else {
    //  print("There was an error updating user details");
    //  print(response.body);
    //  print("The token was ${token}");
    //  print("The actionId was ${actionId.toString()}");
    //  return null;
    //}
  }

  Future<User> starAction(String token, int actionId) async {
    http.Response response = await http.post(
      domainPrefix + 'users/me/actions/${actionId}/favourite',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token,
      },
    );
    if (handleAuthRequestErrors(response) != null) {
      return handleAuthRequestErrors(response);
    }
    //if (response.statusCode == 200) {
    print("The new deets after staring action are");
    print(response.body);
    User u = User.fromJson(json.decode(response.body)['data']);
    return u;
    //} else if (response.statusCode == 401) {
    //  return Future.error(AuthError.unauthorized);
    //} else {
    //  print("There was an error updating user details");
    //  print(response.body);
    //  print(response.statusCode);
    //  print("The token was ${token}");
    //  print("The actionId was ${actionId.toString()}");
    //  return null;
    //}
  }

  Future<User> removeActionStatus(String token, int actionId) async {
    http.Response response = await http.delete(
      domainPrefix + 'users/me/actions/${actionId}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token,
      },
    );
    if (handleAuthRequestErrors(response) != null) {
      return handleAuthRequestErrors(response);
    }
    //if (response.statusCode == 200) {
    print("The new deets after staring action are");
    print(response.body);
    User u = User.fromJson(json.decode(response.body)['data']);
    return u;
    //} else if (response.statusCode == 401) {
    //  return Future.error(AuthError.unauthorized);
    //} else {
    //  print("There was an error updating user details");
    //  print(response.body);
    //  print(response.statusCode);
    //  print("The token was ${token}");
    //  print("The actionId was ${actionId.toString()}");
    //  return null;
    //}
  }

  Future<User> rejectAction(String token, int actionId, String reason) async {
    Map jsonBody = {'reason': reason};
    http.Response response = await http.post(
      domainPrefix + 'users/me/actions/${actionId}/reject',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token,
      },
      body: json.encode(jsonBody),
    );
    if (handleAuthRequestErrors(response) != null) {
      return handleAuthRequestErrors(response);
    }
    //if (response.statusCode == 200) {
    print("The new deets after joining campaign are");
    print(response.body);
    User u = User.fromJson(json.decode(response.body)['data']);
    return u;
    //} else if (response.statusCode == 401) {
    //  return Future.error(AuthError.unauthorized);
    //} else {
    //  print("There was an error updating user details");
    //  print(response.body);
    //  print("The token was ${token}");
    //  print("The actionId was ${actionId.toString()}");
    //  return null;
    //}
  }

  Future<User> joinCampaign(String token, int campaignId) async {
    http.Response response = await http.post(
      domainPrefix + 'users/me/campaigns/${campaignId}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token,
      },
    );
    if (handleAuthRequestErrors(response) != null) {
      return handleAuthRequestErrors(response);
    }
    //if (response.statusCode == 200) {
    print("The new deets after joining campaign are");
    print(response.body);
    User u = User.fromJson(json.decode(response.body)["data"]);
    return u;
    //} else if (response.statusCode == 401) {
    //  return Future.error(AuthError.unauthorized);
    //} else {
    //  print("There was an error updateing user details");
    //  return null;
    //}
  }

  Future<User> unjoinCampaign(String token, int campaignId) async {
    http.Response response = await http.delete(
      domainPrefix + 'users/me/campaigns/${campaignId}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': token,
      },
    );
    if (handleAuthRequestErrors(response) != null) {
      return handleAuthRequestErrors(response);
    }
    //if (response.statusCode == 200) {
    print("The new deets after joining campaign are");
    print(response.body);
    User u = User.fromJson(json.decode(response.body)["data"]);
    return u;
    //} else if (response.statusCode == 401) {
    //  return Future.error(AuthError.unauthorized);
    //} else {
    //  print("There was an error updateing user details");
    //  return null;
    //}
  }
}
