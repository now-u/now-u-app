import 'package:causeApiClient/causeApiClient.dart';
import 'package:nowu/app/app.locator.dart';
import 'package:nowu/models/Notification.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/dialog_service.dart';
import 'package:nowu/services/internal_notification_service.dart';
import 'package:nowu/services/navigation_service.dart';
import 'package:nowu/services/router_service.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/services/user_service.dart';
import 'package:nowu/ui/views/explore/explore_page_viewmodel.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final _internalNotificationService = locator<InternalNotificationService>();
  final _navigationService = locator<NavigationService>();
  final _routerService = locator<RouterService>();
  final _causesService = locator<CausesService>();
  final _dialogService = locator<DialogService>();
  final _userService = locator<UserService>();
  final _searchService = locator<SearchService>();

  late List<Cause> _causes;

  List<Cause> get causes => _causes;

  // TODO Multiple futures viewModel
  List<ActionExploreTileData>? _myActions;

  List<ActionExploreTileData>? get myActions => _myActions;
  List<CampaignExploreTileData>? _recommendedCampaigns;
  List<CampaignExploreTileData>? get recommendedCampaigns =>
      _recommendedCampaigns;
  List<CampaignExploreTileData>? _ofTheMonthCampaigns;
  List<CampaignExploreTileData>? get ofTheMonthCampaigns =>
      _ofTheMonthCampaigns;
  List<NewsArticleExploreTileData>? _inTheNews;

  List<NewsArticleExploreTileData>? get inTheNews => _inTheNews;

  UserProfile? get currentUser => _userService.currentUser;

  Future<void> init() async {
    fetchNotifications();
    _causes = _causesService.causes;

    // TODO Filter by selected causes
    List<int>? selectedCausesId =
        _causesService.userInfo?.selectedCausesIds.toList();
    List<int>? causesFilter =
        selectedCausesId?.isEmpty == false ? selectedCausesId : null;

    await (
      _searchService
          .searchCampaigns(
            filter: CampaignSearchFilter(
              causeIds: causesFilter,
              recommended: true,
              completed: false,
            ),
          )
          .then(
            (value) => _recommendedCampaigns = value
                .map(
                  (campaign) => CampaignExploreTileData(
                    campaign,
                    _causesService.campaignIsComplete(campaign.id),
                  ),
                )
                .toList(),
          ),
      _searchService
          .searchCampaigns(
            filter: CampaignSearchFilter(
              ofTheMonth: true,
              causeIds: causesFilter,
              completed: false,
            ),
          )
          .then(
            (value) => _ofTheMonthCampaigns = value
                .map(
                  (campaign) => CampaignExploreTileData(
                    campaign,
                    _causesService.campaignIsComplete(campaign.id),
                  ),
                )
                .toList(),
          ),
      _searchService
          .searchActions(
            filter:
                ActionSearchFilter(causeIds: causesFilter, completed: false),
          )
          .then(
            (value) => _myActions = value
                .map(
                  (action) => ActionExploreTileData(
                    action,
                    _causesService.actionIsComplete(action.id),
                  ),
                )
                .toList(),
          ),
      _searchService
          .searchNewsArticles(
            filter: NewsArticleSearchFilter(causeIds: causesFilter),
          )
          .then(
            (value) => _inTheNews = value
                .map((action) => NewsArticleExploreTileData(action))
                .toList(),
          ),
    ).wait;
    notifyListeners();
  }

  Future getCausePopup(Cause listCause) async {
    final dialogResult = await _dialogService.showCauseDialog(cause: listCause);
    if (dialogResult) {
      _routerService.navigateToChangeSelectCausesView();
    }
  }

  List<InternalNotification>? get notifications =>
      _internalNotificationService.notifications;

  int get numberOfCompletedCampaigns {
    return _causesService.userInfo!.completedCampaignIds.length;
  }

  int get numberOfCompletedActions {
    return _causesService.userInfo!.completedActionIds.length;
  }

  int get numberOfCompletedLearningResources {
    return _causesService.userInfo!.completedLearningResourceIds.length;
  }

  // getNotifications
  Future fetchNotifications() async {
    await _internalNotificationService.fetchNotifications();
    notifyListeners();
  }

  Future openNotification(InternalNotification notification) async {
    await _routerService.navigateToNotificationInfoView(
      notification: notification,
    );
  }

  Future dismissNotification(int id) async {
    bool success = await _internalNotificationService.dismissNotification(id);
    if (success) {
      notifyListeners();
    }
  }

  void onPressCampaignButton() {
    _navigationService.launchLink(
      'https://docs.google.com/forms/d/e/1FAIpQLSfPKOVlzOOV2Bsb1zcdECCuZfjHAlrX6ZZMuK1Kv8eqF85hIA/viewform',
      description:
          'To suggest causes for future campaigns, fill in this Google Form',
      buttonText: 'Go',
    );
  }

  void goToExplorePage() {
    _routerService.navigateToExplore();
  }

  void goToEditCausesPage() {
    _routerService.navigateToChangeSelectCausesView();
  }

  Future<void> openAction(ListAction action) {
    return _causesService.openAction(action.id);
  }

  Future<void> openCampaign(ListCampaign campaign) {
    return _causesService.openCampaign(campaign);
  }

  Future<void> openNewsArticle(NewsArticle article) {
    return _causesService.openNewArticle(article);
  }
}
