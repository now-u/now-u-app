import 'package:app/models/User.dart';

import 'package:app/routes.dart';

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'package:app/locator.dart';
import 'package:app/services/navigation.dart';
import 'package:app/services/shared_preferences_service.dart';
import 'package:app/services/device_info_service.dart';

class AuthError {
  static const unauthorized = "unauthorized";
  static const internal = "internal";
  static const unknown = "unknown";
  static const tokenExpired = "tokenExpired";
}

class AuthenticationService {
  final NavigationService _navigationService = locator<NavigationService>();
  final SharedPreferencesService _sharedPreferencesService =
      locator<SharedPreferencesService>();
  final DeviceInfoService _deviceInfoService = locator<DeviceInfoService>();

  User _currentUser;
  User get currentUser => _currentUser;

  bool logout() {
    _currentUser = null;
    return true;
  }

  // This is not final as it can be changed
  String domainPrefix = "https://api.now-u.com/api/v1/";

  void switchToStagingBranch() {
    domainPrefix = "https://stagingapi.now-u.com/api/v1/";
  }

  Future<bool> isUserLoggedIn() async {
    User user = await _sharedPreferencesService.loadUserFromPrefs();
    if (user != null) {
      await _updateUser(user.getToken());
    }
    return _currentUser != null;
  }

  Future _updateUser(String token) async {
    if (token != null) {
      _currentUser = await getUser(token);
      _sharedPreferencesService.saveUserToPrefs(_currentUser);
    }
  }

  // Generic Reuqest
  // Handle 401 errors
  Future handleAuthRequestErrors(http.Response response) {
    if (response.statusCode == 200) {
      return null;
    } else if (response.statusCode == 401) {
      // Generic reaction to someone being unauthorized is just send them to the login screen
      _navigationService.navigateTo(Routes.login);
      return Future.error(AuthError.unauthorized);
    } else if (response.statusCode == 500) {
      // Generic reaction to someone being unauthorized is just send them to the login screen
      _navigationService.navigateTo('/');
      return Future.error(AuthError.internal);
    }
    return Future.error(AuthError.unknown);
  }

  Future sendSignInWithEmailLink(
      String email, String name, bool acceptNewletter) async {
    try {
      print("email | $email");
      print("name | $name");
      print("nl | $acceptNewletter");
      print("operatingSystem | ${_deviceInfoService.osType}");
      print("operatingSystemVersion | ${await _deviceInfoService.osVersion}");
      await http.post(
        domainPrefix + 'users',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          'email': email,
          'full_name': name,
          'newsletter_signup': acceptNewletter,
          'platform': _deviceInfoService.osType,
          'version': await _deviceInfoService.osVersion,
        }),
      );
      return true;
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future<String> login(String email, String token) async {
    try {
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

      if (response.statusCode == 401) {
        return AuthError.unauthorized;
      }
      if (response.statusCode == 419) {
        return AuthError.tokenExpired;
      }

      User user = await getUser(json.decode(response.body)['data']['token']);

      return null;
    } on Error catch (e) {
      print("Error ${e.toString()}");
      return AuthError.unknown;
    }
  }

  Future<User> getUser(String token) async {
    http.Response userResponse =
        await http.get(domainPrefix + 'users/me', headers: <String, String>{
      'token': token,
    });
    if (handleAuthRequestErrors(userResponse) != null) {
      return handleAuthRequestErrors(userResponse);
    }
    User u = User.fromJson(json.decode(userResponse.body)["data"]);
    return u;
  }

