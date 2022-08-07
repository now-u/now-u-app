import 'package:app/models/Action.dart';
import 'package:flutter_test/flutter_test.dart';
import './helpers.dart';

void main() {
  group('from json', () {
    test('ListCauseAction serializes successfully', () async {
      final data = await readTestDataList("actions.json");
      final action = ListCauseAction.fromJson(data[0]);

      expect(action.id, 597);
      expect(action.title, "Become a friend of FreePress Unlimited");
      expect(action.type, CampaignActionType.Donation);
      expect(action.time, 5.0);
      expect(action.completed, false);
      expect(action.createdAt, DateTime.utc(2021, 4, 13, 20, 2, 57, 521, ));
      expect(action.releasedAt, DateTime.utc(2021, 4, 30, 23, 0, 0));
      expect(action.cause.id, 61);
    });
    
	test('CauseAction serializes successfully', () async {
      final data = await readTestDataObject("action.json");
      final action = CampaignAction.fromJson(data);

      expect(action.id, 597);
      expect(action.title, "Become a friend of FreePress Unlimited");
      expect(action.type, CampaignActionType.Donation);
      expect(action.time, 5.0);
      expect(action.completed, false);
      expect(action.createdAt, DateTime.utc(2021, 4, 13, 20, 2, 57, 521, ));
      expect(action.releasedAt, DateTime.utc(2021, 4, 30, 23, 0, 0));
      expect(action.whatDescription, "Become a friend of the free press and make a donation starting at 5€.");
      expect(action.whyDescription, "Your contribution will help provide the support to journalists in need, helping media in conflict areas, and develop techniques to circumvent censorship and protect sources. By becoming a friend, you will also receive priority invitations to debates, workshops, festivals and film evenings, as well as updates how this organisation spends your donation.");
      expect(action.link, "https://www.freepressunlimited.org/en/donate");
    });
  });
}
