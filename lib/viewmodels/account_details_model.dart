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
   
  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  final _formKey = GlobalKey<FormState>();
  GlobalKey get formKey => _formKey;
  final _dobFieldController = TextEditingController();
  TextEditingController get dobFieldController => _dobFieldController;

  
  bool save() {
    setBusy(true);
    _authenticationService.updateUserDetails(name: _name, dob: _dob); 
    setBusy(false);
    notifyListeners();
  }

  String dateToString(DateTime date) {
    if (date == null) return null;
    return "${date.day}-${date.month}-${date.year}";
  }
}
