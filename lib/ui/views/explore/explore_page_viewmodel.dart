import 'package:causeApiClient/causeApiClient.dart';

import 'package:nowu/app/app.locator.dart';
import 'package:nowu/services/router_service.dart';
import 'package:nowu/ui/views/explore/explore_page_definition.dart';
import 'package:stacked/stacked.dart';

enum ExploreSectionType {
  Action,
  Learning,
  Campaign,
  News,
}

sealed class ExploreTileData {}

class ExplorePageViewModel extends BaseViewModel {
  RouterService _routerService = locator<RouterService>();

  final String title;
  List<ExploreSectionArguments> sections;

  // void init() {
  //   initSections();
  // }

  ExplorePageViewModel(
    this.title,
    this.sections, {
    Map<String, dynamic>? baseParams,
  }) {
    // Add the base parameters to the sections
    // this.sections = sections.map((args) {
    // 	return exploreSectionFromArgs(
    // 		// TODO Handle filterig across all sections
    // 		// args.addBaseParams(baseParams ?? {})
    // 		args,
    // 	);
    // }).toList();
  }

  void changePage(ExplorePageArguments args) {
    _routerService.navigateToExplore(args);
  }

  bool get canGoBack {
    return !_routerService.stack.isEmpty;
  }

  void back() {
    _routerService.back();
  }

  bool hasLinks() {
    return sections.any((section) => section.link != null);
  }

  void navigateToSearchPage() {
    _routerService.navigateToSearchView();
  }
}

// TODO Move out of this file
//-- Explore Sections --//
class ActionExploreTileData extends ExploreTileData {
  final ListAction action;
  final bool? isCompleted;

  ActionExploreTileData(this.action, this.isCompleted);
}

class LearningResourceExploreTileData extends ExploreTileData {
  final LearningResource learningResource;
  final bool? isCompleted;

  LearningResourceExploreTileData(this.learningResource, this.isCompleted);
}

// TODO Rename these, they have the same name as the widget
class CampaignExploreTileData extends ExploreTileData {
  final ListCampaign campaign;
  final bool? isCompleted;

  CampaignExploreTileData(this.campaign, this.isCompleted);
}

class NewsArticleExploreTileData extends ExploreTileData {
  final NewsArticle article;

  NewsArticleExploreTileData(this.article);
}
