import 'package:flutter/material.dart';
import 'package:nowu/models/cause.dart';

import './factory.dart';
import 'image_factory.dart';

class CauseFactory extends ModelFactory<Cause> {
  @override
  Cause generate() {
    return Cause(
      id: faker.randomGenerator.integer(100),
      title: faker.lorem.sentence(),
      description: faker.lorem.sentence(),
      icon: Icons.place,
      headerImage: ImageFactory().generateBuilder().build(),
    );
  }
}
