import 'package:nowu/models/Campaign.dart';

import 'factory.dart';
import 'cause_factory.dart';
import 'action_factory.dart';
import 'learning_resource_factory.dart';

class ListCampaignFactory extends ModelFactory<ListCampaign> {
  @override
  ListCampaign generate() {
    return ListCampaign(
      id: faker.randomGenerator.integer(100),
      title: faker.lorem.sentence(),
      shortName: faker.lorem.word(),
      headerImage: faker.image.image(),
      cause: ListCauseFactory().generate(),
      completed: faker.randomGenerator.boolean(),
    );
  }
}

class CampaignFactory extends ModelFactory<Campaign> {
  @override
  Campaign generate() {
    return Campaign(
      id: faker.randomGenerator.integer(100),
      title: faker.lorem.sentence(),
      shortName: faker.lorem.word(),
      description: faker.lorem.sentence(),
      headerImage: faker.image.image(),
      videoLink: faker.internet.httpsUrl(),
      cause: ListCauseFactory().generate(),
      completed: faker.randomGenerator.boolean(),
      actions: ListCauseActionFactory().generateList(length: 2),
      learningResources: LearningResourceFactory().generateList(length: 2),
    );
  }
}
