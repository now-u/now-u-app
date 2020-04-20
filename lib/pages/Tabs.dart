import 'package:flutter/material.dart';

import 'package:app/models/ViewModel.dart';

import 'package:app/pages/home/Home.dart';
import 'package:app/pages/profile/Profile.dart';
import 'package:app/pages/campaign/Campaigns.dart';

class TabsPage extends StatefulWidget {

  final ViewModel model;
  int currentIndex;

  TabsPage(this.model, {currentIndex}){
    this.currentIndex =  currentIndex == null ? 1 : currentIndex;
  }

  @override
  _TabsPageState createState() => _TabsPageState();
}


class _TabsPageState extends State<TabsPage> {

  int _currentIndex;

  @override
  void initState() {
    _currentIndex = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
  List<Widget> _pages = <Widget>[Campaigns(widget.model, false), Home(widget.model), Profile(widget.model)];
    return  
          Scaffold(
              body: _pages[_currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: _currentIndex, 
                type: BottomNavigationBarType.fixed, 
                iconSize: 35,
                unselectedFontSize: 15,
                selectedFontSize: 18,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.check),
                      title: Text("Campaings"),
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      title: Text("Home"),
                  ),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.menu),
                      title: Text("Profile"),
                  ),
                ],
                onTap: (index) {
                  setState(() {
                    _currentIndex = index; 
                  }); 
                },
              ),
            );
  }
}
