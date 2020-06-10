import 'package:flutter/material.dart';

import 'package:app/models/Organisation.dart';
import 'package:app/pages/other/OrganisationPage.dart';

import 'package:app/assets/routes/customRoute.dart';

class OrganisationTile extends StatelessWidget {
  final Organisation organisation;
  final Function extraOnTap;
  OrganisationTile(
    this.organisation,
    {this.extraOnTap}
  );
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (extraOnTap != null) {
          extraOnTap();
        }
        Navigator.push(
          context, 
          CustomRoute(builder: (context) => OraganisationInfoPage(organisation))
        );
      },
      child: Container(
        width: 100,
        //height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0,0,0,0.16),
              offset: Offset(0,3),
              blurRadius: 6
            )
          ]
        ),
        child: 
        Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                //height: 80, width: 100,
                  //width: 20,
                  height: 55,
                  child: Image.network(
                    organisation.getLogoLink(),
                    fit: BoxFit.contain,
                )
              ),
              SizedBox(height: 10,),
              Text(
                organisation.getName(),
                style: Theme.of(context).primaryTextTheme.bodyText1,
                maxLines: 2,
                textAlign: TextAlign.center
              )
            ],
          )
        ),
      )
   );

  }
}
