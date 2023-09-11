import 'package:nowu/app/app.router.dart';
import 'package:nowu/ui/views/explore/explore_page_viewmodel.dart';
import 'package:nowu/ui/views/tabs/tabs_view.dart';
import 'package:stacked_services/stacked_services.dart' show RouterService;

export 'package:stacked_services/stacked_services.dart' show RouterService;
export 'package:nowu/app/app.router.dart';

extension RouterServiceExtension on RouterService {
  Future<void> navigateToExplore([ExplorePageFilterData? filterData]) {
    return navigateTo(
      // TODO Fix args for naving to explore
      TabsViewRoute(
          initialPage: TabPage.Explore, exploreFilterData: filterData,),
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
