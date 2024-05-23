import 'package:flutter/material.dart';
import 'package:nowu/assets/icons/customIcons.dart';
import 'package:nowu/router.gr.dart';
import 'package:nowu/ui/views/explore/explore_page_viewmodel.dart';
import 'package:auto_route/auto_route.dart';

enum TabPage { Home, Explore, Menu }

class TabPageDetails {
  final PageRouteInfo route;
  final IconData icon;
  final String title;

  TabPageDetails({
    required this.route,
    required this.icon,
    required this.title,
  });
}

@RoutePage()
class TabsView extends StatelessWidget with WidgetsBindingObserver {
  final TabPage? initialPage;
  final ExplorePageFilterData? exploreFilterData;

  TabsView({this.initialPage, this.exploreFilterData});

  List<TabPageDetails> getTabs() {
    return [
      TabPageDetails(
        route: const HomeRoute(),
        icon: CustomIcons.ic_home,
        title: 'Home',
      ),
      TabPageDetails(
        route: ExploreRoute(filterData: exploreFilterData),
        icon: CustomIcons.ic_news,
        title: 'Explore',
      ),
      TabPageDetails(
        route: const MoreRoute(),
        icon: CustomIcons.ic_more,
        title: 'More',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final tabs = getTabs();
    return AutoTabsScaffold(
      // body: getPageDetails(model.currentPage).widget,
      routes: tabs.map((tab) => tab.route).toList(),
      bottomNavigationBuilder: (_, tabRouter) => BottomNavigationBar(
        currentIndex: tabRouter.activeIndex,
        onTap: tabRouter.setActiveIndex,
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
        items: tabs
            .map(
              (tab) => BottomNavigationBarItem(
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
                  child: Icon(tab.icon),
                ),
                icon: Icon(tab.icon),
                label: tab.title,
              ),
            )
            .toList(),
      ),
    );
  }
}
