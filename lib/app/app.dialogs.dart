// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedDialogGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import '../ui/dialogs/basic/basic_dialog.dart';
import '../ui/dialogs/cause/cause_dialog.dart';
import '../ui/dialogs/email_app_picker/email_app_picker_dialog.dart';
import 'app.locator.dart';

enum DialogType {
  basic,
  emailAppPicker,
  cause,
}

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final Map<DialogType, DialogBuilder> builders = {
    DialogType.basic: (context, request, completer) =>
        BasicDialog(request: request, completer: completer),
    DialogType.emailAppPicker: (context, request, completer) =>
        EmailAppPickerDialog(request: request, completer: completer),
    DialogType.cause: (context, request, completer) =>
        CauseDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
