import '../select_causes_viewmodel.dart';

class OnboardingSelectCausesViewModel extends SelectCausesViewModel {
  Future<void> navigateAfterCausesSelection() async {
    return routerService.navigateToHome(clearHistory: true);
  }
}
