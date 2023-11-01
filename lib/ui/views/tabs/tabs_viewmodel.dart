import 'package:stacked/stacked.dart';

enum TabPage { Home, Explore, Menu }

class TabsViewModel extends BaseViewModel {
  TabsViewModel(TabPage? initalPage) {
    if (initalPage != null) {
      this.currentPage = initalPage;
    }
  }

  TabPage currentPage = TabPage.Home;

  void setPage(TabPage newPage) {
    currentPage = newPage;
    notifyListeners();
  }
}
