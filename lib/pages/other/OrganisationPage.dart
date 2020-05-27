import 'package:app/assets/StyleFrom.dart';
import 'package:app/assets/components/customAppBar.dart';
import 'package:app/assets/components/sectionTitle.dart';
import 'package:flutter/material.dart';

import 'package:app/models/Organisation.dart';

class OraganisationInfoPage extends StatelessWidget {
  final Organisation organisation;
  OraganisationInfoPage(
    this.organisation,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: "Partner",
        context: context,
      ),
      body: Column(
        children: <Widget>[

          Container(
            height: 120,
            width: double.infinity,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Image.network(organisation.getLogoLink())
              ),
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                child: Text(
                  organisation.getName(),
                  style: textStyleFrom(
                    Theme.of(context).primaryTextTheme.headline5,
                    color: Colors.white,
                  )
                ),
              )
            )
          ),

          // Body
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 10),
              children: <Widget>[
                SizedBox(height: 10),
                SectionTitle(
                  "About",
                ),
                Text(
                  organisation.getDescription(),
                ),
                SizedBox(height: 20),

                SectionTitle(
                  "Find out more",
                ),
                organisation.getWebsite() == null ? Container() :
                Text(
                  organisation.getWebsite(),
                ),
                organisation.getEmail() == null ? Container() :
                Text(
                  organisation.getEmail(),
                ),
                SizedBox(height: 20),
                
              ],
            )
          )
        ],
      ),
    );
  }
}
