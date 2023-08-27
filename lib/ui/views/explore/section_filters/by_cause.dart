import 'package:nowu/app/app.locator.dart';
import 'package:nowu/services/causes_service.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/ui/views/explore/explore_page_definition.dart';

abstract class ByCauseExploreFilter<
        FilterT extends ResourceSearchFilter<FilterT>>
    extends ExploreFilterArgs<FilterT, int> {
  ByCauseExploreFilter() : super(isMulti: true);

  // TODO Does this still need to be a getOptions thing, can we just use static options now as causes is not future
  @override
  getOptions() async {
    final CausesService _causesService = locator<CausesService>();
    List<Cause> causes = _causesService.causes;
    return causes.map(
      (Cause cause) => ExploreFilterOptionArgs(
        displayName: cause.title,
        parameterValue: cause.id,
      ),
    );
  }

  @override
  optionsToFilter(selectedOptions) {
    return selectedCauseIdsToFilter(
      selectedOptions.map((e) => e.parameterValue),
    );
  }

  FilterT selectedCauseIdsToFilter(Iterable<int> selectedCauseIds);
}

class ActionByCauseExploreFilter
    extends ByCauseExploreFilter<ActionSearchFilter> {
  @override
  ActionSearchFilter selectedCauseIdsToFilter(Iterable<int> selectedCauseIds) {
    return ActionSearchFilter(causeIds: selectedCauseIds);
  }
}

class CampaignByCauseExploreFilter
    extends ByCauseExploreFilter<CampaignSearchFilter> {
  @override
  CampaignSearchFilter selectedCauseIdsToFilter(
    Iterable<int> selectedCauseIds,
  ) {
    return CampaignSearchFilter(causeIds: selectedCauseIds);
  }
}

class LearningResourceByCauseExploreFilter
    extends ByCauseExploreFilter<LearningResourceSearchFilter> {
  @override
  LearningResourceSearchFilter selectedCauseIdsToFilter(
    Iterable<int> selectedCauseIds,
  ) {
    return LearningResourceSearchFilter(causeIds: selectedCauseIds);
  }
}
