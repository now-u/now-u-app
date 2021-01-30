import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:app/locator.dart';
import 'package:app/services/dialog_service.dart';

import '../setup/test_helpers.dart';

import 'package:app/viewmodels/account_details_model.dart';

void main() {
  group("AccountDetailsViewModelTest - ", () {
    setUpAll(() {
      setupTestLocator();
    });
    DateTime now = DateTime.now();
    
    test("Check save on update failure", () async {
      var mockDialogService = getAndRegisterMockDialogService();
      when(mockDialogService.showDialog(title: "Error", description: "Sorry there has been an error whilst updating your details.")).thenAnswer((_) => Future.value(true));

      // Mock api to always return false i.e. error occured 
      var mockAuth = getAndRegisterMockAuthentiactionService();
      when(mockAuth.updateUserDetails(name: "jelgar", dob: now, orgCode: null)).thenAnswer((_) => Future.value(false));
   
      var model = AccountDetailsViewModel();
      model.name = "jelgar";
      model.dob = now;
      model.save();

      // Verify that updateUserDetails function is called with correct parameters when we save
      verify(mockAuth.updateUserDetails(name: "jelgar", dob: now, orgCode: null));
      // expect(await mockAuth.updateUserDetails(name: "jelgar", dob: now), false);

      // But then since there was an error verify dialog was shown
      verify(mockDialogService.showDialog(title: "Error", description: "Sorry there has been an error whilst updating your details."));
    });
    
    test("Check save on update success", () {

      DateTime now = DateTime.now();

      // Mock api to always return true
      MockAuthenticationService mockAuth = getAndRegisterMockAuthentiactionService();
      when(mockAuth.updateUserDetails(name: "jelgar", dob: now)).thenAnswer((_) => Future.value(true));
      
      var model = AccountDetailsViewModel();
      model.name = "jelgar";
      model.dob = now;
      model.save();

      // Verify that updateUserDetails function is called with correct parameters when we save
      verify(mockAuth.updateUserDetails(name: "jelgar", dob: now));
    });
  });
}
