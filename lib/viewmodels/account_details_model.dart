import 'package:app/models/Organisation.dart';
import 'package:app/viewmodels/base_model.dart';

import 'package:flutter/material.dart';
import 'package:app/locator.dart';
import 'package:app/services/auth.dart';
import 'package:app/services/google_location_search_service.dart';
import 'package:app/services/dialog_service.dart';
import 'package:app/services/analytics.dart';

class AccountDetailsViewModel extends BaseModel {
  final AuthenticationService? _authenticationService =
      locator<AuthenticationService>();
  final GoogleLocationSearchService? _googleLocationSearchService =
      locator<GoogleLocationSearchService>();
  final AnalyticsService? _analyticsService = locator<AnalyticsService>();
  final DialogService? _dialogService = locator<DialogService>();
  //final OrganisationService _organisationService = locator<OrganisationService>();

  String? _name;
  set name(String name) => _name = name;
  DateTime? _dob;
  set dob(DateTime dob) {
    _dob = dob;
    dobFieldController.text = dateToString(dob)!;
  }

  String? _location;
  set location(String location) {
    _location = location;
    locationFieldController.text = location;
  }

  String? _orgCode;
  set orgCode(String orgCode) => _orgCode = orgCode;

  String get placeSearchUuid => _googleLocationSearchService!.sessionToken;
  // The dob in the form or if null the current known dob
  DateTime? get latestDob => _dob ?? currentUser!.getDateOfBirth();

  Organisation? get userOrganisation =>
      _authenticationService!.currentUser!.organisation;

  final _formKey = GlobalKey<FormState>();
  GlobalKey get formKey => _formKey;
  final _dobFieldController = TextEditingController();
  TextEditingController get dobFieldController => _dobFieldController;
  final _locationFieldController = TextEditingController();
  TextEditingController get locationFieldController => _locationFieldController;

  void init() {
    _dobFieldController.text = dateToString(currentUser!.getDateOfBirth())!;
    _locationFieldController.text = currentUser!.getLocation()!;
  }

  Future<void> save() async {
    setBusy(true);
    bool success = await _authenticationService!
        .updateUserDetails(name: _name, dob: _dob, orgCode: _orgCode);

    if (success) {
      print("Success");
      setBusy(false);
      notifyListeners();
    } else {
      _dialogService!.showDialog(
        title: "Error",
        description:
            "Sorry there has been an error whilst updating your details.",
      );
      setBusy(false);
      notifyListeners();
    }
  }

  Future<void> delete() async {
    setBusy(true);

    String? error = await _authenticationService!.deleteUserAccount();

    if (error == null) {
      _dialogService!.showDialog(
        title: "All done!",
        description: "Your account has now been deleted.",
      );
      await _analyticsService!.logUserAccountDeleted();
      logout();
    } else {
      switch (error) {
        case AuthError.request:
          {
            _dialogService!.showDialog(
                title: "Client Error",
                description:
                    "Sorry, something went wrong!\nTry restarting your app.");
            break;
          }
        case AuthError.internal:
          {
            _dialogService!.showDialog(
                title: "Server Error",
                description:
                    "Sorry, there was a server problem.\nTry again later.");
            break;
          }
        default:
          {
            _dialogService!.showDialog(
                title: "Error",
                description: "Sorry, something went wrong!\nPlease try again.");
            break;
          }
      }
    }
    setBusy(false);
    notifyListeners();
  }

  Future<Place> getPlaceDetails(String? placeId) async {
    return await _googleLocationSearchService!.getPlaceDetailFromId(placeId);
  }

  Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    List<Suggestion>? suggestions =
        await _googleLocationSearchService!.fetchSuggestions(input, lang);
    return suggestions ?? List<Suggestion>.empty();
  }

  Future<bool> leaveOrganisation() async {
    setBusy(true);
    await _authenticationService!.leaveOrganisation();
    setBusy(false);
    notifyListeners();
    return true;
  }
}

String? dateToString(DateTime? date) {
  if (date == null) return null;
  return "${date.day}-${date.month}-${date.year}";
}
