import 'package:causeApiClient/causeApiClient.dart';
import 'package:nowu/app/app.router.dart';
import 'package:nowu/models/User.dart';
import 'package:nowu/ui/views/explore/explore_page_definition.dart';
import 'package:nowu/ui/views/tabs/tabs_view.dart';
import 'package:stacked_services/stacked_services.dart' show RouterService;

export 'package:stacked_services/stacked_services.dart' show RouterService;
export 'package:nowu/app/app.router.dart';

extension RouterServiceExtension on RouterService {
  // TODO Use in login_viewmodel and setup_viewmodel
  void navigateUserInitalRoute(UserProfile user, CausesUser causesUser) {
    // TODO Check causes service is also initalized
    if (!user.isInitialised) {
      clearStackAndShow(const ProfileSetupViewRoute());
      // TODO How should we get this proifle? I don't think router service depending on causes... I guess it can be passed in in both cases
    } else if (!causesUser.isInitialised) {
      clearStackAndShow(const OnboardingSelectCausesViewRoute());
    } else {
      navigateToHome(clearHistory: true);
    }
  }

  Future<void> navigateToExplore(ExplorePageArguments args) {
    return navigateTo(
      TabsViewRoute(initialPage: TabPage.Explore, explorePageArgs: args),
    );
  }

  Future<void> navigateToHome({clearHistory = false}) {
    final route = TabsViewRoute(initialPage: TabPage.Home);
    if (clearHistory) {
      return clearStackAndShow(route);
    }
    return navigateTo(route);
  }
}
