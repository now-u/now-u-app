import 'package:causeApiClient/causeApiClient.dart';
import 'package:built_collection/built_collection.dart';
import 'package:logging/logging.dart';
import 'package:nowu/app/app.router.dart';
import 'package:nowu/app/app.locator.dart';
import 'package:nowu/router.dart';
import 'package:nowu/router.gr.dart';
import 'package:nowu/services/analytics.dart';
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
  final _analyticsService = locator<AnalyticsService>();
  final _apiService = locator<ApiService>();
  final _navigationService = locator<NavigationService>();
  final _router = locator<AppRouter>();
  final _logger = Logger('CausesService');

  List<Cause>? _causes;
  Future<List<Cause>> _fetchCauses() async {
	_logger.info("Fetching causes from the service");
    final response = await _causeServiceClient.getCausesApi().causesList();
    return response.data!.asList();
  }

  CauseApiClient get _causeServiceClient => _apiService.apiClient;

  CausesUser? _userInfo = null;
  CausesUser? get userInfo => _userInfo;

  /// Get a list of causes
  ///
  /// Input params
  /// Returns a list of Causes from the API
  Future<List<Cause>> listCauses() async {
    if (_causes == null) {
	  _causes = await _fetchCauses();
	}
	_logger.info("Got causes, $_causes");
    return _causes!;
  }

  Future<Cause> getCause(int id) async {
    final causes = await listCauses();
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
  Future completeAction(Action action) async {
    await (
      _causeServiceClient.getActionsApi().actionsComplete(id: action.id),
      _analyticsService.logActionEvent(
        action,
        ActionEvent.Complete,
      ),
    ).wait;

    // Update user after request
    await fetchUserInfo();
  }

  /// Uncomlete an action
  ///
  /// Sets an action as uncompleted
  Future removeActionStatus(Action action) async {
    await (
      _causeServiceClient.getActionsApi().actionsUncomplete(id: action.id),
      _analyticsService.logActionEvent(
        action,
        ActionEvent.Uncomplete,
      ),
    ).wait;

    // Update user after request
    await fetchUserInfo();
  }

  /// Complete a learning resource
  ///
  /// Marks a learning resource as completed
  Future completeLearningResource(LearningResource learningResource) async {
    await (
      _causeServiceClient
          .getLearningResourcesApi()
          .learningResourcesComplete(id: learningResource.id),
      _analyticsService.logLearningResourceClicked(learningResource),
    ).wait;

    // Update user after request
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
    print('YPatched user select info');
    print(response.data);
    return _userInfo = response.data!;
  }

  Future<void> openAction(int actionId) async {
    await _router.push(ActionInfoRoute(actionId: actionId));
  }

  Future<void> openLearningResource(LearningResource learningResource) async {
    if (_authService.isUserLoggedIn()) {
      // TODO Should this if be inside here?
      await completeLearningResource(learningResource);
    }
    _navigationService.launchLink(
      learningResource.link,
    );
  }

  Future<void> openCampaign(ListCampaign campaign) async {
    await _router.push(CampaignInfoRoute(listCampaign: campaign));
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
    // TODO Store copy of these values as set so don't have to loop through
    return _userInfo!.completedLearningResourceIds.contains(learningResourceId);
  }

  bool? campaignIsComplete(int campaignId) {
    if (_userInfo == null) {
      return null;
    }
    return _userInfo!.completedCampaignIds.contains(campaignId);
  }
}
