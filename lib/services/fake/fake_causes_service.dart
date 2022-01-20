import 'dart:convert';

import 'package:app/models/Learning.dart';
import 'package:app/services/fake/fake_api_service.dart';

import '../causes_service.dart';
import '../api_service.dart';

import 'package:app/models/Cause.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/Campaign.dart';

class FakeCausesService extends ApiService
    with FakeApiService
    implements CausesService {
  Future<List<ListCause>> getCauses({Map<String, dynamic>? params}) async {
    print("Running get causes");
    String response = await readDataFromFile("causes.json");
    Map causesData = json.decode(response);
    return causesData["data"]
        .map<ListCause>((causeData) => ListCause.fromJson(causeData))
        .toList();
  }

  Future<Cause> getCause(int id) async {
    String response = await readDataFromFile("cause.json");
    Map<String, dynamic> causeData = json.decode(response);
    return Cause.fromJson(causeData);
  }

  Future<CampaignAction> getAction(int id) async {
    String response = await readDataFromFile("action.json");
    Map<String, dynamic> actionData = json.decode(response)["data"];
    return CampaignAction.fromJson(actionData);
  }

  Future<Campaign> getCampaign(int id) async {
    String response = await readDataFromFile("campaign.json");
    Map<String, dynamic> data = json.decode(response)["data"];
    return Campaign.fromJson(data);
  }

  Future<List<ListCauseAction>> getActions(
      {Map<String, dynamic>? params}) async {
    Iterable data = await readIterableDataFromFile("actions.json");
    return data.map((e) => ListCauseAction.fromJson(e)).toList();
  }

  Future<List<ListCampaign>> getCampaigns(
      {Map<String, dynamic>? params}) async {
    Iterable data = await readIterableDataFromFile("campaigns.json");
    return data.map((e) => ListCampaign.fromJson(e)).toList();
  }

  Future<List<LearningResource>> getLearningResources(
      {Map<String, dynamic>? params}) async {
    Iterable data = await readIterableDataFromFile("learning_resources.json");
    return data.map((e) => LearningResource.fromJson(e)).toList();
  }
}
