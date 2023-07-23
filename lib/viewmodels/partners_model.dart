import 'package:nowu/services/causes_service.dart';
import 'package:nowu/viewmodels/base_model.dart';

import 'package:nowu/locator.dart';

import 'package:nowu/models/Organisation.dart';

class PartnersViewModel extends BaseModel {
  final CausesService _causesService = locator<CausesService>();
  List<Organisation> _parterns = [];
  List<Organisation> get parterns => _parterns;

  void fetchPartners() async {
    setBusy(true);
    _parterns = await _causesService.getPartners();
    setBusy(false);
    notifyListeners();
  }
}
