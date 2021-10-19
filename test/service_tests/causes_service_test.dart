import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

import 'package:app/services/causes_service.dart';
import 'package:app/locator.dart';
import 'package:app/models/Cause.dart';

String causesResponse = '''[
  {
    "id": 1,
    "title": "Name of the campaign",
    "icon": "ic-abc",
    "description": "Cause description",
    "selected": true
  }
]
''';

@GenerateMocks([http.Client])
void main() {
  CausesService _causesService = locator<CausesService>();

  group('fetchAlbum', () {
    test('returns a List of Causes if the request is successfully', () async {
      final client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client
              .get(Uri.parse('https://api.now-u.com/api/v2/causes')))
          .thenAnswer((_) async =>
              http.Response(causesResponse, 200));

      expect(await _causesService.getCauses(client), isA<List<Cause>>());
    });
  });
}
