import 'package:nowu/models/Campaign.dart';
import 'package:built_collection/built_collection.dart';

import 'factory.dart';
import 'cause_factory.dart';
import 'action_factory.dart';
import 'image_factory.dart';
import 'learning_resource_factory.dart';

class ListCampaignFactory extends ModelFactory<ListCampaign> {
  @override
  ListCampaign generate() {
    return ListCampaign(
      (campaign) => campaign
        ..id = faker.randomGenerator.integer(100)
        ..title = faker.lorem.sentence()
        ..shortName = faker.lorem.word()
        ..headerImage = ImageFactory().generateBuilder()
        ..causes = ListBuilder(CauseFactory().generateList(length: 1)),
    );
  }
}

class CampaignFactory extends ModelFactory<Campaign> {
  @override
  Campaign generate() {
    return Campaign(
      (campaign) => campaign
        ..id = faker.randomGenerator.integer(100)
        ..title = faker.lorem.sentence()
        ..shortName = faker.lorem.word()
        ..headerImage = ImageFactory().generateBuilder()
        ..causes = ListBuilder(CauseFactory().generateList(length: 1))
        ..isCompleted = faker.randomGenerator.boolean()
        ..actions = ListBuilder(ListActionFactory().generateList(length: 2))
        ..learningResources =
            ListBuilder(LearningResourceFactory().generateList(length: 2)),
    );
  }
}
