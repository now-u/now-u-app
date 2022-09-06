import 'package:app/locator.dart';
import 'package:app/models/Cause.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/Campaign.dart';
import 'package:app/models/Learning.dart';
import 'package:app/services/api_service.dart';
import 'package:app/services/auth.dart';

class CausesService {
  final ApiService _apiService = locator<ApiService>();

  /// Get a list of causes
  ///
  /// Input params
  /// Returns a list of ListCauses from the API
  Future<List<ListCause>> getCauses({Map<String, dynamic>? params}) async {
    return _apiService.getModelListRequest("v2/causes", ListCause.fromJson,
        params: params);
  }

  /// Get a list of campaigns
  ///
  /// Input params
  /// Returns List of ListCampaign
  Future<List<ListCampaign>> getCampaigns(
      {Map<String, dynamic>? params}) async {
    return _apiService.getModelListRequest(
        "v2/campaigns", ListCampaign.fromJson,
        params: params);
  }

  /// Get a campaign by id
  ///
  /// Input Action id
  /// Returns the CampaignAction with that id
  Future<Campaign> getCampaign(int id) async {
    return _apiService.getModelRequest("v2/campaigns/$id", Campaign.fromJson);
  }

  /// Get a list of actions
  ///
  /// Input params
  /// Return a List of ListCauseActions
  Future<List<ListCauseAction>> getActions(
      {Map<String, dynamic>? params}) async {
    return _apiService.getModelListRequest(
        "v2/actions", ListCauseAction.fromJson,
        params: params);
  }

  /// Get an action by id
  ///
  /// Input params
  /// Return a List of ListCauseActions
  Future<CampaignAction> getAction(int id) async {
    return _apiService.getModelRequest(
        "v2/actions/$id", CampaignAction.fromJson);
  }

  /// Get a list of learnig resources
  ///
  /// Input params
  /// Return a List of ListCauseActions
  Future<List<LearningResource>> getLearningResources(
      {Map<String, dynamic>? params}) async {
    return _apiService.getModelListRequest(
        "v2/learning_resources", LearningResource.fromJson,
        params: params);
  }

  /// Set user's selected causes
  ///
  /// Input causes that the user has selected
  /// Posts the ids of these causes to the API
  Future<void> selectCauses(List<ListCause> selectedCauses) async {
    List<int> ids = selectedCauses.map((cause) => cause.id).toList();
    // TODO check this is the correct endpoint
    await _apiService.postRequest('v2/me/causes', body: {'cause_ids': ids});

    // Update user after request
    await locator<AuthenticationService>().syncUser();
  }

  /// Complete an action
  ///
  /// Used so a user can set an action as completed
  Future completeAction(int id) async {
    await _apiService.postRequest('v1/users/me/actions/$id/complete');

    // Update user after request
    await locator<AuthenticationService>().syncUser();
  }

  /// Uncomlete an action
  ///
  /// Sets an action as uncompleted
  Future removeActionStatus(int id) async {
    await _apiService.deleteRequest(
      'v1/users/me/actions/$id',
    );

    // Update user after request
    await locator<AuthenticationService>().syncUser();
  }

  /// Complete a learning resource
  ///
  /// Marks a learning resource as completed
  Future completeLearningResource(int id) async {
    await _apiService.postRequest(
      'v1/users/me/learning_resources/$id',
    );

    // Update user after request
    await locator<AuthenticationService>().syncUser();
  }
}
