import 'package:nowu/services/analytics.dart';
import 'package:nowu/services/api_service.dart';
import 'package:nowu/services/auth.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/dynamicLinks.dart';
import 'package:nowu/services/faq_service.dart';
import 'package:nowu/services/internal_notification_service.dart';
import 'package:nowu/services/navigation_service.dart';
import 'package:nowu/services/pushNotifications.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/services/shared_preferences_service.dart';
import 'package:nowu/services/storage.dart';
import 'package:nowu/services/user_service.dart';
import 'package:nowu/ui/bottom_sheets/explore_filter/explore_filter_sheet.dart';
import 'package:nowu/ui/dialogs/basic/basic_dialog.dart';
import 'package:nowu/ui/dialogs/cause/cause_dialog.dart';
import 'package:nowu/ui/dialogs/email_app_picker/email_app_picker_dialog.dart';
import 'package:nowu/ui/views/action_info/action_info_view.dart';
import 'package:nowu/ui/views/campaign_info/campaign_info_view.dart';
import 'package:nowu/ui/views/causes_selection/change_view/change_select_causes_view.dart';
import 'package:nowu/ui/views/causes_selection/onboarding_view/onboarding_select_causes_view.dart';
import 'package:nowu/ui/views/faq/faq_view.dart';
import 'package:nowu/ui/views/intro/intro_view.dart';
import 'package:nowu/ui/views/login/login_view.dart';
import 'package:nowu/ui/views/login_code/login_code_view.dart';
import 'package:nowu/ui/views/login_email_sent/login_email_sent_view.dart';
import 'package:nowu/ui/views/notification_info/notification_info_view.dart';
import 'package:nowu/ui/views/partner_info/partner_info_view.dart';
import 'package:nowu/ui/views/partners/partners_view.dart';
import 'package:nowu/ui/views/profile_setup/profile_setup_view.dart';
import 'package:nowu/ui/views/startup/startup_view.dart';
import 'package:nowu/ui/views/tabs/tabs_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart' hide NavigationService;
// @stacked-import

@StackedApp(
  routes: [
    CustomRoute(page: StartupView, initial: true),
    CustomRoute(page: PartnersView),
    CustomRoute(page: ActionInfoView, path: 'action/:actionId'),
    CustomRoute(page: CampaignInfoView),
    CustomRoute(page: FaqView),
    CustomRoute(page: IntroView),
    CustomRoute(page: ProfileSetupView),
    CustomRoute(
      page: LoginView,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
    CustomRoute(page: LoginCodeView),
    CustomRoute(page: LoginEmailSentView),
    CustomRoute(page: ChangeSelectCausesView),
    CustomRoute(page: OnboardingSelectCausesView),
    CustomRoute(page: TabsView),
    CustomRoute(page: PartnerInfoView),
    CustomRoute(page: NotificationInfoView),
    // @stacked-route

    // TODO Would be nice if these were accessible on the router service (but within tabs)
    // CustomRoute(page: MoreView),
    // CustomRoute(page: HomeView),

    // TODO
    // CustomRoute(page: UnknownView, path: '/404'),

    // /// When none of the above routes match, redirect to UnknownView
    // RedirectRoute(path: '*', redirectTo: '/404'),
  ],
  // TODO Switch to this locator
  dependencies: [
    // TODO Switch to using these services
    LazySingleton(classType: BottomSheetService),
    // LazySingleton(classType: DialogService),
    LazySingleton(classType: RouterService),
    LazySingleton(classType: CausesService),
    LazySingleton(classType: SearchService),
    LazySingleton(classType: SecureStorageService),
    LazySingleton(classType: SharedPreferencesService),
    LazySingleton(classType: AuthenticationService),
    LazySingleton(classType: UserService),
    LazySingleton(classType: FAQService),
    LazySingleton(classType: PushNotificationService),
    LazySingleton(classType: DynamicLinkService),
    LazySingleton(classType: AnalyticsService),
    // TODO This is super temporary this should be removed
    LazySingleton(classType: NavigationService),
    // LazySingleton(classType: DialogService),
    LazySingleton(classType: DialogService),

    LazySingleton(classType: ApiService),
    LazySingleton(classType: InternalNotificationService),

    // TODO Setup
    // LazySingleton(classType: DialogService),
    // LazySingleton(classType: InternalNotificationService),
    // TODO Api service -> remove and update internal notifactions not to use it

    // TODO Remove if not used
    // LazySingleton(classType: DeviceInfoService),
    // LazySingleton(classType: GoogleLocationSearchService)
    // LazySingleton(classType: RemoteConfigService),
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: ExploreFilterSheet),
// @stacked-bottom-sheet
  ],
  // TODO Switch to these dialogs
  dialogs: [
    StackedDialog(classType: BasicDialog),
    StackedDialog(classType: EmailAppPickerDialog),
    StackedDialog(classType: CauseDialog),
// @stacked-dialog
  ],
)
class App {}
