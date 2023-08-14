import 'package:nowu/assets/constants.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/ui/views/explore/explore_page_definition.dart';
import 'package:nowu/ui/views/explore/section_filters/by_action_type.dart';
import 'package:nowu/ui/views/explore/section_filters/by_cause.dart';
import 'package:nowu/ui/views/explore/section_filters/by_time.dart';

ExplorePageArguments campaigns_explore_page = ExplorePageArguments(
  title: 'Campaigns',
  sections: [
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
  ],
);

ExplorePageArguments actions_explore_page = ExplorePageArguments(
  title: 'Actions',
  sections: [
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
  ],
);

ExplorePageArguments learning_explore_page = ExplorePageArguments(
  title: 'Learn',
  sections: [
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
  ],
);

ExplorePageArguments home_explore_page = ExplorePageArguments(
  title: 'Explore',
  sections: [
    ActionExploreSectionArgs(
      title: 'Actions',
      link: actions_explore_page,
      description:
          'Take a wide range of actions to drive lasting change for issues you care about',
    ),
    LearningResourceExploreSectionArgs(
      title: 'Learn',
      link: learning_explore_page,
      description:
          'Learn more about key topics of pressing social and environmental issues',
    ),
    CampaignExploreSectionArgs(
      title: 'Campaigns',
      link: campaigns_explore_page,
      description:
          'Join members of the now-u community in coordinated campaigns to make a difference',
    ),
    NewsArticleExploreSectionArgs(
      title: 'News',
      description:
          'Find out what’s going on in the world this week in relation to your chosen causes',
    ),
  ],
);
