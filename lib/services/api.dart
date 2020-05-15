import 'package:app/models/Campaign.dart';
import 'package:app/models/Campaigns.dart';

import 'package:app/models/Article.dart';

abstract class Api {
  Future<Campaign> getCampaign(int id);
  Future<Campaigns> getCampaigns();

  Future<List<Article>> getArticles();
}
