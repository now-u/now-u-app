import 'package:app/routes.dart';
import 'package:app/viewmodels/base_model.dart';
import 'package:app/models/Cause.dart';
import "dart:async";
import 'package:app/services/navigation_service.dart';
import 'package:app/services/causes_service.dart';
import 'package:app/locator.dart';
import 'package:app/services/dialog_service.dart';

class CausesViewModel extends BaseModel {
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final CausesService _causesService = locator<CausesService>();

  Map<ListCause, bool> _causes = {};

  List<ListCause> get causesList => _causes.keys.toList();
  bool get areAllCausesStillDisabled =>
      !_causes.values.toList().any((value) => value);

  Future fetchCauses() async {
    setBusy(true);

    List<ListCause> causesList = await _causesService.getCauses();
    _causes = {for (ListCause cause in causesList) cause: cause.selected};

    setBusy(false);
    notifyListeners();
  }

  bool isCauseSelected(ListCause cause) {
    return _causes[cause] ?? false;
  }

  void toggleSelection({required ListCause listCause}) {
    bool isCauseSelected = _causes[listCause] ?? false;
    _causes[listCause] = !isCauseSelected;
    notifyListeners();
  }

  void selectCauses() async {
    List<ListCause> selectedCauses =
        causesList.where((cause) => isCauseSelected(cause)).toList();
    _causesService.selectCauses(selectedCauses);
  }

  void goToLogin() {
    _navigationService.navigateTo(Routes.login);
  }

  void goHome() {
    _navigationService.navigateTo(Routes.home);
  }

  Future getCausePopup(
      {required ListCause listCause, required int causeIndex}) async {
    var dialogResult =
        await _dialogService.showDialog(CauseDialog(causesList[causeIndex]));
    if (dialogResult.response) {
      if (_causes[listCause] == false) {
        toggleSelection(listCause: listCause);
      }
    }
  }
}
