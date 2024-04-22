import 'package:nowu/router.dart';
import 'package:nowu/router.gr.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';

class ActionCompletedDialogModel extends BaseViewModel {
  final _router = locator<AppRouter>();

  void onNavigateToExplore() {
    _router.push(TabsRoute(children: [ExploreRoute()]));
  }

  void onClose() {
    _router.maybePop();
  }
}
