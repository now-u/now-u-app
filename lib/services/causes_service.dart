import 'package:app/models/Cause.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/services/api_service.dart';

class CausesService extends ApiService {
  Future<List<ListCause>> getCauses() async {
    Map response = await getRequest("causes");
    List<Map<String, dynamic>> causesData = new List<Map<String, dynamic>>.from(response["data"]);
    return causesData.map((causeData) => ListCause.fromJson(causeData)).toList();
  }
  
  Future<Cause> getCause(int id) async {
    Map response = await getRequest("cause/$id");
    return Cause.fromJson(response["data"]);
  }
  
  Future<List<ListCampaign>> getCampaigns() async {
    Map response = await getRequest("campaign");
    return response["data"].map((campData) => ListCampaign.fromJson(campData)).toList();
  }
  
  Future<CampaignAction> getAction(int id) async {
    Map response = await getRequest("action/$id");
    return CampaignAction.fromJson(response["data"]);
  }
  
  Future<List<ListCauseAction>> getActions() async {
    Map response = await getRequest("actions");
    List<Map<String, dynamic>> actionsData = new List<Map<String, dynamic>>.from(response["data"]);
    return actionsData.map((actionData) => ListCauseAction.fromJson(actionData)).toList();
  }
}
