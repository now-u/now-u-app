import 'package:app/models/User.dart';

import 'package:app/locator.dart';
import 'package:app/services/auth.dart';

import 'package:app/models/Campaign.dart';
import 'package:app/models/Campaigns.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/Learning.dart';
import 'package:app/models/Organisation.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class CampaignService {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

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
    return user.filterSelectedCampaigns(_campaigns);
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
      actions.removeWhere((a) => user.getRejectedActions().contains(a.getId()));
    }

    // If dont include todo actions then get rid of those todo
    if (!(includeTodo ?? true)) {
      actions.removeWhere((a) =>
          !user.getCompletedActions().contains(a.getId()) &&
          !user.getStarredActions().contains(a.getId()));
    }
    if (!(includeCompleted ?? false)) {
      actions
          .removeWhere((a) => user.getCompletedActions().contains(a.getId()));
    }
    if (!(includeStarred ?? true)) {
      actions.removeWhere((a) => user.getStarredActions().contains(a.getId()));
    }
    if (onlySelectedCampaigns ?? false) {
      // If action is not in the selected campaings then get rid
      // TODO CHECK THIS
      List<Campaign> activeSelectedCampaigns = getActiveSelectedCampaigns();
      actions.removeWhere((action) {
        activeSelectedCampaigns.forEach((campaign) {
          if (campaign.getActions().contains(action)) {
            return false;
          }
        });
        return true;
      });
    }
    return actions;
  }

  
  Future getCampaign(int id) async {
    Campaign campaign = _campaigns.firstWhere((c) => c.getId() == id);
    if (campaign != null) {
      return campaign;
    }
    return await fetchCampaign(id);
  }

  Future fetchCampaign(int id) async {
    for (Campaign c in _campaigns) {
      if (c.getId() == id) {
        return c;
      }
    }

    try {
      var response = await http.get(domainPrefix + "campaigns/$id");
      Campaign c = Campaign.fromJson(json.decode(response.body)['data']);
      return c;
    } catch (e) {
      return e.toString();
    }
  }

  Future fetchCampaigns() async {
    try {
      var response = await http.get(domainPrefix + "campaigns");
      Campaigns cs = Campaigns.fromJson(json.decode(response.body)['data']);
      _campaigns = cs.getActiveCampaigns();
    } catch (e) {}
  }

  Future<List<Campaign>> getPastCampaigns() async {
    var response = await http.get(domainPrefix + "campaigns" + "?old=true");
    if (response.statusCode == 200) {
      Campaigns cs = Campaigns.fromJson(json.decode(response.body)['data']);
      return cs.getActiveCampaigns();
    } else {
      return Future.error("Error getting campaigns in http api",
          StackTrace.fromString("The stack trace is"));
    }
  }

  Future<CampaignAction> getAction(int id) async {
    var response = await http.get(domainPrefix + "actions/$id");
    if (response.statusCode == 200) {
      CampaignAction a =
          CampaignAction.fromJson(json.decode(response.body)['data']);
      return a;
    } else {
      return Future.error("Error getting campaigns in http api",
          StackTrace.fromString("The stack trace is"));
    }
  }

  Future getLearningCentre(int campaignId) async {
    try {
      http.Response response = await http
          .get(domainPrefix + "campaigns/$campaignId/learning_topics");
      if (response.statusCode == 200) {
        List jsonData = json.decode(response.body)["data"] as List;
        LearningCentre lc = LearningCentre.fromJson(jsonData);
        return lc;
      } else {
        return "Unknown error";
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<List<Organisation>> getPartners() async {
    var response = await http.get(domainPrefix + "organisations");
    if (response.statusCode == 200) {
      List<Organisation> c = json
          .decode(response.body)['data']
          .map((e) => Organisation.fromJson(e))
          .toList()
          .cast<Organisation>();
      return c;
    } else {
      return Future.error("Error getting organisations in http api",
          StackTrace.fromString("The stack trace is"));
    }
  }
}
