import 'package:nowu/models/time.dart';
import 'package:nowu/services/search_service.dart';
import 'package:nowu/ui/views/explore/explore_page_definition.dart';
import 'package:tuple/tuple.dart';

abstract class TimeExploreFilter<FilterT extends ResourceSearchFilter<FilterT>>
    extends ExploreFilterArgs<FilterT, Tuple2<double, double>> {
  TimeExploreFilter() : super(isMulti: true);

  @override
  getOptions() async {
    return timeBrackets.map(
      (bracket) => ExploreFilterOptionArgs(
        displayName: bracket.text,
        parameterValue: Tuple2(
          bracket.minTime.toDouble(),
          bracket.maxTime.toDouble(),
        ),
      ),
    );
  }

  @override
  optionsToFilter(selectedOptions) {
    Iterable<Tuple2<double, double>> timeBrackets =
        selectedOptions.map((option) => option.parameterValue);
    return timeBracketsToFilter(timeBrackets);
  }

  FilterT timeBracketsToFilter(Iterable<Tuple2<double, double>> timeBrackets);
}

class ActionTimeExploreFilter extends TimeExploreFilter<ActionSearchFilter> {
  ActionSearchFilter timeBracketsToFilter(
    Iterable<Tuple2<double, double>> timeBrackets,
  ) {
    return ActionSearchFilter(timeBrackets: timeBrackets);
  }
}

class LearningResourceTimeExploreFilter
    extends TimeExploreFilter<LearningResourceSearchFilter> {
  LearningResourceSearchFilter timeBracketsToFilter(
    Iterable<Tuple2<double, double>> timeBrackets,
  ) {
    return LearningResourceSearchFilter(timeBrackets: timeBrackets);
  }
}
