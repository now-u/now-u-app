import '../select_causes_viewmodel.dart';

class ChangeSelectCausesViewModel extends SelectCausesViewModel {
  Future<void> navigateAfterCausesSelection() async {
    return routerService.navigateToHome();
  }

  void goBack() {
    routerService.back();
  }
}
