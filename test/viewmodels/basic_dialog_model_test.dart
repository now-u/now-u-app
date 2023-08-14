import 'package:flutter_test/flutter_test.dart';
import 'package:nowu/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('BasicDialogModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
