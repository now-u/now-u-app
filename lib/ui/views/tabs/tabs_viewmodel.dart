import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../services/analytics.dart';

enum TabPage { Home, Explore, Menu }

class TabsViewModel extends BaseViewModel {
  final _analyticsService = locator<AnalyticsService>();

  TabsViewModel(TabPage? initalPage) {
    if (initalPage != null) {
      this.currentPage = initalPage;
    }
  }

  TabPage currentPage = TabPage.Home;

  void setPage(TabPage newPage) {
    _analyticsService.setCustomRoute('tab_${newPage.name}');
    currentPage = newPage;
    notifyListeners();
  }
}
