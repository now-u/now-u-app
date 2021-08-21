import 'package:app/routes.dart';
import 'package:app/viewmodels/base_model.dart';
import 'package:app/models/Cause.dart';
import "dart:async";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app/services/navigation_service.dart';
import 'package:app/locator.dart';

class CausesViewModel extends BaseModel {
  List<Cause> _causesList;
  List<Cause> get causesList => _causesList;

  final NavigationService _navigationService = locator<NavigationService>();

  Future fetchCauses() async {
    await Future.delayed(const Duration(seconds: 5));
    _causesList = [
      Cause(name: 'Environment'),
      Cause(name: 'Health & Wellbeing')
    ];
    notifyListeners();
  }

  void goHome() async {
    _navigationService.navigateTo(Routes.home);
  }
}
