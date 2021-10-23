// Mocks generated by Mockito 5.0.15 from annotations
// in app/test/service_tests/api_service_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:app/models/User.dart' as _i6;
import 'package:app/services/api_service.dart' as _i3;
import 'package:app/services/auth.dart' as _i4;
import 'package:http/http.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeClient_0 extends _i1.Fake implements _i2.Client {}

class _FakeApiException_1 extends _i1.Fake implements _i3.ApiException {}

/// A class which mocks [AuthenticationService].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthenticationService extends _i1.Mock
    implements _i4.AuthenticationService {
  MockAuthenticationService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get domainPrefix =>
      (super.noSuchMethod(Invocation.getter(#domainPrefix), returnValue: '')
          as String);
  @override
  set domainPrefix(String? _domainPrefix) =>
      super.noSuchMethod(Invocation.setter(#domainPrefix, _domainPrefix),
          returnValueForMissingStub: null);
  @override
  bool get isAuthenticated => (super
          .noSuchMethod(Invocation.getter(#isAuthenticated), returnValue: false)
      as bool);
  @override
  _i2.Client get client => (super.noSuchMethod(Invocation.getter(#client),
      returnValue: _FakeClient_0()) as _i2.Client);
  @override
  set client(_i2.Client? _client) =>
      super.noSuchMethod(Invocation.setter(#client, _client),
          returnValueForMissingStub: null);
  @override
  String get baseUrl =>
      (super.noSuchMethod(Invocation.getter(#baseUrl), returnValue: '')
          as String);
  @override
  set baseUrl(String? _baseUrl) =>
      super.noSuchMethod(Invocation.setter(#baseUrl, _baseUrl),
          returnValueForMissingStub: null);
  @override
  String get baseUrlPath =>
      (super.noSuchMethod(Invocation.getter(#baseUrlPath), returnValue: '')
          as String);
  @override
  set baseUrlPath(String? _baseUrlPath) =>
      super.noSuchMethod(Invocation.setter(#baseUrlPath, _baseUrlPath),
          returnValueForMissingStub: null);
  @override
  void switchToStagingBranch() =>
      super.noSuchMethod(Invocation.method(#switchToStagingBranch, []),
          returnValueForMissingStub: null);
  @override
  _i5.Future<bool> isUserLoggedIn() =>
      (super.noSuchMethod(Invocation.method(#isUserLoggedIn, []),
          returnValue: Future<bool>.value(false)) as _i5.Future<bool>);
  @override
  _i5.Future<dynamic>? handleAuthRequestErrors(_i2.Response? response) => (super
          .noSuchMethod(Invocation.method(#handleAuthRequestErrors, [response]))
      as _i5.Future<dynamic>?);
  @override
  _i5.Future<dynamic> sendSignInWithEmailLink(
          String? email, String? name, bool? acceptNewletter) =>
      (super.noSuchMethod(
          Invocation.method(
              #sendSignInWithEmailLink, [email, name, acceptNewletter]),
          returnValue: Future<dynamic>.value()) as _i5.Future<dynamic>);
  @override
  _i5.Future<String?> login(String? email, String? token) =>
      (super.noSuchMethod(Invocation.method(#login, [email, token]),
          returnValue: Future<String?>.value()) as _i5.Future<String?>);
  @override
  bool logout() =>
      (super.noSuchMethod(Invocation.method(#logout, []), returnValue: false)
          as bool);
  @override
  _i5.Future<_i6.User>? getUser(String? token) =>
      (super.noSuchMethod(Invocation.method(#getUser, [token]))
          as _i5.Future<_i6.User>?);
  @override
  _i5.Future<bool> updateUserDetails(
          {String? name, DateTime? dob, String? orgCode}) =>
      (super.noSuchMethod(
          Invocation.method(#updateUserDetails, [],
              {#name: name, #dob: dob, #orgCode: orgCode}),
          returnValue: Future<bool>.value(false)) as _i5.Future<bool>);
  @override
  _i5.Future<String?> deleteUserAccount() =>
      (super.noSuchMethod(Invocation.method(#deleteUserAccount, []),
          returnValue: Future<String?>.value()) as _i5.Future<String?>);
  @override
  _i5.Future<bool> leaveOrganisation() =>
      (super.noSuchMethod(Invocation.method(#leaveOrganisation, []),
          returnValue: Future<bool>.value(false)) as _i5.Future<bool>);
  @override
  _i5.Future<bool> completeAction(int? actionId) =>
      (super.noSuchMethod(Invocation.method(#completeAction, [actionId]),
          returnValue: Future<bool>.value(false)) as _i5.Future<bool>);
  @override
  _i5.Future<bool> starAction(int? actionId) =>
      (super.noSuchMethod(Invocation.method(#starAction, [actionId]),
          returnValue: Future<bool>.value(false)) as _i5.Future<bool>);
  @override
  _i5.Future<bool> removeActionStatus(int? actionId) =>
      (super.noSuchMethod(Invocation.method(#removeActionStatus, [actionId]),
          returnValue: Future<bool>.value(false)) as _i5.Future<bool>);
  @override
  _i5.Future<_i6.User>? rejectAction(
          String? token, int? actionId, String? reason) =>
      (super.noSuchMethod(
              Invocation.method(#rejectAction, [token, actionId, reason]))
          as _i5.Future<_i6.User>?);
  @override
  _i5.Future<bool> joinCampaign(int? campaignId) =>
      (super.noSuchMethod(Invocation.method(#joinCampaign, [campaignId]),
          returnValue: Future<bool>.value(false)) as _i5.Future<bool>);
  @override
  _i5.Future<bool> leaveCampaign(int? campaignId) =>
      (super.noSuchMethod(Invocation.method(#leaveCampaign, [campaignId]),
          returnValue: Future<bool>.value(false)) as _i5.Future<bool>);
  @override
  _i5.Future<bool> completeLearningResource(int? learningResourceId) =>
      (super.noSuchMethod(
          Invocation.method(#completeLearningResource, [learningResourceId]),
          returnValue: Future<bool>.value(false)) as _i5.Future<bool>);
  @override
  _i3.ApiException getExceptionForResponse(_i2.Response? response) => (super
      .noSuchMethod(Invocation.method(#getExceptionForResponse, [response]),
          returnValue: _FakeApiException_1()) as _i3.ApiException);
  @override
  Map<String, String> getRequestHeaders() =>
      (super.noSuchMethod(Invocation.method(#getRequestHeaders, []),
          returnValue: <String, String>{}) as Map<String, String>);
  @override
  _i5.Future<Map<dynamic, dynamic>> getRequest(String? path,
          {Map<String, dynamic>? params}) =>
      (super.noSuchMethod(
              Invocation.method(#getRequest, [path], {#params: params}),
              returnValue:
                  Future<Map<dynamic, dynamic>>.value(<dynamic, dynamic>{}))
          as _i5.Future<Map<dynamic, dynamic>>);
  @override
  String toString() => super.toString();
}
