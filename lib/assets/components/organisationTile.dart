import 'package:flutter/material.dart';

import 'package:app/models/Organisation.dart';

class OrganisationTile extends StatelessWidget {
  final Organisation organisation;
  OrganisationTile(
    this.organisation,
  );
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red,
        ),
        //child: Expanded(
          //padding: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 80,
                child: 
                  Container(child: Image.network(organisation.getLogoLink()),)
              ),
              Text(organisation.getName()),
              Text(organisation.getName()),
            ],
          )
          //child: Column(
          //  mainAxisSize: MainAxisSize.min,
          //  children: <Widget>[
          //    Container(
          //      decoration: BoxDecoration(
          //        image: DecorationImage(
          //          image: NetworkImage(organisation.getLogoLink()),
          //          fit: BoxFit.contain,
          //        )
          //      ),
          //    ),
          //    Container(
          //      width: width ?? 40,
          //      child: Text(organisation.getName()),
          //    )
          //  ],
          //),
        //),
      )
    );
  }
}
