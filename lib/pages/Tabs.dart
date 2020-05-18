import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:app/models/ViewModel.dart';

import 'package:app/pages/home/Home.dart';
import 'package:app/pages/profile/Profile.dart';
import 'package:app/pages/campaign/CampaignPage.dart';
import 'package:app/pages/news/NewsPage.dart';
import 'package:app/pages/action/ActionPage.dart';

import 'package:app/assets/dynamicLinks.dart';

enum TabPage {
  Campaigns,
  Actions,
  Home,
  News,
  Menu
}

class TabsPage extends StatefulWidget {

  final TabPage currentPage;

  TabsPage({this.currentPage});

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
    handleDynamicLinks(
      changePage
    );
  }
  
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.resumed){
      print("Tabs resumed");
      handleDynamicLinks(
        changePage
      );
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
      'page': CampaignPage(false, campaignId: _subIndex), 
      'icon': Icon(Icons.check),
      'title': Text("Campaigns"),
    },
    {
      'page': ActionPage(), 
      'icon': Icon(Icons.check),
      'title': Text("Actions"),
    },
    {
      'page': Home(changePage), 
      'icon': Icon(Icons.home),
      'title': Text("Home"),
    },
    {
      'page': NewsPage(), 
      'icon': Icon(FontAwesomeIcons.newspaper),
      'title': Text("News"),
    },
    {
      'page': Profile(currentPage: _subIndex,),
      'icon': Icon(Icons.menu),
      'title': Text("Profile"),
    },
  ];
  List <BottomNavigationBarItem> generateBottomNavBarItems() {
    List<BottomNavigationBarItem> items = [];
    for (int i = 0; i < _pages.length; i++) {
     print("Doing thing" + i.toString());
     items.add(
      new BottomNavigationBarItem(
        icon: _pages[i]['icon'],
        title: _pages[i]['title'],
      )
     );
    }
    return items;
  }
    return  
          Scaffold(
              body: _pages[currentPage.index]['page'],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: currentPage.index, 
                type: BottomNavigationBarType.fixed, 
                iconSize: 25,
                unselectedFontSize: 13,
                selectedFontSize: 15,
                items: generateBottomNavBarItems(),
                //[
                //  BottomNavigationBarItem(
                //      icon: Icon(Icons.check),
                //      title: Text("Campaings"),
                //  ),
                //  BottomNavigationBarItem(
                //      icon: Icon(Icons.home),
                //      title: Text("Home"),
                //  ),
                //  BottomNavigationBarItem(
                //      icon: Icon(Icons.menu),
                //      title: Text("Profile"),
                //  ),
                //],
                onTap: (index) {
                  setState(() {
                    currentPage = TabPage.values[index]; 
                    _subIndex = null;
                  }); 
                },
              ),
            );
  }
}
