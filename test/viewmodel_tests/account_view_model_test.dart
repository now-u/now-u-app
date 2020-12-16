import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../setup/test_helpers.dart';

import 'package:app/viewmodels/account_details_model.dart';

void main() {
  group("AccountDetailsViewModelTest - ", () {
    setUpAll(() {
      setupTestLocator();
    });
    test("Check api updateUserDetails is called with correct arguments", () {

      DateTime now = DateTime.now();
      var mockApi = mockAuthenticationService();
      when(mockApi.updateUserDetails(name: "jelgar", dob: now)).thenAnswer((_) => Future.value(true));
      
      var model = AccountDetailsViewModel();
      model.name = "jelgar";
      model.dob = now;
      model.save();

      verify(mockApi.updateUserDetails(name: "jelgar", dob: now));
    });
  });
}
