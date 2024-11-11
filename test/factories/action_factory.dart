import 'package:nowu/models/action.dart';

import 'factory.dart';
import 'cause_factory.dart';

class ListActionFactory extends ModelFactory<ListAction> {
  @override
  ListAction generate() {
    return ListAction(
      id: faker.randomGenerator.integer(100),
      title: faker.lorem.sentence(),
      type: getInvolved,
      cause: CauseFactory().generate(),
      time: faker.randomGenerator.integer(10),
      releaseAt: faker.date.dateTime(),
      createdAt: faker.date.dateTime(),
    );
  }
}

class ActionFactory extends ModelFactory<Action> {
  @override
  Action generate() {
    return Action(
      id: faker.randomGenerator.integer(100),
      title: faker.lorem.sentence(),
      type: getInvolved,
      cause: CauseFactory().generate(),
      time: faker.randomGenerator.integer(10),
      releaseAt: faker.date.dateTime(),
      createdAt: faker.date.dateTime(),
      whatDescription: faker.lorem.words(100).join(' '),
      whyDescription: faker.lorem.words(100).join(' '),
      link: Uri.parse(faker.internet.uri('https')),
    );
  }
}
