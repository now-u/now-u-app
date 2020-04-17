import 'package:flutter/material.dart';
import 'package:app/pages/home/Home.dart';

void main() => runApp(MyApp());

List<Widget> _pages = <Widget>[Home()];

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  
  int _currentIndex = 0;

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
              
              headline : TextStyle(
                    fontSize: 32, 
                    color: Color.fromRGBO(36, 35, 52, 1),
                    fontWeight: FontWeight.w300,
                  )  
            ),
        primarySwatch: Colors.blue,
        buttonTheme: ButtonThemeData(
               
            ),
        primaryColorDark: Color.fromRGBO(36, 35, 52, 1),
        buttonColor: Color.fromRGBO(36, 35, 52, 1),
        textSelectionColor: Colors.white, // Text used on top of 
      ),
      home: Scaffold(
            body: PageView.builder(
                  itemBuilder: (context, position) => _pages[position],
                  itemCount: _pages.length,
                ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex, 
              type: BottomNavigationBarType.fixed, 
              iconSize: 40,
              unselectedFontSize: 15,
              selectedFontSize: 20,
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
