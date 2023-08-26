import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/app/app.locator.dart';
import 'package:nowu/services/dialog_service.dart';
import 'package:nowu/services/router_service.dart';
import 'package:stacked/stacked.dart';

export 'package:nowu/services/router_service.dart';

// TODO Maybe to future view model here? Maybe it need smultiple or idk something
abstract class SelectCausesViewModel extends FutureViewModel<Map<Cause, bool>> {
  final DialogService _dialogService = locator<DialogService>();
  final CausesService _causesService = locator<CausesService>();

  @protected
  final RouterService routerService = locator<RouterService>();

  List<Cause> get causesList => data!.keys.toList();
  bool get areCausesDisabled =>
      data == null ? true : !data!.values.toList().any((value) => value);

  @override
  Future<Map<Cause, bool>> futureToRun() async {
    List<Cause> causesList = await _causesService.getCauses();
    return {for (Cause cause in causesList) cause: cause.isSelected};
  }

  bool isCauseSelected(Cause cause) {
    return data![cause] ?? false;
  }

  void toggleSelection({required Cause listCause}) {
    bool isCauseSelected = data![listCause] ?? false;
    data![listCause] = !isCauseSelected;
    print('Cause selected');
    print(areCausesDisabled);
    notifyListeners();
  }

  Future getCausePopup({
    required Cause listCause,
    required int causeIndex,
  }) async {
    var dialogResult =
        await _dialogService.showCauseDialog(cause: causesList[causeIndex]);
    if (dialogResult) {
      if (data![listCause] == false) {
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
