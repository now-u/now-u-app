import 'package:app/models/User.dart';

import 'package:app/locator.dart';
import 'package:app/services/auth.dart';

import 'package:app/models/Campaign.dart';
import 'package:app/models/Campaigns.dart';
import 'package:app/models/Action.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
  
class CampaignService {
  
  String domainPrefix = "https://api.now-u.com/api/v1/";
  
  final AuthenticationService _authenticationService = locator<AuthenticationService>();

  Future<Campaign> getCampaign(int id) async {
    var response = await http.get(domainPrefix + "campaigns/1");
    if (response.statusCode == 200) {
      Campaign c = Campaign.fromJson(json.decode(response.body)['data']);
      return c;
    }
    else {
      return Future.error("Error getting campaign in http api", StackTrace.fromString("The stack trace is"));
    }
  }
 
  Future<Campaigns> getCampaigns() async {

    // Get campaings from api
    var response = await http.get(domainPrefix + "campaigns");
   
    if (response.statusCode == 200) {

      // Decode response into campaigns model
      Campaigns cs = Campaigns.fromJson(json.decode(response.body)['data']);
      return cs;
    }
    else {
      return Future.error("Error getting campaigns in http api", StackTrace.fromString("The stack trace is"));
    }
  }
  
  Future<Campaigns> getAllCampaigns() async {
    var response = await http.get(domainPrefix + "campaigns" + "?old=true");
    if (response.statusCode == 200) {
      Campaigns cs = Campaigns.fromJson(json.decode(response.body)['data']);
      return cs;
    }
    else {
      return Future.error("Error getting campaigns in http api", StackTrace.fromString("The stack trace is"));
    }
  }
  
  Future<CampaignAction> getAction(int id) async {
    var response = await http.get(domainPrefix + "actions/$id");
    if (response.statusCode == 200) {
      CampaignAction a = CampaignAction.fromJson(json.decode(response.body)['data']);
      return a;
    }
    else {
      return Future.error("Error getting campaigns in http api", StackTrace.fromString("The stack trace is"));
    }
  }

  Future<User> completeAction(int actionId) async {
    http.Response response = await http.post(
      domainPrefix + 'users/me/actions/$actionId/complete',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': _authenticationService.currentUser.getToken(),
      },
    );
    if (_authenticationService.handleAuthRequestErrors(response) != null) {
      return _authenticationService.handleAuthRequestErrors(response);
    }
    User u = User.fromJson(json.decode(response.body)['data']);
    return u;
  }

  Future<User> starAction(String token, int actionId) async {
    http.Response response = await http.post(
      domainPrefix + 'users/me/actions/$actionId/favourite',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': _authenticationService.currentUser.getToken(),
      },
    );
    if (_authenticationService.handleAuthRequestErrors(response) != null) {
      return _authenticationService.handleAuthRequestErrors(response);
    }
    User u = User.fromJson(json.decode(response.body)['data']);
    return u;
  }

  Future<User> removeActionStatus(String token, int actionId) async {
    http.Response response = await http.delete(
      domainPrefix + 'users/me/actions/$actionId',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': _authenticationService.currentUser.getToken(),
      },
    );
    if (_authenticationService.handleAuthRequestErrors(response) != null) {
      return _authenticationService.handleAuthRequestErrors(response);
    }
    User u = User.fromJson(json.decode(response.body)['data']);
    return u;
  }

  Future<User> rejectAction(String token, int actionId, String reason) async {
    Map jsonBody = {'reason': reason};
    http.Response response = await http.post(
      domainPrefix + 'users/me/actions/$actionId/reject',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': _authenticationService.currentUser.getToken(),
      },
      body: json.encode(jsonBody),
    );
    if (_authenticationService.handleAuthRequestErrors(response) != null) {
      return _authenticationService.handleAuthRequestErrors(response);
    }
    User u = User.fromJson(json.decode(response.body)['data']);
    return u;
  }

  Future<User> joinCampaign(String token, int campaignId) async {
    http.Response response = await http.post(
      domainPrefix + 'users/me/campaigns/$campaignId',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': _authenticationService.currentUser.getToken(),
      },
    );
    if (_authenticationService.handleAuthRequestErrors(response) != null) {
      return _authenticationService.handleAuthRequestErrors(response);
    }
    User u = User.fromJson(json.decode(response.body)["data"]);
    return u;
  }

  Future<User> unjoinCampaign(String token, int campaignId) async {
    http.Response response = await http.delete(
      domainPrefix + 'users/me/campaigns/$campaignId',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': _authenticationService.currentUser.getToken(),
      },
    );
    if (_authenticationService.handleAuthRequestErrors(response) != null) {
      return _authenticationService.handleAuthRequestErrors(response);
    }
    User u = User.fromJson(json.decode(response.body)["data"]);
    return u;
  }
  
  Future<User> completeLearningResource(String token, int learningResourceId) async {
    http.Response response = await http.post(
      domainPrefix + 'users/me/learning_resources/$learningResourceId',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'token': _authenticationService.currentUser.getToken(),
      },
    );
    if (_authenticationService.handleAuthRequestErrors(response) != null) {
      return _authenticationService.handleAuthRequestErrors(response);
    }
    return User.fromJson(json.decode(response.body)["data"]);
  }
  
  
}
