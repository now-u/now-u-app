import 'package:app/models/Cause.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Cause from json -', () {
    test('Happy json test', () {
      Cause cause = Cause(
          id: 1,
          name: "Cause_name",
          icon: "icon_name",
          description: "Some desc",
          headerImage: "Header image",
          actions: [1, 2, 3]);

      expect(cause.id, 1);
      expect(cause.name, 'Cause_name');
      expect(cause.icon, 'icon_name');
      expect(cause.description, 'Some desc');
      expect(cause.headerImage, 'Header image');
      expect(cause.actions, [1, 2, 3]);
    });
  });
}
