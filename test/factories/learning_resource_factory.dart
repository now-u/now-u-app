import 'package:nowu/models/learning.dart';
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
    return LearningResource(
        id: faker.randomGenerator.integer(100),
        title: faker.lorem.sentence(),
        time: faker.randomGenerator.integer(10),
        link: Uri.parse(faker.internet.httpUrl()),
        type: LearningResourceType.video,
        createdAt: faker.date.dateTime(),
        cause: CauseFactory().generate(),
    );
  }
}
