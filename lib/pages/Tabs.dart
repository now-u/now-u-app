import 'package:flutter/material.dart';

import 'package:app/assets/icons/customIcons.dart';

import 'package:app/pages/home/Home.dart';
import 'package:app/pages/more/MoreMenu.dart';
import 'package:app/pages/explore/ExplorePage.dart';

//import 'package:app/assets/dynamicLinks.dart';

// These must be in the corect order
enum TabPage { Home, Explore, Menu }

class TabPageDetails {
  final Widget widget;
  final IconData icon;
  final String title;

  TabPageDetails(
      {required this.widget, required this.icon, required this.title});
}

class TabsPage extends StatefulWidget {
  final TabPage currentPage;
  final dynamic arguments;

  TabsPage({required this.currentPage, this.arguments});

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> with WidgetsBindingObserver {
  late TabPage currentPage;

  @override
  void initState() {
    currentPage = widget.currentPage;
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void changePage(TabPage page, {int? subIndex}) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<TabPage, TabPageDetails> _pages = {
      TabPage.Home: TabPageDetails(
        widget: Home(),
        icon: CustomIcons.ic_home,
        title: "Home",
      ),
      TabPage.Explore: TabPageDetails(
        widget: home_explore_page,
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
        onWillPop: () async => false,
        child: Scaffold(
          body: _pages[currentPage]!.widget,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentPage.index,
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
            onTap: (index) {
              setState(() {
                currentPage = TabPage.values[index];
              });
            },
          ),
        ));
  }
}
