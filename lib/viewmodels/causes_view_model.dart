import 'package:app/routes.dart';
import 'package:app/viewmodels/base_model.dart';
import 'package:app/models/Cause.dart';
import "dart:async";
import 'package:app/services/navigation_service.dart';
import 'package:app/locator.dart';
import 'package:app/services/dialog_service.dart';
import 'package:http/http.dart';

class CausesViewModel extends BaseModel {
  final DialogService _dialogService = locator<DialogService>();

  List<Cause> _causesList = [];
  List<Cause> get causesList => _causesList;

  List<bool> _causesSelectedList = [false, false, false, false, false, false];

  List<bool> get causesSelectedList => _causesSelectedList;

  bool _isButtonDisabled = true;

  bool get isButtonDisabled => _isButtonDisabled;

  final NavigationService _navigationService = locator<NavigationService>();

  Future fetchCauses() async {
    await Future.delayed(const Duration(seconds: 0));
    _causesList = [
      Cause(
          title: 'Environment',
          description:
              'Get involved with charities and activists locally and across the globe.',
      headerImage: 'https://images.unsplash.com/photo-1498925008800-019c7d59d903?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=968&q=80'),
      Cause(title: 'Health & Wellbeing', description: 'ipsum'),
      Cause(title: 'Equality & Human-Rights', description: 'ipsum'),
      Cause(title: 'Education & Citizenship', description: 'ipsum'),
      Cause(title: 'Economic Opportunity', description: 'ipsum'),
      Cause(title: 'Safe Homes & Community', description: 'ipsum')
    ];
    notifyListeners();
  }

  void getIsButtonDisabled() {
    _isButtonDisabled = true;
    for (int countIndex = 0; countIndex <= 5; countIndex++) {
      if (_causesSelectedList[countIndex] == true) {
        _isButtonDisabled = false;
      }
    }
  }

  void toggleSelection({required int causeIndex}) {
    _causesSelectedList[causeIndex] = !_causesSelectedList[causeIndex];
    getIsButtonDisabled();
    notifyListeners();
  }

  void goHome() async {
    _navigationService.navigateTo(Routes.home);
  }

  Future getCausePopup({required int causeIndex}) async {
    var dialogResult = await _dialogService.showDialog(
      title: _causesList[causeIndex].title,
      description: _causesList[causeIndex].description,
      headerImage: _causesList[causeIndex].headerImage,
    );
    if (dialogResult.response) {
      if (_causesSelectedList[causeIndex] == false) {
        toggleSelection(causeIndex: causeIndex);
      }
    }
  }
}
