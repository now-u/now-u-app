import 'package:app/models/User.dart';

import 'package:app/locator.dart';
import 'package:app/services/auth.dart';

import 'package:app/models/Campaign.dart';
import 'package:app/models/Campaigns.dart';
import 'package:app/models/Action.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
  
class CampaignService {
  
  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  
  String domainPrefix = "https://api.now-u.com/api/v1/";

  List<Campaign> _campaigns = [];
  List<Campaign> get campaigns {
    return _campaigns;
  }
    
  List<Campaign> getActiveSelectedCampaigns() {
    User user = _authenticationService.currentUser;
    if (user == null) {
      return [];
    }
    return user
      .filterSelectedCampaigns(_campaigns);
  }
    
  List<CampaignAction> getActiveActions(
      {bool includeCompleted,
      bool includeRejected,
      bool onlySelectedCampaigns,
      bool includeTodo, // Todo actions are unstarred and uncompleted
      bool includeStarred}) {
    
    List<CampaignAction> actions = [];
    for (Campaign campaign in _campaigns) {
      actions.addAll(campaign.getActions());
    }

    User user = _authenticationService.currentUser;

    if (user == null) {
      return actions;
    }

    if (!(includeRejected ?? false)) {
      actions.removeWhere((a) => user 
          .getRejectedActions()
          .contains(a.getId()));
    }
    
    // If dont include todo actions then get rid of those todo
    if (!(includeTodo ?? true)) {
      actions.removeWhere((a) =>
          !user
              .getCompletedActions()
              .contains(a.getId()) &&
          !user
              .getStarredActions()
              .contains(a.getId()));
    }
    if (!(includeCompleted ?? false)) {
      actions.removeWhere((a) => user
          .getCompletedActions()
          .contains(a.getId()));
    }
    if (!(includeStarred ?? true)) {
      actions.removeWhere((a) =>
          user.getStarredActions().contains(a.getId()));
    }
    if (onlySelectedCampaigns ?? false) {
      // If action is not in the selected campaings then get rid
      // TODO CHECK THIS
      List<Campaign> activeSelectedCampaigns = getActiveSelectedCampaigns();
      actions.removeWhere(
          (action) { 
            activeSelectedCampaigns.forEach((campaign) { 
              if (campaign.getActions().contains(action)){
                return false;
              }
            });
            return true;
          }
      );
    }
    return actions;
  }
  

  Future getCampaign(int id) async {
    for (Campaign c in _campaigns) {
      if (c.getId() == id) {
        return c;
      }
    }

    try {
      var response = await http.get(domainPrefix + "campaigns/$id");
      Campaign c = Campaign.fromJson(json.decode(response.body)['data']);
      return c;
    }
    catch (e) {
      return e.toString();
    }
  }
  
  Future pullCampaings() async {
    try {
      var response = await http.get(domainPrefix + "campaigns");
      Campaigns cs = Campaigns.fromJson(json.decode(response.body)['data']);
      _campaigns = cs.getActiveCampaigns();
    } catch(e) {
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
