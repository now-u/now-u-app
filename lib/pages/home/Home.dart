import 'package:flutter/material.dart';
import 'package:app/pages/home/HomeTile.dart';
import 'package:app/assets/components/pageTitle.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
              color: Colors.white,
              child: Column(
                  children: <Widget>[
                    PageTitle("Home"),
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
    );
  }
}

Text sectionTitle(String t, BuildContext context) {
  return Text(t, style: Theme.of(context).primaryTextTheme.headline);
}
