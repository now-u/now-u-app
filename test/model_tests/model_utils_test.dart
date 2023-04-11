import 'package:nowu/models/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("authBooleanSerializer", () {
    test("Return false when input is string", () {
      expect(authBooleanSerializer("Auth error"), false);
    });

    test("Return false when input is false", () {
      expect(authBooleanSerializer(false), false);
    });

    test("Return true when input is true", () {
      expect(authBooleanSerializer(true), true);
    });
  });
}
