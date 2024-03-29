// class AccountDetailsViewModel extends BaseModel {
//   final AuthenticationService _authenticationService =
//       locator<AuthenticationService>();
//   final GoogleLocationSearchService _googleLocationSearchService =
//       locator<GoogleLocationSearchService>();
//   final AnalyticsService _analyticsService = locator<AnalyticsService>();
//   final DialogService _dialogService = locator<DialogService>();
//   //final OrganisationService _organisationService = locator<OrganisationService>();
//
//   String? _name;
//   set name(String name) => _name = name;
//   DateTime? _dob;
//   set dob(DateTime dob) {
//     _dob = dob;
//     dobFieldController.text = dateToString(dob)!;
//   }
//
//   String? _location;
//   set location(String location) {
//     _location = location;
//     locationFieldController.text = location;
//   }
//
//   String? _orgCode;
//   set orgCode(String orgCode) => _orgCode = orgCode;
//
//   String get placeSearchUuid => _googleLocationSearchService.sessionToken;
//   // The dob in the form or if null the current known dob
//   DateTime? get latestDob => _dob ?? currentUser!.getDateOfBirth();
//
//   Organisation? get userOrganisation =>
//       _authenticationService.currentUser!.organisation;
//
//   final _formKey = GlobalKey<FormState>();
//   GlobalKey get formKey => _formKey;
//   final _dobFieldController = TextEditingController();
//   TextEditingController get dobFieldController => _dobFieldController;
//   final _locationFieldController = TextEditingController();
//   TextEditingController get locationFieldController => _locationFieldController;
//
//   void init() {
//     _dobFieldController.text = dateToString(currentUser!.getDateOfBirth())!;
//     _locationFieldController.text = currentUser!.getLocation()!;
//   }
//
//   Future<void> save() async {
//     setBusy(true);
//     bool success = await _authenticationService.updateUserDetails(
//         name: _name, dob: _dob, orgCode: _orgCode);
//
//     if (success) {
//       print("Success");
//       setBusy(false);
//       notifyListeners();
//     } else {
//       _dialogService.showDialog(BasicDialog(
//         title: "Error",
//         description:
//             "Sorry there has been an error whilst updating your details.",
//       ));
//       setBusy(false);
//       notifyListeners();
//     }
//   }
//
//   Future<void> delete() async {
//     setBusy(true);
//
//     try {
//       await _authenticationService.deleteUserAccount();
//     } on ApiException catch (e) {
//       _dialogService.showDialog(
//         BasicDialog(
//           title: "Error",
//           description:
//               "Sorry, something went wrong!\nPlease try again. ${e.message}",
//         ),
//       );
//     }
//
//     await _dialogService.showDialog(BasicDialog(
//       title: "All done!",
//       description: "Your account has now been deleted.",
//     ));
//     await _analyticsService.logUserAccountDeleted();
//     logout();
//     setBusy(false);
//     notifyListeners();
//   }
//
//   Future<Place> getPlaceDetails(String? placeId) async {
//     return await _googleLocationSearchService.getPlaceDetailFromId(placeId);
//   }
//
//   Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
//     List<Suggestion>? suggestions =
//         await _googleLocationSearchService.fetchSuggestions(input, lang);
//     return suggestions ?? List<Suggestion>.empty();
//   }
// }
//
// String? dateToString(DateTime? date) {
//   if (date == null) return null;
//   return "${date.day}-${date.month}-${date.year}";
// }
