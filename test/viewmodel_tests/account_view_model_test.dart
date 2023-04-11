import 'package:nowu/services/analytics.dart';
import 'package:nowu/services/api_service.dart';
import 'package:nowu/services/google_location_search_service.dart';
import 'package:nowu/services/navigation_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nowu/locator.dart';
import 'package:nowu/services/dialog_service.dart';
import 'package:nowu/services/auth.dart';
import 'package:mocktail/mocktail.dart';

import '../setup/test_helpers.dart';

import 'package:nowu/viewmodels/account_details_model.dart';

class MockAuthenticationService extends Mock implements AuthenticationService {}

class MockGoogleLocationService extends Mock
    implements GoogleLocationSearchService {}

class MockDialogService extends Mock implements DialogService {}

class MockNavigationService extends Mock implements NavigationService {}

class MockAnalyticsService extends Mock implements AnalyticsService {}

void main() {
  late AuthenticationService mockAuthService;
  late GoogleLocationSearchService mockGoogleLocationService;
  late DialogService mockDialogService;
  late AnalyticsService mockAnalyticsService;
  late NavigationService mockNavigationService;

  setUp(() {
    locator.reset();
    setupLocator();

    mockAuthService = MockAuthenticationService();
    mockGoogleLocationService = MockGoogleLocationService();
    mockDialogService = MockDialogService();
    mockNavigationService = MockNavigationService();
    mockAnalyticsService = MockAnalyticsService();

    registerMock<AuthenticationService>(mockAuthService);
    registerMock<GoogleLocationSearchService>(mockGoogleLocationService);
    registerMock<DialogService>(mockDialogService);
    registerMock<NavigationService>(mockNavigationService);
    registerMock<AnalyticsService>(mockAnalyticsService);
  });

  group("AccountDetailsViewModelTest - ", () {
    group("save tests - ", () {
      // test("Check save on update failure", () async {
      //   DateTime now = DateTime.now();

      //   when(() => mockDialogService.showDialog(BasicDialog(
      //           title: "Error",
      //           description:
      //               "Sorry there has been an error whilst updating your details.")))
      //       .thenAnswer((_) => Future.value(true));

      //   when(() => mockAuthService.updateUserDetails(
      //           name: "jelgar", dob: now, orgCode: null))
      //       .thenAnswer((_) => Future.value(false));

      //   var model = AccountDetailsViewModel();
      //   model.name = "jelgar";
      //   model.dob = now;
      //   await model.save();

      //   // Verify that updateUserDetails function is called with correct parameters when we save
      //   verify(() => mockAuthService.updateUserDetails(
      //       name: "jelgar", dob: now, orgCode: null));

      //   // But then since there was an error verify dialog was shown
      //   verify(() =>
      //     mockDialogService.showDialog(BasicDialog(
      //       title: "Error",
      //       description:
      //           "Sorry there has been an error whilst updating your details.",
      //     )),
      //   );
      // });

      // test("Check save on update success", () {
      //   DateTime now = DateTime.now();

      //   // Mock api to always return true
      //   when(() => mockAuthService.updateUserDetails(name: "jelgar", dob: now))
      //       .thenAnswer((_) => Future.value(true));

      //   getAndRegisterMockAnalyticsService();

      //   var model = AccountDetailsViewModel();
      //   model.name = "jelgar";
      //   model.dob = now;
      //   model.save();

      //   // Verify that updateUserDetails function is called with correct parameters when we save
      //   verify(
      //       () => mockAuthService.updateUserDetails(name: "jelgar", dob: now));
      // });
    });

    // group("delete tests - ", () {
    //   void testDeleteUserAccountDialogs(ApiExceptionType? exceptionType,
    //       String dialogTitle, String dialogDescription) async {
    //     // Mock api response
    //     if (exceptionType != null) {
    //         when(() => mockAuthService.deleteUserAccount()).thenThrow((_) async => ApiException(type: exceptionType, statusCode: 500, message: "Error"));
    //     } else {
    //         when(() => mockAuthService.deleteUserAccount()).thenAnswer((_) async => null);
    //     }

    //     // Mock Dialog service to return true when dialog shown
    //     when(() => mockDialogService.showDialog(BasicDialog(
    //       title: dialogTitle,
    //       description: dialogDescription,
    //     ))).thenAnswer((_) => Future.value(true));

    //     // Delete account
    //     var model = AccountDetailsViewModel();
    //     await model.delete();

    //     // Check api delete account called
    //     verify(() => mockAuthService.deleteUserAccount());

    //     // Check success dialog shown
    //     verify(() => mockDialogService.showDialog(BasicDialog(
    //       title: dialogTitle,
    //       description: dialogDescription,
    //     )));
    //   }

    //   test("Check delete() account on case success", () async {
    //     testDeleteUserAccountDialogs(
    //         null, "All done!", "Your account has now been deleted.");
    //   });

    //   test("Check delete() account on client error", () async {
    //     testDeleteUserAccountDialogs(
    //       ApiExceptionType.REQUEST,
    //       "Client Error",
    //       "Sorry, something went wrong!\nTry restarting your app.",
    //     );
    //   });

    //   test("Check delete() account on server error", () async {
    //     testDeleteUserAccountDialogs(
    //       ApiExceptionType.INTERNAL,
    //       "Server Error",
    //       "Sorry, there was a server problem.\nTry again later.",
    //     );
    //   });

    //   test("Check delete() account on generic error", () async {
    //     testDeleteUserAccountDialogs(
    //       ApiExceptionType.UNKNOWN,
    //       "Error",
    //       "Sorry, something went wrong!\nPlease try again.",
    //     );
    //   });
    // });
  });
}
