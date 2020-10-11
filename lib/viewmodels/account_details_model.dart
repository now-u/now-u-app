import 'package:app/viewmodels/base_model.dart';

import 'package:flutter/material.dart';
import 'package:app/locator.dart';
import 'package:app/services/auth.dart';

class AccountDetailsViewModel extends BaseModel {

  String _name;
  set name(String n) => _name = n;
   
  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  final _formKey = GlobalKey<FormState>();
  GlobalKey get formKey => _formKey;
  
  bool save() {
    setBusy(true);
    _authenticationService.updateUserDetails(name: _name); 
    setBusy(false);
    notifyListeners();
  }
}
