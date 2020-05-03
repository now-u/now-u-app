import 'package:app/models/Campaign.dart';
import 'package:app/models/Campaigns.dart';

abstract class Api {
  Future<Campaign> getCampaign(int id);
  Future<Campaigns> getCampaigns();
}
