import 'package:nowu/models/campaign.dart';

import 'factory.dart';
import 'cause_factory.dart';
import 'action_factory.dart';
import 'image_factory.dart';
import 'learning_resource_factory.dart';

class ListCampaignFactory extends ModelFactory<ListCampaign> {
  @override
  ListCampaign generate() {
    return ListCampaign(
      id: faker.randomGenerator.integer(100),
      title: faker.lorem.sentence(),
      headerImage: ImageFactory().generate(),
      cause: CauseFactory().generate(),
      isCompleted: true,
    );
  }
}

class CampaignFactory extends ModelFactory<Campaign> {
  @override
  Campaign generate() {
    return Campaign(
      id: faker.randomGenerator.integer(100),
      title: faker.lorem.sentence(),
      headerImage: ImageFactory().generate(),
      cause: CauseFactory().generate(),
      actions: ListActionFactory().generateList(length: 2),
      learningResources: LearningResourceFactory().generateList(length: 2),
      description: faker.lorem.words(100).join(' '),
      isCompleted: true,
    );
  }
}
