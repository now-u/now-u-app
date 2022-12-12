import 'package:app/viewmodels/base_model.dart';

enum TabPage { Home, Explore, Menu }

class TabsViewModel extends BaseModel {
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
