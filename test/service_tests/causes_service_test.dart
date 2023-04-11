import 'package:nowu/models/Action.dart';
import 'package:nowu/models/Campaign.dart';
import 'package:nowu/models/Cause.dart';
import 'package:nowu/models/Learning.dart';
import 'package:nowu/services/api_service.dart';
import 'package:nowu/services/auth.dart';
import 'package:flutter_test/flutter_test.dart';
import '../factories/action_factory.dart';
import '../factories/campaign_factory.dart';
import '../factories/cause_factory.dart';
import 'package:mocktail/mocktail.dart';

import 'package:nowu/services/causes_service.dart';
import 'package:nowu/locator.dart';

import '../factories/learning_resource_factory.dart';
import '../setup/test_helpers.dart';

class MockApiService extends Mock implements ApiService {}

class MockAuthenticationService extends Mock implements AuthenticationService {}

void main() {
  late ApiService mockApiService;
  late AuthenticationService mockAuthenticationService;
  late CausesService causesService;

  final listCause = ListCauseFactory().generate();
  final listAction = ListCauseActionFactory().generate();
  final action = CampaignActionFactory().generate();
  final listCampaign = ListCampaignFactory().generate();
  final campaign = CampaignFactory().generate();
  final learningResource = LearningResourceFactory().generate();

  const inputParams = {"test": "params"};

  void mockModelListRequestResponseValue<T>(List<T> value) {
    when(() => mockApiService.getModelListRequest<T>(any(), any(),
        params: any(named: "params"),
        limit: any(named: "limit"))).thenAnswer((_) async => value);
  }

  void mockModelRequestResponseValue<T>(T value) {
    when(() => mockApiService.getModelRequest<T>(any(), any(),
        params: any(named: "params"))).thenAnswer((_) async => value);
  }

  setUp(() {
    locator.reset();
    setupLocator();
    mockApiService = MockApiService();
    mockAuthenticationService = MockAuthenticationService();
    registerMock<ApiService>(mockApiService);
    registerMock<AuthenticationService>(mockAuthenticationService);
    causesService = locator<CausesService>();

    when(() => mockAuthenticationService.fetchUser())
        .thenAnswer((_) async => null);
  });

  group('causes', () {
    test('getCauses calls getModelListRequest', () async {
      mockModelListRequestResponseValue([listCause]);
      List<ListCause> causes =
          await causesService.getCauses(params: inputParams);
      expect(causes, [listCause]);

      verify(() => mockApiService.getModelListRequest(
          "v2/causes", ListCause.fromJson,
          params: inputParams)).called(1);
    });
  });

  group('actions', () {
    test('getAction calls getModelRequest', () async {
      final testId = 123;
      mockModelRequestResponseValue(action);
      CampaignAction response = await causesService.getAction(testId);
      expect(response, action);

      verify(() => mockApiService.getModelRequest(
          "v2/actions/123", CampaignAction.fromJson)).called(1);
    });

    test('getActions calls getModelListRequest', () async {
      mockModelListRequestResponseValue([listAction]);
      List<ListCauseAction> actions =
          await causesService.getActions(params: inputParams);
      expect(actions, [listAction]);

      verify(() => mockApiService.getModelListRequest(
              "v2/actions", ListCauseAction.fromJson, params: inputParams))
          .called(1);
    });
  });

  group('campaigns', () {
    test('getCampaign calls getModelRequest', () async {
      final testId = 123;
      mockModelRequestResponseValue(campaign);
      Campaign response = await causesService.getCampaign(testId);
      expect(response, campaign);

      verify(() => mockApiService.getModelRequest(
          "v2/campaigns/123", Campaign.fromJson)).called(1);
    });

    test('getCampaigns calls getModelListRequest', () async {
      mockModelListRequestResponseValue([listCampaign]);
      List<ListCampaign> response =
          await causesService.getCampaigns(params: inputParams);
      expect(response, [listCampaign]);

      verify(() => mockApiService.getModelListRequest(
              "v2/campaigns", ListCampaign.fromJson, params: inputParams))
          .called(1);
    });
  });

  group('learning resources', () {
    test('getLearningResources calls getModelListRequest', () async {
      mockModelListRequestResponseValue([learningResource]);
      List<LearningResource> response =
          await causesService.getLearningResources(params: inputParams);
      expect(response, [learningResource]);

      verify(() => mockApiService.getModelListRequest(
          "v2/learning_resources", LearningResource.fromJson,
          params: inputParams)).called(1);
    });
  });

  group('join causes', () {
    test('sends correct cause ids', () async {
      when(() => mockApiService.postRequest(any(), body: any(named: "body")))
          .thenAnswer((_) async => {});

      await causesService.selectCauses([listCause]);

      verify(() => mockApiService.postRequest("v2/me/causes", body: {
            'cause_ids': [listCause.id]
          })).called(1);

      verify(() => mockAuthenticationService.fetchUser()).called(1);
    });
  });

  group('completeAction', () {
    test('calls corrrect endpoint', () async {
      when(() => mockApiService.postRequest(any(), body: any(named: "body")))
          .thenAnswer((_) async => {});

      await causesService.completeAction(123);

      verify(() =>
              mockApiService.postRequest("v1/users/me/actions/123/complete"))
          .called(1);
      verify(() => mockAuthenticationService.fetchUser()).called(1);
    });
  });

  group('removeActionStatus', () {
    test('calls corrrect endpoint', () async {
      when(() => mockApiService.deleteRequest(any()))
          .thenAnswer((_) async => {});

      await causesService.removeActionStatus(123);

      verify(() => mockApiService.deleteRequest("v1/users/me/actions/123"))
          .called(1);
      verify(() => mockAuthenticationService.fetchUser()).called(1);
    });
  });

  group('completeLearningResources', () {
    test('calls corrrect endpoint', () async {
      when(() => mockApiService.postRequest(any(), body: any(named: "body")))
          .thenAnswer((_) async => {});

      await causesService.completeLearningResource(123);

      verify(() =>
              mockApiService.postRequest("v1/users/me/learning_resources/123"))
          .called(1);
      verify(() => mockAuthenticationService.fetchUser()).called(1);
    });
  });
}
