import 'package:nowu/app/app.router.dart';
import 'package:nowu/ui/views/explore/explore_page_viewmodel.dart';
import 'package:stacked_services/stacked_services.dart'
    show NavigationService, RouterService;

export 'package:nowu/app/app.router.dart';
export 'package:stacked_services/stacked_services.dart' show RouterService;

extension RouterServiceExtension on NavigationService {
  Future<void> navigateToExplore([ExplorePageFilterData? filterData]) {
    return navigateToFaqView();
    // return navigateTo(
    //   // TODO Fix args for naving to explore
    //   TabsViewRoute(
    //     initialPage: TabPage.Explore,
    //     exploreFilterData: filterData,
    //   ),
    // );
  }

  Future<void> navigateToHome({clearHistory = false}) {
    return navigateToTabsView();
    // final route = TabsViewRoute(initialPage: TabPage.Home);
    // if (clearHistory) {
    //   return clearStackAndShow(route);
    // }
    // return navigateTo(route);
  }
}
