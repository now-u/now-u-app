import 'package:app/assets/icons/customIcons.dart';
import 'package:app/models/Cause.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Cause from json -', () {
    test('Happy ListCause json test', () {
      // TODO Read JSON from file 
      ListCause cause = ListCause.fromJson({
        "id": 1,
        "title": "Cause title",
        "icon": "ic-abc",
        "description": "Cause description",
        "selected": true
      });

      expect(cause.id, 1);
      expect(cause.title, 'Cause title');
      expect(cause.icon, getIconFromString("ic-abc"));
      expect(cause.description, 'Cause description');
      expect(cause.selected, true);
    });
  });
}
