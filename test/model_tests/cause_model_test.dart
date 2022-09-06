import 'package:app/assets/icons/customIcons.dart';
import 'package:app/models/Cause.dart';
import 'package:flutter_test/flutter_test.dart';

import './helpers.dart';

void main() {
  group('Cause from json -', () {
    test('Happy Cause json test', () async {
      final data = await readTestDataList("causes.json");
      final cause = ListCause.fromJson(data[0]);

      expect(cause.id, 1);
      expect(cause.title, 'Environment');
      expect(cause.icon, getIconFromString("ic_learning"));
      expect(cause.description,
          'Get involved with charities and activists locally and across the globe.');
      expect(cause.selected, true);
      expect(cause.headerImage,
          "https://images.unsplash.com/photo-1498925008800-019c7d59d903?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=968&q=80");
    });
  });
}
