import 'package:causeApiClient/causeApiClient.dart';
import 'package:nowu/routes.dart';
import 'package:nowu/viewmodels/base_model.dart';
import "dart:async";
import 'package:nowu/services/navigation_service.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/locator.dart';
import 'package:nowu/services/dialog_service.dart';

class CausesViewModel extends BaseModel {
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final CausesService _causesService = locator<CausesService>();

  Map<Cause, bool> _causes = {};

  List<Cause> get causesList => _causes.keys.toList();
  bool get areCausesDisabled => !_causes.values.toList().any((value) => value);

  Future fetchCauses() async {
    setBusy(true);

    List<Cause> causesList = await _causesService.getCauses();
    _causes = {for (Cause cause in causesList) cause: cause.isSelected};

    setBusy(false);
    notifyListeners();

    print(_causes);
  }

  bool isCauseSelected(Cause cause) {
    return _causes[cause] ?? false;
  }

  void toggleSelection({required Cause listCause}) {
    bool isCauseSelected = _causes[listCause] ?? false;
    _causes[listCause] = !isCauseSelected;
    print("Cause selected");
    print(areCausesDisabled);
    notifyListeners();
  }

  Future getCausePopup(
      {required Cause listCause, required int causeIndex}) async {
    var dialogResult =
        await _dialogService.showDialog(CauseDialog(causesList[causeIndex]));
    if (dialogResult.response) {
      if (_causes[listCause] == false) {
        toggleSelection(listCause: listCause);
      }
    }
  }

  Future<void> selectCauses() async {
    List<Cause> selectedCauses =
        causesList.where((cause) => isCauseSelected(cause)).toList();
    return await _causesService.selectCauses(selectedCauses);
  }
}

class SelectCausesViewModel extends CausesViewModel {
  Future<void> selectCauses() async {
    await super.selectCauses();
    _navigationService.navigateTo(Routes.home, clearHistory: true);
  }
}

class ChangeCausesViewModel extends CausesViewModel {
  Future<void> selectCauses() async {
    await super.selectCauses();
    _navigationService.navigateTo(Routes.home);
  }

  void goToPreviousPage() {
    _navigationService.goBack();
  }
}
