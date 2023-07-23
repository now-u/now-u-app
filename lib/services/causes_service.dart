import 'package:causeApiClient/causeApiClient.dart';
import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:nowu/locator.dart';
import 'package:nowu/services/auth.dart';

export 'package:nowu/models/Action.dart';
export 'package:nowu/models/Campaign.dart';
export 'package:nowu/models/Learning.dart';
export 'package:nowu/models/Cause.dart';

class CausesService {
  final AuthenticationService _authService = locator<AuthenticationService>();
  CauseApiClient get _causeServiceClient {
	return CauseApiClient(
  	    dio: Dio(
  	    	BaseOptions(
  	    		baseUrl: 'http://192.168.1.11:8000',
				headers: _authService.token == null ? null : {
  	  				'Authorization': 'JWT ${_authService.token!}'
  	  			}
  	    	)
  	    )
  	);
  }

  CausesUser? _userInfo = null;
  CausesUser? get userInfo => _userInfo;

  /// Get a list of causes
  ///
  /// Input params
  /// Returns a list of Causes from the API
  Future<List<Cause>> getCauses() async {
	final response = await _causeServiceClient.getCausesApi().causesList();
	return response.data!.asList();
  }

  /// Get a campaign by id
  ///
  /// Input Action id
  /// Returns the Action with that id
  Future<Campaign> getCampaign(int id) async {
	final response = await _causeServiceClient.getCampaignsApi().campaignsRetrieve(id: id);
	return response.data!;
  }

  /// Get an action by id
  ///
  /// Input params
  /// Return a List of ListActions
  Future<Action> getAction(int id) async {
	final response = await _causeServiceClient.getActionsApi().actionsRetrieve(id: id);
	return response.data!;
  }

  /// Set user's selected causes
  ///
  /// Input causes that the user has selected
  /// Posts the ids of these causes to the API
  Future<void> selectCauses(List<Cause> selectedCauses) async {
	// TOOD Update API to match spec here
    // List<int> ids = selectedCauses.map((cause) => cause.id).toList();
    // // TODO check this is the correct endpoint
    // await _apiService.postRequest('v2/me/causes', body: {'cause_ids': ids});

    // // Update user after request
    // await locator<AuthenticationService>().fetchUser();
	_causeServiceClient.getMeApi().meCausesInfoPartialUpdate(
		patchedCausesUser: PatchedCausesUser((userInfo) => userInfo
			..newSelectedCausesIds = ListBuilder(selectedCauses.map((cause) => cause.id).toList())
		)
	);
  }

  /// Complete an action
  ///
  /// Used so a user can set an action as completed
  Future completeAction(int id) async {
	await _causeServiceClient.getActionsApi().actionsComplete(id: id);

    // Update user after request
    await fetchUserInfo();
  }

  /// Uncomlete an action
  ///
  /// Sets an action as uncompleted
  Future removeActionStatus(int id) async {
	await _causeServiceClient.getActionsApi().actionsUncomplete(id: id);

    // Update user after request
	await fetchUserInfo();
  }

  /// Complete a learning resource
  ///
  /// Marks a learning resource as completed
  Future completeLearningResource(int id) async {
	await _causeServiceClient.getLearningResourcesApi().learningResourcesComplete(id: id);

    // // Update user after request
	await fetchUserInfo();
  }

  /// Fetch organisation which are partnered with now-u
  Future<List<Organisation>> getPartners() async {
	final response = await _causeServiceClient.getOrganisationsApi().organisationsList();
	return response.data!.toList();
  }

  Future<CausesUser> fetchUserInfo() async {
	final response = await _causeServiceClient.getMeApi().meCausesInfoRetrieve();
	return _userInfo = response.data!;
  }

  bool actionIsComplete(int actionId) {
	if (_userInfo == null) {
		return false;
	}
	return _userInfo!.completedActionIds.contains(actionId);
  }
  
  bool learningResourceIsComplete(int learningResourceId) {
	if (_userInfo == null) {
		return false;
	}
	return _userInfo!.completedLearningResourceIds.contains(learningResourceId);
  }
  
  bool campaignIsComplete(int campaignId) {
	if (_userInfo == null) {
		return false;
	}
	return _userInfo!.completedCampaignIds.contains(campaignId);
  }
}
