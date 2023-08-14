import 'package:flutter/material.dart';

import 'package:nowu/assets/components/customAppBar.dart';
import 'package:nowu/assets/components/organisationTile.dart';

import 'package:stacked/stacked.dart';

import 'partners_viewmodel.dart';

// TODO Test this works
class PartnersView extends StackedView<PartnersViewModel> {
  @override
  Widget builder(
    BuildContext context,
    PartnersViewModel viewModel,
    Widget? child,
  ) {
    // TODO Handle error -> viewModel.hasError -> do something
    return Scaffold(
      appBar: customAppBar(
        text: 'Partners',
        context: context,
        backButtonText: 'Menu',
      ),
      body: !viewModel.dataReady
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.85,
              ),
              itemCount: viewModel.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: OrganisationTile(viewModel.data!.elementAt(index)),
                  ),
                );
              },
            ),
    );
  }

  @override
  PartnersViewModel viewModelBuilder(BuildContext context) {
    return PartnersViewModel();
  }
}
