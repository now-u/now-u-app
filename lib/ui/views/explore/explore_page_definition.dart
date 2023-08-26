import 'package:flutter/material.dart';
import 'package:nowu/services/search_service.dart';

// TODO Add base parameters to explore page
class ExplorePageArguments {
  final List<ExploreSectionArguments> sections;
  final String title;

  // TODO Use this base filter
  final BaseResourceSearchFilter? baseParams;

  ExplorePageArguments({
    required this.sections,
    required this.title,
    this.baseParams,
  });
}

class ExploreFilterOptionArgs<T> {
  /// What is displayed to the user
  final String displayName;

  /// The value posted to the api when this is selected
  final T parameterValue;

  ExploreFilterOptionArgs({
    required this.displayName,
    required this.parameterValue,
  });
}

abstract class ExploreFilterArgs<FilterT extends ResourceSearchFilter<FilterT>,
    FilterParamType> {
  bool isMulti;
  Future<Iterable<ExploreFilterOptionArgs<FilterParamType>>> getOptions();
  FilterT optionsToFilter(
    Iterable<ExploreFilterOptionArgs<FilterParamType>> selectedOptions,
  );

  ExploreFilterArgs({required this.isMulti});
}

sealed class ExploreSectionArguments<
    FilterT extends ResourceSearchFilter<FilterT>, FilterParamType> {
  /// Title of the section
  final String title;

  /// Where clicking on the title should go
  final BaseResourceSearchFilter? link;

  /// Description of the section
  final String? description;

  // Params to provide to fetch query
  final FilterT baseParams;

  /// A filter UX which is shown above the tiles in the section. This is used to
  /// allow the user to apply additional filtering to the tiles
  final ExploreFilterArgs<FilterT, FilterParamType>? filter;

  // TODO Make this required and include default here
  /// Background color of the section (white by default)
  final Color? backgroundColor;

  /// The height of the section. This must be fixed for a given tile type.
  final double tileHeight;

  ExploreSectionArguments({
    required this.title,
    required this.filter,
    required this.baseParams,
    required this.description,
    required this.link,
    required this.backgroundColor,
    required this.tileHeight,
  });

  // TODO Handle base params
  // ExploreSectionArguments<FilterT> addBaseParams(FilterT baseParams) {
  //   return ExploreSectionArguments(
  //     title: title,
  //     // TODO This doesnt quite work as we also need to update the title
  //     // link: link != null ? link!.addBaseParams(baseParams) : null,
  //     link: link,
  //     description: description,
  //     baseParams: this.baseParams != null ? baseParams.merge(this.baseParams!) : baseParams,
  //     filter: filter,
  //     backgroundColor: backgroundColor,
  //     type: type,
  //   );
  // }
}

class CampaignExploreSectionArgs<FilterParamType>
    extends ExploreSectionArguments<CampaignSearchFilter, FilterParamType> {
  CampaignExploreSectionArgs({
    required String title,
    ExploreFilterArgs<CampaignSearchFilter, FilterParamType>? filter,
    BaseResourceSearchFilter? link,
    String? description,
    CampaignSearchFilter? baseParams,
    Color? backgroundColor,
  }) : super(
          title: title,
          link: link,
          description: description,
          baseParams: baseParams ?? CampaignSearchFilter(),
          filter: filter,
          backgroundColor: backgroundColor,
          tileHeight: 300,
        );
}

class ActionExploreSectionArgs<FilterParamType>
    extends ExploreSectionArguments<ActionSearchFilter, FilterParamType> {
  ActionExploreSectionArgs({
    required String title,
    // TODO This should be args - its currently got state as well!
    // State should be handled in the view model and not passed in the args
    ExploreFilterArgs<ActionSearchFilter, FilterParamType>? filter,
    BaseResourceSearchFilter? link,
    String? description,
    ActionSearchFilter? baseParams,
    Color? backgroundColor,
  }) : super(
          title: title,
          link: link,
          description: description,
          baseParams: baseParams ?? ActionSearchFilter(),
          filter: filter,
          backgroundColor: backgroundColor,
          tileHeight: 160,
        );
}

class LearningResourceExploreSectionArgs<FilterParamType>
    extends ExploreSectionArguments<LearningResourceSearchFilter,
        FilterParamType> {
  LearningResourceExploreSectionArgs({
    required String title,
    ExploreFilterArgs<LearningResourceSearchFilter, FilterParamType>? filter,
	// TODO REmove
    BaseResourceSearchFilter? link,
    String? description,
    LearningResourceSearchFilter? baseParams,
    Color? backgroundColor,
  }) : super(
          title: title,
          link: link,
          description: description,
          baseParams: baseParams ?? LearningResourceSearchFilter(),
          filter: filter,
          backgroundColor: backgroundColor,
          tileHeight: 160,
        );
}

class NewsArticleExploreSectionArgs<FilterParamType>
    extends ExploreSectionArguments<NewsArticleSearchFilter, FilterParamType> {
  NewsArticleExploreSectionArgs({
    required String title,
    ExploreFilterArgs<NewsArticleSearchFilter, FilterParamType>? filter,
    BaseResourceSearchFilter? link,
    String? description,
    NewsArticleSearchFilter? baseParams,
    Color? backgroundColor,
  }) : super(
          title: title,
          link: link,
          description: description,
          baseParams: baseParams ?? NewsArticleSearchFilter(),
          filter: filter,
          backgroundColor: backgroundColor,
          tileHeight: 330,
        );
}
