import 'package:flutter_test/flutter_test.dart';
import 'package:app/models/Learning.dart';

import './helpers.dart';

void main() {
  group('LearningResource', () {
    test('fromJson serializes correctly', () async {
      final data = await readTestDataList("learning_resources.json");
      final resource = LearningResource.fromJson(data[0]);

      expect(resource.id, 47);
      expect(resource.title, "Watch 'Why talk toilets?'");
      expect(resource.type, getResourceTypeFromString("video"));
      expect(resource.time, 2.0);
      expect(resource.completed, true);
      expect(resource.source, "bbc");
      expect(resource.createdAt, DateTime.utc(2020, 7, 6, 20, 49, 43, 892));
      expect(resource.cause.id, 1);
    });
    
	test('fromJson serializes correctly', () {
		isNew()
    });
  });
}
