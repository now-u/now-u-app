import 'package:nowu/models/Cause.dart';
import 'package:flutter/material.dart';

import './factory.dart';

class ListCauseFactory extends ModelFactory<ListCause> {
  @override
  ListCause generate() {
    return ListCause(
      id: faker.randomGenerator.integer(100),
      title: faker.lorem.sentence(),
      description: faker.lorem.sentence(),
      isSelected: faker.randomGenerator.boolean(),
      icon: Icons.wc,
      headerImage: faker.image.image(),
    );
  }
}
