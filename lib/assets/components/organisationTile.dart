import 'package:nowu/assets/StyleFrom.dart';
import 'package:flutter/material.dart';

import 'package:nowu/models/Organisation.dart';

import 'package:nowu/assets/components/custom_network_image.dart';

import 'package:nowu/routes.dart';

class OrganisationTile extends StatelessWidget {
  final Organisation organisation;
  final Function? extraOnTap;
  OrganisationTile(this.organisation, {this.extraOnTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (extraOnTap != null) {
            extraOnTap!();
          }
          Navigator.of(context)
              .pushNamed(Routes.organisationPage, arguments: organisation);
        },
        child: Container(
          width: 100,
          //height: 60,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.16),
                    offset: Offset(0, 3),
                    blurRadius: 6)
              ]),
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                      //height: 80, width: 100,
                      //width: 20,
                      child: CustomNetworkImage(
                    organisation.getLogoLink(),
                    fit: BoxFit.contain,
                  )),
                  SizedBox(
                    height: 10,
                  ),
                  Text(organisation.getName()!,
                      style: textStyleFrom(
                        Theme.of(context).primaryTextTheme.bodyText1,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center)
                ],
              )),
        ));
  }
}
