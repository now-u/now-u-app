import 'dart:async';

class DialogService {
  Function _showDialogListener;
  Completer _dialogCompleter;

  void registerDialogListener(Function showDialogListener) {
    _showDialogListener = showDialogListener;
  }

  Future showDialog() {
    _dialogCompleter = Completer();
    _showDialogListener();
    return _dialogCompleter.future;
  }

  void dialogComplete() {
    _dialogCompleter.complete();
    _dialogCompleter = null;
  }
}
