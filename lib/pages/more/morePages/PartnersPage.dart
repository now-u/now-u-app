import 'package:flutter/material.dart';

import 'package:app/assets/components/customAppBar.dart';
import 'package:app/assets/components/organisationTile.dart';

import 'package:stacked/stacked.dart';
import 'package:app/viewmodels/partners_model.dart';

class PartnersPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        text: "Partners",
        context: context,
        backButtonText: "Menu",
      ),
      body: ViewModelBuilder<PartnersViewModel>.reactive(
          viewModelBuilder: () => PartnersViewModel(),
          onModelReady: (model) => model.fetchPartners(),
          builder: (context, model, child) {
            return GridView.builder(
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.85,
              ),
              itemCount: model.parterns.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 200,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: OrganisationTile(model.parterns[index]),
                  )
                );
              },
            );
          }
      ),
    );
  }
}

