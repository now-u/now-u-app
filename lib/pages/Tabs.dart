import 'package:flutter/material.dart';

import 'package:app/models/ViewModel.dart';

import 'package:app/pages/home/Home.dart';
import 'package:app/pages/profile/Profile.dart';
import 'package:app/pages/campaign/CampaignPage.dart';

import 'package:app/assets/dynamicLinks.dart';

class TabsPage extends StatefulWidget {

  ViewModel model;
  int currentIndex;

  TabsPage(this.model, {currentIndex}){
    print("In constructor");
    print(currentIndex);
    this.currentIndex = currentIndex ?? 0;
  }

  @override
  _TabsPageState createState() => _TabsPageState();
}


class _TabsPageState extends State<TabsPage> with WidgetsBindingObserver {

  int _currentIndex;
  int _subIndex;

  @override
  void initState() {
    print("initing state");
    _currentIndex = widget.currentIndex;
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

  void changePage(int index, {int subIndex}) {
    print("Changing page");
    print(index);
    print(subIndex);
    setState(() {
      _currentIndex = index;
      _subIndex = subIndex;
    }); 
  }


  @override
  Widget build(BuildContext context) {
  //_currentIndex = widget.currentIndex;
  //print("When drawing tabs view the current index is");
  //print(_currentIndex);
  List<Map> _pages = <Map>[
    {
      'page': CampaignPage(widget.model, false, campaignId: _subIndex), 
      'icon': Icon(Icons.check),
      'title': Text("Campaigns"),
    },
    {
      'page': CampaignPage(widget.model, false, campaignId: _subIndex), 
      'icon': Icon(Icons.check),
      'title': Text("Actions"),
    },
    {
      'page': Home(widget.model, changePage), 
      'icon': Icon(Icons.home),
      'title': Text("Home"),
    },
    {
      'page': Profile(widget.model, currentPage: _subIndex,),
      'icon': Icon(Icons.menu),
      'title': Text("News"),
    },
    {
      'page': Profile(widget.model, currentPage: _subIndex,),
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
              body: _pages[_currentIndex]['page'],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: _currentIndex, 
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
                    _currentIndex = index; 
                    _subIndex = null;
                  }); 
                },
              ),
            );
  }
}
