import 'package:flutter/material.dart';
import 'package:nowu/assets/components/customAppBar.dart';
import 'package:nowu/assets/components/custom_network_image.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nowu/router.gr.dart';
import 'package:nowu/services/causes_service.dart';

import './bloc/partners_bloc.dart';
import './bloc/partners_event.dart';
import './bloc/partners_state.dart';

@RoutePage()
class PartnersView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO Handle error -> viewModel.hasError -> do something
    return Scaffold(
      appBar: customAppBar(
        text: 'Collaborations',
        context: context,
        backButtonText: 'Menu',
      ),
      body: BlocProvider(
        create: (_) => PartnersBloc(causesService: CausesService())
          ..add(PartnersFetched()),
        child:
            BlocBuilder<PartnersBloc, PartnersState>(builder: (context, state) {
          switch (state) {
            case PartnersStateFailure():
              return const Center(
                  child: Text('Failed to fetch collaborations'),);
            case PartnersStateInitial():
              return const Center(child: CircularProgressIndicator());
            case PartnersStateSuccess():
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.85,
                ),
                itemCount: state.partners.length,
                itemBuilder: (BuildContext context, int index) {
                  final organisation = state.partners.elementAt(index);
                  return Container(
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: _OrganisationTile(
                        organisation: organisation,
                        onTap: () => context.router
                            .push(PartnerInfoRoute(organisation: organisation)),
                      ),
                    ),
                  );
                },
              );
          }
        }),
      ),
    );
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
