import 'dart:async';

import 'package:nowu/app/app.locator.dart';
import 'package:nowu/services/dialog_service.dart';
import 'package:nowu/services/router_service.dart';
import 'package:nowu/ui/common/post_login_viewmodel.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:stacked/stacked.dart';

class LoginEmailSentViewModel extends BaseViewModel with PostLoginViewModelMixin {
  final String email;
  LoginEmailSentViewModel({required this.email});

  final _dialogService = locator<DialogService>();
  final _routerService = locator<RouterService>();

  Future backToLogin() async {
    _routerService.navigateToLoginView();
  }

  Future openMailApp() async {
    var result = await OpenMailApp.openMailApp();

    // If no mail apps found, show error
    if (!result.didOpen && !result.canOpen) {
      _dialogService.showErrorDialog(
        title: 'No email apps found',
        description: 'Please check your emails',
      );

      // iOS: if multiple mail apps found, show dialog to select.
      // There is no native intent/default app system in iOS so
      // you have to do it yourself.
    } else if (!result.didOpen && result.canOpen) {
      _dialogService.showEmailAppPickerDialog(mailApps: result.options);
    }
  }

  void navigateToSecretCodePage() {
    _routerService.navigateToLoginCodeView(email: email);
  }
}
