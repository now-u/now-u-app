import 'package:nowu/app/app.router.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/ui/views/explore/explore_page_definition.dart';
import 'package:nowu/ui/views/tabs/tabs_view.dart';
import 'package:stacked_services/stacked_services.dart' show RouterService;

export 'package:stacked_services/stacked_services.dart' show RouterService;
export 'package:nowu/app/app.router.dart';

extension RouterServiceExtension on RouterService {
  Future<void> navigateToExplore([BaseResourceSearchFilter? baseFilter]) {
    return navigateTo(
      TabsViewRoute(
          initialPage: TabPage.Explore, explorePageBaseFilter: baseFilter),
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
