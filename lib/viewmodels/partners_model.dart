import 'package:app/viewmodels/base_model.dart';

import 'package:app/locator.dart';
import 'package:app/services/organisation_service.dart';

import 'package:app/models/Organisation.dart';

class PartnersViewModel extends BaseModel {
  final OrganisationService _organisationService = locator<OrganisationService>();
  List<Organisation> _parterns = [];
  List<Organisation> get parterns => _parterns;

  void fetchPartners() async {
    setBusy(true);
    _parterns = await _organisationService.getPartners();
    setBusy(false);
    notifyListeners();
  }
}
