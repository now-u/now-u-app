import 'package:app/models/Learning.dart';
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
      time: faker.randomGenerator.decimal(scale: 10),
      link: faker.internet.httpUrl(),
      type: LearningResourceTypeFactory().generate(),
      createdAt: faker.date.dateTime(),
      completed: faker.randomGenerator.boolean(),
      cause: ListCauseFactory().generate(),
    );
  }
}
