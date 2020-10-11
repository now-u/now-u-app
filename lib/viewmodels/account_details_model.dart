import 'package:app/viewmodels/base_model.dart';

import 'package:flutter/material.dart';
import 'package:app/locator.dart';
import 'package:app/services/auth.dart';

class AccountDetailsViewModel extends BaseModel {

  String _name;
  set name(String name) => _name = name;
  DateTime _dob; 
  set dob(DateTime dob) { 
    _dob = dob;
    dobFieldController.text = dateToString(dob);
  }
  // The dob in the form or if null the current known dob
  DateTime get latestDob => _dob ?? currentUser.getDateOfBirth();

  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  final _formKey = GlobalKey<FormState>();
  GlobalKey get formKey => _formKey;
  final _dobFieldController = TextEditingController();
  TextEditingController get dobFieldController => _dobFieldController;
  
  void init() {
    _dobFieldController.text = dateToString(currentUser.getDateOfBirth());
  }
  
  bool save() {
    setBusy(true);
    _authenticationService.updateUserDetails(name: _name, dob: _dob); 
    setBusy(false);
    notifyListeners();
  }

}

String dateToString(DateTime date) {
  if (date == null) return null;
  return "${date.day}-${date.month}-${date.year}";
}
