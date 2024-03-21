import 'package:nowu/services/router_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class ActionCompletedDialogModel extends BaseViewModel {
  final _routerService = locator<NavigationService>();

  void onNavigateToExplore() {
    _routerService.navigateToExplore();
  }

  void onClose() {
    // TODO: _routerService.pop();
  }
}
