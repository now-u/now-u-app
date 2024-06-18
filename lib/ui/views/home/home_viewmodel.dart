import 'package:causeApiClient/causeApiClient.dart';
import 'package:logging/logging.dart';
import 'package:nowu/locator.dart';
import 'package:nowu/models/Notification.dart';
import 'package:nowu/router.dart';
import 'package:nowu/router.gr.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/dialog_service.dart';
import 'package:nowu/services/internal_notification_service.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/services/user_service.dart';
import 'package:nowu/ui/views/explore/explore_page_viewmodel.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  Logger _logger = Logger('HomeViewModel');
  final _internalNotificationService = locator<InternalNotificationService>();
  final _router = locator<AppRouter>();
  final _causesService = locator<CausesService>();
  final _dialogService = locator<DialogService>();
  final _userService = locator<UserService>();
  final _searchService = locator<SearchService>();

  List<Cause>? _causes;
  List<Cause>? get causes => _causes;

  // TODO Multiple futures viewModel
  // List<ActionExploreTileData>? _myActions;

  // List<ActionExploreTileData>? get myActions => _myActions;
  // List<CampaignExploreTileData>? _recommendedCampaigns;

  // List<CampaignExploreTileData>? get recommendedCampaigns =>
  //     _recommendedCampaigns;
  // List<CampaignExploreTileData>? _ofTheMonthCampaigns;

  // List<CampaignExploreTileData>? get ofTheMonthCampaigns =>
  //     _ofTheMonthCampaigns;
  // List<NewsArticleExploreTileData>? _inTheNews;

  // List<NewsArticleExploreTileData>? get inTheNews => _inTheNews;

  UserProfile? get currentUser => _userService.currentUser;

  Future<void> init() async {
    await (
      fetchNotifications(),
      fetchCauses(),
    ).wait;

    // TODO Filter by selected causes
    List<int>? selectedCausesId =
        _causesService.userInfo?.selectedCausesIds.toList();
    List<int>? causesFilter =
        selectedCausesId?.isEmpty == false ? selectedCausesId : null;

    // await (
    //   _searchService
    //       .searchCampaigns(
    //         filter: CampaignSearchFilter(
    //           causeIds: causesFilter,
    //           completed: false,
    //           ofTheMonth: false,
    //         ),
    //       )
    //       .then(
    //         (value) => _recommendedCampaigns = value.items
    //             .map(
    //               (campaign) => CampaignExploreTileData(
    //                 campaign,
    //                 _causesService.campaignIsComplete(campaign.id),
    //               ),
    //             )
    //             .toList(),
    //       ),
    //   _searchService
    //       .searchCampaigns(
    //         filter: CampaignSearchFilter(
    //           ofTheMonth: true,
    //           causeIds: causesFilter,
    //           completed: false,
    //         ),
    //       )
    //       .then(
    //         (value) => _ofTheMonthCampaigns = value.items
    //             .map(
    //               (campaign) => CampaignExploreTileData(
    //                 campaign,
    //                 _causesService.campaignIsComplete(campaign.id),
    //               ),
    //             )
    //             .toList(),
    //       ),
    //   _searchService
    //       .searchActions(
    //         filter:
    //             ActionSearchFilter(causeIds: causesFilter, completed: false),
    //       )
    //       .then(
    //         (value) => _myActions = value.items
    //             .map(
    //               (action) => ActionExploreTileData(
    //                 action,
    //                 _causesService.actionIsComplete(action.id),
    //               ),
    //             )
    //             .toList(),
    //       ),
    //   _searchService
    //       .searchNewsArticles(
    //         filter: NewsArticleSearchFilter(causeIds: causesFilter),
    //       )
    //       .then(
    //         (value) => _inTheNews = value.items
    //             .map((action) => NewsArticleExploreTileData(action))
    //             .toList(),
    //       ),
    // ).wait;
    notifyListeners();
  }

  Future getCausePopup(Cause listCause) async {
    final dialogResult = await _dialogService.showCauseDialog(cause: listCause);
    if (dialogResult) {
      goToEditCausesPage();
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

  Future fetchCauses() async {
    // Assign the value *after* the future is complete
    final causes = await _causesService.listCauses();
    this._causes = causes;
    notifyListeners();
  }

  Future openNotification(InternalNotification notification) async {
    await _router.push(
      NotificationInfoRoute(notification: notification),
    );
  }

  Future dismissNotification(int id) async {
    bool success = await _internalNotificationService.dismissNotification(id);
    if (success) {
      notifyListeners();
    }
  }

  void goToExplorePage() {
    _router.push(
      TabsRoute(children: [ExploreRoute()]),
    );
  }

  void goToEditCausesPage() {
    _router.push(const ChangeSelectCausesRoute());
  }
}
