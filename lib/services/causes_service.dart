import 'package:app/models/Cause.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/services/api_service.dart';

class CausesService extends ApiService {
  Future<List<ListCause>> getCauses() async {
    List<Map<String, dynamic>> data = await getListRequest("causes");
    return data.map((causeData) => ListCause.fromJson(causeData)).toList();
  }
  
  Future<Cause> getCause(int id) async {
    Map response = await getRequest("cause/$id");
    return Cause.fromJson(response["data"]);
  }
  
  Future<List<ListCampaign>> getCampaigns() async {
    List<Map<String, dynamic>> data = await getListRequest("campaign");
    return data.map((campData) => ListCampaign.fromJson(campData)).toList();
  }
  
  Future<CampaignAction> getAction(int id) async {
    Map response = await getRequest("action/$id");
    return CampaignAction.fromJson(response["data"]);
  }
  
  Future<List<ListCauseAction>> getActions() async {
    List<Map<String, dynamic>> data = await getListRequest("action");
    return data.map((actionData) => ListCauseAction.fromJson(actionData)).toList();
  }
}
