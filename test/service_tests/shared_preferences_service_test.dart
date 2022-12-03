import 'package:app/services/shared_preferences_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('shared preferences service', () {
    test('sets and gets value', () async {
      SharedPreferencesService sharedPreferencesService = SharedPreferencesService();
      await sharedPreferencesService.init();
      sharedPreferencesService.saveUserToken("abc");
      expect(await sharedPreferencesService.getUserToken(), "abc");
    });
  });
}
