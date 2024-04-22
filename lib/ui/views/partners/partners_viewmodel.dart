import 'package:nowu/router.dart';
import 'package:nowu/router.gr.dart';
import 'package:nowu/services/causes_service.dart';

import 'package:nowu/app/app.locator.dart';

import 'package:nowu/models/Organisation.dart';
import 'package:nowu/services/router_service.dart';
import 'package:stacked/stacked.dart';

class PartnersViewModel extends FutureViewModel<Iterable<Organisation>> {
  final _causesService = locator<CausesService>();
  final _router = locator<AppRouter>();

  @override
  Future<Iterable<Organisation>> futureToRun() => _causesService.getPartners();

  // TODO Pick name between organisation and partner
  Future<void> openOrganisationInfo(Organisation organisation) {
    return _router.push(PartnerInfoRoute(organisation: organisation));
  }
}
