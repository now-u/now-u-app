import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:app/pages/home/HomeTile.dart';
import 'package:app/assets/components/pageTitle.dart';

import 'package:app/models/Campaign.dart';

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
  return Text(t, style: Theme.of(context).primaryTextTheme.headline, textAlign: TextAlign.start,);
}

class _ActionTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      },
      child: Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 5, 10),
          child: 
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  ListView.builder(
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        return Text("Testeroo");
                      },
                  ),
                  Transform.rotate(
                    angle: 180 * math.pi / 180,
                    child: Icon(Icons.chevron_left, size: 25), 
                  ),
                ],
                  
              ),
            ],   
          ),
      )
    );
  }
}
