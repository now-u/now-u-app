import 'package:nowu/viewmodels/base_model.dart';

import 'package:nowu/locator.dart';
import 'package:nowu/services/organisation_service.dart';

import 'package:nowu/models/Organisation.dart';

class PartnersViewModel extends BaseModel {
  final OrganisationService? _organisationService =
      locator<OrganisationService>();
  List<Organisation>? _parterns = [];
  List<Organisation>? get parterns => _parterns;

  void fetchPartners() async {
    setBusy(true);
    _parterns = await _organisationService!.getPartners();
    setBusy(false);
    notifyListeners();
  }
}
