import 'package:flutter_test/flutter_test.dart';
import 'package:nowu/models/Campaign.dart';

import './helpers.dart';

void main() {
  group('Campaign', () {
    test('ListCampaign fromJson serializes correctly', () async {
      final data = await readTestDataList("campaigns.json");
      final campaign = ListCampaign.fromJson(data[0]);

      expect(campaign.id, 3);
      expect(campaign.title, "Global access to water, sanitation & hygiene");
      expect(campaign.shortName, "WASH");
      expect(campaign.headerImage,
          "https://images.unsplash.com/photo-1437914983566-976d85602771?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80");
      expect(campaign.completed, true);
      expect(campaign.startDate, DateTime.utc(2021, 8, 6, 23));
      expect(campaign.endDate, DateTime.utc(2021, 9, 17, 23));
      expect(campaign.cause.id, 4);
    });

    test('Campaign fromJson serializes correctly', () async {
      final data = await readTestDataObject("campaign.json");
      final campaign = Campaign.fromJson(data);

      expect(campaign.id, 3);
      expect(campaign.title, "Global access to water, sanitation & hygiene");
      expect(campaign.shortName, "WASH");
      expect(campaign.headerImage,
          "https://images.unsplash.com/photo-1437914983566-976d85602771?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80");
      expect(campaign.completed, true);
      expect(campaign.startDate, DateTime.utc(2021, 8, 6, 23));
      expect(campaign.endDate, DateTime.utc(2021, 9, 17, 23));
      expect(campaign.cause.id, 4);

      expect(campaign.description,
          "George Floyd’s death sparked an anti-racism movement on a global scale. However, structural racism has existed for generations, and is certainly not limited to the United States. In the UK, 47% of Black children live in poverty (Runnymede) and Black people are vastly overrepresented in the prison population (The Lammy Review). We need to look in the mirror if we are serious about putting an end to racism.\n\nBy joining this campaign, you can learn more about the issues disproportionately impacting Black people in the UK, access learning materials about structural racism, and take actions that will support the BLM movement. \n");
      expect(campaign.actions.length, 1);
      expect(campaign.actions[0].id, 47);
      expect(campaign.learningResources.length, 1);
      expect(campaign.learningResources[0].id, 47);
      expect(campaign.videoLink, "https://youtu.be/EBfIH6dN3fk");
      expect(campaign.infographicUrl,
          "https://now-u.s3.eu-west-2.amazonaws.com/blm_campaign_illustration_f5ede3b48c.png");
    });
  });
}
