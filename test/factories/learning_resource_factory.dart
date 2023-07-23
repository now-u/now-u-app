import 'package:built_collection/built_collection.dart';
import 'package:nowu/models/Learning.dart';
import 'package:flutter/material.dart';

import './cause_factory.dart';
import './factory.dart';

class LearningResourceTypeFactory extends ModelFactory<LearningResourceType> {
  @override
  LearningResourceType generate() {
    return LearningResourceType(
      name: faker.lorem.word(),
      icon: Icons.error,
    );
  }
}

class LearningResourceFactory extends ModelFactory<LearningResource> {
  @override
  LearningResource generate() {
    return LearningResource((resource) => resource
      ..id = faker.randomGenerator.integer(100)
      ..title = faker.lorem.sentence()
      ..time = faker.randomGenerator.integer(10)
      ..link = faker.internet.httpUrl()
      ..learningResourceType = LearningResourceTypeEnum.INFOGRAPHIC
      ..createdAt = faker.date.dateTime()
      ..causes = ListBuilder(CauseFactory().generateList(length: 1))
    );
  }
}
