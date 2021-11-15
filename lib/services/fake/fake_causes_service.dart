import 'dart:io';
import 'dart:convert';

import '../causes_service.dart';
import '../api_service.dart';

import 'package:app/models/Cause.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/Campaign.dart';
import 'package:flutter/services.dart' show rootBundle;

Directory findRoot(FileSystemEntity entity) {
    final Directory parent = entity.parent;
    if (parent.path == entity.path) return parent;
    return findRoot(parent);
}

class FakeCausesService extends ApiService implements CausesService {

  Future<String> readDataFromFile(String fileName) async {
    print("Getting asset"); 
    return await rootBundle.loadString('assets/json/$fileName');
  }

  Future<List<ListCause>> getCauses({Map<String, dynamic>? params}) async {
    String response = await readDataFromFile("causes.json");
    Map causesData = json.decode(response);
    return causesData["data"].map<ListCause>((causeData) => ListCause.fromJson(causeData)).toList();
  }
  
  Future<Cause> getCause(int id) async {
    String response = await readDataFromFile("cause.json");
    Map<String, dynamic> causeData = json.decode(response);
    return Cause.fromJson(causeData);
  }
  
  Future<CampaignAction> getAction(int id) async {
    String response = await readDataFromFile("action.json");
    Map<String, dynamic> causeData = json.decode(response);
    return CampaignAction.fromJson(causeData);
  }
  
  Future<List<ListCauseAction>> getActions({Map<String, dynamic>? params}) async {
    String response = await readDataFromFile("actions.json");
    Map actionsData = json.decode(response);
    return actionsData["data"].map<ListCauseAction>((actionData) => ListCause.fromJson(actionData)).toList();
  }
  
  Future<List<ListCampaign>> getCampaigns({Map<String, dynamic>? params}) async {
    String response = await readDataFromFile("campaings.json");
    Map data = json.decode(response);
    return data["data"].map<ListCampaign>((campaignData) => ListCampaign.fromJson(campaignData)).toList();
  }
}
