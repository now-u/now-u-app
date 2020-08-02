import 'package:app/services/api.dart';

import 'package:app/models/Campaign.dart';
import 'package:app/models/Campaigns.dart';
import 'package:app/models/Article.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/FAQ.dart';
import 'package:app/models/Organisation.dart';
import 'package:app/models/Learning.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpError {
  static const internal = "internal";
  static const unknown = "unknown";
}

class HttpApi implements Api {

  String domainPrefix = "https://api.now-u.com/api/v1/";
  
  void toggleStagingApi() {
    if (domainPrefix.contains("staging")) {
      domainPrefix = "https://api.now-u.com/api/v1/";
    } else {
      domainPrefix = "https://stagingapi.now-u.com/api/v1/";
    }
  }

  @override
  Future<Campaign> getCampaign(int id) async {
    var response = await http.get(domainPrefix + "campaigns/1");
    if (response.statusCode == 200) {
      print("We got a 200!");
      Campaign c = Campaign.fromJson(json.decode(response.body)['data']);
      print("Here is the campaign");
      print(c);
      return c;
    }
    else {
      print("We got an error whilst doing the http request");
      return Future.error("Error getting campaign in http api", StackTrace.fromString("The stack trace is"));
    }
  }
  
  @override
  Future<Campaigns> getCampaigns() async {
    print("Getting campaigns");
    print("ITS HAPPENING");
    print(domainPrefix);
    var response = await http.get(domainPrefix + "campaigns");
    if (response.statusCode == 200) {
      print("200");
      Campaigns cs = Campaigns.fromJson(json.decode(response.body)['data']);
      print("We got some camps");
      return cs;
    }
    else {
      // TODO different error different reults
      print("We got an error whilst doing the http request");
      return Future.error("Error getting campaigns in http api", StackTrace.fromString("The stack trace is"));
    }
  }
  
  @override
  Future<Campaigns> getAllCampaigns() async {
    print("ITS HAPPENING");
    var response = await http.get(domainPrefix + "campaigns" + "?old=true");
    if (response.statusCode == 200) {
      Campaigns cs = Campaigns.fromJson(json.decode(response.body)['data']);
      print("We got all camps");
      return cs;
    }
    else {
      // TODO different error different reults
      print("We got an error whilst doing the http request");
      return Future.error("Error getting campaigns in http api", StackTrace.fromString("The stack trace is"));
    }
  }
  
  @override
  Future<CampaignAction> getAction(int id) async {
    print("Getting action");
    var response = await http.get(domainPrefix + "actions/${id}");
    if (response.statusCode == 200) {
      print("200");
      CampaignAction a = CampaignAction.fromJson(json.decode(response.body)['data']);
      print("We got an action");
      return a;
    }
    else {
      // TODO different error different reults
      print("We got an error whilst doing the http request");
      return Future.error("Error getting campaigns in http api", StackTrace.fromString("The stack trace is"));
    }
  }

  @override
  Future<List<Article>> getArticles() async {
    var response = await http.get(domainPrefix + "articles");
    if (response.statusCode == 200) {
      print("We got a 200 when getting articles!");
      List<Article> c = json.decode(response.body)['data'].map((e) => Article.fromJson(e)).toList().cast<Article>();
      print("Here are the aricles");
      print(c);
      return c;
    }
    else {
      print("We got an error whilst doing the http request");
      return Future.error("Error getting campaign in http api", StackTrace.fromString("The stack trace is"));
    }
  }

  // TODO implement
  @override
  Future<Article> getVideoOfTheDay() async {
    // TODO handle there being no video of the day
    var response = await http.get(domainPrefix + "articles");
    if (response.statusCode == 200) {
      print("We got a 200 when getting articles!");
      List<Article> arts = json.decode(response.body)['data'].map((e) => Article.fromJson(e)).toList().cast<Article>();
      print("Here are the aricles");
      for (int i = 0; i < arts.length; i++){
        if(arts[i].getIsVideoOfTheDay() && arts[i].getVideoLink() != null) {
          print("Video of the day title is" + arts[i].getTitle());
          return arts[i];
        }
      }
      return null;
    }
    else {
      print("We got an error whilst doing the http request");
      return Future.error("Error getting campaign in http api", StackTrace.fromString("The stack trace is"));
    }
  }

  @override
  Future<List<FAQ>> getFAQs() async {
    var response = await http.get(domainPrefix + "faqs");
    if (response.statusCode == 200) {
      print("We got a 200 when getting faqs!");
      List<FAQ> faqs = json.decode(response.body)['data'].map((e) => FAQ.fromJson(e)).toList().cast<FAQ>();
      print("Here is the faqs");
      print(faqs);
      return faqs;
    }
    else {
      print("We got an error whilst doing the http request");
      return Future.error("Error getting faqs in http api", StackTrace.fromString("The stack trace is"));
    }
  }

  @override
  Future<List<Organisation>> getPartners() async {
    var response = await http.get(domainPrefix + "organisations");
    if (response.statusCode == 200) {
      print("We got a 200 when getting articles!");
      List<Organisation> c = json.decode(response.body)['data'].map((e) => Organisation.fromJson(e)).toList().cast<Organisation>();
      print("Here is the aricles");
      print(c);
      return c;
    }
    else {
      print("We got an error whilst doing the http request");
      return Future.error("Error getting organisations in http api", StackTrace.fromString("The stack trace is"));
    }
  }

  Future<LearningCentre> getLearningCentre(int campaignId) async {
    http.Response response = await http.get(domainPrefix + "campaigns/${campaignId}/learning_topics");
    if (response.statusCode == 200) {
     print(response.body);
     print("Got the response");
     print((json.decode(response.body)));
     List jsonData = json.decode(response.body)["data"] as List;
     print(jsonData);
     LearningCentre lc = LearningCentre.fromJson(jsonData);
     print("Got learning center");
     print(lc.getLearningTopics()[0]);
     return lc;
    }
    else {
      print("We got an error whilst doing the http request");
      return Future.error("Error getting learning centre in http api", StackTrace.fromString("The stack trace is"));
    }
  }
} 
