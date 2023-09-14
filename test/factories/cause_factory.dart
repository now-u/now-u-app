import 'package:causeApiClient/causeApiClient.dart';
import 'package:nowu/models/Cause.dart';

import './factory.dart';
import 'image_factory.dart';

class CauseFactory extends ModelFactory<Cause> {
  @override
  Cause generate() {
    return Cause(
      (cause) => cause
        ..id = faker.randomGenerator.integer(100)
        ..title = faker.lorem.sentence()
        ..description = faker.lorem.sentence()
        ..isSelected = faker.randomGenerator.boolean()
        ..icon = IconEnum.environment
        ..headerImage = ImageFactory().generateBuilder(),
    );
  }
}
