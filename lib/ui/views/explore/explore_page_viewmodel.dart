import 'package:causeApiClient/causeApiClient.dart';

import 'package:nowu/app/app.locator.dart';
import 'package:nowu/assets/constants.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/router_service.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/ui/views/explore/explore_page_definition.dart';
import 'package:nowu/ui/views/explore/section_filters/by_action_type.dart';
import 'package:nowu/ui/views/explore/section_filters/by_cause.dart';
import 'package:nowu/ui/views/explore/section_filters/by_time.dart';
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
  CausesService _causesService = locator<CausesService>();

  BaseResourceSearchFilter baseFilter;
  ExplorePageViewModel({
    this.baseFilter = const BaseResourceSearchFilter(),
  });

  List<Cause> get causes => _causesService.causes;

  List<ExploreSectionArguments> get sections {
    final sections = _getSections();
    sections.forEach((section) {
      section.baseParams.mergeBaseFilter(this.baseFilter);
    });
    print('Merged base filter with every section');
    print(sections.map((section) => section.baseParams.causeIds));
    return sections;
  }

  List<ExploreSectionArguments> _getSections() {
    bool isFilterOnlyResource(ResourceType resourceType) {
      return baseFilter.resourceTypes?.length == 1 &&
          baseFilter.resourceTypes!.contains(resourceType);
    }

    if (isFilterOnlyResource(ResourceType.ACTION)) {
      return [
        ActionExploreSectionArgs(
          title: 'Actions of the month',
          baseParams: ActionSearchFilter(ofTheMonth: true),
        ),
        ActionExploreSectionArgs(
          title: 'Actions by cause',
          filter: ActionByCauseExploreFilter(),
        ),
        ActionExploreSectionArgs(
          title: 'Actions by time',
          filter: ActionTimeExploreFilter(),
        ),
        ActionExploreSectionArgs(
          title: 'Actions by type',
          filter: ByActionTypeFilter(),
        ),
        ActionExploreSectionArgs(
          title: 'Completed actions',
          baseParams: ActionSearchFilter(completed: true),
          backgroundColor: CustomColors.lightOrange,
        ),
      ];
    }
    if (isFilterOnlyResource(ResourceType.LEARNING_RESOURCE)) {
      return [
        LearningResourceExploreSectionArgs(
          title: 'Learning resources by time',
          filter: LearningResourceTimeExploreFilter(),
        ),
        LearningResourceExploreSectionArgs(
          title: 'Learning resource by cause',
          filter: LearningResourceByCauseExploreFilter(),
        ),
        LearningResourceExploreSectionArgs(
          title: 'Learning resources',
        ),
        LearningResourceExploreSectionArgs(
          title: 'Completed learning',
          backgroundColor: CustomColors.lightOrange,
          baseParams: LearningResourceSearchFilter(completed: true),
        ),
      ];
    }
    // TODO THis doesn't seem to quite work! need to make equitable/write little function
    if (isFilterOnlyResource(ResourceType.CAMPAIGN)) {
      return [
        CampaignExploreSectionArgs(
          title: 'Campaigns of the month',
          baseParams: CampaignSearchFilter(ofTheMonth: true),
        ),
        CampaignExploreSectionArgs(
          title: 'Recommended campaigns',
          baseParams: CampaignSearchFilter(recommended: true),
        ),
        CampaignExploreSectionArgs(
          title: 'Campaigns by cause',
          filter: CampaignByCauseExploreFilter(),
        ),
        CampaignExploreSectionArgs(
          title: 'Completed campaigns',
          baseParams: CampaignSearchFilter(completed: true),
          backgroundColor: CustomColors.lightOrange,
        ),
      ];
    }

    return [
      if (baseFilter.resourceTypes == null ||
          baseFilter.resourceTypes!.contains(ResourceType.ACTION))
        ActionExploreSectionArgs(
          title: 'Actions',
          link: const BaseResourceSearchFilter(
              resourceTypes: [ResourceType.ACTION]),
          description:
              'Take a wide range of actions to drive lasting change for issues you care about',
        ),
      if (baseFilter.resourceTypes == null ||
          baseFilter.resourceTypes!.contains(ResourceType.LEARNING_RESOURCE))
        LearningResourceExploreSectionArgs(
          title: 'Learn',
          link: const BaseResourceSearchFilter(
              resourceTypes: [ResourceType.LEARNING_RESOURCE]),
          description:
              'Learn more about key topics of pressing social and environmental issues',
        ),
      if (baseFilter.resourceTypes == null ||
          baseFilter.resourceTypes!.contains(ResourceType.CAMPAIGN))
        CampaignExploreSectionArgs(
          title: 'Campaigns',
          link: const BaseResourceSearchFilter(
              resourceTypes: [ResourceType.CAMPAIGN]),
          description:
              'Join members of the now-u community in coordinated campaigns to make a difference',
        ),
      if (baseFilter.resourceTypes == null ||
          baseFilter.resourceTypes!.contains(ResourceType.NEWS_ARTICLE))
        NewsArticleExploreSectionArgs(
          title: 'News',
          description:
              'Find out what’s going on in the world this week in relation to your chosen causes',
        ),
    ];
  }

  // TODO Merge with base filter rather than replacing
  void updateFilter(BaseResourceSearchFilter args) {
    this.baseFilter = args;
    print('Updating filter');
    notifyListeners();
  }

  bool get canGoBack {
    return !_routerService.stack.isEmpty;
  }

  Cause getCauseById(int id) {
    return _causesService.getCause(id);
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
