import 'package:flutter/material.dart';
import 'package:nowu/app/app.locator.dart';
import 'package:nowu/assets/icons/customIcons.dart';
import 'package:nowu/services/navigation_service.dart';
import 'package:nowu/ui/views/explore/explore_page_view.dart';
import 'package:nowu/ui/views/explore/explore_page_viewmodel.dart';
import 'package:nowu/ui/views/home/home_view.dart';
import 'package:nowu/ui/views/more/more_view.dart';
import 'package:stacked/stacked.dart';

import 'tabs_viewmodel.dart';

export 'tabs_viewmodel.dart' show TabPage;

class TabPageDetails {
  final Widget widget;
  final IconData icon;
  final String title;

  TabPageDetails({
    required this.widget,
    required this.icon,
    required this.title,
  });
}

class TabsView extends StatelessWidget with WidgetsBindingObserver {
  final TabPage? initialPage;
  final ExplorePageFilterData? exploreFilterData;

  TabsView({this.initialPage, this.exploreFilterData});

  @override
  Widget build(BuildContext context) {
    TabPageDetails getPageDetails(TabPage page) {
      switch (page) {
        case TabPage.Home:
          return TabPageDetails(
            widget: HomeView(),
            icon: CustomIcons.ic_home,
            title: 'Home',
          );

        case TabPage.Explore:
          return TabPageDetails(
            // TODO Does the filter go in here?
            widget: ExplorePage(filterData: exploreFilterData),
            icon: CustomIcons.ic_news,
            title: 'Explore',
          );
        case TabPage.Menu:
          return TabPageDetails(
            widget: MoreView(),
            icon: CustomIcons.ic_more,
            title: 'More',
          );
      }
    }

    List<BottomNavigationBarItem> generateBottomNavBarItems() {
      return TabPage.values
          .map(getPageDetails)
          .map(
            (pageDetails) => BottomNavigationBarItem(
              activeIcon: ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Theme.of(context).colorScheme.error,
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor,
                  ],
                ).createShader(bounds),
                child: Icon(pageDetails.icon),
              ),
              icon: Icon(pageDetails.icon),
              label: pageDetails.title,
            ),
          )
          .toList()
          .cast<BottomNavigationBarItem>();
    }

    return PopScope(
      canPop: locator<LauncherService>().canGoBack(),
      child: ViewModelBuilder<TabsViewModel>.reactive(
        viewModelBuilder: () => TabsViewModel(initialPage),
        builder: (context, model, child) {
          return Scaffold(
            body: getPageDetails(model.currentPage).widget,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: model.currentPage.index,
              type: BottomNavigationBarType.fixed,
              elevation: 3,
              iconSize: 25,
              unselectedLabelStyle: const TextStyle(
                color: Color.fromRGBO(155, 159, 177, 1),
                fontSize: 10,
              ),
              unselectedItemColor: const Color.fromRGBO(155, 159, 177, 1),
              selectedItemColor: Theme.of(context).primaryColor,
              selectedIconTheme: const IconThemeData(color: Colors.white),
              selectedLabelStyle: const TextStyle(fontSize: 12),
              items: generateBottomNavBarItems(),
              onTap: (index) => model.setPage(TabPage.values[index]),
            ),
          );
        },
      ),
    );
  }
}
