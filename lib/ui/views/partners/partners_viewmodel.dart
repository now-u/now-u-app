import 'package:nowu/services/causes_service.dart';

import 'package:nowu/app/app.locator.dart';

import 'package:nowu/models/Organisation.dart';
import 'package:stacked/stacked.dart';

class PartnersViewModel extends FutureViewModel<Iterable<Organisation>> {
  final CausesService _causesService = locator<CausesService>();

  @override
  Future<Iterable<Organisation>> futureToRun() => _causesService.getPartners();
}
