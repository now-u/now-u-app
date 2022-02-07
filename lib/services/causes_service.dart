import 'package:app/models/Cause.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/models/Learning.dart';
import 'package:app/services/api_service.dart';

class CausesService extends ApiService {
  /// Get request
  ///
  /// Input params
  /// Returns a list of ListCauses from the API
  Future<List<ListCause>> getCauses({Map<String, dynamic>? params}) async {
    List<Map<String, dynamic>> data =
        await getListRequest("causes", params: params);
    return data.map((causeData) => ListCause.fromJson(causeData)).toList();
  }

  /// Get request
  ///
  /// Input a cause id
  /// Returns cause at that id
  Future<Cause> getCause(int id) async {
    Map response = await getRequest("causes/$id");
    return Cause.fromJson(response["data"]);
  }

  /// Get request
  ///
  /// Input params
  /// Returns List of ListCampaign
  Future<List<ListCampaign>> getCampaigns(
      {Map<String, dynamic>? params}) async {
    print("Getting real campaigns");
    List<Map<String, dynamic>> data =
        await getListRequest("campaigns", params: params);
    return data.map((campData) => ListCampaign.fromJson(campData)).toList();
  }

  /// Get request
  ///
  /// Input Action id
  /// Returns the CampaignAction with that id
  Future<Campaign> getCampaign(int id) async {
    Map response = await getRequest("campaigns/$id");
    return Campaign.fromJson(response["data"]);
  }

  Future<CampaignAction> getAction(int id) async {
    Map response = await getRequest("actions/$id");
    return CampaignAction.fromJson(response["data"]);
  }

  /// Get request
  ///
  /// Input params
  /// Return a List of ListCauseActions
  Future<List<ListCauseAction>> getActions(
      {Map<String, dynamic>? params}) async {
    List<Map<String, dynamic>> data =
        await getListRequest("actions", params: params);
    return data
        .map((actionData) => ListCauseAction.fromJson(actionData))
        .toList();
  }

  /// Post request
  ///
  /// Input causes that the user has selected
  /// Posts the ids of these causes to the API
  Future<void> selectCauses(List<ListCause> selectedCauses) async {
    List<int> ids = selectedCauses.map((cause) => cause.id).toList();
    await postRequest('me/causes', body: {'cause_ids': ids});
  }

  Future<List<LearningResource>> getLearningResources(
      {Map<String, dynamic>? params}) async {
    List<Map<String, dynamic>> data =
        await getListRequest("learning/resources", params: params);

    if (params != null) {
      return [];
    }

    return data
        .map((actionData) => LearningResource.fromJson(actionData))
        .toList();
  }
}
