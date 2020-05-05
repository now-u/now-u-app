import 'package:app/services/api.dart';

import 'package:app/models/Campaign.dart';
import 'package:app/models/Campaigns.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpApi implements Api {

  final String domainPrefix = "https://now-u-api.herokuapp.com/api/v1/";

  @override
  Future<Campaign> getCampaign(int id) async {
    print("Getting campaigns");
    print("ITS HAPPENING");
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
    var response = await http.get(domainPrefix + "campaigns");
    if (response.statusCode == 200) {
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
} 
