import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:app/locator.dart';
import 'package:app/services/dialog_service.dart';
import 'package:app/services/auth.dart';

import '../setup/test_helpers.dart';

import 'package:app/viewmodels/account_details_model.dart';

void main() {
  group("AccountDetailsViewModelTest - ", () {
    group("save tests - ", () {
      test("Check save on update failure", () async {
        DateTime now = DateTime.now();
        getAndRegisterMockGoogleLocationSearchService();
        getAndRegisterMockAnalyticsService();
        getAndRegisterMockNavigationService();

        var mockDialogService = getAndRegisterMockDialogService();

        when(mockDialogService.showDialog(
                title: "Error",
                description:
                    "Sorry there has been an error whilst updating your details."))
            .thenAnswer((_) => Future.value(true));

        // Mock api to always return false i.e. error occured
        var mockAuth = getAndRegisterMockAuthentiactionService();

        when(mockAuth.updateUserDetails(
                name: "jelgar", dob: now, orgCode: null))
            .thenAnswer((_) => Future.value(false));

        var model = AccountDetailsViewModel();
        model.name = "jelgar";
        model.dob = now;
        await model.save();

        // Verify that updateUserDetails function is called with correct parameters when we save
        verify(mockAuth.updateUserDetails(
            name: "jelgar", dob: now, orgCode: null));

        // But then since there was an error verify dialog was shown
        verify(
          mockDialogService.showDialog(
            title: "Error",
            description:
                "Sorry there has been an error whilst updating your details.",
          ),
        );
      });

      test("Check save on update success", () {
        DateTime now = DateTime.now();

        // Mock api to always return true
        MockAuthenticationService mockAuth =
            getAndRegisterMockAuthentiactionService() as MockAuthenticationService;
        when(mockAuth.updateUserDetails(name: "jelgar", dob: now))
            .thenAnswer((_) => Future.value(true));

        getAndRegisterMockAnalyticsService();

        var model = AccountDetailsViewModel();
        model.name = "jelgar";
        model.dob = now;
        model.save();

        // Verify that updateUserDetails function is called with correct parameters when we save
        verify(mockAuth.updateUserDetails(name: "jelgar", dob: now));
      });
    });

    group("delete tests - ", () {
      void testDeleteUserAccountDialogs(String? deleteUserAccountResponse,
          String dialogTitle, String dialogDescription) async {
        // Mock api to always return "success" string
        MockAuthenticationService mockAuth =
            getAndRegisterMockAuthentiactionService() as MockAuthenticationService;
        when(mockAuth.deleteUserAccount())
            .thenAnswer((_) async => deleteUserAccountResponse);

        // Mock Dialog service to return true when dialog shown
        MockDialogService mockDialog = getAndRegisterMockDialogService() as MockDialogService;
        when(mockDialog.showDialog(
          title: dialogTitle,
          description: dialogDescription,
        )).thenAnswer((_) => Future.value(true));

        // Delete account
        var model = AccountDetailsViewModel();
        await model.delete();

        // Check api delete account called
        verify(mockAuth.deleteUserAccount());

        // Check success dialog shown
        verify(mockDialog.showDialog(
          title: dialogTitle,
          description: dialogDescription,
        ));
      }

      test("Check delete() account on case success", () async {
        testDeleteUserAccountDialogs(
            null, "All done!", "Your account has now been deleted.");
      });

      test("Check delete() account on client error", () async {
        testDeleteUserAccountDialogs(
          AuthError.request,
          "Client Error",
          "Sorry, something went wrong!\nTry restarting your app.",
        );
      });

      test("Check delete() account on server error", () async {
        testDeleteUserAccountDialogs(
          AuthError.internal,
          "Server Error",
          "Sorry, there was a server problem.\nTry again later.",
        );
      });

      test("Check delete() account on generic error", () async {
        testDeleteUserAccountDialogs(
          AuthError.unknown,
          "Error",
          "Sorry, something went wrong!\nPlease try again.",
        );
      });
    });
  });
}
