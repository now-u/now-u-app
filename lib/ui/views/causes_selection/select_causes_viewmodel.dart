import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/app/app.locator.dart';
import 'package:nowu/services/dialog_service.dart';
import 'package:nowu/services/router_service.dart';
import 'package:stacked/stacked.dart';

export 'package:nowu/services/router_service.dart';

// TODO Maybe to future view model here? Maybe it need smultiple or idk something
abstract class SelectCausesViewModel extends BaseViewModel implements Initialisable {
  final DialogService _dialogService = locator<DialogService>();
  final CausesService _causesService = locator<CausesService>();

  late Map<Cause, bool> causesData;

  void initialise() {
    causesData = {
      for (Cause cause in _causesService.causes) cause: cause.isSelected
    };
  }

  @protected
  final RouterService routerService = locator<RouterService>();

  List<Cause> get causesList => causesData.keys.toList();
  bool get areCausesDisabled =>
      !causesData.values.toList().any((value) => value);

  bool isCauseSelected(Cause cause) {
    return causesData[cause] ?? false;
  }

  void toggleSelection({required Cause listCause}) {
    bool isCauseSelected = causesData[listCause] ?? false;
    causesData[listCause] = !isCauseSelected;
    notifyListeners();
  }

  Future getCausePopup({
    required Cause listCause,
    required int causeIndex,
  }) async {
    var dialogResult =
        await _dialogService.showCauseDialog(cause: causesList[causeIndex]);
    if (dialogResult) {
      if (causesData[listCause] == false) {
        toggleSelection(listCause: listCause);
      }
    }
  }

  Future<void> selectCauses() async {
    List<Cause> selectedCauses =
        causesList.where((cause) => isCauseSelected(cause)).toList();
    await _causesService.selectCauses(selectedCauses);
    navigateAfterCausesSelection();
  }

  Future<void> navigateAfterCausesSelection();
}
