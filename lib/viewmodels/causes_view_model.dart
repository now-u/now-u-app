import 'package:app/assets/icons/my_flutter_app_icons_old.dart';
import 'package:app/routes.dart';
import 'package:app/viewmodels/base_model.dart';
import 'package:app/models/Cause.dart';
import "dart:async";
import 'package:app/services/navigation_service.dart';
import 'package:app/services/causes_service.dart';
import 'package:app/locator.dart';
import 'package:app/services/dialog_service.dart';
import 'package:http/http.dart';

class CausesViewModel extends BaseModel {
  final DialogService _dialogService = locator<DialogService>();

  List<ListCause> _causesList = [];
  List<ListCause> get causesList => _causesList;

  List<bool> _causesSelectedList = [false, false, false, false, false, false];

  List<bool> get causesSelectedList => _causesSelectedList;
  bool get isButtonDisabled => !_causesSelectedList.any((element) => element);

  final NavigationService _navigationService = locator<NavigationService>();
  final CausesService _causesService = locator<CausesService>();

  Future fetchCauses() async {
    setBusy(true);
    _causesList = await _causesService.getCauses();
    setBusy(false);
  }

  void toggleSelection({required int causeIndex}) {
    _causesSelectedList[causeIndex] = !_causesSelectedList[causeIndex];
    notifyListeners();
  }

  void getStarted() async {
    // TODO register selection
    _causesService.joinCauses(selectedCauses);
    _navigationService.navigateTo(Routes.login);
  }

  Future getCausePopup({required int causeIndex}) async {
    var dialogResult = await _dialogService.showDialog(
      CauseDialog(causesList[causeIndex])
    );
    if (dialogResult.response) {
      if (_causesSelectedList[causeIndex] == false) {
        toggleSelection(causeIndex: causeIndex);
      }
    }
  }
}
