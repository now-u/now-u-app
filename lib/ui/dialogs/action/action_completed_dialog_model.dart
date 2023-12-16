import 'package:nowu/services/router_service.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';

class ActionCompletedDialogModel extends BaseViewModel {
  final _routerService = locator<RouterService>();

  void onNavigateToExplore() {
    _routerService.navigateToExplore();
  }

  void onClose() {
    _routerService.pop();
  }
}
