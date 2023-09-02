import 'package:causeApiClient/causeApiClient.dart';
import 'package:built_collection/built_collection.dart';
import 'package:logging/logging.dart';
import 'package:nowu/app/app.router.dart';
import 'package:nowu/app/app.locator.dart';
import 'package:nowu/services/api_service.dart';
import 'package:nowu/services/auth.dart';
import 'package:nowu/services/navigation_service.dart';
import 'package:stacked_services/stacked_services.dart' hide NavigationService;

export 'package:nowu/models/Action.dart';
export 'package:nowu/models/Campaign.dart';
export 'package:nowu/models/Learning.dart';
export 'package:nowu/models/Cause.dart';

class CausesService {
  final _authService = locator<AuthenticationService>();
  final _apiService = locator<ApiService>();
  final _navigationService = locator<NavigationService>();
  final _routerService = locator<RouterService>();
  final _logger = Logger('CausesService');

  List<Cause>? _causes;
  List<Cause> get causes {
    if (_causes == null) {
      throw Exception('Cannot get causes before initalizing causes service');
    }
    return _causes!;
  }

  Future<void> init() async {
    await _fetchCauses();
  }

  CauseApiClient get _causeServiceClient => _apiService.apiClient;

  CausesUser? _userInfo = null;
  CausesUser? get userInfo => _userInfo;

  /// Get a list of causes
  ///
  /// Input params
  /// Returns a list of Causes from the API
  Future<void> _fetchCauses() async {
    final response = await _causeServiceClient.getCausesApi().causesList();
    _causes = response.data!.asList();
  }

  Cause getCause(int id) {
    return causes.firstWhere((cause) => cause.id == id);
  }

  /// Get a campaign by id
  ///
  /// Input Action id
  /// Returns the Action with that id
  Future<Campaign> getCampaign(int id) async {
    final response =
        await _causeServiceClient.getCampaignsApi().campaignsRetrieve(id: id);
    return response.data!;
  }

  /// Get an action by id
  ///
  /// Input params
  /// Return a List of ListActions
  Future<Action> getAction(int id) async {
    final response =
        await _causeServiceClient.getActionsApi().actionsRetrieve(id: id);
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
    final response = await _causeServiceClient
        .getMeApi()
        .meCausesInfoPartialUpdate(
          patchedCausesUser: PatchedCausesUser(
            (userInfo) => userInfo
              ..selectedCausesIds =
                  ListBuilder(selectedCauses.map((cause) => cause.id).toList()),
          ),
        );

    _userInfo = response.data;

    // After selecting causes we fetch all causes to updated 'selected' status
    await _fetchCauses();
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
    await _causeServiceClient
        .getLearningResourcesApi()
        .learningResourcesComplete(id: id);

    // // Update user after request
    await fetchUserInfo();
  }

  /// Fetch organisation which are partnered with now-u
  Future<List<Organisation>> getPartners() async {
    final response =
        await _causeServiceClient.getOrganisationsApi().organisationsList();
    return response.data!.toList();
  }

  Future<CausesUser?> fetchUserInfo() async {
    if (!_authService.isAuthenticated) {
      _logger.warning('Trying to fetch user info when not authenticated');
      return null;
    }
    final response =
        await _causeServiceClient.getMeApi().meCausesInfoRetrieve();
    print("YPatched user select info");
    print(response.data);
    return _userInfo = response.data!;
  }

  Future<void> openAction(int actionId) async {
    await _routerService.navigateToActionInfoView(actionId: actionId);
  }

  Future<void> openLearningResource(LearningResource learningResource) async {
    await completeLearningResource(learningResource.id);
    _navigationService.launchLink(
      learningResource.link,
    );
  }

  Future<void> openCampaign(ListCampaign campaign) async {
    await _routerService.navigateToCampaignInfoView(listCampaign: campaign);
  }

  Future<void> openNewArticle(NewsArticle article) async {
    await _navigationService.launchLink(article.link);
  }

  bool? actionIsComplete(int actionId) {
    if (_userInfo == null) {
      return null;
    }
    return _userInfo!.completedActionIds.contains(actionId);
  }

  bool? learningResourceIsComplete(int learningResourceId) {
    if (_userInfo == null) {
      return null;
    }
    return _userInfo!.completedLearningResourceIds.contains(learningResourceId);
  }

  bool? campaignIsComplete(int campaignId) {
    if (_userInfo == null) {
      return null;
    }
    return _userInfo!.completedCampaignIds.contains(campaignId);
  }
}
