import 'package:nowu/app/app.dialogs.dart';
import 'package:nowu/models/Cause.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:stacked_services/stacked_services.dart';

export 'package:stacked_services/stacked_services.dart' show DialogService;

extension DialogServiceExtension on DialogService {
  // TODO These are a bit of a hack for now and provide the correct types for
  // each dialog, we should try to auto generate these

  // TODO Show error dialog
  Future<void> showErrorDialog({
    required String title,
    required String description,
  }) {
    return showCustomDialog<void, void>(
      barrierDismissible: true,
      variant: DialogType.basic,
      title: title,
      description: description,
    );
  }

  Future<void> showEmailAppPickerDialog({required List<MailApp> mailApps}) {
    return showCustomDialog(
      barrierDismissible: true,
      variant: DialogType.emailAppPicker,
      data: mailApps,
    );
  }

  Future<bool> showCauseDialog({required Cause cause}) async {
    final response = await showCustomDialog(
      barrierDismissible: true,
      variant: DialogType.cause,
      data: cause,
    );
    return response?.confirmed == true;
  }

  Future<bool> showExitConfirmationDialog() async {
    final response = await showCustomDialog(
      barrierDismissible: true,
      variant: DialogType.basic,
      title: "You're about to leave",
      description:
          'This link will take you out of the app. Are you sure you want to go?',
      mainButtonTitle: "Let's go",
      secondaryButtonTitle: 'Close',
    );
    return response?.confirmed == true;
  }

  Future<bool> showActionCompletedDialog() async {
    final response = await showCustomDialog(
      barrierDismissible: true,
      variant: DialogType.actionCompleted,
    );
    return response?.confirmed == true;
  }
}