  Future<bool> updateUserDetails({
    String name,
    DateTime dob,
    String orgCode,
  }) async {
    try {
      final Map<String, String> userDetials = {};
      if (name != null) {
        userDetials["full_name"] = name;
      }
      if (dob != null) {
        userDetials["date_of_birth"] = dob.toString();
      }
      if (orgCode != null) {
        userDetials["organisation_code"] = orgCode;
      }
      http.Response response = await http.put(
        domainPrefix + 'users/me',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': currentUser.getToken(),
        },
        body: jsonEncode(userDetials),
      );
      if (response.statusCode >= 300) {
        return false;
      }
      print(response.body);
      print(json.decode(response.body)['data']['organisation']);
      User u = User.fromJson(json.decode(response.body)['data']);
      currentUser.setName(u.getName());
      currentUser.setDateOfBirth(u.getDateOfBirth());
      print("new user og is ${u.organisation}");
      currentUser.setOrganisation = u.organisation;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteUserAccount() async {
    try {
      print("Delete method from Authentication Service fired");
//      switchToStagingBranch(); // Changed to staging api
//      String testingToken = "3ac4e8d88113";
//      http.Response response = await http.delete(
//        domainPrefix + 'users/me',
//        headers: <String, String>{
//          'Content-Type': 'application/json; charset=UTF-8',
////          'token': currentUser.getToken(),
//          'token': testingToken,
//        },
//      );
//      if (response.statusCode != 200) {
//        print("Returned false, no error but status not 200");
//        return false;
//      }
//      print("Returned true, account should be deleted");
      return true;
    } catch (e) {
      print("Error");
      return false;
    }
  }

  Future<bool> leaveOrganisation() async {
    try {
      print("Leaving org");
      http.Response response = await http.put(
        domainPrefix + 'users/me/organisations',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': currentUser.getToken(),
        },
      );
      if (response.statusCode >= 300) {
        print("Put organisation_code sjdfkljsdf");
        return false;
      }
      print("Put organisation_code null");
      User u = User.fromJson(json.decode(response.body));
      currentUser.setOrganisation = u.organisation;
      return true;
    } catch (e) {
      print("Error");
      return false;
    }
  }

  Future<bool> completeAction(int actionId) async {
    try {
      http.Response response = await http.post(
        domainPrefix + 'users/me/actions/$actionId/complete',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': currentUser.getToken(),
        },
      );
      if (response.statusCode != 200) {
        return false;
      }
      User u = User.fromJson(json.decode(response.body)['data']);

      _currentUser.setPoints(u.getPoints());
      _currentUser.setCompletedActions(u.getCompletedActions());

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> starAction(int actionId) async {
    try {
      http.Response response = await http.post(
        domainPrefix + 'users/me/actions/$actionId/favourite',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': currentUser.getToken(),
        },
      );
      if (response.statusCode != 200) {
        return false;
      }
      User u = User.fromJson(json.decode(response.body)['data']);
      _currentUser = _currentUser.copyWith(
        starredActions: u.starredActions,
        points: u.points,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> removeActionStatus(int actionId) async {
    try {
      http.Response response = await http.delete(
        domainPrefix + 'users/me/actions/$actionId',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': currentUser.getToken(),
        },
      );
      if (response.statusCode != 200) {
        return false;
      }
      User u = User.fromJson(json.decode(response.body)['data']);
      //_currentUser.setPoints(u.getPoints());
      _currentUser = _currentUser.copyWith(
        starredActions: u.getStarredActions(),
        rejectedActions: u.getRejectedActions(),
        completedActions: u.getCompletedActions(),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<User> rejectAction(String token, int actionId, String reason) async {
    Map jsonBody = {'reason': reason};
    http.Response response = await http.post(
      domainPrefix + 'users/me/actions/$actionId/reject',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': currentUser.getToken(),
      },
      body: json.encode(jsonBody),
    );
    if (handleAuthRequestErrors(response) != null) {
      return handleAuthRequestErrors(response);
    }
    User u = User.fromJson(json.decode(response.body)['data']);
    return u;
  }

  Future<bool> joinCampaign(int campaignId) async {
    try {
      http.Response response = await http.post(
        domainPrefix + 'users/me/campaigns/$campaignId',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': currentUser.getToken(),
        },
      );
      if (response.statusCode != 200) {
        return false;
      }
      User u = User.fromJson(json.decode(response.body)["data"]);
      _currentUser = _currentUser.copyWith(
        selectedCampaigns: u.getSelectedCampaigns(),
        points: u.getPoints(),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> leaveCampaign(int campaignId) async {
    try {
      http.Response response = await http.delete(
        domainPrefix + 'users/me/campaigns/$campaignId',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': currentUser.getToken(),
        },
      );
      if (response.statusCode != 200) {
        return false;
      }
      User u = User.fromJson(json.decode(response.body)["data"]);
      _currentUser = _currentUser.copyWith(
        selectedCampaigns: u.getSelectedCampaigns(),
        points: u.getPoints(),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> completeLearningResource(int learningResourceId) async {
    try {
      http.Response response = await http.post(
        domainPrefix + 'users/me/learning_resources/$learningResourceId',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'token': currentUser.getToken(),
        },
      );
      if (response.statusCode != 200) {
        return false;
      }
      User u = User.fromJson(json.decode(response.body)['data']);
      _currentUser = _currentUser.copyWith(
          completedLearningResources: u.getCompletedLearningResources());
      return true;
    } catch (e) {
      return false;
    }
  }
}
