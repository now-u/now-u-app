import 'package:app/pages/campaign/LearningCentre/LearningCentreAllPage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:app/assets/icons/customIcons.dart';

import 'package:app/models/ViewModel.dart';

import 'package:app/pages/home/Home.dart';
import 'package:app/pages/profile/Profile.dart';
import 'package:app/pages/campaign/CampaignPage.dart';
import 'package:app/pages/news/NewsPage.dart';
import 'package:app/pages/action/ActionPage.dart';


//import 'package:app/assets/dynamicLinks.dart';

// These must be in the corect order
enum TabPage { Home, Actions, Learning, News, Menu }

class TabsPage extends StatefulWidget {
  final TabPage currentPage;
  final dynamic arguments;

  TabsPage({this.currentPage, this.arguments});

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> with WidgetsBindingObserver {
  TabPage currentPage;
  int _subIndex;

  @override
  void initState() {
    print("initing state");
    currentPage = widget.currentPage;
    _subIndex = null;
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    //handleDynamicLinks(
    //  changePage
    //);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      print("Tabs resumed");
      //handleDynamicLinks(
      //  changePage
      //);
    }
  }

  void changePage(TabPage page, {int subIndex}) {
    print("Changing page");
    print(page);
    print(subIndex);
    setState(() {
      currentPage = page;
      _subIndex = subIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    //_currentIndex = widget.currentIndex;
    //print("When drawing tabs view the current index is");
    //print(_currentIndex);
    // TODO add an enum so pages numbers can change
    List<Map> _pages = <Map>[
      {
        'page': Home(changePage),
        'icon': Icon(CustomIcons.ic_home),
        'title': "Home",
      },
      {
        'page': ActionPage(),
        'icon': Icon(CustomIcons.ic_actions),
        'title': "Actions",
      },
      {
        'page': LearningCentreAllPage(),
        'icon': Icon(CustomIcons.ic_learning),
        'title': "Learning",
      },
      {
        'page': NewsPage(),
        'icon': Icon(CustomIcons.ic_news),
        'title': "News",
      },
      {
        'page': Profile(currentPage: _subIndex, changeTabPage: changePage),
        'icon': Icon(CustomIcons.ic_more),
        'title': "More",
      },
    ];
    List<BottomNavigationBarItem> generateBottomNavBarItems() {
      List<BottomNavigationBarItem> items = [];
      for (int i = 0; i < _pages.length; i++) {
        print("Doing thing" + i.toString());
        items.add(new BottomNavigationBarItem(
          activeIcon: ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: <Color>[
                    Theme.of(context).errorColor,
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor,
                  ]).createShader(bounds);
            },
            child: _pages[i]['icon'],
          ),
          icon: _pages[i]['icon'],
          title: Text(
            _pages[i]['title'],
          ),
        ));
      }
      return items;
    }

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: _pages[currentPage.index]['page'],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentPage.index,
            type: BottomNavigationBarType.fixed,
            elevation: 3,
            iconSize: 25,
            unselectedLabelStyle: TextStyle(color: Color.fromRGBO(155,159,177,1), fontSize: 10),
            selectedLabelStyle: TextStyle(color: Colors.red, fontSize: 12),
            //selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Color.fromRGBO(155,159,177,1),
            items: generateBottomNavBarItems(),
            onTap: (index) {
              setState(() {
                currentPage = TabPage.values[index];
                _subIndex = null;
              });
            },
          ),
        ));
  }
}
