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
      return Future.error("Uhoh", StackTrace.fromString("The stack trace is"));
    }
  }
  
  @override
  Future<Campaigns> getCampaigns() {

  }
} 
