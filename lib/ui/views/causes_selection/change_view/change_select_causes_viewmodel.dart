import 'package:nowu/router.gr.dart';

import '../select_causes_viewmodel.dart';

class ChangeSelectCausesViewModel extends SelectCausesViewModel {
  Future<void> navigateAfterCausesSelection() async {
    router.push(TabsRoute(children: [const HomeRoute()]));
  }

  void goBack() {
    router.back();
  }
}
