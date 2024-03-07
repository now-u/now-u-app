import 'package:nowu/app/app.locator.dart';
import 'package:nowu/models/Organisation.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/router_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PartnersViewModel extends FutureViewModel<Iterable<Organisation>> {
  final _causesService = locator<CausesService>();
  final _routerService = locator<NavigationService>();

  @override
  Future<Iterable<Organisation>> futureToRun() => _causesService.getPartners();

  // TODO Pick name between organisation and partner
  Future<void> openOrganisationInfo(Organisation organisation) {
    return _routerService.navigateToPartnerInfoView(organisation: organisation);
  }
}
