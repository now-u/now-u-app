import 'package:flutter/material.dart';
import 'package:app/assets/components/customBottomNavBar.dart';
import 'package:app/pages/home/HomeTile.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
              color: Colors.white,
              child: Column(
                  children: <Widget>[
                    SafeArea(
                          child: Padding(
                                padding: EdgeInsets.all(20),
                                child: 
                                  Text("Home", style: Theme.of(context).primaryTextTheme.title), 
                              )
                          
                        ),
                    HomeTile(
                        Container(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    sectionTitle("Actions", context),
                                  ],
                                  )
                            ),
                    ), 
                    HomeTile(
                        Container(
                              child: Column(
                                  children: <Widget>[
                                    sectionTitle("Actions", context),
                                  ],
                                  )
                            ),
                    ), 
                  ],
                  
                  )
            ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}

Text sectionTitle(String t, BuildContext context) {
  return Text(t, style: Theme.of(context).primaryTextTheme.headline);
}
