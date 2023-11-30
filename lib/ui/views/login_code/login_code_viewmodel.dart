import 'dart:js';

import 'package:nowu/locator.dart';
import 'package:nowu/services/auth.dart';
import 'package:nowu/services/dialog_service.dart';
import 'package:nowu/ui/common/post_login_viewmodel.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:stacked/stacked.dart';
import '../../../generated/l10n.dart';
import 'login_code_view.form.dart';

class LoginCodeFormValidators {
  static String? codeInputValidator(String? value) {
    if (value == null || value.isEmpty)
      return 'Please enter the secret code from the email';
    if (value.length != 6) return 'The secret code must be 6 digits long';
    return null;
  }
}

class LoginCodeViewModel extends FormViewModel with PostLoginViewModelMixin {
  // TODO Should we pass this around or get it from secure storage?
  final String email;
  LoginCodeViewModel({required this.email});

  final _authenticationService = locator<AuthenticationService>();
  final _dialogService = locator<DialogService>();

  Future<void> loginWithCode() async {
    // TODO Is this validate call required or does isFormValid do it
    validateForm();
    if (isFormValid) {
      try {
        setBusy(true);
        await _authenticationService.signInWithCode(email, codeInputValue!);
      } catch (e) {
        setBusy(false);
        Sentry.captureException(e);
        return _dialogService.showErrorDialog(
          title: 'Login error',
          description: S.current.errorAuthenticationFailed,
        );
      }
    }
  }
}
