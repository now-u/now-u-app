import 'dart:io';
import 'package:nowu/app/app.locator.dart';

Map<String, String> unauthenticatedHeaders = {
  'Content-Type': 'application/json; charset=UTF-8'
};

Future<String> readTestData(
  String fileName, {
  String filePath = 'assets/json/',
}) async {
  final file = File(filePath + fileName);
  return await file.readAsString();
}

void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}

void registerMock<T extends Object>(T service) {
  _removeRegistrationIfExists<T>();
  locator.registerSingleton<T>(service);
}
