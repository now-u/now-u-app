import 'dart:async';

class AlertRequest {
  final String title;
  final String description;
  final List buttons;

  AlertRequest({this.title, this.description, this.buttons});
}

class AlertResponse {
  final dynamic response;
  AlertResponse({this.response});
}

class DialogButton {
  String text;
  dynamic response; // If the button is clicked what should the dialog service return 
  
  DialogButton({
    this.text,
    this.response,
  });
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
    List buttons,
  }) {
    _dialogCompleter = Completer<AlertResponse>();
    _showDialogListener(AlertRequest(title: title, description: description, buttons: buttons));
    return _dialogCompleter.future;
  }
  
  void dialogComplete(AlertResponse response) {
    if (_dialogCompleter != null) {
      _dialogCompleter.complete(response);
    }
    _dialogCompleter = null;
  }
}
