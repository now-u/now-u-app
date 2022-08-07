import 'package:app/assets/icons/customIcons.dart';
import 'package:app/models/Learning.dart';
import 'package:app/services/api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'causes_service_test.mocks.dart';
import 'package:http/http.dart' as http;

import 'package:app/services/causes_service.dart';
import '../setup/test_helpers.dart';
import 'package:app/locator.dart';
import 'package:app/models/Cause.dart';
import 'package:app/models/Action.dart';
import '../setup/helpers/factories.dart';

@GenerateMocks([ApiService])
void main() {
  final mockApiService = MockApiService();
  // setupLocator();
  locator.registerSingleton<ApiService>(mockApiService);
  CausesService _causesService = CausesService();

  group('get causes', () {
    test('calls getRequest with correct path and iteratively calls Cause.fromJson on response',
        () async {

      when(mockApiService.getListRequest(any, params: anyNamed("params")))
        .thenAnswer((_) async => [{"dummy": "data1"}, {"dummy": "data2"}]);
    });
  });

  // group('get action', () {
  //   test('returns an Action if the request is successfully', () async {
  //     final client = MockClient();
  //     _causesService.client = client;

  //     when(client.get(Uri.parse('https://api.now-u.com/api/v2/action/2'),
  //             headers: unauthenticatedHeaders))
  //         .thenAnswer((_) async =>
  //             http.Response(await readTestData("action.json"), 200));

  //     CampaignAction action = await _causesService.getAction(2);
  //     expect(action.id, 2);
  //     expect(action.title, "Watch 'Why talk toilets?'");
  //     expect(action.link, "https://www.youtube.com/watch?v=MS4va1WLaro");
  //     expect(action.type, CampaignActionType.Learn);

  //     ListCause actionCause = action.cause;
  //     expect(actionCause.id, 1);
  //   });
  // });

  // group('get actions', () {
  //   test('returns a List of Actions if the request is successful', () async {
  //     final client = MockClient();
  //     _causesService.client = client;

  //     when(client.get(Uri.parse('https://api.now-u.com/api/v2/action'),
  //             headers: unauthenticatedHeaders))
  //         .thenAnswer((_) async =>
  //             http.Response(await readTestData("actions.json"), 200));

  //     List<ListCauseAction> actions = await _causesService.getActions();

  //     ListCauseAction action = actions[0];

  //     expect(action.id, 47);
  //     expect(action.title, "Watch 'Why talk toilets?'");
  //     expect(action.type, CampaignActionType.Learn);

  //     ListCause actionCause = action.cause;
  //     expect(actionCause.id, 1);
  //   });
  // });

  // group('join causes', () {
  //   test('sends correct ids when causes are selected', () async {
  //     final client = MockClient();
  //     _causesService.client = client;

  //     Map body = {
  //       'cause_ids': [1, 2]
  //     };

  //     when(client.post(Uri.parse('https://api.now-u.com/api/v2/me/causes'),
  //             headers: unauthenticatedHeaders, body: body))
  //         .thenAnswer((_) async => http.Response('{}', 200));

  //     await _causesService.selectCauses([mockCause(id: 1), mockCause(id: 2)]);

  //     verify(client.post(Uri.parse('https://api.now-u.com/api/v2/me/causes'),
  //             headers: unauthenticatedHeaders, body: body))
  //         .called(1);
  //   });
  // });

  // group('get learning resources', () {
  //   test('returns a List of LearningResources if the request is successful',
  //       () async {
  //     final client = MockClient();
  //     _causesService.client = client;

  //     when(client.get(
  //             Uri.parse('https://api.now-u.com/api/v2/learning/resources'),
  //             headers: unauthenticatedHeaders))
  //         .thenAnswer((_) async => http.Response(
  //             await readTestData("learning_resources.json"), 200));

  //     List<LearningResource> resources =
  //         await _causesService.getLearningResources();
  //     LearningResource resource = resources[0];

  //     expect(resource.id, 47);
  //     expect(resource.title, "Watch 'Why talk toilets?'");
  //     expect(resource.type, getResourceTypeFromString("video"));

  //     ListCause actionCause = resource.cause;
  //     expect(actionCause.id, 1);
  //   });
  // });
}
