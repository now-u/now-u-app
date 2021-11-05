import 'package:app/viewmodels/base_model.dart';
import 'package:app/models/article.dart';
import 'package:app/models/Campaign.dart';

import 'package:app/locator.dart';
import 'package:app/services/news_service.dart';
import 'package:app/services/campaign_service.dart';
import 'package:app/services/navigation_service.dart';

class NewsViewModel extends BaseModel {
  final NewsService? _newsService = locator<NewsService>();
  final CampaignService? _campaignService = locator<CampaignService>();
  final NavigationService? _navigationService = locator<NavigationService>();

  String? _category;

  List<Article> _filteredArticles = [];
  List<Article> get filteredArticles => _filteredArticles;

  List<Campaign>? get campaigns => _campaignService!.campaigns;

  bool _searching = false;
  bool get searching => _searching;

  Future fetchArticles() async {
    setBusy(true);
    await _newsService!.fetchArticles();
    _category = null;
    _filteredArticles.clear();
    _filteredArticles.addAll(_newsService!.articles!);
    setBusy(false);
    notifyListeners();
  }

  void onTapPill(index) {
    print(_filteredArticles);
    String? indexCategory = index == _campaignService!.campaigns!.length
        ? "general"
        : _campaignService!.campaigns![index].shortName;

    // Retap to deselect
    _category = _category == indexCategory ? null : indexCategory;

    _filteredArticles.clear();
    _filteredArticles.addAll(_newsService!.articles!);
    if (_category != null) {
      _filteredArticles.removeWhere((a) =>
          a.getCategory(campaigns: _campaignService!.campaigns) != _category);
    }
    notifyListeners();
  }

  bool pillIsSelected(index) {
    return getCategoryFromIndex(index) == _category;
  }

  // Filter for string - this was used for search but should really be deleted now (but search may come back one day xD)
  void filterArticlesList(String query) {
    if (query.isNotEmpty) {
      List<Article> tempList = List<Article>.empty();
      _newsService!.articles!.forEach((article) {
        if (article.title.toLowerCase().contains(query.toLowerCase())) {
          tempList.add(article);
        }
      });
      _searching = true;
      _filteredArticles.clear();
      _filteredArticles.addAll(tempList);
    } else {
      _searching = false;
      _filteredArticles.clear();
      _filteredArticles.addAll(_newsService!.articles!);
    }
    notifyListeners();
  }

  String? getCategoryFromIndex(int index) {
    return index == campaigns!.length
        ? "general"
        : campaigns![index].shortName;
  }

  void openArticle(article) {
    _navigationService!.launchLink(article.getFullArticleLink());
  }
}
