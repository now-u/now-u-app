import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'causes_service_test.mocks.dart';
import 'package:http/http.dart' as http;

import 'package:app/services/causes_service.dart';
import '../setup/test_helpers.dart';
import 'package:app/locator.dart';
import 'package:app/models/Cause.dart';

@GenerateMocks([http.Client])
void main() {
  setupLocator();
  CausesService _causesService = locator<CausesService>();
  Map<String, String> unauthenticatedHeaders = {
    "Content-Type": "application/json; charset=UTF-8"
  };

  group('get causes', () {
    test('returns a List of ListCauses if the request is successfully',
        () async {
      final client = MockClient();
      _causesService.client = client;

      when(client.get(Uri.parse('https://api.now-u.com/api/v2/causes'),
              headers: unauthenticatedHeaders))
          .thenAnswer((_) async =>
              http.Response(await readTestData("causes.json"), 200));

      List<ListCause> causes = await _causesService.getCauses();
      expect(causes.length, 1);

      ListCause cause = causes[0];
      expect(cause.id, 1);
      expect(cause.title, "Cause title");
      expect(cause.icon, "ic-abc");
      expect(cause.description, "Cause description");
      expect(cause.selected, true);
    });

    // TODO error case
  });

  group('get cause', () {
    test('returns a Cause if the request is successfully', () async {
      final client = MockClient();
      _causesService.client = client;

      when(client.get(Uri.parse('https://api.now-u.com/api/v2/cause/1'),
              headers: unauthenticatedHeaders))
          .thenAnswer((_) async =>
              http.Response(await readTestData("cause.json"), 200));

      Cause cause = await _causesService.getCause(1);
      expect(cause.id, 1);
      expect(cause.title, "Cause title");
      expect(cause.icon, "ic-abc");
      expect(cause.description, "Cause description");
      expect(cause.selected, true);
    });
  });
}
