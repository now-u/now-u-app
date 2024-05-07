// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedDialogGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/dialogs/action/action_completed_dialog.dart';
import '../ui/dialogs/cause/cause_dialog.dart';
import '../ui/dialogs/email_app_picker/email_app_picker_dialog.dart';

enum DialogType {
  emailAppPicker,
  cause,
  actionCompleted,
}

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final Map<DialogType, DialogBuilder> builders = {
    DialogType.emailAppPicker: (context, request, completer) =>
        EmailAppPickerDialog(request: request, completer: completer),
    DialogType.cause: (context, request, completer) =>
        CauseDialog(request: request, completer: completer),
    DialogType.actionCompleted: (context, request, completer) =>
        ActionCompletedDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
