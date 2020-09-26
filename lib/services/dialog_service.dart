import 'dart:async';

class AlertRequest {
  final String title;
  final String description;

  AlertRequest({this.title, this.description});
}


class AlertResponse {
  final bool confirmed;
  AlertResponse({this.confirmed});
}


class DialogService {
  Function(AlertRequest) _showDialogListener;
  Completer<AlertResponse> _dialogCompleter;

  void registerDialogListener(Function(AlertRequest) showDialogListener) {
    _showDialogListener = showDialogListener;
  }

  Future showDialog({
    String title,
    String description,
  }) {
    _dialogCompleter = Completer<AlertResponse>();
    _showDialogListener(AlertRequest(title: title, description: description));
    return _dialogCompleter.future;
  }
  
  void dialogComplete(AlertResponse response) {
    if (_dialogCompleter != null) {
      _dialogCompleter.complete(response);
    }
    _dialogCompleter = null;
  }
}
