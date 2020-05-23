import 'package:flutter/material.dart';

import 'package:app/assets/components/customAppBar.dart';
import 'package:app/assets/components/organisationTile.dart';

import 'package:app/services/api.dart';
import 'package:app/locator.dart';

class PartnersPage extends StatelessWidget {
  final api = locator<Api>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: "Partners",
        context: context,
        backButtonText: "Menu",
      ),
      body: FutureBuilder(
        future: api.getPartners(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.85,
              ),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 200,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: OrganisationTile(snapshot.data[index]),
                  )
                );
              },
            );
          }
          else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

