import 'package:app/assets/icons/my_flutter_app_icons_old.dart';
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

  List<ListCause> _causesList = [];
  List<ListCause> get causesList => _causesList;

  List<bool> _causesSelectedList = [false, false, false, false, false, false];

  List<bool> get causesSelectedList => _causesSelectedList;
  bool get isButtonDisabled => !_causesSelectedList.any((element) => element);

  final NavigationService _navigationService = locator<NavigationService>();

  Future fetchCauses() async {
    await Future.delayed(const Duration(seconds: 0));
    _causesList = [
      ListCause(
        id: 1,
        title: 'Environment',
        description:
              'Get involved with charities and activists locally and across the globe.',
        headerImage: 'https://images.unsplash.com/photo-1498925008800-019c7d59d903?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=968&q=80',
        selected: true,
        icon: CustomIcons.icon_quiz_01,
      ),
      ListCause(
        id: 2,
        title: 'Health & Wellbeing',
        description: 'ipsum',
        headerImage: 'https://images.unsplash.com/photo-1498925008800-019c7d59d903?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=968&q=80',
        selected: true,
        icon: CustomIcons.icon_quiz_01,
      ),
      ListCause(
        id: 3,
        title: 'Equality & Human-Rights',
        description: 'ipsum',
        headerImage: 'https://images.unsplash.com/photo-1498925008800-019c7d59d903?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=968&q=80',
        selected: true,
        icon: CustomIcons.icon_quiz_01,
      ),
      ListCause(
        id: 4,
        title: 'Education & Citizenship',
        description: 'ipsum',
        headerImage: 'https://images.unsplash.com/photo-1498925008800-019c7d59d903?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=968&q=80',
        selected: true,
        icon: CustomIcons.icon_quiz_01,
      ),
      ListCause(
        id: 5,
        title: 'Economic Opportunity',
        description: 'ipsum',
        headerImage: 'https://images.unsplash.com/photo-1498925008800-019c7d59d903?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=968&q=80',
        selected: true,
        icon: CustomIcons.icon_quiz_01,
      ),
      ListCause(
        id: 6,
        title: 'Safe Homes & Community',
        description: 'ipsum',
        headerImage: 'https://images.unsplash.com/photo-1498925008800-019c7d59d903?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=968&q=80',
        selected: true,
        icon: CustomIcons.icon_quiz_01,
      )
    ];
    notifyListeners();
  }

  void toggleSelection({required int causeIndex}) {
    _causesSelectedList[causeIndex] = !_causesSelectedList[causeIndex];
    notifyListeners();
  }

  void getStarted() async {
    // TODO register selection
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
