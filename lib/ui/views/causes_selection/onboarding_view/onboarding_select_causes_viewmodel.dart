import 'package:nowu/router.gr.dart';

import '../select_causes_viewmodel.dart';

class OnboardingSelectCausesViewModel extends SelectCausesViewModel {
  Future<void> navigateAfterCausesSelection() async {
    return router.replaceAll([
      TabsRoute(children: [const HomeRoute()]),
    ]);
  }
}
