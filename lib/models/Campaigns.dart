import 'package:app/models/Campaign.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/User.dart';

import 'package:app/services/api.dart';
import 'package:app/locator.dart';

import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import 'package:hive/hive.dart';


class Campaigns {
  List<Campaign> activeCampaigns;

  Campaigns(this.activeCampaigns);

  List<Campaign> getActiveCampaigns() {
    return activeCampaigns; 
  }
  
  List<Campaign> getSelectedActiveCampaigns(User u) {
    print("Getting asc");
    var asc = activeCampaigns.where((c) => u.getSelectedCampaigns().contains(c.getId())).toList(); 
    print("Got asc");
    print(asc);
    print(asc.length);
    return asc;
  }

  //TODO shuffle/ return in sesible order
  List<CampaignAction> getActions() {
    List<CampaignAction> actions = [];
    for (int i =0; i < activeCampaigns.length; i++) {
      actions.addAll(activeCampaigns[i].getActions()); 
    }
    return actions;
  }

  int activeLength () {
    return activeCampaigns.length;
  }
  
  Campaigns.fromJson(List json) {
    activeCampaigns = json.map((e) => Campaign.fromJson(e)).toList().cast<Campaign>();
  }

  String toJson() {
    return json.encode(this.activeCampaigns);
  }
 
  Campaigns.init() {
    print("Initalizing campaigns");
    Api api = locator<Api>();
    List<Campaign> camps; 
    api.getCampaigns().then(
      (Campaigns cs) {
        activeCampaigns = cs.getActiveCampaigns();
        print("got campaigns");
        print(activeCampaigns);
      },
      onError: (error) {
        print("There was an error when getting campaigns");
        readCampaingsFromAssets().then((String s) {
          camps = (jsonDecode(s) as List).map((e) => Campaign.fromJson(e)).toList().cast<Campaign>();
          activeCampaigns = camps ?? <Campaign>[];
        });
      }
    );
  }

  Campaigns getCampaignsFromIds(List<int> ids) {
    List<Campaign> campaigns;
    for (int i = 0; i < activeCampaigns.length; i++){
      if (ids.contains(activeCampaigns[i].getId())) {
        campaigns.add(activeCampaigns[i]);
      }
    }
    return Campaigns(campaigns);
  }

  Future<String> readCampaingsFromAssets() async {
    String data = await rootBundle.loadString('assets/json/campaigns.json');
    return data;
  }
  
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    print("Directory path is");
    print(directory.path);
    return directory.path;
  }

  Future<File> get _campaignsFile async {
    final path = await _localPath;
    return File('$path/assets/json/campaigns.json');
  }

  Future<String> readCampaings() async {
    try {
      final file = await _campaignsFile;

      // Read the file
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      throw e;
    }
  }
}
