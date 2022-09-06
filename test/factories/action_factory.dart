import 'package:app/models/Action.dart';

import 'factory.dart';
import 'cause_factory.dart';

class ListCauseActionFactory extends ModelFactory<ListCauseAction> {
  @override
  ListCauseAction generate() {
    return ListCauseAction(
      id: faker.randomGenerator.integer(100),
      title: faker.lorem.sentence(),
      type: CampaignActionType.Volunteer,
      cause: ListCauseFactory().generate(),
      completed: faker.randomGenerator.boolean(),
      time: faker.randomGenerator.decimal(min: 1, scale: 10),
      createdAt: faker.date.dateTime(),
    );
  }
}

class CampaignActionFactory extends ModelFactory<CampaignAction> {
  @override
  CampaignAction generate() {
    return CampaignAction(
      id: faker.randomGenerator.integer(100),
      title: faker.lorem.sentence(),
      type: CampaignActionType.Volunteer,
      cause: ListCauseFactory().generate(),
      completed: faker.randomGenerator.boolean(),
      time: faker.randomGenerator.decimal(min: 1, scale: 10),
      createdAt: faker.date.dateTime(),
    );
  }
}
