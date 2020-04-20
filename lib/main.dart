import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:app/pages/home/Home.dart';
import 'package:app/pages/profile/Profile.dart';
import 'package:app/pages/campaign/Campaigns.dart';

import 'package:app/assets/components/videoPlayerFlutterSimple.dart';

import 'package:app/models/User.dart';
import 'package:app/models/Campaign.dart';
  

int _currentIndex = 1; 
User _user = User(
      id: 0,
      fullName: "Andrew",
      username: "Andy123",
      age: 21,
      location: "Bristol",
      monthlyDonationLimit: 20.0,
      homeOwner: false,
    );

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: darkBlue
    ),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(App());
}

var campaigns = <Campaign> [
  Campaign(1, "Refugees", "Help with the things", 270, "https://cdn.pixabay.com/photo/2013/04/16/14/23/eritrea-105081_960_720.jpg", false),
  Campaign(2, "Other Thing", "Help with the things", 170, "https://cdn.pixabay.com/photo/2013/04/16/14/23/eritrea-105081_960_720.jpg", false),
  Campaign(3, "Other2", "Help with the things", 320, "https://cdn.pixabay.com/photo/2013/04/16/14/23/eritrea-105081_960_720.jpg", false),

];


// This is a really annoying color thing --> Makes our fav color into material colour
Map<int, Color> darkBlueMap ={50:Color.fromRGBO(36,35,52, .1),100:Color.fromRGBO(36,35,52, .2),200:Color.fromRGBO(36,35,52, .3),300:Color.fromRGBO(36,35,52, .4),400:Color.fromRGBO(36,35,52, .5),500:Color.fromRGBO(36,35,52, .6),600:Color.fromRGBO(36,35,52, .7),700:Color.fromRGBO(36,35,52, .8),800:Color.fromRGBO(36,35,52, .9),900:Color.fromRGBO(36,35,52, 1),};
MaterialColor darkBlue = MaterialColor(0xFF242334, darkBlueMap);

List<Widget> _pages = <Widget>[Campaigns(campaigns), Home(), Profile(_user)];

class App extends StatefulWidget {
  int _currentIndex;
  App({currentIndex}) {
    _currentIndex = currentIndex != null ? currentIndex : 1;
  }
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // This widget is the root of your application.
  @override
  void initState() {
    _currentIndex = widget._currentIndex;
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        fontFamily: 'Raleway',
        primaryTextTheme: TextTheme(
              // Page Header
              title: TextStyle(
                    fontSize: 46, 
                    color: Color.fromRGBO(36, 35, 52, 1),
                    fontWeight: FontWeight.w300,
                  ),  
              subtitle: TextStyle(
                    fontSize: 30, 
                    color: Color.fromRGBO(36, 35, 52, 1),
                    fontWeight: FontWeight.w300,
                  ),  
              
              headline : TextStyle(
                    fontSize: 31,
                    color: Color.fromRGBO(36, 35, 52, 1),
                    fontWeight: FontWeight.w300,
                  ),
              body1: TextStyle(
                    fontSize: 18,
                    color: Color.fromRGBO(36, 35, 52, 1),
                    fontWeight: FontWeight.w300,
                  ),
              body2: TextStyle(
                    fontSize: 22, 
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
              button : TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.w300
                  ),
              display1: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontFamily: 'PeaceSans',
                  ),
              display2: TextStyle(
                    fontSize: 26,
                    color: Color.fromRGBO(36, 35, 52, 1),
                    fontWeight: FontWeight.w300,
                  ),
              display3: TextStyle(
                    fontSize: 20,
                    color: Color.fromRGBO(36, 35, 52, 1),
                    fontWeight: FontWeight.w300,
                  ),
              
            ),
        primarySwatch: darkBlue,
        buttonTheme: ButtonThemeData(
            colorScheme: ColorScheme.fromSwatch(
                backgroundColor: Color.fromRGBO(36, 35, 52, 1),
                ),
              buttonColor: Color.fromRGBO(36, 35, 52, 1), 
              textTheme: ButtonTextTheme.primary
            ),
        primaryColorDark: Color.fromRGBO(36, 35, 52, 1),
        buttonColor: Color.fromRGBO(36, 35, 52, 1),
        textSelectionColor: Colors.white, // Text used on top of 

      ),
      home: Scaffold(
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
          ),
    );
  }
}
