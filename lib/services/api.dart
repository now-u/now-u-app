import 'package:app/models/Campaign.dart';
import 'package:app/models/Campaigns.dart';

import 'package:app/models/Article.dart';

import 'package:app/models/FAQ.dart';

abstract class Api {
  Future<Campaign> getCampaign(int id);
  Future<Campaigns> getCampaigns();

  Future<List<Article>> getArticles();
  Future<Article> getVideoOfTheDay();
  
  Future<List<FAQ>> getFAQs();
}
