import 'package:app/locator.dart';
import 'package:app/models/Cause.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/models/Learning.dart';
import 'package:app/models/User.dart';
import 'package:app/services/api_service.dart';
import 'package:app/services/auth.dart';

class CausesService extends ApiService {
  /// Get request
  ///
  /// Input params
  /// Returns a list of ListCauses from the API
  Future<List<ListCause>> getCauses({Map<String, dynamic>? params}) async {
    List<Map<String, dynamic>> data =
        await getListRequest("v2/causes", params: params);
    return data.map((causeData) => ListCause.fromJson(causeData)).toList();
  }

  /// Get request
  ///
  /// Input a cause id
  /// Returns cause at that id
  Future<Cause> getCause(int id) async {
    Map response = await getRequest("v2/causes/$id");
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
        await getListRequest("v2/campaigns", params: params);
    return data.map((campData) => ListCampaign.fromJson(campData)).toList();
  }

  /// Get request
  ///
  /// Input Action id
  /// Returns the CampaignAction with that id
  Future<Campaign> getCampaign(int id) async {
    Map response = await getRequest("v2/campaigns/$id");
    return Campaign.fromJson(response["data"]);
  }

  Future<CampaignAction> getAction(int id) async {
    Map response = await getRequest("v2/actions/$id");
    return CampaignAction.fromJson(response["data"]);
  }

  /// Get request
  ///
  /// Input params
  /// Return a List of ListCauseActions
  Future<List<ListCauseAction>> getActions(
      {Map<String, dynamic>? params}) async {
    List<Map<String, dynamic>> data =
        await getListRequest("v2/actions", params: params);
    return data
        .map((actionData) => ListCauseAction.fromJson(actionData))
        .toList();
  }

  Future<List<LearningResource>> getLearningResources(
      {Map<String, dynamic>? params}) async {
    List<Map<String, dynamic>> data =
        await getListRequest("v2/learning_resources", params: params);

    if (params != null) {
      return [];
    }

    return data
        .map((actionData) => LearningResource.fromJson(actionData))
        .toList();
  }

  /// Set user's selected causes
  ///
  /// Input causes that the user has selected
  /// Posts the ids of these causes to the API
  Future<void> selectCauses(List<ListCause> selectedCauses) async {
    List<int> ids = selectedCauses.map((cause) => cause.id).toList();
    await postRequest('v1/me/causes', body: {'cause_ids': ids});

    // Update user after request
    await locator<AuthenticationService>().syncUser();
  }

  /// Complete an action
  ///
  /// Used so a user can set an action as completed
  Future completeAction(int id) async {
    await postRequest('v1/users/me/actions/$id/complete');

    // Update user after request
    await locator<AuthenticationService>().syncUser();
  }

  /// Uncomlete an action
  ///
  /// Sets an action as uncompleted
  Future removeActionStatus(int id) async {
    await deleteRequest(
      'v1/users/me/actions/$id',
    );

    // Update user after request
    await locator<AuthenticationService>().syncUser();
  }

  /// Complete a learning resource
  ///
  /// Marks a learning resource as completed
  Future completeLearningResource(int id) async {
    await postRequest(
      'v1/users/me/learning_resources/$id',
    );

    // Update user after request
    await locator<AuthenticationService>().syncUser();
  }
}
