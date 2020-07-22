import 'package:app/models/Campaign.dart';
import 'package:app/models/Campaigns.dart';
import 'package:app/models/Action.dart';
import 'package:app/models/Learning.dart';

import 'package:app/models/Article.dart';

import 'package:app/models/Organisation.dart';

import 'package:app/models/FAQ.dart';

abstract class Api {
  void switchToStagingBranch();

  Future<Campaign> getCampaign(int id);
  Future<Campaigns> getCampaigns();
  Future<CampaignAction> getAction(int id);

  Future<List<Article>> getArticles();
  Future<Article> getVideoOfTheDay();
  
  Future<List<FAQ>> getFAQs();
  
  Future<List<Organisation>> getPartners();
  Future<LearningCentre> getLearningCentre(int campaignId);
}
