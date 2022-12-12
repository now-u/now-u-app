import 'package:app/locator.dart';
import 'package:app/services/navigation_service.dart';
import 'package:app/viewmodels/explore_page_view_model.dart';
import 'package:app/viewmodels/tabs_view_model.dart';
import 'package:flutter/material.dart';

import 'package:app/assets/icons/customIcons.dart';

import 'package:app/pages/home/Home.dart';
import 'package:app/pages/more/MoreMenu.dart';
import 'package:app/pages/explore/ExplorePage.dart';
import 'package:stacked/stacked.dart';

export 'package:app/viewmodels/tabs_view_model.dart';

class TabPageDetails {
  final Widget widget;
  final IconData icon;
  final String title;

  TabPageDetails(
      {required this.widget, required this.icon, required this.title});
}

class TabsPageArguments {
  final TabPage? initialPage;
  final ExplorePageArguments? explorePageArgs;
  
  TabsPageArguments({this.initialPage, this.explorePageArgs});
}

class TabsPage extends StatelessWidget with WidgetsBindingObserver {
  final TabsPageArguments args;

  TabsPage(this.args);

  @override
  Widget build(BuildContext context) {
    Map<TabPage, TabPageDetails> _pages = {
      TabPage.Home: TabPageDetails(
        widget: Home(),
        icon: CustomIcons.ic_home,
        title: "Home",
      ),
      TabPage.Explore: TabPageDetails(
        widget: ExplorePage(args.explorePageArgs != null ? args.explorePageArgs! : home_explore_page),
        icon: CustomIcons.ic_news,
        title: "Explore",
      ),
      TabPage.Menu: TabPageDetails(
        widget: Profile(),
        icon: CustomIcons.ic_more,
        title: "More",
      )
    };

    List<BottomNavigationBarItem> generateBottomNavBarItems() {
      return _pages.values
          .map((pageDetails) => BottomNavigationBarItem(
              activeIcon: ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Theme.of(context).errorColor,
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor
                  ],
                ).createShader(bounds),
                child: Icon(pageDetails.icon),
              ),
              icon: Icon(pageDetails.icon),
              label: pageDetails.title))
          .toList()
          .cast<BottomNavigationBarItem>();
    }

    return WillPopScope(
        onWillPop: () async => locator<NavigationService>().canGoBack(),
        child: ViewModelBuilder<TabsViewModel>.reactive(
          viewModelBuilder: () => TabsViewModel(args.initialPage),
          builder: (context, model, child) {
            return Scaffold(
              body: _pages[model.currentPage]!.widget,
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: model.currentPage.index,
                type: BottomNavigationBarType.fixed,
                elevation: 3,
                iconSize: 25,
                unselectedLabelStyle: TextStyle(
                    color: Color.fromRGBO(155, 159, 177, 1), fontSize: 10),
                unselectedItemColor: Color.fromRGBO(155, 159, 177, 1),
                selectedItemColor: Theme.of(context).primaryColor,
                selectedIconTheme: IconThemeData(color: Colors.white),
                selectedLabelStyle: TextStyle(fontSize: 12),
                items: generateBottomNavBarItems(),
                onTap: (index) => model.setPage(TabPage.values[index]),
              ),
            );
          },
        )
    );
  }
}
