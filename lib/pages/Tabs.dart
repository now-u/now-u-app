import 'package:flutter/material.dart';

import 'package:app/assets/icons/customIcons.dart';

import 'package:app/pages/home/Home.dart';
import 'package:app/pages/more/MoreMenu.dart';
import 'package:app/pages/explore/ExplorePage.dart';
import 'package:flutter/rendering.dart';

//import 'package:app/assets/dynamicLinks.dart';

// These must be in the corect order
enum TabPage { Home, Explore, Impact, Menu }

class TabsPage extends StatefulWidget {
  final TabPage? currentPage;
  final dynamic arguments;

  TabsPage({this.currentPage, this.arguments});

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> with WidgetsBindingObserver {
  TabPage? currentPage;

  @override
  void initState() {
    currentPage = widget.currentPage;
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  void changePage(TabPage page, {int? subIndex}) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO add an enum so pages numbers can change
    List<Map> _pages = <Map>[
      {
        'page': Home(),
        'icon': Icon(CustomIcons.ic_home),
        'title': "Home",
      },
      {
        'page': home_explore_page,
        'icon': Icon(CustomIcons.ic_news),
        'title': "Explore",
      },
      {
        'page': Container(
          child: Center(child: Text("Coming soon")),
        ),
        'icon': Icon(CustomIcons.ic_up),
        'title': "Impact",
      },
      {
        'page': Profile(),
        'icon': Icon(CustomIcons.ic_more),
        'title': "More",
      },
    ];
    List<BottomNavigationBarItem> generateBottomNavBarItems() {
      List<BottomNavigationBarItem> items = [];
      for (int i = 0; i < _pages.length; i++) {
        items.add(new BottomNavigationBarItem(
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
              child: _pages[i]['icon'],
            ),
            // ShaderMask(
            //   shaderCallback: (Rect bounds) {
            //     return LinearGradient(
            //         begin: Alignment.bottomLeft,
            //         end: Alignment.topRight,
            //         colors: <Color>[
            //           Theme.of(context).errorColor,
            //           Theme.of(context).primaryColor,
            //           Theme.of(context).primaryColor,
            //         ]).createShader(bounds);
            //   },
            //   child: _pages[i]['icon'],
            // ),
            icon: _pages[i]['icon'],
            label: _pages[i]['title']));
      }
      return items;
    }

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: _pages[currentPage!.index]['page'],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentPage!.index,
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
