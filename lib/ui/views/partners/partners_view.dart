import 'package:flutter/material.dart';
import 'package:nowu/assets/components/customAppBar.dart';
import 'package:nowu/assets/components/custom_network_image.dart';
import 'package:nowu/models/Organisation.dart';
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
        text: 'Collaborations',
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
                final organisation = viewModel.data!.elementAt(index);
                return Container(
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: _OrganisationTile(
                      organisation: organisation,
                      onTap: () => viewModel.openOrganisationInfo(organisation),
                    ),
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

class _OrganisationTile extends StatelessWidget {
  final Organisation organisation;
  final VoidCallback onTap;

  const _OrganisationTile({required this.organisation, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        //height: 60,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.16),
              offset: Offset(0, 3),
              blurRadius: 6,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                //height: 80, width: 100,
                //width: 20,
                child: CustomNetworkImage(
                  organisation.logo.url,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                organisation.name,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 12,
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
