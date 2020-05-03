import 'package:app/services/api.dart';

import 'package:app/models/Campaign.dart';
import 'package:app/models/Campaigns.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpApi implements Api {

  final String domainPrefix = "https://now-u-api.herokuapp.com/api/v1/";

  @override
  Future<Campaign> getCampaign(int id) {
    print("Getting campaigns");
    print("ITS HAPPENING");
    http.get(domainPrefix + "campaigns/1").then(
      (response) {
        if (response.statusCode == 200) {
          return Campaign.fromJson(json.decode(response.body));
        }
        else {
          return null;
        }
      }
    );
  }
  
  @override
  Future<Campaigns> getCampaigns() {

  }
} 
