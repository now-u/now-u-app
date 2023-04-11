import 'package:nowu/services/shared_preferences_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});

  group('shared preferences service', () {
    test('sets and gets value', () async {
      SharedPreferencesService sharedPreferencesService =
          SharedPreferencesService();
      await sharedPreferencesService.init();
      sharedPreferencesService.saveUserToken("abc");
      expect(await sharedPreferencesService.getUserToken(), "abc");
    });
  });
}
